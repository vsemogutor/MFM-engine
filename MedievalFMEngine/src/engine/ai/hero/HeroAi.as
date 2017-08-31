package engine.ai.hero
{
	import __AS3__.vec.Vector;
	
	import computers.utils.Utils;
	
	import engine.ai.AiBase;
	import engine.ai.AiContext;
	import engine.ai.AiHintType;
	import engine.ai.ItemAiHintType;
	import engine.ai.schedules.AiSchedule;
	import engine.ai.schedules.AiSchedulesRepository;
	import engine.core.isometric.IsoTile;
	import engine.core.isometric.IsoWorld;
	import engine.fraction.ResourceType;
	import engine.game.Game;
	import engine.heros.Hero;
	import engine.spells.Spell;
	import engine.structures.Structure;
	import engine.units.ArmorType;
	import engine.units.SpecialUnitCategory;
	import engine.units.Unit;
	import engine.units.UnitOrders.UnitOrderAttack;
	import engine.units.UnitProperties;
	import engine.units.VisibleUnits;
	import engine.util.TileUtil;
	import engine.util.Util;
	
	import flash.geom.Rectangle;
	
	public class HeroAi extends AiBase
	{
		protected var _retreatWaypoints:Array = new Array();
		protected var _attackWaypoints:Array = new Array();
		protected var _hero:Hero;
		protected var _watcher:HeroWatcher;
		protected var _heroLevelingStrategy:HeroLevelingStrategyBase;
		protected var _heroItemsEquipStrategy:HeroItemsEquipStrategy;
		protected var _buyItemsCooldown:int = 0;
		protected var _retreatStarted:Boolean;
		protected var _fullRetreatCooldown:int;
		protected var _threatLevel:int;
		protected var _minHealthLevel:int;
		protected var _suspendRetreat:Boolean = false;
		
		protected static const BUY_ITEMS_COOLDOWN:int = 60;
		protected static const RETREAT_COOLDOWN:int = Util.secToFrames(60*5);		
		protected static const HERO_THREAT_COEF:int = 4;
				
		public function get watcher():HeroWatcher {
			return _watcher;
		}
		
		public function get suspendRetreat():Boolean {
			return _suspendRetreat;
		}

		public function set suspendRetreat(value:Boolean):void {
			_suspendRetreat = value;
		}	
			
		public function HeroAi(hero:Hero)
		{
			super();
			
			_hero = hero;
			_watcher = new HeroWatcher(hero);
			_heroLevelingStrategy = new HeroLevelingStrategySimple(_hero);
			_heroItemsEquipStrategy = new HeroItemsEquipStrategy(_hero);
			enableHeroCheats();
			
			if (_hero.type.properties[UnitProperties.AttackRange] <= 1)
				 _minHealthLevel = 400;
			else
				_minHealthLevel = 300;
		}
		
		public function setLevelingStrategy(strategy:HeroLevelingStrategyBase):void
		{
			_heroLevelingStrategy = strategy;
		}
		
		public function setRetreatWaypoints(waypoints:Array):void
		{
			_retreatWaypoints = waypoints;
		}

		public function setAttackWaypoints(waypoints:Array):void
		{
			_attackWaypoints = waypoints;
		}
						
		protected override function gatherConditions(context:AiContext):void
		{
			_threatLevel = 0;
			
			gatherInsideConditions(context);
			gatherOutsideConditions(context);
			
			if (_threatLevel >= 25)
			{
				context.conditions.push(HeroConditions.THREAT_LEVEL_VERY_HIGH);
				context.conditions.push(HeroConditions.THREAT_LEVEL_HIGH);	
			}		
			else if (_threatLevel >= 15)
			{
				context.conditions.push(HeroConditions.THREAT_LEVEL_HIGH);
			}
		}
		
		protected override function selectNewSchedule(context:AiContext):AiSchedule
		{
			var conditions:Array = context.conditions;
			if (conditions.indexOf(HeroConditions.HEALTH_VERY_LOW) >= 0 || _retreatStarted)	
			{
				if (conditions.indexOf(HeroConditions.CAN_HEAL) >= 0)
				{
					return AiSchedulesRepository.getHealSchedule(context, _hero);
				}
				else if (conditions.indexOf(HeroConditions.ULTIMATE_READY) >= 0
						|| conditions.indexOf(HeroConditions.CAN_SPEED_UP) >= 0)
				{
					return AiSchedulesRepository.getCastSchedule(context, _hero);
				}
				else if (conditions.indexOf(HeroConditions.CAN_MOVE) >= 0 && !_suspendRetreat)
				{					
					if (!_fullRetreatCooldown)
					{
						_fullRetreatCooldown = RETREAT_COOLDOWN;
						_retreatStarted = true;
					}
					
					context.waypoints = _retreatWaypoints;
					return AiSchedulesRepository.getRetreatSchedule(context, _hero);
				}	 
			}
			
			if (!_suspendRetreat && (conditions.indexOf(HeroConditions.THREAT_LEVEL_VERY_HIGH) >= 0
				|| (conditions.indexOf(HeroConditions.THREAT_LEVEL_HIGH) >= 0 
				&& conditions.indexOf(HeroConditions.UNDER_ATTACK) >= 0)))
			{
				context.waypoints = _retreatWaypoints;
				return AiSchedulesRepository.getRetreatSchedule(context, _hero);					
			}
			
			if (conditions.indexOf(HeroConditions.HEALTH_LOW) >= 0)
			{
				if (conditions.indexOf(HeroConditions.CAN_HEAL) >= 0)
					return AiSchedulesRepository.getHealSchedule(context, _hero);				
			}
			
			if (conditions.indexOf(HeroConditions.SEE_ALLY_UNIT_NEAR_DEATH) >= 0)
			{
				if (Utils.rand(0, 2) == 1)
				{
					return AiSchedulesRepository.getAttackUnitSchedule(context, _hero);
				}
			}	
			
			if (conditions.indexOf(HeroConditions.HAVE_MONEY) >= 0 && conditions.indexOf(HeroConditions.NEAR_STORE) >= 0)
			{
				if (_buyItemsCooldown <= 0)
				{
					_buyItemsCooldown = BUY_ITEMS_COOLDOWN;
					return AiSchedulesRepository.getPurchaseItemsSchedule(context, _hero);	
				}			
			}					
			
			var canCast:Boolean = conditions.indexOf(HeroConditions.CAN_CAST) >= 0 
				&& (conditions.indexOf(HeroConditions.HAVE_NOTHING_TO_CAST) == -1);
			
			if (canCast)
			{
				if (conditions.indexOf(HeroConditions.SEE_ENEMY_UNIT) >= 0 && conditions.indexOf(HeroConditions.MANA_NORMAL) >= 0 
					|| conditions.indexOf(HeroConditions.SEE_ENEMY_HERO) >= 0)
				{
					var manaLow:Boolean = (conditions.indexOf(HeroConditions.MANA_VERY_LOW) >= 0);
					if (!manaLow || !_watcher.hasHealingSpells)
						return AiSchedulesRepository.getCastSchedule(context, _hero);
				}
			}
			
			if (conditions.indexOf(HeroConditions.SEE_LOOT) >= 0)
			{
				context.waypoints = context.loot;
				return AiSchedulesRepository.getMoveSchedule(context, _hero);
			}	
			else if (conditions.indexOf(HeroConditions.CAN_ATTACK) >= 0)
			{
				context.waypoints = _attackWaypoints;
				return AiSchedulesRepository.getAttackSchedule(context, _hero);
			}
			else if (canCast && conditions.indexOf(HeroConditions.MANA_VERY_LOW) == -1)
			{
				return AiSchedulesRepository.getCastSchedule(context, _hero);				
			}

			if (!_suspendRetreat && conditions.indexOf(HeroConditions.UNDER_ATTACK) >= 0
				&& (conditions.indexOf(HeroConditions.SEE_ENEMY_HERO) >= 0
				||	conditions.indexOf(HeroConditions.HEALTH_NORMAL) == -1))
			{
				context.waypoints = _retreatWaypoints;
				return AiSchedulesRepository.getRetreatUntilAttackedSchedule(context, _hero);
			}
			else
			{
				return AiSchedulesRepository.getWaitSchedule(context, _hero);				
			}				
		}
		
		protected function gatherOutsideConditions(context:AiContext):void
		{
			var gt:int = _game.gameTime.value;
			var units:VisibleUnits = _hero.getVisibles(true);
			var enemyUnits:Vector.<Unit> = units.enemy;
			var friendlyUnits:Vector.<Unit> = units.friendly;
			var underAttackTreshold:int = Util.secToFrames(3);
			var unit:Unit;
			
			context.friendlyUnits = friendlyUnits;
			context.loot = units.items;
			
			if (units.items.length)
			{
				context.conditions.push(HeroConditions.SEE_LOOT);
			}
			
			if (enemyUnits.length)
			{
				context.units = enemyUnits;
				context.conditions.push(HeroConditions.SEE_ENEMY_UNIT);
				
				for (var i:int = 0; i < enemyUnits.length; ++i)
				{
					unit = enemyUnits[i];
					
					if (unit is Hero)
					{
						context.conditions.push(HeroConditions.SEE_ENEMY_HERO);	
						_threatLevel += Hero(unit).level*HERO_THREAT_COEF;					
					}
					else if (unit is Structure)
					{
						if (unit.properties[UnitProperties.AttackRange] > 0)
							_threatLevel += unit.type.level*2.5;
					}
					else
					{
						_threatLevel += unit.type.level;
					}
				}
				
				for (var i:int = 0; i < friendlyUnits.length; ++i)
				{
					unit = friendlyUnits[i];
					if (unit.properties[UnitProperties.Health] < 50 
						&& gt - unit.lastHitTime < underAttackTreshold
						&& !unit.summoner && !(unit is Hero) && !(unit is Structure))
					{
						context.target = unit;
						context.conditions.push(HeroConditions.SEE_ALLY_UNIT_NEAR_DEATH);
					}
					
					_threatLevel -= unit.type.level;
				}
			}
	
			if (gt - _hero.lastHitTime < underAttackTreshold)
			{
				context.conditions.push(HeroConditions.UNDER_ATTACK);
			}
			
			if (context.conditions.indexOf(HeroConditions.HAVE_MONEY))
			{
				var stores:Vector.<Unit> = _game.unitManager.getUnitsByCategory(SpecialUnitCategory.STORE);
				for (var i:int = 0; i < stores.length; ++i)
				{
					if (TileUtil.getTileDist(stores[i].tile, _hero.tile) < 5)
					{
						context.nearStore = stores[i];
						context.conditions.push(HeroConditions.NEAR_STORE);
						break;
					}
				}
			}
		}
		
		protected function gatherInsideConditions(context:AiContext):void
		{
			var conditions:Array = context.conditions;
			
			var health:int = _hero.properties[UnitProperties.Health];
			var maxHealth:int = _hero.properties[UnitProperties.MaxHealth];
			if (health < maxHealth * 0.3 || health <= _minHealthLevel)
			{
				conditions.push(HeroConditions.HEALTH_VERY_LOW);
				conditions.push(HeroConditions.HEALTH_LOW);				
			}
			else if (health < maxHealth * 0.7)
			{
				conditions.push(HeroConditions.HEALTH_LOW);	
			}
			else
			{
				conditions.push(HeroConditions.HEALTH_NORMAL);
				_threatLevel -= 3;				
			}
			
			if (health < maxHealth * 0.8)
			{
				var spells:Array = _watcher.getSpellsByAiType(AiHintType.Heal, true);
				var items:Array = _watcher.getItemsByAiType(ItemAiHintType.RestoreHealth);				
				if (spells.length || items.length)
				{
					context.spells = spells;
					context.items = items;
					conditions.push(HeroConditions.CAN_HEAL);
				}
			}
						
			var mana:int = _hero.properties[UnitProperties.Mana];
			var maxMana:int = _hero.properties[UnitProperties.MaxMana];	
			if (mana >= maxMana * 0.5 || mana >= 400)
			{
				conditions.push(HeroConditions.MANA_NORMAL);
			}
			else if (mana > maxMana*0.3 || mana >= 110)
			{
				conditions.push(HeroConditions.MANA_LOW);
			}
			else
			{
				conditions.push(HeroConditions.MANA_LOW);
				conditions.push(HeroConditions.MANA_VERY_LOW);
			}
			
			var ultimate:Array = _watcher.getSpellsByAiType(AiHintType.Ultimate, true);
			if (ultimate.length)
			{
				context.spells = ultimate;
				conditions.push(HeroConditions.ULTIMATE_READY);
			}
			else
			{
				var speedBuff:Array = _watcher.getSpellsByAiType(AiHintType.SpeedBuff, true);
				if (speedBuff.length)
				{
					context.spells = speedBuff;
					conditions.push(HeroConditions.CAN_SPEED_UP);
				}
			}
			
			if (_hero.properties[UnitProperties.AttackRange] > 0)
			{
				conditions.push(HeroConditions.CAN_ATTACK);
			}	

			if (_hero.properties[UnitProperties.CanMove] != 0)
			{
				conditions.push(HeroConditions.CAN_MOVE);
			}
			
			if (_hero.properties[UnitProperties.CastDelay] < Spell.MAX_CAST_DELAY)
			{
				conditions.push(HeroConditions.CAN_CAST)
				if (!_watcher.hasAvaliableSpells())
					conditions.push(HeroConditions.HAVE_NOTHING_TO_CAST);
			}	
			
			if (_hero.fraction.getResource(ResourceType.Gold) >= 400)
			{
				conditions.push(HeroConditions.HAVE_MONEY);
			}
			
			_threatLevel -= _hero.level * (HERO_THREAT_COEF * 1.29);
			if (!_hero.visible || _hero.properties[UnitProperties.ArmorType] == ArmorType.DIVINE) 
				_threatLevel = _threatLevel*0.8;
		}
		
		protected override function prescheduleThink():void
		{
			if (_buyItemsCooldown > 0) _buyItemsCooldown--;
			if (_fullRetreatCooldown > 0) _fullRetreatCooldown--;
			if (_retreatStarted && _hero.properties[UnitProperties.Health] == _hero.properties[UnitProperties.MaxHealth])
			{
				_retreatStarted = false;
			}
		}
		
		protected override function postScheduleThink():void
		{
			summonControl();
		}
		
		private function summonControl():void
		{
			var summons:Vector.<Unit> = _hero.summons;
			if (_hero.order is UnitOrderAttack)
			{
				for (var i:int = 0; i < summons.length; ++i)
				{
					var order:UnitOrderAttack = summons[i].order as UnitOrderAttack;
					if (!order || (order.target != _hero.order.target && Utils.rand(0,5) == 2))
						summons[i].attack(_hero.order.target as Unit);
				}	
			}
			else 
			{
				var world:IsoWorld = Game.instance().world;
				var range:Rectangle = world.getRangeAroundTile(_hero.tile, 3);
				for (var i:int = 0; i < summons.length; ++i)
				{
					var summon:Unit = summons[i];
					if (summon.isActive && !(summon.order is UnitOrderAttack) && TileUtil.getTileDist(summon.tile, _hero.tile) > 5)
					{
						var tile:IsoTile = world.getTile(Utils.rand(range.x, range.right), Utils.rand(range.y, range.bottom));
						if (tile)
							summon.attackMove(tile);
					}
				}				
			}
		}
		
		private function enableHeroCheats():void
		{
			_hero.heroProperties[UnitProperties.HealthRegenRate] -= 1;
			_hero.heroProperties[UnitProperties.ManaRegenRate] -= 2;
			
			if (_hero.type.intellectPerLevel >= 3) _hero.heroProperties[UnitProperties.ManaRegenRate] -= 2;			
		}
		
		public override function reset():void
		{
			super.reset();
			_fullRetreatCooldown = 0;
			_buyItemsCooldown = 0;
			_retreatStarted = false;
			_threatLevel = 0;
			_suspendRetreat = false;
		}					
	}
}