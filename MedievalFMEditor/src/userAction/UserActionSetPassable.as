package userAction
{
	import engine.core.isometric.IsoTile;
	import engine.game.Game;
	import engine.userAction.UserActionBase;
	
	import flash.events.MouseEvent;
	
	public class UserActionSetPassable extends UserActionBase
	{
		private var _passable:Boolean;
		private var _mouseDown:Boolean;
		private var _brushSize:int;
		
		public function UserActionSetPassable(passable:Boolean, brushSize:int)
		{
			_passable = passable;
			_brushSize = brushSize;
		}
		
		public override function onMouseDown(evt:MouseEvent):void
		{
			_currentTile = Game.instance().sceneManager.pickIsoTile(evt.localX, evt.localY);
			if (_currentTile)
			{
				_mouseDown = true;
				setTiles(_currentTile);
			}
		}
	
		protected override function onMouseMove(evt:MouseEvent):void
		{
			_currentTile = Game.instance().sceneManager.pickIsoTile(evt.localX, evt.localY);
			if (_mouseDown)
			{
				setTiles(_currentTile);
			}
		}
		
		private function setTiles(cTile:IsoTile):void
		{
			if (cTile)
			{
				for (var i:int = cTile.xindex - _brushSize + 1; i < cTile.xindex + _brushSize; ++i)
				{
					for (var j:int = cTile.yindex - _brushSize + 1; j < cTile.yindex + _brushSize; ++j)
					{
						var tile:IsoTile = Game.instance().world.getTile(i,j);
						if (tile)
						{
							tile.passable = _passable;
						}
					}				
				}
			}
		}
			
		protected override function onMouseUp(evt:MouseEvent):void
		{
			_mouseDown = false;
		}
	}
}