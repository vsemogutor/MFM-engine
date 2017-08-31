package engine.userAction
{
	import engine.cursor.CursorType;
	import engine.game.Game;
	import engine.units.groups.UnitGroup;
	
	import flash.events.MouseEvent;
	
	public class UserActionOrderUnitAttack extends UserActionOrderUnitGroup
	{
		public function UserActionOrderUnitAttack(group:UnitGroup)
		{
			super(group);
			_needsSelection = true;
			_cursorType = CursorType.ATTACK;
		}
		
		public override function onMouseDown(evt:MouseEvent):void
		{
			if (checkPosition(evt.localX, evt.localY))
			{
				_group.orderAttack(_currentTile.unit);
				_currentTile.unit.displaySelection.setActive(0xFF0000);
			}
			done();
		}
		
		private function checkPosition(x:int, y:int):Boolean
		{
			_currentTile = Game.instance().sceneManager.pickIsoTile(x, y);
			return _currentTile && _currentTile.unit;
		}
	}
}