package engine.core
{
	import __AS3__.vec.Vector;
	
	import computers.utils.Utils;
	
	import engine.animation.AnimatedSequenceSprite;
	import engine.core.events.GameEvent;
	import engine.core.events.GameEvents;
	import engine.core.isometric.*;
	import engine.display.ClickMark;
	import engine.display.IsometricView;
	import engine.game.GameManager;
	import engine.game.GameState;
	import engine.tileset.*;
	import engine.timer.Timer;
	import engine.trigger.Trigger;
	import engine.units.Unit;
	import engine.util.*;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class SceneManager extends ManagerBase
	{
	    public var view: IsometricView;
	    
	    // Camera settings
	    private var _canScroll:Boolean = true;
	    private var _scrollDuration:int;
	   	private var _scrollDx:int;
	    private var _scrollDy:int;
	    private var _snapToUnit:Unit;
	    private var _shakeTime:int;
	    private var _shakeAmplitude:int;
	    private var _isInCinematicMode:Boolean;
	    
	    public function get visibleAreaTileWidth():int{
	    	return view.visibleAreaTileWidth;
	    }	    

	    public function get visibleAreaTileHeight():int{
	    	return view.visibleAreaTileHeight;
	    }
	    
	    public function get isInCinematicMode():Boolean{
	    	return _isInCinematicMode;
	    }		

	    public function get snapToUnit():Unit{
	    	return _snapToUnit;
	    }
	    		
		public function render(): void 
		{
			view.render();					
		}
		
		public function cameraCenter(): void
		{
			world.xCenter = Math.floor(world.xGridSize>>1);
			world.yCenter = Math.floor(world.yGridSize>>1);				
		}

		public function cameraCenterOnUnit(unit:Unit): void
		{
			world.xCenter = unit.tile.xindex;
			world.yCenter = unit.tile.yindex;				
		}		

		public function cameraScroll(dx:Number,dy:Number, duration:int = 0, ignoreFreeze:Boolean = false): void 
		{
			if (ignoreFreeze || (_canScroll && (!_snapToUnit || !_snapToUnit.isActive)))
			{
				_scrollDuration = duration;
				_scrollDx = dx;
				_scrollDy = dy;
	  		}				
		}
		
		public function setCameraScroll(direction:int): void 
		{
			if (_canScroll && !_snapToUnit)
			{
				_scrollDuration = int.MAX_VALUE;
				if (direction == Direction.UP)
					_scrollDy = GameManager.instance().options.scrollSpeed;
				else if (direction == Direction.Down)
					_scrollDy = -GameManager.instance().options.scrollSpeed;
				if (direction == Direction.Left)
					_scrollDx = GameManager.instance().options.scrollSpeed;
				else if (direction == Direction.Right)
					_scrollDx = -GameManager.instance().options.scrollSpeed;
	  		}				
		}

		public function stopCameraScroll(direction:int): void 
		{
			if (direction == Direction.UP || direction == Direction.Down)
				_scrollDy = 0;
			else if (direction == Direction.Left || direction == Direction.Right)
				_scrollDx = 0;
				
			if (!_scrollDy	&& !_scrollDx)
				_scrollDuration = 0;
		}
		
		public function stopCameraScrollAll():void
		{
			_scrollDx = 0;
			_scrollDy = 0;
			_scrollDuration = 0;
		}
				
		public function cameraMove(x:Number,y:Number, ignoreFreeze:Boolean = false): void 
		{
			if ( (ignoreFreeze || (_canScroll)) && world.getTile(x, y))
			{	
				world.xCenter = x;
				world.yCenter = y;	
				
				view.visibleRect.x = Constants.TILE_WIDTH;
				view.visibleRect.y = Constants.TILE_U;
			}			
		}		
		
		public function cameraShake(amplitude:int, time:int):void
		{
			_shakeTime = time;
			_shakeAmplitude = amplitude;
		}
		
		public function cameraSnapTo(unit:Unit):void
		{
			_snapToUnit = unit;
		}
		
		public function cameraFree():void
		{
			_canScroll = true;
			_snapToUnit = null;
		}
		
		public function cameraFreeze():void
		{
			_canScroll = false;
			_scrollDuration = 0;
			_scrollDx = 0;
			_scrollDy = 0;
		}
		
		public function processCamera():void
		{
			var scrollDx:int = _scrollDx;
			var scrollDy:int = _scrollDy;
			var scrollDuration:int = _scrollDuration;
			var mouseX:int = game.systemManager.stage.mouseX;
			var mouseY:int = game.systemManager.stage.mouseY;
			
			// scroll camera if cursor is at the stage borders
			if (scrollDuration <= 1 && game.currentState == GameState.PLAYING
				&& GameManager.instance().options.scrollWithMouse)
			{
				if (mouseX <= 5)
					cameraScroll(GameManager.instance().options.scrollSpeed, 0, 2);
				else if (mouseX >= view.width - 6)
					cameraScroll(-GameManager.instance().options.scrollSpeed, 0, 2);
					
				if (mouseY < 5)
					cameraScroll(0, GameManager.instance().options.scrollSpeed, 2);
				else if (mouseY > view.width - 6)
					cameraScroll(0, -GameManager.instance().options.scrollSpeed, 2); 					
			}
								
			if (_snapToUnit && _snapToUnit.isActive && _snapToUnit.isInWorld)
			{
				cameraMove(_snapToUnit.tile.xindex, _snapToUnit.tile.yindex, true);
				var cameraPos:Point = cameraPositionIso;
				var dx:int = cameraPos.x - _snapToUnit.center.x;
				var dy:int = _snapToUnit.center.y - cameraPos.y;
				world.xGap = dx + dy;
				world.yGap = Math.ceil((dx - dy) / 2);
			}
			else if ((scrollDx || scrollDy) && scrollDuration > 0)
			{				
				var visibleAreaWidth:int = visibleAreaTileWidth;
				var visibleAreaHeight:int = visibleAreaTileHeight;				
				
				var x:int = (world.xCenter - world.yCenter);
				var y:Number = ((world.xCenter + world.yCenter)>>1) + (visibleAreaHeight>>1);
				
				var diagonalSize:int = (world.xGridSize + world.yGridSize)>>1;
				
				if (x > -diagonalSize && scrollDx > 0 || 
					x + visibleAreaWidth < diagonalSize && scrollDx < 0)
					world.xGap = scrollDx;
					
				if (y - visibleAreaHeight > 0 && scrollDy > 0 || 
					y < diagonalSize && scrollDy < 0)
					world.yGap = scrollDy;
					
				_scrollDuration--;
			}
			
			if (_shakeTime > 0)
			{
				var dx:int = Utils.rand(-_shakeAmplitude, _shakeAmplitude);
				var dy:int = Utils.rand(-_shakeAmplitude, _shakeAmplitude);
				world.xGap += dx;
				world.yGap += dy;
				_shakeTime--;
			}
			
			view.applyScroll();
		}
		
		public function get cameraPositionIso():Point
		{
			return new Point(world.xCenter*Constants.TILE_U + view.visibleRect.x - Constants.TILE_WIDTH, 
				world.yCenter*Constants.TILE_U + view.visibleRect.y - Constants.TILE_HEIGHT);
		}
		
		public function enterCinematicMode():void{
			_isInCinematicMode = true;
			eventManager.dispatch(new GameEvent(GameEvents.ENTER_CINEMATIC_MODE));
		}

		public function exitCinematicMode():void{
			_isInCinematicMode = false;
			eventManager.dispatch(new GameEvent(GameEvents.EXIT_CINEMATIC_MODE));
		}
				
		public function displayGrid(value:Boolean): void 
		{
			view.displayGrid = value;					
		}
		
		public function screenToIso(screenX:int, screenY:int):Point 
		{
	    	var x3d:int = screenX - view.width/2 + (view.visibleRect.x - (Constants.TILE_U<<1));
			var y3d:int = screenY  - view.height/2 + Constants.TILE_V + (view.visibleRect.y - Constants.TILE_U);
			var dy:int = ( (y3d<<1) - x3d )>>1;
			var dx:int = x3d + dy;
			
			return new Point(world.xCenter*Constants.TILE_U + dx, world.yCenter*Constants.TILE_U + dy);
	    }
	    
	    public function pickIsoTile(screenX:int, screenY:int):IsoTile 
	    {	  	
	    	var x3d:int = screenX - view.width/2 + (view.visibleRect.x - (Constants.TILE_U<<1));
			var y3d:int = screenY  - view.height/2 + Constants.TILE_V+ (view.visibleRect.y - Constants.TILE_U);
			var py2d:int = ( (y3d<<1) - x3d )>>1;
			var px2d:int = x3d + py2d;
			var dx:Number = Math.floor(px2d/Constants.TILE_U);
			var dy:Number = Math.floor(py2d/Constants.TILE_U);
			var xt:int,yt:int;

			xt = world.xCenter + dx;
			yt = world.yCenter + dy;		
	
			return world.getTile(xt, yt);
	    }
	    
	    public function pickIsoTiles(area:Rectangle):Vector.<IsoTile> 
	    {	
	    	var tiles:Vector.<IsoTile> = new Vector.<IsoTile>();
	    	  	
	    	for (var i:int = area.x; i < area.right; i += Constants.TILE_V)
	    	{
	    		for (var j:int = area.y; j < area.bottom; j += Constants.TILE_V)
	    		{
	    			var screenX:int = i;
	    			var screenY:int = j;
	    			
			    	var x3d:int = screenX - view.width/2 + (view.visibleRect.x - (Constants.TILE_U<<1));
					var y3d:int = screenY  - view.height/2 + Constants.TILE_V + (view.visibleRect.y - Constants.TILE_U);
					var py2d:int = ( (y3d<<1) - x3d )>>1;
					var px2d:int = x3d + py2d;
					var dx:Number = Math.floor(px2d/Constants.TILE_U);
					var dy:Number = Math.floor(py2d/Constants.TILE_U);
			
					var tile:IsoTile = world.getTile(world.xCenter + dx, world.yCenter + dy);
					
					if (tile && tiles.indexOf(tile) == -1)
						tiles.push(tile);
			    }
			}
				
			return tiles;
	    }
	    
	    public function isHitSuccesefull(unit:Unit, screenPoint:Point):Boolean
		{
			if (unit)
			{
				var rect:Rectangle = view.getUnitDrawRect(unit);															
				if (rect.containsPoint(screenPoint))
				{
					var sprite:AnimatedSequenceSprite = unit.model.currentAnimation;
					var frame:Rectangle = unit.model.currentFrame;
					var px:int = screenPoint.x - rect.x + frame.x;
					var py:int = screenPoint.y - rect.y + frame.y;
					
					for (var i:int = px - 4; i <= px + 4; ++i)
					{
						for (var j:int = py - 4; j <= py + 4; ++j)
						{
							// check if hit pixel is not transparent
							if (frame.contains(i, j))
							{
								var color:uint = sprite.bitmap.getPixel32(i, j);
								if ((color >> 24 & 0xFF) > 0) return true;
							}
						}
					}
					
					return false;
				}
			}
			
			return false;
		}
		
		public function getUnitAtScreenPosition(screenPoint:Point):Unit
		{
			var area:Rectangle = new Rectangle();
			area.x = screenPoint.x - Constants.TILE_U;
			area.y = screenPoint.y - Constants.TILE_U;
			area.width = Constants.TILE_WIDTH;
			area.height = Constants.TILE_WIDTH << 1;

			var tile:IsoTile = pickIsoTile(screenPoint.x, screenPoint.y);
			tile && (area.y += tile.z);
			
			var tiles:Vector.<IsoTile> = pickIsoTiles(area);
			
			var selectedUnit:Unit;
			for (var i:int = 0; i < tiles.length; ++i)
			{
				if (isHitSuccesefull(tiles[i].unitFlying, screenPoint))
				{
					selectedUnit = tiles[i].unitFlying;
					continue;
				}
				if (isHitSuccesefull(tiles[i].unit, screenPoint))
				{
					if (!selectedUnit || tiles[i].unit.fraction.isEnemyOf(game.fractionManager.player) 
						|| selectedUnit.fraction.isAllyOf(game.fractionManager.player))
						selectedUnit = tiles[i].unit;
				}
			}	
			
			return selectedUnit;		
		}
		
		public function isUnitVisible(unit:Unit):Boolean
		{
			var rect:Rectangle = view.getUnitDrawRect(unit);
			return view.visibleRect.intersects(rect);
		}
		
		public function fadeInOut(duration:int):void
		{
			view.fadeInOut(duration);
		}
		
		public function placeLandMark(screenX:int, screenY:int):void
		{
			var pos:Point = screenToIso(screenX, screenY);
			view.clickMark = new ClickMark(pos);
		}
		
		public function applyTransform(dr:Number, dg:Number, db:Number, duration:GameTime):void
		{
			var periodFrames:int = Util.secToFrames(0.2);
			var totalFire:int = duration.value / periodFrames;
			var drgb:Array = view.drgb;
			var changeR:Number = drgb[0] - dr;
			var changeG:Number = drgb[1] - dg;
			var changeB:Number = drgb[2] - db;
									
			Trigger.addRepeat(function(state:Object, t:Timer):void
			{
				var cdrgb:Array = view.drgb;
				view.setTransform(cdrgb[0] - changeR/totalFire, cdrgb[1] - changeG/totalFire, cdrgb[2] - changeB/totalFire);
			}, 
			new GameTime(periodFrames),
			totalFire);
		}
	}
}