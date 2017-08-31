package engine.units.UnitOrders
{
	import engine.game.GameManager;
	import engine.units.Unit;
	import engine.units.UnitProperties;
	import engine.units.UnitState;
	import engine.util.TileUtil;
	
	public final class UnitOrderRepair extends UnitOrderBase
	{
		private static const REPAIR_DISTANCE:int = 1;
		
		public function UnitOrderRepair(unit:Unit, target:Unit)
		{
			super(unit, target.tile);
			_target = target;
		}

		public override function execute():int
		{
			if (_unit.state != UnitState.Waiting)
				return IN_PROGRESS;
				
			var target:Unit = _target as Unit;
			if (!_unit.isAllowedAllyTarget(target) || !target.properties[UnitProperties.IsMechanical])
			{
				if (_unit.fraction.isCurrentPlayer())
					GameManager.instance().showWarning("Wrong target.");
				return ABORTED;
			}
				
			if (!_unit.type.canRepair)
				return ABORTED;
				
			if (target.properties[UnitProperties.Health] >= target.properties[UnitProperties.MaxHealth])
				return COMPLETE;
				
			_targetTile = target.getClosestActiveTile(_unit.tile);
			var dist:int = TileUtil.getTileDist(_targetTile, _unit.tile);
			if (dist <= REPAIR_DISTANCE)
			{
				_unit.state = UnitState.Repairing;
			}
			else
			{
				var moveOrder:UnitOrderMove = new UnitOrderMove(_unit, _targetTile, false);
				moveOrder.target = target;
				moveOrder.execute();
			}
			
			return IN_PROGRESS;
		}
	}
}