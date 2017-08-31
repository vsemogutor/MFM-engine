package engine.units.UnitOrders
{
	import engine.core.isometric.IsoTile;
	import engine.game.Game;
	import engine.game.GameManager;
	import engine.units.*;
	
	public final class UnitOrderConstruct extends UnitOrderBase
	{
		private var _type:UnitType;
		
		public function get typeToConstruct():UnitType {
			return _type;
		}
				
		public function UnitOrderConstruct(unit:Unit, type:UnitType, targetTile:IsoTile)
		{
			super(unit, targetTile);
			_type = type;
		}

		public override function execute():int
		{
			var newUnit:Unit = Game.instance().unitManager.unitFactory.createUnit(_type, _unit.fraction);
			newUnit.state = UnitState.UnderConstruction;
			newUnit.setProp(UnitProperties.Health, 1);
			// set construction model
			newUnit.setModel(Game.instance().spriteRepository.
				getConstructionPlaceModel(_type.xLength, _type.yLength));
			
			if (Game.instance().unitManager.placeUnitOnWorld(newUnit, _targetTile, true))
			{
				_type.subtractCost(_unit.fraction);
				_unit.repair(newUnit);
			}
			else
			{
				if (_unit.fraction.isCurrentPlayer())
					GameManager.instance().showWarning("Can't build here.");
				return COMPLETE;
			}
			
			return IN_PROGRESS;
		}
	}
}