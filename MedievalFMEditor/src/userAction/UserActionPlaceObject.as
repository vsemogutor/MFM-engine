package userAction
{
	import computers.utils.Utils;
	
	import engine.area.Area;
	import engine.core.isometric.IsoTile;
	import engine.game.Game;
	import engine.objects.ObjectType;
	import engine.objects.isometric.IsoObject;
	import engine.userAction.UserActionBase;
	import engine.util.Util;
	
	import flash.events.MouseEvent;
	
	public class UserActionPlaceObject extends UserActionBase
	{
		private var type:ObjectType;	
		private var _area:Area;
		private var _isMouseDown:Boolean;
		private static const AreaValidColor:int = 0x00FF11;
		private static const AreaInvalidColor:int = 0xFF0000;	
		private var _brushSize:int;
		private var _random:Boolean;
			
		public function UserActionPlaceObject(type:ObjectType, brushSize:int, random:Boolean)
		{
			this.type = type;
			_brushSize = brushSize;
			_random = random;
			_area = new Area(null, -100, -100, type.xLength, type.yLength);
			Game.instance().areaManager.displayArea(_area);
		}
		
		public override function onMouseDown(evt:MouseEvent):void
		{
			checkPosition(evt.localX, evt.localY);
			if (_currentTile)
			{
				_isMouseDown = true;
				Game.instance().areaManager.displayArea(_area);
				placeObjects(_currentTile);
			}
		}
	
		protected override function onMouseMove(evt:MouseEvent):void
		{
			checkPosition(evt.localX, evt.localY);
			if (_isMouseDown)
			{
				placeObjects(_currentTile);
			}
		}
		
		private function placeObjects(cTile:IsoTile):void
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
							if (!_random || _brushSize <= 1 || Utils.rand(0, Utils.rand(80, 100)) > 55)
							{
								var object:IsoObject = Game.instance().objectManager.createObjectFromType(type);
								Game.instance().objectManager.placeObjectOnWorld(object, tile);
							}
						}
					}				
				}
			}
		}
		
		private function checkPosition(x:int, y:int):Boolean
		{
			_currentTile = Game.instance().sceneManager.pickIsoTile(x, y);
			if (_currentTile)
			{
				_area.x = _currentTile.xindex;
				_area.y = _currentTile.yindex;
			}
			
			if (Game.instance().world.canPlaceObject(_currentTile, type))
			{
				_area.color = AreaValidColor;
				return true;
			}
			else 
			{
				_area.color = AreaInvalidColor;
				return false;
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