package engine.units.UnitOrders
{
	import engine.core.fm_internal;
	import engine.core.isometric.IsoTile;
	import engine.game.Game;
	import engine.units.Unit;
	import engine.units.UnitProperties;
	import engine.units.UnitState;
	import engine.util.TileUtil;
	import engine.util.Util;
	
	use namespace fm_internal;
	
	public final class UnitOrderAttack extends UnitOrderBase
	{
		private static const MAX_PERSUITE_TIME:int = Util.secToFrames(3);
		private var _holdPosition:Boolean;
		private var _lastInRangeTime:int;
		private var _lastDist:int = 100000;
		
		public function UnitOrderAttack(unit:Unit, target:Unit, holdPosition:Boolean = false)
		{
			super(unit, target.tile, true);
			this._target = target;
			this._holdPosition = holdPosition;
			_lastInRangeTime = Game.instance().gameTime.value + MAX_PERSUITE_TIME;
		}
		
		public override function execute():int
		{
			if (_unit.state != UnitState.Waiting)
				return IN_PROGRESS;	
			
			_unit._target = null;
			
			if (unit.properties[UnitProperties.AttackRange] <= 0)
				return ABORTED;
							
			var target:Unit = _target as Unit;
			if (!_unit.isAllowedTarget(target))
			{
/* 				if (_unit.fraction.isCurrentPlayer() && _target == _unit)
				{
					GameManager.instance().showWarning("Wrong target.");
				} */
				return ABORTED;		
			}
					
			var closestTile:IsoTile = target.getClosestActiveTile(_unit._tile);				
			var dist:int = TileUtil.getTileDist(_unit._tile, closestTile);
			var gt:int = Game.instance().gameTime.value;
			if (dist <= _unit.properties[UnitProperties.AttackRange])
			{
				_unit.state = UnitState.Attacking;		
				_lastInRangeTime = gt;	
				_unit._target = target;
			}
			else if (!_holdPosition && _unit.properties[UnitProperties.CanMove])
			{
				if (_parentOrder)
				{
					if ( ((gt > _lastInRangeTime + MAX_PERSUITE_TIME) && _lastDist <= dist) || (gt > _lastInRangeTime + MAX_PERSUITE_TIME*4))
					{
						_parentOrder.target = null;
						return COMPLETE;
					}
					_lastDist = dist;
				}
				
				setTargetTileAndResetPath(closestTile, dist);
				
				var moveOrder:UnitOrderMove = new UnitOrderMove(_unit, _targetTile, false);
				moveOrder.target = target;
				moveOrder.execute();
			}
			else
			{
				return COMPLETE;
			}
			
			_unit.actionCallForHelp(target);
				
			return IN_PROGRESS;
		}
		
	}
}