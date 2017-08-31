package engine.ai.schedules.heroTasks
{
	import computers.utils.Utils;
	
	import engine.ai.AiContext;
	import engine.ai.schedules.tasks.AiHeroTask;
	import engine.core.isometric.IsoTile;
	import engine.units.UnitOrders.UnitOrderAttackMove;
	import engine.units.UnitOrders.UnitOrderMove;
	import engine.units.UnitOrders.UnitOrderStand;
	import engine.units.UnitState;
	import engine.util.TileUtil;

	public class AiTaskGoToWaypoint extends AiHeroTask
	{
		private var _waypointTraversalMode:int;
		private var _currentWaypoint:IsoTile;
		private var _attack:Boolean;
		private var _timeout:int;
		private var _lastSeenPosition:IsoTile;
		
		public function AiTaskGoToWaypoint(waypointTraversalMode:int, attack:Boolean = false)
		{
			_waypointTraversalMode = waypointTraversalMode;
			_attack = attack;
		}
		
		public override function execute(newContext:AiContext):Boolean
		{
			if (_attack && (_hero.state == UnitState.Attacking || _hero.state == UnitState.Casting))
				return true;
			
			if (!_currentWaypoint)
				_currentWaypoint = getNextWaypoint(_schedule.context.waypoints);
			
			var dist:int = TileUtil.getTileDist(_currentWaypoint, _hero.tile);
			if (dist < 3)
			{
				if (_hero.tile == _currentWaypoint || _hero.order.targetTile == _currentWaypoint)	 
					return true;
			}
			
			if (_hero.order.targetTile != _currentWaypoint)
			{
				if (_attack)
					_hero.attackMove(_currentWaypoint);
				else
					_hero.move(_currentWaypoint);
			}
			else if (_hero.tile == _lastSeenPosition 
				&& ((_hero.order is UnitOrderMove) || (_hero.order is UnitOrderStand)))
			{
				if (++_timeout >= 200)	return true;
			}
			else
			{
				_timeout = 0;
			}
			
			return false;
		}
		
		private function getNextWaypoint(waypoints:Array):IsoTile
		{
			var result:IsoTile;
							
			if (_waypointTraversalMode == WaypointTraversalMode.Nearest)
			{
				result = TileUtil.getClosestTile(_hero.tile, waypoints);
			}
			else
			{
				result = waypoints[Utils.rand(0, waypoints.length - 1)];
			}
			
			return result;
		}
	}
}