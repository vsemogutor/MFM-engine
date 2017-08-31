package engine.userAction
{
	import engine.game.Game;
	import engine.units.groups.UnitGroup;
	
	public class UserActionOrderUnitGroup extends UserActionBase
	{
		protected var _group:UnitGroup;
		
		public function UserActionOrderUnitGroup(group:UnitGroup)
		{
			_group = group;
		}
		
		internal override function process():Boolean
		{
			if (_group.isEmpty())
				done();
			
			return super.process();
		}
		
		internal override function enter():void
		{
			// prevent issuing orders to other fraction units
			if (!_group.isEmpty() && !_group.getUnit(0).fraction.isCurrentPlayer())
			{
			 	done();
			 	return;
			}
			
			super.enter();
		}
	}
}