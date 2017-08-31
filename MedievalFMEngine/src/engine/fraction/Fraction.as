package engine.fraction
{
	import __AS3__.vec.Vector;
	
	import de.polygonal.ds.HashMap;
	import de.polygonal.ds.HashMapValIterator;
	
	import engine.ai.fraction.FractionAi;
	import engine.core.ManagerBase;
	import engine.core.events.GameEvent;
	import engine.core.events.GameEvents;
	import engine.heros.Hero;
	import engine.structures.Structure;
	import engine.units.Unit;
	import engine.units.UnitOrders.UnitOrderStand;
	import engine.units.UnitType;
	import engine.util.Constants;
	import engine.util.TileUtil;
	
	import flash.geom.Point;
	
	import mx.utils.ColorUtil;
	
	public final class Fraction extends ManagerBase
	{
		private static const AI_EXP_BONUS:Number = 0.16;		
		private static const AI_GOLD_BONUS:Number = 0.165;
								
		private var _name:String;
		private var _locName:String;
		public var color:uint;
		public var glowColor:uint;		
		public var controllerType:int;
		private var _id:int = Constants.UNDEFINED;
		internal var fractionRelationships:Array = [];
		private var _unitsByType:HashMap = new HashMap();
		private var _units:Vector.<Unit> = new Vector.<Unit>();	
		private var _resources:Vector.<int> = new Vector.<int>(ResourceType.Count);
		private var _statistics:FractionStatistics = new FractionStatistics();
		private var _workerTypes:Vector.<UnitType> = new Vector.<UnitType>();
		private var _ai:FractionAi;
		private var _heroes:Vector.<Hero> = new Vector.<Hero>();
		private var _expBonus:Number = 0;	
		private var _goldBonus:Number = 0;
		private var _startPoint:Point = new Point(0,0);
						
		public function get id():int
		{
			return _id;
		}
		
		public function set id(value:int):void
		{
			_id = value;
		}
				
		public function get name():String
		{
			return _name;
		}
		
		/**
		 * Gets localized display name of the fraction 
		 */
		public function get locName():String
		{
			return _locName;
		}

		public function set locName(value:String):void
		{
			_locName = value;
		}
		
		public function get statistics():FractionStatistics
		{
			return _statistics;
		}
		
		public function get units():Vector.<Unit>
		{
			return _units;
		}
		
		public function get heroes():Vector.<Hero>
		{
			return _heroes;
		}
		
		public function get expBonus():Number
		{
			return _expBonus;
		}

		public function set expBonus(value:Number):void
		{
			_expBonus = value;
			if (_ai) _expBonus += AI_EXP_BONUS;
		}
		
		public function get startPoint():Point
		{
			return _startPoint;
		}

		public function set startPoint(value:Point):void
		{
			_startPoint = value;
		}						
				
		public function getResource(type:int):int
		{
			return _resources[type];
		}
		
		public function setResource(type:int, value:int, notify:Boolean=true):void
		{
			_resources[type] = value;
			_statistics.setResourceTotal(type, value);
			if (notify)
			{
				eventManager.dispatch(
					new GameEvent(GameEvents.FRACTION_RESOURCE_CHANGED, 
					{fraction:this, resType:type, newValue:value}));
			}
		}	

		public function addResource(type:int, value:int, notify:Boolean=true):void
		{
			if (value)
			{
				var newValue:int = _resources[type] + value;
				setResource(type, newValue, notify);
			}
		}
						
		public function Fraction(name:String, controllerType:int, color:uint, locName:String = null, ai:FractionAi = null)
		{
			_name = name;
			this.color = color;
			this.glowColor = ColorUtil.adjustBrightness(color, 35);
			if (locName) _locName = locName;
			else _locName = _name;
			this.controllerType = controllerType;
			this._ai = ai;
			if (ai) 
			{
				ai.init(this);
				_expBonus = AI_EXP_BONUS;
				_goldBonus = AI_GOLD_BONUS;
			}
		}
		
		public function cleanUp():void
		{
			if (_ai) _ai.cleanUp();
			_ai = null;
			
			
		}
		
		public function isEnemyOf(fraction:Fraction):Boolean
		{
			return getRelationships(fraction) == FractionRelationshipType.Enemy;
		}
		
		public function isAllyOf(fraction:Fraction):Boolean
		{
			 return getRelationships(fraction) == FractionRelationshipType.Ally;
		}
		
		public function getRelationships(fraction:Fraction):int
		{
			if (fraction._id == PredefinedFractions.Passive || _id == PredefinedFractions.Passive)
				return FractionRelationshipType.Neutral;
			else if (fraction._id == _id)
				return FractionRelationshipType.Ally;
			else if (fraction._id == PredefinedFractions.PassiveAgressive || _id == PredefinedFractions.PassiveAgressive)
				return FractionRelationshipType.Enemy;
				
			var rel:* = fractionRelationships[fraction._id];
			
			if (!rel)
				return FractionRelationshipType.Neutral;
				
			return rel as int;
		}
		
		public function get isAIControlled():Boolean
		{
			return controllerType == FractionControllerType.Computer;
		}

		public function isCurrentPlayer():Boolean
		{
			return this == game.fractionManager.player;
		}
				
		public function getUnitsByType(type:UnitType):Vector.<Unit>
		{
			if (!_unitsByType.hasKey(type))
			{
				_unitsByType.set(type, new Vector.<Unit>());
			}
			
			return _unitsByType.get(type) as Vector.<Unit>;
		}
		
		public function attachUnit(unit:Unit):void 
		{
			var type:UnitType = unit.type;
			getUnitsByType(type).push(unit);
			_units.push(unit);
			
			if (unit is Hero)
			{
				_heroes.push(unit as Hero);
			}
			
			var populationCost:int = type.costResources[ResourceType.Population];
			var populationProduction:int = type.costResources[ResourceType.PopulationProduction];
		
			addResource(ResourceType.Population, -populationCost + populationProduction);
			addResource(ResourceType.PopulationProduction, populationProduction);
			
			// remember that this type can build.
			if (type.canBuild() && !(unit is Structure) && _workerTypes.indexOf(type) == -1)
				_workerTypes.push(type);
		}
		
		public function detachUnit(unit:Unit):void 
		{
			var units:Vector.<Unit> = getUnitsByType(unit.type);
			var indx:int = units.indexOf(unit);
			if (indx != -1)
				units.splice(indx, 1);
				
			indx = units.indexOf(unit);
			if (indx != -1)
				_units.splice(indx, 1);
				
			if (unit is Hero)
			{
				indx = _heroes.indexOf(unit);
				if (indx != -1)
				{
					_heroes.splice(indx, 1);
					if (Hero(unit).ai) Hero(unit).ai.reset();
				}
			}
				
			var populationCost:int = unit.type.costResources[ResourceType.Population];
			var populationProduction:int = -unit.type.costResources[ResourceType.PopulationProduction];
		
			addResource(ResourceType.Population, populationCost + populationProduction );
			addResource(ResourceType.PopulationProduction, populationProduction);
		}	
		
		public function checkDependenceies(dependencies:Vector.<UnitType>):Boolean
		{
			for (var i:int = 0; i < dependencies.length; ++i)
			{
				if (getUnitsByType(dependencies[i]).length == 0)
					return false;
			}
			
			return true;
		}
		
		public function getFreeWorkers():Vector.<Unit>
		{
			var freeWorkers:Vector.<Unit> = new Vector.<Unit>();
			var len:int = _workerTypes.length;
			for (var i:int = 0; i < len; ++i)
			{
				var workers:Vector.<Unit> = _unitsByType.get(_workerTypes[i]) as Vector.<Unit>;
				if (workers)
				{
					for (var j:int = 0; j < workers.length; ++j)
					{
						if (workers[j].order is UnitOrderStand)
						{
							freeWorkers.push(workers[j]);
						}
					}
				}
			}
			
			return freeWorkers;
		}
		
		public function distributeExpAndBounty(unit:Unit, experience:int, bounty:Vector.<int>, coeff:Number=1):void
		{
			var exp:int = experience * coeff;
			var gold:int = bounty[ResourceType.Gold];
			
			exp += exp * _expBonus;
			gold += gold * _goldBonus; 
			
			if (coeff < 1)
			{
				addResource(ResourceType.Gold, gold*(coeff/2));			
			}
			else
			{
				addResource(ResourceType.Gold, gold);
				addResource(ResourceType.Crystal, bounty[ResourceType.Crystal]);
			}
						
			if (unit is Hero)
			{
				Hero(unit).addExperience(exp);
			}
			else if (unit.summoner is Hero)
			{
				Hero(unit.summoner).addExperience(exp);
			}
			
			if (coeff == 1)
			{
				var fractions:HashMap = game.fractionManager.fractions;
				var iter:HashMapValIterator = fractions.iterator() as HashMapValIterator;
				while (iter.hasNext())
				{
					var fract:Fraction = iter.next() as Fraction;
					if (fract != this && isAllyOf(fract))
					{
						for (var j:int = 0; j < fract._heroes.length; ++j)
						{
							var hero:Unit = fract._heroes[j];
							var dist:int = TileUtil.getTileDist(unit.tile, hero.tile);
							if (dist <= 10)
							{
								fract.distributeExpAndBounty(hero, exp, bounty, 0.5);
								break;
							}
							else if (dist <= 25)
							{
								fract.distributeExpAndBounty(hero, exp, bounty, 0.3);
								break;								
							}
							else if (dist <= 50)
							{
								fract.distributeExpAndBounty(hero, exp, bounty, 0.1);
								break;								
							}
						}
					}
				}
			}
		}
	}
}