package engine.units.UnitOrders
{
	import computers.utils.Utils;
	
	import engine.animation.UnitAnimation;
	import engine.core.fm_internal;
	import engine.core.isometric.IsoTile;
	import engine.game.Game;
	import engine.heros.Hero;
	import engine.units.Unit;
	import engine.units.UnitProperties;
	import engine.units.UnitState;
	import engine.util.Constants;
	import engine.util.TileUtil;
	
	use namespace fm_internal;

	public class UnitOrderMove extends UnitOrderBase
	{	
		private var _waitingTime:int = 0;
		
		public function UnitOrderMove(unit:Unit, tile:IsoTile, hasPriority:Boolean=true)
		{
			super(unit, tile, hasPriority);
		}
	
		public override function execute():int
		{
			if (_unit.state != UnitState.Waiting)
				return IN_PROGRESS;
				
			if (_unit.tile == _targetTile || 
				(TileUtil.getTileDist(_unit._tile, _targetTile) == 1 && !_targetTile.isFreeFor(_unit)))
				return COMPLETE;
				
			if (!unit.properties[UnitProperties.CanMove])
			{
/* 				if (_waitingTime > Constants.ORDER_DISCARD_TIME)
				{
					return COMPLETE;
				} */
				return IN_PROGRESS;
			}
			
			if (_unit.path.length > 0)
			{
				if (_unit.setTile(_unit.path[0]))
				{
					_unit.direction = Utils.getDir(_unit.center, _unit.path[0].center);
					_unit.actionMoveToPoint(_unit._tile.center);
					_unit.lastMoveTime = Game.instance().gameTime.value;
					_waitingTime = 0;
				}
				else
				{
					_waitingTime++;
					var pathExpTime:int = Game.instance().world.pathFinder.pathExpirationTime;
					if (_unit is Hero)
					{
						pathExpTime = (pathExpTime>>2);
						if (_waitingTime > pathExpTime)
							Game.instance().unitManager.unitDemandPath(_unit, true);
					}
					else if (_waitingTime > pathExpTime)
					{
						Game.instance().unitManager.unitDemandPath(_unit);
					}
					else if (_waitingTime > Constants.ORDER_DISCARD_TIME)
					{
						return COMPLETE;
					}
					return IN_PROGRESS;
				}
			}
			else
			{
				_unit.model.setCurrent(UnitAnimation.Stand, _unit.direction);
			}

			_unit.state = UnitState.Moving;
			
			return IN_PROGRESS;
		}
	}
}