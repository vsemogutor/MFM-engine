package userAction
{
	import engine.core.isometric.IsoTile;
	import engine.game.Game;
	import engine.tileset.TileType;
	import engine.userAction.UserActionBase;
	
	import flash.events.MouseEvent;
	
	import utils.TilesetMapEditor;
	
	public class UserActionSetTile extends UserActionBase
	{
		private var _type:TileType;
		private var _mouseDown:Boolean;
		private var _brushSize:int;
		
		public function UserActionSetTile(type:TileType, brushSize:int)
		{
			_type = type;
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
							TilesetMapEditor.instance().setTileTypeByTile(tile, _type);
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