package engine.units
{
	import __AS3__.vec.Vector;
	
	import computers.utils.Utils;
	
	import de.polygonal.ds.HashMap;
	import de.polygonal.ds.HashMapValIterator;
	import de.polygonal.ds.LinkedDeque;
	
	import engine.animation.UnitAnimation;
	import engine.computers.ExperienceCalculator;
	import engine.core.IdManager;
	import engine.core.ManagerBase;
	import engine.core.events.GameEvent;
	import engine.core.events.GameEvents;
	import engine.core.fm_internal;
	import engine.core.isometric.IsoTile;
	import engine.fraction.Fraction;
	import engine.game.GameManager;
	import engine.heros.Hero;
	import engine.specialEffects.SpecialEffectType;
	import engine.specialEffects.SpecialEffects;
	import engine.spells.Spell;
	import engine.structures.Structure;
	import engine.units.UnitOrders.*;
	import engine.units.groups.UnitGroup;
	import engine.util.Constants;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	use namespace fm_internal;
		
	public final class UnitManager extends ManagerBase
	{
		private var _units:Vector.<Unit> = new Vector.<Unit>();
		private var _unitTypes:HashMap = new HashMap();
		private var _unitsToGetPath:LinkedDeque = new LinkedDeque();
		private var _unitFactory:UnitFactory;
		private var _lastSeenOrderPriority:int = Constants.UNDEFINED;
		private var _specialUnits:Dictionary = new Dictionary();
		
				
		public function get unitFactory():UnitFactory{
			return _unitFactory;
		}
		
		public function get units():Vector.<Unit> {
			return _units;
		}
		
		public function get unitTypes():HashMap {
			return _unitTypes;
		}
				
		public function UnitManager()
		{
			super();
			_unitFactory = new UnitFactory();
		}
		
		public function addUnitType(unitType:UnitType, id:int=-1):int
		{
			if (id != Constants.UNDEFINED)
				unitType.id = id;
			else if (unitType.id == Constants.UNDEFINED)
				unitType.id = idManager.idByName(unitType.name);
		
			if (_unitTypes.get(unitType.id))
				throw new Error("unit type already defined");
			
			unitType.validateDefinition();
			
			if (!unitType.level)
				unitType.level = ExperienceCalculator.deductLevel(unitType);
			
			_unitTypes.set(unitType.id, unitType);
			return unitType.id;
		}

		public function createUnitFromType(type:UnitType, fraction:Fraction):Unit
		{
			return unitFactory.createUnit(type, fraction);
		}
				
		public function createUnitFromTypeId(id:int, fraction:Fraction):Unit
		{
			return unitFactory.createUnit(getTypeById(id), fraction);
		}
		
		private function processUnitOrders():void
		{
			if (_lastSeenOrderPriority < UnitOrderBase.CurrentPriority)
			{
				function prioritySort(u1:Unit, u2:Unit):Number
				{
					return u1.order.priority - u2.order.priority;
				}
				
				_lastSeenOrderPriority = UnitOrderBase.CurrentPriority;
				_units.sort(prioritySort);
			}

			var len:int = _units.length;
			for (var i:int = 0; i < len; ++i)
			{
				var unit:Unit = _units[i];
				var order:UnitOrderBase = unit.order;
				if (order && order.execute())
				{
					order.nextOrder();
				}
			}
		}
		
		public function processUnitStates():void
		{
			var len:int = _units.length;
			for (var i:int = 0; i < len; ++i)
			{
				var unit:Unit = _units[i];

				switch (unit.state)
				{
					// Waiting ----------------------------------
					case UnitState.Waiting:
						unit.model.setCurrent(UnitAnimation.Stand, unit._direction);
						unit.model.play();
						
					break;
					
					// Moving ------------------------------------				
					case UnitState.Moving:
					
						if (unit.path.length > 0 && unit.path[0].center.equals(unit.center) )
						{
							if(unit.path.length == 1 && unit.path[unit.path.length - 1] != unit.order.targetTile)
							{
								unitDemandPath(unit, unit is Hero);
							}
							
							unit.path.splice(0, 1);
						}
						else if (unit.path.length == 0)
						{
							unitDemandPath(unit, unit is Hero);
						}
						
						if (unit.tile.center.equals(unit.center))
						{
							unit.state = UnitState.Waiting;
						}
						else
						{
							unit.actionMoveToPoint(unit.tile.center);
						}
					break;
					
					// Attacking ----------------------------------
					case UnitState.Attacking:
						if ( ( (unit._target != unit.order.target || !(unit.order is UnitOrderAttack)) && !unit.isAIControlled) || 
							unit.actionAttack())
						{
							unit.state = UnitState.Waiting;
						}
					break;

					// Casting ----------------------------------
					case UnitState.Casting:
						if (!(unit.order is UnitOrderCastSpell) || 
							unit.actionCast((unit.order as UnitOrderCastSpell).spell))
						{
							unit.state = UnitState.Waiting;
							unit.order.completed = true;
						}
					break;
					
					// Constructing ----------------------------------
					case UnitState.Training:
						if ( !(unit.order is UnitOrderTrainUpgrade) ||
						 --(unit.order as UnitOrderTrainUpgrade).constructionTime <= 0)
						{
							unit.state = UnitState.Waiting;
						}
					break;

					// Repairing ----------------------------------					
					case UnitState.Repairing:
						if (!(unit.order is UnitOrderRepair) ||
							unit.actionRepair(unit.order.target as Unit))
						{
							unit.state = UnitState.Waiting;
						}
					break;

					// Linking ----------------------------------					
					case UnitState.Linked:
						if (!(unit.order is UnitOrderLink) || !unit.order.target || !unit.order.target.isActive)
						{
							unit.actionUnlink();
							unit.state = UnitState.Waiting;
						}
					break;										
					// End Unit States ----------------------------
				}
			}
		}
		
		private function processUnitPathfinding():void
		{		
			var totalTime:int;
			for (var i:int = 0; i < world.pathFinder.pathFindingQuota;)
			{
				if (_unitsToGetPath.isEmpty())
					return;
				
				var unit:Unit = _unitsToGetPath.popFront() as Unit;
				if (!unit.isActive || !unit.order.targetTile)
					continue;
				
				var tile:IsoTile = unit.order.targetTile;
							
				if (unit.path.length > 10)
				{
					// if unit has a path he can't use - try to better path for first 10 point
					// others probably good enough
					tile = unit.path[10];
					
					if (!tile.isFreeFor(unit))
					{
						tile = world.getFreeTileAroundPoint(tile, 5, unit, unit.type.isFlying);
					}
					
					if (!tile)
						tile = unit.order.targetTile;
				}
				
				if (!tile.isFreeFor(unit) || tile.region != unit.tile.region)
				{
					tile = world.getFreeTileAroundPoint(tile, 5, unit, unit.type.isFlying, true);
				}
				
				if (tile)
				{
					var time:int = getTimer();
					unit.path = world.pathFinder.getPath(unit.tile, tile, unit.type);
					totalTime += getTimer() - time;
					if (totalTime >= 8 || _units.length >= 170) ++i;	
				}
				
				unit.pathDemanded = false;
			}
		}
		
		public function unitDemandPath(unit:Unit, hightPriority:Boolean = false):void
		{
			if (unit.pathDemanded)
				return;
				
			unit.pathDemanded = true;
			if (hightPriority) _unitsToGetPath.pushFront(unit);
			else _unitsToGetPath.pushBack(unit);
		}
		
		public function processUnits():void
		{
			var gameTime:int = gameTime.value;
			
			for (var i:int = 0; i < _units.length; ++i)
			{
				var unit:Unit = _units[i];
				var uProps:Vector.<int> = unit.properties;
				
				// check if summon life time is over
				if (unit.summoner)
				{
					if (unit.summonLifeTime <= 0)
					{
						deleteUnitInternal(unit, i);
						continue;
					}
					unit.summonLifeTime--;
				}
				
				if (unit is Hero)
				{
					var hero:Hero = Hero(unit);
					hero.calculatePropertiesBasedOnStats();
					Utils.copyVector(unit.baseProperties, uProps);
					hero.applyItems(false);
					hero.applySpells();
					hero.processAi();
				}
				else
				{
					var baseProps:Vector.<int> = unit.baseProperties;
					var j:int = UnitProperties.CountWithoutReserved;
					while ( (--j) >= 0) uProps[j] = baseProps[j];
			
					unit.applySpells();
				}
				
				// after properties ready		
				var health:int = uProps[UnitProperties.Health];	
				var maxHealth:int = uProps[UnitProperties.MaxHealth];	
				if (health <= 0)
				{
					unit.actionDie();
				}
				if (!unit.isActive)
				{
					deleteUnitInternal(unit, i);
					continue;
				}
				
				if (unit.state == UnitState.UnderConstruction)
				{
					// check if construction complete
					if (health >= maxHealth)
					{
						unit.state = UnitState.Waiting;
						eventManager.dispatch(
							new GameEvent(GameEvents.CONSTRUCTION_COMPLETED, {unit:unit}));
						unit.setModel(unit.type.model.clone());
						GameManager.instance().showWarning(unit.type.locName + " complete.");
					}
				}
				else
				{
					if (gameTime % uProps[UnitProperties.HealthRegenRate] == 0)
					{
						unit.changeProp(UnitProperties.Health, 
							uProps[UnitProperties.HealthRegen], 
							maxHealth);
					}
					if (gameTime % uProps[UnitProperties.ManaRegenRate] == 0)
					{
						unit.changeProp(UnitProperties.Mana, 
							uProps[UnitProperties.ManaRegen], 
							uProps[UnitProperties.MaxMana]);
					}
							
					if (unit.auraSpell && (gameTime % unit.auraSpell.duration == 0))
					{
						var spell:Spell = game.spellManager.createSpellFromType(unit.auraSpell, unit, unit);
						game.spellManager.castSpell(spell, true, true);
					}
					
					if (unit.type.isTrader)
					{
						unit.resetStockItems();
					}
					
					if (unit is Structure)
					{
						if (health < maxHealth*0.4)
						{
							var bigFireEffect:SpecialEffectType = game.effectManager.getEffectType(SpecialEffects.BuildingBigFire);
							if (gameTime % bigFireEffect.duration == 0)
							{
								game.effectManager.addEffectByType(bigFireEffect, unit.physicalCenter);
							}	
						}
						else if (health < maxHealth*0.7)
						{
							var smallFireEffect:SpecialEffectType = game.effectManager.getEffectType(SpecialEffects.BuildingSmallFire);
							if (gameTime % smallFireEffect.duration == 0)
							{
								game.effectManager.addEffectByType(smallFireEffect, unit.physicalCenter);
								game.effectManager.addEffectByType(smallFireEffect, unit.center.add(new Point(-3, 10)));
							}							
						}
					}
				}
				
				world.pathFinder.setWalkable(
					unit, unit.state == UnitState.Moving);
			}
		}
		
		private function deleteUnitInternal(unit:Unit, index:int):void
		{
			_units.splice(index, 1);
			unit.fraction.detachUnit(unit);
			world.removeUnitFromWorld(unit);
			if (unit.summoner)
			{
				var indx:int = unit.summoner.summons.indexOf(unit);
				if (indx >= 0) unit.summoner.summons.splice(indx, 1);
			}
			eventManager.dispatch(new GameEvent(GameEvents.UNIT_REMOVED, {unit:unit}));
		}
		
		public function tick():void
		{
			processUnitOrders();
			processUnitStates();
			processUnits();
			processUnitPathfinding();
		}
		
		public function placeUnitOnWorld(unit:Unit, position:*, forced:Boolean = false, ignoreUnbuildable:Boolean=false):Boolean 
		{
			if (!unit || unit.isInWorld)
				return false;
			
			var ret:Boolean;
			var pos:Point;
			
			if (position is Point)
				pos = position;
			else
				pos = new Point(position.xindex, position.yindex);
			
			if (unit is Structure)
			{
				ret = world.placeStructureOnWorld(unit as Structure, pos, ignoreUnbuildable);
			} 
			else
			{
				ret = world.placeUnitOnWorld(unit, pos, forced);
			}
			
			if (ret)
			{
				unit.isInWorld = true;
				unit.isActive = true;
				unit.visible = true;
				_units.push(unit);	
				addToCategory(unit);
				eventManager.dispatch(new GameEvent(GameEvents.UNIT_ADDED, {unit:unit}));
			}
			return ret;
		}
		
		public function createUnitsFromType(count:int, typeOrId:*, fraction:Fraction):Vector.<Unit>
		{
			var type:UnitType;
			if (typeOrId is int)
				type = getTypeById(typeOrId);
			else
				type = typeOrId;
			
			var units:Vector.<Unit> = new Vector.<Unit>();
			for (var i:int = 0; i < count; ++i)
			{
				var unit:Unit = unitFactory.createUnit(type, fraction);
				units.push(unit);
			}
			
			return units;
		}
		
		public function getTypeById(id:int):UnitType
		{
			return _unitTypes.get(id) as UnitType;
		}

		public function getUnitByName(name:String):Unit
		{
			var id:int = IdManager.idByName(name);
			var len:int = _units.length;
			for (var i:int = 0; i < len; ++i)
			{
				if (_units[i].id == id)
					return _units[i];
			}
			
			return null;
		}
				
		public function placeUnitsOnWorld(units:Vector.<Unit>, positionOrArea:*, forced:Boolean = false, random:Boolean=false):void
		{
			if (positionOrArea is Point || positionOrArea is IsoTile)
			{
				for (var i:int = 0; i < units.length; ++i)
				{
					placeUnitOnWorld(units[i], positionOrArea, forced);
				}
			}
			else if (positionOrArea is Rectangle)
			{
				var rect:Rectangle = positionOrArea;
				var i:int = 0;
				if (random)
				{
					for (var i:int = 0; i < units.length; ++i)
					{
						var x:int = Utils.rand(rect.x, rect.right);
						var y:int = Utils.rand(rect.y, rect.bottom);
						placeUnitOnWorld(units[i], new Point(x, y), forced);
					}
				}
				else
				{	
					for (var x:int = rect.x; x < rect.right; ++x)
					{
						for (var y:int = rect.y; y < rect.bottom; ++y)
						{
							if (i >= units.length)
								return;
							
							if (placeUnitOnWorld(units[i], new Point(x, y), forced))
								i++;
						}
					}
				}
			}
		} 
		
		public function removeUnit(unit:Unit):void
		{
			if (unit)
				unit.isActive = false;
		}

		
		/**
		 * Removes units from world
		 * @param units group or units vector
		 */
		public function removeUnits(units:*):void
		{
			var unitsVector:Vector.<Unit>;
			if (units is UnitGroup)
				unitsVector = units.units;
			else
				unitsVector = units;
			
			for (var i:int = 0; i < unitsVector.length;++i)
			{
				removeUnit(unitsVector[i]);
			}
		}
		
		public function moveUnit(unit:Unit, pos:IsoTile, forced:Boolean=true, revive:Boolean = false):void
		{
			if (unit)
			{
				if (unit.isActive)
				{
					game.projectileManager.unsnapFrom(unit);
										
					world.placeUnitOnWorld(unit, new Point(pos.xindex, pos.yindex), forced);
					unit.stand();
					unit.state = UnitState.Waiting;
				}
				else if (revive)
				{
					reviveUnit(unit, pos);
				}
			}
		}		
		
		public function moveUnits(units:*, pos:IsoTile):void
		{
			var unitsVector:Vector.<Unit>;
			if (units is UnitGroup)
				unitsVector = units.units;
			else
				unitsVector = units;
			
			for (var i:int = 0; i < unitsVector.length;++i)
			{
				moveUnit(unitsVector[i], pos, true);
			}
		}
		
		public function reviveUnit(unit:Unit, pos:IsoTile):void
		{
			if (unit.isActive || unit.isInWorld) return;
			
			unit.isActive = true;
			unit.setProp(UnitProperties.Health, unit.properties[UnitProperties.MaxHealth]);
			unit.setProp(UnitProperties.Mana, unit.properties[UnitProperties.MaxMana]);
			placeUnitOnWorld(unit, pos, true);
			unit.state = UnitState.Waiting;
			unit.stand();
			unit.fraction.attachUnit(unit);
		}
		
		public function getUnitTypes(unitTypes:Array):Array
		{
			var types:Array = [];
			
			var iter:HashMapValIterator = _unitTypes.iterator() as HashMapValIterator;
			while (iter.hasNext())
			{
				var type:UnitType = iter.next() as UnitType;
				if (unitTypes.indexOf(type.type) != -1)
					types.push(type);
			}
			
			return types;
		}
		
		public function getUnitsByCategory(category:int):Vector.<Unit>
		{
			if (!_specialUnits[category])
				return new Vector.<Unit>();
				
			return 	_specialUnits[category];
		}
		
		private function addToCategory(unit:Unit):void
		{
			if (unit.type.isTrader)
			{
				if (_specialUnits[SpecialUnitCategory.STORE] == null)
					_specialUnits[SpecialUnitCategory.STORE] = new Vector.<Unit>();
					
				_specialUnits[SpecialUnitCategory.STORE].push(unit);	
			}
		}
	}
}