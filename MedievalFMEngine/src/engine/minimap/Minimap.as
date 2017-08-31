package engine.minimap
{
	import __AS3__.vec.Vector;
	
	import engine.core.ManagerBase;
	import engine.core.events.GameEvent;
	import engine.core.events.GameEvents;
	import engine.core.isometric.IsoTile;
	import engine.game.GameState;
	import engine.heros.Hero;
	import engine.objects.isometric.IsoObject;
	import engine.units.Unit;
	import engine.util.Constants;
	
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.containers.Canvas;
	import mx.utils.ColorUtil;
	
	public final class Minimap extends ManagerBase
	{
		private static const REFRESH_DELAY:int = Constants.FRAME_RATE + 4;
		
		
		private var _canvas:Canvas;
		private var _minimapWidth:int;
		private var _minimapHeight:int;;
		private var _graphics:Graphics;
		private var _backBuffer:BitmapData;
		private var _staticBuffer:BitmapData;
		private var _viewPortBuffer:BitmapData;
		private var _viewPortGraphics:Graphics;
		private var _viewPortLayer:Shape;
		private var _updateInterval:int;	
		
		private var _viewportWidth:int;
		private var _viewportHeight:int;	
			
		private var _transform:Matrix;
		
		private var _skaleX:Number;
		private var _skaleY:Number;
		
		private var _enabled:Boolean;
		private var _mouseDown:Boolean;
		
		public function get enabled():Boolean{
			return _enabled;
		}
		
		public function set enabled(value:Boolean):void{
			_enabled = value;
		}
									
		public function init(drawTo:Canvas, updateInterval:int = 0, enabled:Boolean = true):void
		{						 
			_minimapWidth = drawTo.width;
			_minimapHeight = drawTo.height;		

			_staticBuffer = new BitmapData(world.yGridSize, world.xGridSize, false);
			_backBuffer = new BitmapData(world.yGridSize, world.xGridSize, false); 
			_viewPortBuffer = new BitmapData(world.yGridSize, world.xGridSize, false);
			_viewPortLayer = new Shape();
			_viewPortGraphics = _viewPortLayer.graphics;
			
			_canvas = drawTo;
			_graphics = drawTo.graphics;
			
			_canvas.addEventListener(MouseEvent.MOUSE_DOWN, onMouseClick);
			_canvas.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			_canvas.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			_canvas.addEventListener(MouseEvent.MOUSE_OUT, onMouseUp);
														
			if (updateInterval == 0)
			{
				// by default update once a second
				_updateInterval = Constants.FRAME_RATE;
			}
			else
			{
				_updateInterval	= updateInterval;
			}	
			
			if (_minimapHeight != _backBuffer.height || _minimapWidth != _backBuffer.width)
			{
				// if minimap is bigger/smaller than draw surface - scale
				_transform = new Matrix();
				
				_skaleY = _minimapHeight/_backBuffer.height;
				_skaleX = _minimapWidth/_backBuffer.width;
									
				_transform.scale(_skaleX, _skaleY);
			}
			else
			{
				_transform = null;
			}
			
			_viewportWidth = (scene.visibleAreaTileWidth)*_skaleX;
			_viewportHeight = (scene.visibleAreaTileHeight)*_skaleY - 4;
			
			_enabled = enabled;
			
			updateStaticBuffer();
			eventManager.addEventListener(GameEvents.OBJECT_ADDED, onObjectAddedRemoved);
			eventManager.addEventListener(GameEvents.OBJECT_REMOVED, onObjectAddedRemoved);
		}
		
		public function updateStaticBuffer():void
		{		
			if (!_enabled)
				return;
					
			var worldWidth:int = world.xGridSize;
			var worldHeight:int = world.yGridSize;
										
			for (var i:int = 0; i < worldWidth; ++i)
			{
				for (var j:int = 0; j < worldHeight; ++j)
				{
					var tile:IsoTile = world.getTileUnsafe(i, j);
					var color:uint = (tile.cliffType ? tile.cliffType.color : tile.type.color);;
					
					// since objects and tiles are pretty static - no need to update them often
					// this is better to do event based
					if (tile.object)
					{
						color = ColorUtil.adjustBrightness(color, -10);
						_staticBuffer.setPixel(worldHeight - j - 1, i, color);
					}
					else
					{
						_staticBuffer.setPixel(worldHeight - j - 1, i, color);
					}
				}
			}		
		}
		
		public function updateMinimap(force:Boolean = false):void
		{		
			if (!_enabled)
				return;
			
			if (gameTime.value % _updateInterval == 0 || force)
			{		
				_backBuffer.copyPixels(_staticBuffer, _staticBuffer.rect, new Point(0, 0));
												
				var units:Vector.<Unit> = game.unitManager.units;
				var len:int = units.length;
				var worldHeight:int = world.yGridSize;
				
				for (var i:int = 0; i < len; ++i)
				{
					var unit:Unit = units[i];
					
					var tile:IsoTile = unit.tile;
					if (unit.overTiles)
					{
						_backBuffer.fillRect(new Rectangle(worldHeight - tile.yindex - 1, tile.xindex, unit.yLength, unit.xLength), unit.fraction.color);
					}
					else
					{
						if (tile)
						{
							if (unit is Hero)
								_backBuffer.fillRect(new Rectangle(worldHeight - tile.yindex - 2, tile.xindex - 1, 6, 4), unit.fraction.color);
							else
								_backBuffer.fillRect(new Rectangle(worldHeight - tile.yindex - 1, tile.xindex, 2, 2), unit.fraction.color);
						}
					}
				}
				
				draw();
			}		
			else if (gameTime.value % 3 == 0)
			{
				// view port selection should be updated more often for smooth scrolling
				draw();
			}
			
			// since during editing you can actually change tile, updates to minimap is also required
			// this can be event based but since tile update can actually propagate to nearby tiles
			// we need to update whole minimap anyway - so update it once in a while
			if (gameTime.value % REFRESH_DELAY == 0 && game.currentState == GameState.EDITING )
			{
				updateStaticBuffer();
			}
		}
		
		private function draw():void
		{					
			_graphics.clear();
			
			_graphics.beginBitmapFill(_backBuffer, _transform, false);
			_graphics.drawRect(0, 0, _minimapWidth, _minimapHeight);
			_graphics.endFill();	
			
			_graphics.lineStyle(1, 0x00FF00);
			_graphics.drawRect((world.yGridSize - world.yCenter)*_skaleX - (_viewportHeight>>1),
				 world.xCenter*_skaleY - (_viewportWidth>>1), 
				_viewportHeight, _viewportWidth); 
			_graphics.lineStyle();	
		}
		
		private function onMouseClick(evt:MouseEvent):void
		{
			if (scene.snapToUnit && scene.snapToUnit.fraction.isCurrentPlayer())
			{
				var tile:IsoTile = world.getTile(evt.localY/_skaleY, world.yGridSize - evt.localX/_skaleX);
				if (tile) 
				{
					scene.snapToUnit.move(tile);
					_backBuffer.fillRect(new Rectangle(world.yGridSize - tile.yindex - 2, tile.xindex - 1, 6, 4), 0x00FF00);
				}
			}
			else
				scene.cameraMove(evt.localY/_skaleY, world.yGridSize - evt.localX/_skaleX);
			_mouseDown = true;
		}

		private function onMouseMove(evt:MouseEvent):void
		{
			if (_mouseDown)
				scene.cameraMove(evt.localY/_skaleY, world.yGridSize - evt.localX/_skaleX);
		}
		
		private function onMouseUp(evt:MouseEvent):void
		{
			_mouseDown = false;
		}
		
		private function onObjectAddedRemoved(evt:GameEvent):void
		{
			var object:IsoObject = evt.properties.object;
			
			for( var iy:int = 0 ; iy < object.yLength ; iy++ ) {
				for( var ix:int = 0 ; ix < object.xLength ; ix++ ) {
					var tile:IsoTile = object.overTiles[ix][iy];	
					if (evt.type == GameEvents.OBJECT_ADDED)		
						_staticBuffer.setPixel(world.yGridSize - tile.yindex - 1, tile.xindex, object.type.color);
					else
						_staticBuffer.setPixel(world.yGridSize - tile.yindex - 1, tile.xindex, tile.type.color);
				}						
			}
		}
		
		public function cleanUp():void
		{
			_canvas.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseClick);
			_canvas.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			_canvas.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			_canvas.removeEventListener(MouseEvent.MOUSE_OUT, onMouseUp);

			eventManager.removeEventListener(GameEvents.OBJECT_ADDED, onObjectAddedRemoved);
			eventManager.removeEventListener(GameEvents.OBJECT_REMOVED, onObjectAddedRemoved);						
		}
	}
}