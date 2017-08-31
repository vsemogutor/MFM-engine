package engine.units.UnitOrders
{
	import computers.utils.Utils;
	
	import engine.game.Game;
	import engine.units.Unit;
	import engine.units.UnitProperties;
	import engine.units.UnitState;
	import engine.util.Constants;

	/**
	 * Order unit to wander around.
	 * @author Igor Novikov 
	 */
	public final class UnitOrderWander extends UnitOrderBase
	{
		private var _canAttack:Boolean = false;
		private var _cooldown:int;
		
		public function UnitOrderWander(unit:Unit, canAttack:Boolean = false)
		{
			// set initial cooldown to prevent everybody start wondering at the same time.
			_cooldown = Utils.rand(Constants.FRAME_RATE*3, Constants.FRAME_RATE*8);
			_canAttack = canAttack;
			super(unit, unit.tile, false);
		}
	
		public override function execute():int
		{
			if (_unit.state != UnitState.Waiting)
				return IN_PROGRESS;
			
			if (!unit.properties[UnitProperties.CanMove])
				return IN_PROGRESS;
			
			if (_cooldown <= 0)
			{
				var randX:int = Utils.rand(-2, 2);
				var randY:int = Utils.rand(-2, 2);	
				
				_targetTile = Game.instance().world.getTile(unit.tile.xindex + randX, unit.tile.yindex + randY);
				if (_targetTile)
				{
					var order:UnitOrderBase = new UnitOrderMove(unit, _targetTile, true);
					executeOtherFirst(order);
				}
				_cooldown = Utils.rand(Constants.FRAME_RATE, Constants.FRAME_RATE*8);
			} 
			else
			{
				--_cooldown;
				var order:UnitOrderBase = new UnitOrderStand(unit);
				order.execute();	
			}
			
			return IN_PROGRESS;
		}
	}
}