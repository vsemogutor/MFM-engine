package engine.userAction
{
	import engine.cursor.CursorType;
	import engine.game.Game;
	import engine.sound.SoundManager;
	import engine.units.groups.UnitGroup;
	
	import flash.events.MouseEvent;
	
	public class UserActionOrderUnitMove extends UserActionOrderUnitGroup
	{
		public function UserActionOrderUnitMove(group:UnitGroup)
		{
			super(group);
			_needsSelection = true;
			_cursorType = CursorType.SELECT;
		}

		public override function onMouseDown(evt:MouseEvent):void
		{
			if (checkPosition(evt.localX, evt.localY))
			{
				_group.orderMove(_currentTile);
				SoundManager.instance().clickSound();
			}
			done();
		}
	
		protected override function onMouseMove(evt:MouseEvent):void
		{
			checkPosition(evt.localX, evt.localY);
		}
		
		private function checkPosition(x:int, y:int):Boolean
		{
			_currentTile = Game.instance().sceneManager.pickIsoTile(x, y);
			return _currentTile != null;
		}	
	}
}