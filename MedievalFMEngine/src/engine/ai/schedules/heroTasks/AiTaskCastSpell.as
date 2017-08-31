package engine.ai.schedules.heroTasks
{
	import __AS3__.vec.Vector;
	
	import computers.utils.Utils;
	
	import engine.ai.AiContext;
	import engine.ai.AiHintType;
	import engine.ai.ItemAiHintType;
	import engine.ai.hero.HeroAi;
	import engine.ai.hero.HeroConditions;
	import engine.ai.hero.HeroWatcher;
	import engine.ai.schedules.AiSchedule;
	import engine.ai.schedules.tasks.AiHeroTask;
	import engine.heros.Hero;
	import engine.spells.SpellCastType;
	import engine.spells.SpellType;
	import engine.spells.TargetType;
	import engine.units.DamageType;
	import engine.units.Unit;
	import engine.units.UnitOrders.UnitOrderAttack;
	import engine.units.UnitOrders.UnitOrderMove;
	import engine.units.UnitState;
	import engine.util.TileUtil;

	public class AiTaskCastSpell extends AiHeroTask
	{
		private static const NORMAL_SPELL_TYPES:Array = [AiHintType.Attack, AiHintType.Summon, AiHintType.Debuff, AiHintType.Buff];
		private static const DEF_SPELL_TYPES:Array = [AiHintType.DrainHealth, AiHintType.Summon, AiHintType.Debuff];
						
		public function AiTaskCastSpell(schedule:AiSchedule=null)
		{
			super(schedule);
		}
		
		public override function execute(context:AiContext):Boolean
		{
			if (_hero.state == UnitState.Casting)
				return true;
			
			var conditions:Array = context.conditions;
			var watcher:HeroWatcher = HeroAi(context.ai).watcher;
				
			var rand:int = Utils.rand(0, 3);
			var underAttack:Boolean = (conditions.indexOf(HeroConditions.UNDER_ATTACK) >= 0);
			
			if (conditions.indexOf(HeroConditions.ULTIMATE_READY) >= 0
				&& (conditions.indexOf(HeroConditions.UNDER_ATTACK) >= 0 || rand == 3))
			{
				if (castSpell(context.spells, context)) return true;
			}
			else if (conditions.indexOf(HeroConditions.CAN_SPEED_UP) >= 0
					&& (conditions.indexOf(HeroConditions.HEALTH_VERY_LOW) >= 0
					|| isCurrentAttackTargetFar(rand)))
			{
				if (castSpell(context.spells, context)) return true;
			}
			else if (conditions.indexOf(HeroConditions.HEALTH_LOW) >= 0
				&& underAttack)
			{
				var spells:Array = watcher.getSpellsByAiType(AiHintType.ProtectionCritical, true);
				if (castSpell(spells, context)) return true;	
			}
					
			if (conditions.indexOf(HeroConditions.MANA_LOW) >= 0 && rand == 1)
			{
				var manaItems:Array = watcher.getItemsByAiType(ItemAiHintType.RestoreMana);
				
				if (manaItems.length)
				{
					_hero.useItem(manaItems[Utils.rand(0, manaItems.length - 1)]);
				}	
				else if (conditions.indexOf(HeroConditions.HEALTH_NORMAL) >= 0)
				{
					var spells:Array = watcher.getSpellsByAiType(AiHintType.HealthToMana);
					if (castSpell(spells, context)) return true;
				}
				else if (conditions.indexOf(HeroConditions.HEALTH_VERY_LOW) == -1 
						&& !underAttack)
				{
					// try to tap and heal
					if (watcher.hasHealingSpells)
					{
						spells = watcher.getSpellsByAiType(AiHintType.HealthToMana);
						if (castSpell(spells, context)) return true;
					}							
				}
				
				var spells:Array = watcher.getSpellsByAiType(AiHintType.DrainMana);	
				if (castSpell(spells, context)) return true;							
			}
			
			if (conditions.indexOf(HeroConditions.HEALTH_NORMAL) == -1 && rand == 1)
			{
				var spells:Array = watcher.getSpellsByAiType(AiHintType.DrainHealth);
				if (castSpell(spells, context)) return true;
			}
			
			if (underAttack)
			{
				if (rand == 2)
				{
					if (_hero.lastHitDamageType == DamageType.Spell || _hero.lastHitDamageType == DamageType.Magic)
					{
						var spells:Array = watcher.getSpellsByAiType(AiHintType.ProtectionMagic);
						if (castSpell(spells, context)) return true;					
					}
					else
					{
						var spells:Array = watcher.getSpellsByAiType(AiHintType.Protection);
						if (castSpell(spells, context)) return true;				
					}
				}
				else if (rand == 0)
				{
					var spells:Array = watcher.getSpellsByAiType(DEF_SPELL_TYPES[Utils.rand(0, DEF_SPELL_TYPES.length - 1)]);
					if (castSpell(spells, context)) return true;	
				}		
			}

			// just select some random spell from appropriate categories
			var spells:Array = watcher.getSpellsByAiType(NORMAL_SPELL_TYPES[Utils.rand(0, NORMAL_SPELL_TYPES.length - 1)]);
			if (!castSpell(spells, context))
			{
				context.signals.push(HeroConditions.HAVE_NOTHING_TO_CAST);
			}
			
			return true;
		}
		
		private function isCurrentAttackTargetFar(rand:int):Boolean
		{
			if (rand == 0)
			{
				var attackOrder:UnitOrderAttack = _hero.order as UnitOrderAttack;
				if (attackOrder && attackOrder.target is Hero && attackOrder.target.isActive)
				{
					var moveOrder:UnitOrderMove = Unit(attackOrder.target).order as UnitOrderMove; 
					return moveOrder && TileUtil.getTileDist(_hero.tile, moveOrder.targetTile) > 5 && TileUtil.getTileDist(_hero.tile, attackOrder.target.tile) > 2;	
				}
			}
			
			return false;
		}
		
		private function castSpell(spells:Array, context:AiContext):Boolean
		{
			if (spells && spells.length)
			{
				var spell:SpellType = spells[Utils.rand(0, spells.length - 1)];
				
				var target:* = getSpellTarget(spell, context);
				if (target) 
				{
					_hero.castSpell(target, spell);	
					return true;
				}		
			}
			return false;
		}
		
		private function getSpellTarget(spell:SpellType, context:AiContext):*
		{
			if (spell.targetType == TargetType.Self || spell.castType == SpellCastType.Self)
			{
				return _hero;
			}
			else if (spell.castType == SpellCastType.Unit || spell.castType == SpellCastType.Place)
			{
				if (spell.targetType == TargetType.Enemy || spell.targetType >= TargetType.All)
				{
					if (spell.aiHint == AiHintType.ProtectionCritical)
					{
						if (context.friendlyUnits && context.friendlyUnits.length > 1)
							return context.friendlyUnits[Utils.rand(0, context.friendlyUnits.length - 1) ];
					}
					else
					{
						var attackOrder:UnitOrderAttack = _hero.order as UnitOrderAttack;
						var units:Vector.<Unit> = context.units;
						
						if (units)
						{
							if (attackOrder && spell.isAllowedTarget(_hero, attackOrder.target as Unit) 
								&& units.indexOf(attackOrder.target) >= 0)
							{
								return attackOrder.target;
							}
							
							for (var i:int; i < units.length; ++i)
							{
								if (spell.isAllowedTarget(_hero, units[i]))
								{
									return units[i];
								}
							}
						}
					}
				}
				else if (spell.targetType == TargetType.Ally)
				{
					return _hero;
				} 
			}
			
			return null;			
		}		
	}
}