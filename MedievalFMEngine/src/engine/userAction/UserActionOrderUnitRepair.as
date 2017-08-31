package engine.userAction
{
	import engine.cursor.CursorType;
	import engine.game.Game;
	import engine.units.Unit;
	import engine.units.groups.UnitGroup;
	
	import flash.events.MouseEvent;

	public class UserActionOrderUnitRepair extends UserActionOrderUnitGroup
	{
		private var _unit:Unit;
				
		public function UserActionOrderUnitRepair(group:UnitGroup)
		{
			super(group);
			_needsSelection = true;
			_cursorType = CursorType.SELECT;
		}
		
		public override function onMouseDown(evt:MouseEvent):void
		{
			_success = checkPosition(evt.localX, evt.localY); 
			if (_success)
			{
				_group.orderRepair(_unit);
			}
			done();
		}
		
		private function checkPosition(x:int, y:int):Boolean
		{
			_currentTile = Game.instance().sceneManager.pickIsoTile(x, y);
			if (_currentTile)
			{
				_unit = _currentTile.unit
				return _currentTile && _unit 
					&& _unit.fraction.isAllyOf(_group.fraction);
			}
			
			return false;
		}	
	}
}