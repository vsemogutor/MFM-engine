package userAction
{
	import engine.area.Area;
	import engine.core.isometric.IsoTile;
	import engine.game.Game;
	import engine.userAction.UserActionBase;
	
	import flash.events.MouseEvent;
	
	public class UserActionRemoveObject extends UserActionBase
	{	
		private var _area:Area;
		private var _isMouseDown:Boolean;
		private static const AreaValidColor:int = 0x00FF11;
		private static const AreaInvalidColor:int = 0xFF0000;	
		private var _brushSize:int = 1;	
			
		public function UserActionRemoveObject(brushSize:int)
		{
			_area = new Area(null, -100, -100, 1, 1);
			_brushSize = brushSize;
			Game.instance().areaManager.displayArea(_area);
		}
		
		public override function onMouseDown(evt:MouseEvent):void
		{
			checkPosition(evt.localX, evt.localY);
			if (_currentTile)
			{
				_isMouseDown = true;
				Game.instance().areaManager.displayArea(_area);
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
							if (tile.object)
								Game.instance().objectManager.removeObject(tile.object);
						}
					}				
				}
			}
		}
	
		protected override function onMouseMove(evt:MouseEvent):void
		{
			checkPosition(evt.localX, evt.localY);
			if (_currentTile && _isMouseDown)
			{
				if (_currentTile.object)
					Game.instance().objectManager.removeObject(_currentTile.object);
			}
		}
		
		private function checkPosition(x:int, y:int):void
		{
			_currentTile = Game.instance().sceneManager.pickIsoTile(x, y);
			if (_currentTile)
			{
				_area.x = _currentTile.xindex;
				_area.y = _currentTile.yindex;
			}
			
			if (_currentTile && _currentTile.object)
			{
				_area.color = AreaValidColor;
			}
			else 
			{
				_area.color = AreaInvalidColor;
			}
		}
			
		protected override function onMouseUp(evt:MouseEvent):void
		{
			_isMouseDown = false;
			//Game.instance().areaManager.displayArea(_area, false);
		}
		
		protected override function afterCleanup():void
		{
			Game.instance().areaManager.displayArea(_area, false);
		}

	}
}