package engine.units.UnitOrders
{
	import engine.game.GameManager;
	import engine.units.Unit;
	import engine.units.UnitProperties;
	import engine.units.UnitState;
	import engine.util.TileUtil;
	
	public final class UnitOrderLink extends UnitOrderBase
	{
		public function UnitOrderLink(unit:Unit, target:Unit)
		{
			super(unit, target.tile);
			_target = target;
		}
		
		public override function execute():int
		{
			var target:Unit = _target as Unit;
			if (!_unit.isAllowedFractionTarget(target))
			{
				GameManager.instance().showWarning("Wrong target.");
				_unit.actionUnlink();
				return COMPLETE;
			}
			
			if (_unit.state != UnitState.Waiting)
				return IN_PROGRESS;
				
			_unit.actionUnlink();
				
/* 			if (!_unit.properties[UnitProperties.CanLink] || !target.properties[UnitProperties.CanBeLinked])
			{
				GameManager.instance().showWarning("Wrong target.");
				return COMPLETE;
			} */
				
			var dist:int = TileUtil.getTileDist(
				target.getClosestActiveTile(_unit.tile), _unit.getClosestActiveTile(targetTile));
			if (dist <= 1)
			{
				_unit.actionLink(target);
				_unit.state = UnitState.Linked;
			}
			else
			{
				return COMPLETE;
			}
			
			return IN_PROGRESS;
		}
	}
}