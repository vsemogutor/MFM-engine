package engine.units.UnitOrders
{
	import engine.core.events.GameEvent;
	import engine.core.events.GameEvents;
	import engine.fraction.ResourceType;
	import engine.game.Game;
	import engine.game.GameManager;
	import engine.units.*;
	import engine.units.upgrade.TypeUpgrade;
	import engine.units.upgrade.UnitTypeUpgrade;
	import engine.units.upgrade.UnitUpgrade;
	
	public final class UnitOrderTrainUpgrade extends UnitOrderBase
	{		
		private var _constructionQueue:Vector.<UnitType> = new Vector.<UnitType>();
		private var _constructionTime:int;
		private var _type:UnitType;
		
		public function get constructionTime():int {
			return _constructionTime;
		}
		public function set constructionTime(value:int):void {
			_constructionTime = value;
		}
		public function get constructionQueue():Vector.<UnitType> {
			return _constructionQueue;
		}

		public function get current():UnitType {
			return _type;
		}
		
		public override function get canInterrupt():Boolean
		{
			return _constructionQueue.length == 0;
		}
				
		public function UnitOrderTrainUpgrade(unit:Unit, type:UnitType)
		{
			super(unit, unit.tile);
			if (!type || type.type == UnitTypes.Structure)
				throw new Error("Wrong train or upgrade target");
				
			addToConstruction(type);
		}
		
		public function addToConstruction(type:UnitType):void
		{
			if ( !(type is UnitTypeUpgrade) || (_constructionQueue.length == 0 && !_type))
			{
				type.subtractCost(_unit.fraction);
				_constructionQueue.push(type);
			}
			else
			{
				if (_unit.fraction.isCurrentPlayer())
					GameManager.instance().showWarning("Upgrade is not allowed when train or upgrade is in progress.");
			}
		}
		
		public function removeFromConstruction(indx:int):void
		{
			if (indx < _constructionQueue.length && indx > -1)
			{
				_constructionQueue[indx].subtractCost(_unit.fraction, true);
				_constructionQueue.splice(indx, 1);
			}
		}		
		
		public override function execute():int
		{
			if (_unit.state != UnitState.Waiting)
				return IN_PROGRESS;
		
			if (!_type)
			{
				if (_constructionQueue.length > 0)
				{	
					_type = _constructionQueue.shift();
					_constructionTime = _type.constructionTime;
					_unit.state = UnitState.Training;
				}
				else
				{
					return COMPLETE;
				}
			}
			else
			{
				if (_constructionTime <= 0)
				{
					if (_type is UnitUpgrade)
					{
						var upgrade:UnitUpgrade = _type as UnitUpgrade;
						
						if (upgrade is TypeUpgrade)
						{
							upgrade.apply(_unit.fraction);
						}
						else
						{
							upgrade.apply(_unit);
						}
						Game.instance().eventManager.dispatch(
							new GameEvent(GameEvents.UPGRADE_COMPLETE, {upgrade:upgrade, fraction:_unit.fraction}));
						GameManager.instance().showWarning(upgrade.locName + " complete.");
					}
					else
					{
						var newUnit:Unit = Game.instance().unitManager.unitFactory.createUnit(_type, _unit.fraction);
						if (!newUnit.type.validatePopulationCost(unit.fraction))
						{
							if (_unit.fraction.isCurrentPlayer())
								GameManager.instance().showWarning("Can't complete training, population limit is exceeded.");
							return IN_PROGRESS;	
						}					
						
						if (!Game.instance().unitManager.placeUnitOnWorld(newUnit, _unit.tile, true))
						{
							if (_unit.fraction.isCurrentPlayer())
								GameManager.instance().showWarning("Can't complete training, not enough place around " + unit.type.locName + ".");
							return IN_PROGRESS;
						}
							
						// ve have already subtracted cost, it will we subtracred again in fraction attach, so add it back.
						_unit.fraction.addResource(ResourceType.Population, _type.costResources[ResourceType.Population]);
							
						Game.instance().eventManager.dispatch(
							new GameEvent(GameEvents.CONSTRUCTION_COMPLETED, {unit:newUnit, constructor:_unit}));
						if (_unit.fraction.isCurrentPlayer())
							GameManager.instance().showWarning(_type.locName + " is ready.");	
					}
					
					_type = null;
				}
				else
				{
					_unit.state = UnitState.Training;
				}
			}
			
			return IN_PROGRESS;
		}

	}
}