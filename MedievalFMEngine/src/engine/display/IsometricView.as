package engine.display
{
	import __AS3__.vec.Vector;
	
	import com.greensock.TweenMax;
	import com.greensock.data.TweenMaxVars;
	import com.greensock.easing.Linear;
	
	import engine.animation.AnimatedSequenceSprite;
	import engine.animation.AnimatedSprite;
	import engine.area.Area;
	import engine.core.fm_internal;
	import engine.core.isometric.IsoTile;
	import engine.core.isometric.IsoWorld;
	import engine.cursor.CursorManager;
	import engine.fraction.Fraction;
	import engine.game.Game;
	import engine.heros.Hero;
	import engine.items.InventoryItem;
	import engine.objects.BaseObject;
	import engine.objects.isometric.IsoObject;
	import engine.projectile.Projectile;
	import engine.specialEffects.SpecialEffect;
	import engine.specialEffects.SpecialEffectLayers;
	import engine.specialEffects.generated.GeneratedEffect;
	import engine.structures.Structure;
	import engine.text.Text;
	import engine.tileset.CliffTileType;
	import engine.tileset.TileType;
	import engine.units.ArmorType;
	import engine.units.Unit;
	import engine.units.UnitProperties;
	import engine.util.Constants;
	import engine.util.StrUtil;
	
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	import mx.containers.Canvas;
	import mx.core.UIComponent;
	
	use namespace fm_internal;	
	
	[Event(name="initialized", type="flash.events.Event")]
	public final class IsometricView extends UIComponent
	{
		private static const SELECTION_COLOR:uint = 0x00BF11;		
		private static const SELECTION_COLOR_ALT:uint = 0x00FF11;	
		private static const LINK_COLOR:uint = 0xDED300;
		private static const HEALTH_BAR_BORDER_COLOR:uint = 0x042400;
		private static const HEALTH_BAR_GREEN_COLOR:uint = 0x00BF11;		
		private static const HEALTH_BAR_RED_COLOR:uint = 0xFF0011;
		private static const HEALTH_BAR_YELLOW_COLOR:uint = 0xDED300;
		private static const ENEMY_HEALTH_BAR_BORDER_COLOR:uint = 0x591414;		
								
	    private var _offScreen: BitmapData;
	    private var _effectsBuffer: BitmapData;	    
	    private var _gridLayer: Shape;
	    private var _selectionLayer: Shape;
	    private var _genEffLayer: Shape;
	    
	    public var isInitialized: Boolean = false;	    
	    public var visibleRect: Rectangle;
	    
	    private static const zeroPoint: Point = new Point(0, 0);
	    public var _world: IsoWorld;
	    

	    private var _displayGrid:Boolean = false;
	    
	    private var _visibleAreaTileWidth:int;
	    private var _visibleAreaTileHeight:int;
		
		public var highlightRegions:Vector.<Area> = new Vector.<Area>();
		public var selectionRegion:Rectangle;
		public var clickMark:ClickMark = new ClickMark(zeroPoint, 0);
		
		private var _canvas:Canvas;
		private var _screenMatrix:ColorMatrixFilter;
		private var _dr:Number = 1;
		private var _dg:Number = 1;		
		private var _db:Number = 1;
				
	    private var _heroGlowNum:int;
	    private var _heroGlowAlpha:Number;
	    private var _heroGlowUp:Boolean;
	    	    		
		// preset arrays to avoid memory allocation during drawing process
		private var unitsLayer:Vector.<IsoTile>;
		private var unitsLayerCount:int = 0;
		private var unitsFlyingLayer:Vector.<IsoTile>;
		private var itemsLayer:Vector.<IsoTile>;	
		private var itemsLayerCount:int = 0;			
		private var unitsFlyingLayerCount:int = 0;
		private var objectsLayer:Vector.<IsoTile>;
		private var objectsLayerCount:int = 0;
		private var cliffsLayer:Vector.<IsoTile>;
		private var cliffsLayerCount:int = 0;
		
		private var textfield:TextField = new TextField();
		private var game:Game;
		
		private static const textRect:Rectangle = new Rectangle(0, 0, 64, 32)
					    
	    public function set world(value:IsoWorld) :void {	    	
			isInitialized = false;						
			_world = value as IsoWorld;
			initializeDisplay();									
		}
		
		public function set displayGrid(value:Boolean) :void {
		 	_displayGrid = value;
		}
		
		public function get displayGrid() : Boolean {		 	
		 	return _displayGrid;		 	
		}
		
		public function get visibleAreaTileWidth():int{
	    	return _visibleAreaTileWidth;
	    }	  
	      
	    public function get visibleAreaTileHeight():int{
	    	return _visibleAreaTileHeight;
	    }

	    public function get drgb():Array{
	    	return [_dr, _dg, _db];
	    }
	    
		private function initializeDisplay():void 
		{
			staticInit();
			cleanUp();
						
			game = Game.instance();
			
			_canvas = this.parent as Canvas;
			
			if (!width)
				width = _canvas.width;
			if (!height)
				height = _canvas.height;
				
			if (!width || !height)
				throw new Error("View size if not correct");
				
			visibleRect = new Rectangle(Constants.TILE_WIDTH, Constants.TILE_U, width, height);
			_gridLayer = new Shape();
			_selectionLayer = new Shape();
			_genEffLayer = new Shape();
			_offScreen = new BitmapData(width + Constants.TILE_WIDTH*2, height + Constants.TILE_HEIGHT*2,false,0xffffffff);
			_effectsBuffer = new BitmapData(200, 200);

			_visibleAreaTileWidth = visibleRect.width/Constants.TILE_WIDTH;
			_visibleAreaTileHeight = visibleRect.height/Constants.TILE_HEIGHT;			

			isInitialized = true;
			
			var totalVisibleTilesCount:int = _visibleAreaTileHeight * _visibleAreaTileWidth;
			unitsLayer = new Vector.<IsoTile>(3*totalVisibleTilesCount, true);
			unitsFlyingLayer = new Vector.<IsoTile>(totalVisibleTilesCount, true);
			objectsLayer = new Vector.<IsoTile>(2*totalVisibleTilesCount, true);			
			cliffsLayer = new Vector.<IsoTile>(2*totalVisibleTilesCount, true);	
			itemsLayer = new Vector.<IsoTile>(2*totalVisibleTilesCount, true);	

	    	_heroGlowNum = 0;
	   		_heroGlowAlpha = -0.27;
	   		_heroGlowUp = true;

	        textfield.textColor = 0xF7D60D;	
	        _screenMatrix = null; 
	        
			_dr = 1;
			_dg = 1;		
			_db = 1;	             
	    									
			dispatchEvent(new Event("initialized"));
		}
		
		public function setTransform(dr:Number=1, dg:Number=1, db:Number=1, da:Number=1):void
		{
			_dr = dr;
			_dg = dg;
			_db = db;
			
			if (Math.abs(1 -_dr) < 0.01) _dr = 1;
			if (Math.abs(1 -_dg) < 0.01) _dg = 1;
			if (Math.abs(1 -_db) < 0.01) _db = 1;						
			
			if (_dr != 1 || _dg != 1 || _db != 1)
			{
				_screenMatrix = new ColorMatrixFilter([_dr, 0, 0, 0, 0,
														0, _dg, 0, 0, 0,
														0, 0, _db, 0, 0,
														0, 0, 0, da, 0]);				
			}
			else
			{
				_screenMatrix = null;
			}
		}
		
		public function getUnitDrawRect(unit:BaseObject):Rectangle
		{
			var xc:Number,yc:Number,dx:Number,dy:Number,x3dObj:Number,y3dObj:Number;
			dx =  - _offScreen.width/2;
			dy =  - _offScreen.height/2;
			xc = _world.xCenter;
			yc = _world.yCenter;
			dx +=(xc-yc)*Constants.TILE_U; 
			dy +=(xc+yc)*Constants.TILE_V;
			
			x3dObj = unit._x - unit._y - dx;
			y3dObj = ( unit._x  + unit._y )/2 - dy - unit._z;
			var pRect:Rectangle = unit._model.currentFrame;									
			x3dObj -= pRect.width/2;
			y3dObj -= pRect.height;
			
			// units are aligned at center of the tile
			if (!(unit is Structure) && !(unit is IsoObject))
			{
				y3dObj -= pRect.height/2 - Constants.TILE_V;
			}
			
			return new Rectangle(x3dObj - visibleRect.x, y3dObj - visibleRect.y, pRect.width, pRect.height);
		}
		
		private static var _isInitialized:Boolean;
		private static var _hBarsBitmaps:Vector.<Vector.<BitmapData>> = new Vector.<Vector.<BitmapData>>();
				
		private static function staticInit():void
		{
			if (_isInitialized) return;
			_isInitialized = true;
			
			const colors:Array = [HEALTH_BAR_BORDER_COLOR, ENEMY_HEALTH_BAR_BORDER_COLOR];
			
			var hbWidth:int = Constants.TILE_U + 8;
			var hBarShape:Shape = new Shape();

			for (var j:int = 0; j < colors.length; ++j)
			{			
				var bitmaps:Vector.<BitmapData> = new Vector.<BitmapData>();
				_hBarsBitmaps.push(bitmaps);
				
				for (var i:int = 0; i <= 20; ++i)
				{
					var bitmap:BitmapData = new BitmapData(hbWidth, 5, true, 0x00000000);
					var hRatio:Number = i/20;
					var hbBarWidth:int = hbWidth * hRatio;
					
					var barColor:uint;
					if (hRatio >= 0.8)
						barColor = HEALTH_BAR_GREEN_COLOR;
					else if (hRatio > 0.4)
						barColor = HEALTH_BAR_YELLOW_COLOR;
					else
						barColor = HEALTH_BAR_RED_COLOR;
						
					var selectionGraphics:Graphics = hBarShape.graphics;
					selectionGraphics.clear();
					selectionGraphics.lineStyle();
					selectionGraphics.beginFill(barColor);
					selectionGraphics.drawRect(0, 0, hbBarWidth, 4);
					selectionGraphics.endFill();
					
					selectionGraphics.lineStyle(1, colors[j]);
					selectionGraphics.drawRect(0, 0, hbWidth - 1, 4);
					
					bitmap.draw(hBarShape);
					bitmaps.push(bitmap);	
				}		
			}
		}
		
		private function drawHealthBar(unit:Unit, p:Point, pRect:Rectangle, borderColorIndx:uint=0):void
		{
			var hRatio:Number = unit.properties[UnitProperties.Health]/unit.properties[UnitProperties.MaxHealth];
			var hIndex:int = hRatio * 20;
			if (hIndex > 20) hIndex = 20;
			else if (hIndex < 0) hIndex = 0;
			
			var bitmap:BitmapData = _hBarsBitmaps[borderColorIndx][hIndex];
			
			_offScreen.copyPixels(bitmap, bitmap.rect, new Point(p.x + (pRect.width - bitmap.width)/2, p.y) ); 										
		}
		
		private function screenToDrawBoundary(screenX:int, screenY:int, xBoundary:Boolean):int
		{
			var x3d:int = screenX - width/2 + (visibleRect.x - (Constants.TILE_WIDTH));
			var y3d:int = screenY - height/2 + (visibleRect.y - Constants.TILE_V);
			var py2d:int = ( (y3d<<1) - x3d )>>1;

			if (xBoundary) 
			{
				var px2d:int = x3d + py2d;
				return _world.xCenter + Math.floor(px2d/Constants.TILE_U);
			}
			else return _world.yCenter + Math.floor(py2d/Constants.TILE_U);
		}
			
		private function fullRedraw():void 
		{										
			_offScreen.fillRect(_offScreen.rect, 0xff000000);		
			
			var player:Fraction = game.fractionManager.player;
			var xc:int, yc:int, dx:int, dy:int;
			var sel:DisplayUnitSelection;
			var pRect:Rectangle;
			
			dx =  -(_offScreen.width>>1);
			dy =  -(_offScreen.height>>1);
			xc = _world.xCenter;
			yc = _world.yCenter;
			dx +=(xc-yc)*Constants.TILE_U; 
			dy +=(xc+yc)*Constants.TILE_V;
			
			var pyy2d:int = ( (dy<<1) - dx ) >> 1;
			var pxx2d:int = dx + pyy2d;								
			var mxi:Number = Math.floor(pxx2d/Constants.TILE_U);
			var myi:Number = Math.floor(pyy2d/Constants.TILE_U);			
					
			var p:Point = new Point(0, 0);	
			var bd:BitmapData;		
			var x3d:Number;
			var y3d:Number;
									
			var wxGridSize:int = _world.xGridSize;
			var wyGridSize:int = _world.yGridSize;
			var tiles:Vector.<IsoTile> = _world.tiles;
			
			var visibleLeft:int = visibleRect.x - Constants.TILE_WIDTH;
			var visibleTop:int = visibleRect.y - Constants.TILE_WIDTH;		
			var visibleRight:int = visibleRect.right + (Constants.TILE_WIDTH<<1);
			var visibleBottom:int = visibleRect.bottom + (Constants.TILE_WIDTH<<1);
			
			var tilesetBitmap:BitmapData = _world.tileset.bitmap;
			var tilesetBitmaps:Vector.<BitmapData> = _world.tileset.bitmaps;
			var cycleTilesetBitmap:BitmapData = _world.tileset.getCycleBitmap();
			
			var curSprite:AnimatedSequenceSprite;
			var curPose:AnimatedSprite;			
			
			var selectionGraphics:Graphics = _selectionLayer.graphics;			
						
			unitsLayerCount = -1;
			objectsLayerCount = -1;
			unitsFlyingLayerCount = -1;
			itemsLayerCount = -1;
			cliffsLayerCount = -1;
			
			var xiStart:int = screenToDrawBoundary(0, 0, true);
			var bWidth:int = screenToDrawBoundary(visibleRect.width, visibleRect.height, true) + 1;
			
			var yiStart:int = screenToDrawBoundary(visibleRect.width, 0, false);
			var bHeigth:int = screenToDrawBoundary(0, visibleRect.height, false) + 1;			

			var gt:int = game.gameTime.value;
			if (gt % 3 == 0)
			{
				if (_heroGlowUp)
				{
				 	if (++_heroGlowNum >= 10) _heroGlowUp = false;
				 	_heroGlowAlpha += 0.05;
				} 
				else
				{
					if (--_heroGlowNum <= 2) _heroGlowUp = true;
					_heroGlowAlpha -= 0.05;
				}
			}
											
			var xi:int;
			for (var yi:int = yiStart; xiStart <= bWidth;)
			{				
				var yr:int = yi;
				for (xi = xiStart; xi <= bWidth && yr >= yiStart; ++xi, --yr)
				{
					var xt:int = xi;
					var yt:int = yr;
											
					// tiles display
					// don't display border tiles - they just border markers for pathfinder
					if ( xt > 0 && xt < wxGridSize - 1 && yt > 0 && yt < wyGridSize - 1 ) 
					{	
						// computes sreen coordinates
						var xtw:int = xt * Constants.TILE_U;
						var ytw:int = yt * Constants.TILE_U;
						
						x3d = xtw - ytw - dx - Constants.TILE_U;
						y3d = ((xtw + ytw)>>1) - dy + Constants.TILE_V;

						if (visibleLeft > x3d || visibleRight < x3d 
							|| visibleTop > y3d || visibleBottom < y3d)
							continue;
														
						var index:int = xt*wyGridSize + yt;									
						var tile:IsoTile = tiles[index];					
						var type:TileType = tile.type;			
												
						// for flat cliffs it is guarantied that tile underneath will not be visible																									
						if (tile.cliffTypeVariation != CliffTileType.FLAT)
						{
							pRect = type.tileTypeVariations[tile.tileTypeVariation];
							p.x = x3d;																		
							p.y = y3d - pRect.height;
							if (type.animated)
								_offScreen.copyPixels(cycleTilesetBitmap, pRect, p);
							else
								_offScreen.copyPixels(tilesetBitmaps[tile.tileVariation], pRect, p);	
						}

						var tObject:IsoObject = tile.object;	
						var tUnit:Unit = tile.unit;
						var tfUnit:Unit = tile.unitFlying;
						
						if (tile.cliffType)
						{
							unitsLayer[++unitsLayerCount] = tile;
							if (tObject)
							{
								if (tObject.passable)
								{
									objectsLayer[++objectsLayerCount] = tile;
									tUnit = tile.unit;
								}
								tObject._displayInfo.tile = tile;
							}
							
							if (tUnit)
							{
								if (!tUnit._displayInfo.tile)
								{
									tUnit._displaySelection.reset();
									tUnit._displayInfo.tile = tile;
								}
								else if (tUnit._displayInfo.tile.yindex < tile.yindex)
								{
									tUnit._displayInfo.tile = tile;
								}							
							}
						}
						else 
						{
							if (tObject) 
							{							
								if (!tObject.passable)
								{
									unitsLayer[++unitsLayerCount] = tile;
								}
								else
								{
									objectsLayer[++objectsLayerCount] = tile;
								}
	
								tObject._displayInfo.tile = tile;
							}
							else if (tile.items && tile.items.length)
							{
								itemsLayer[++itemsLayerCount] = tile;
							}
							
							if (tUnit)
							{
								if (!tUnit._displayInfo.tile)
								{
									if (tUnit.visible || tUnit.fraction.isAllyOf(player))
									{
										tUnit._displaySelection.reset();
										unitsLayer[++unitsLayerCount] = tile;
										tUnit._displayInfo.tile = tile;
									}
								}
								else if (tUnit._displayInfo.tile.yindex < tile.yindex)
								{
									unitsLayer[++unitsLayerCount] = tile;
									tUnit._displayInfo.tile = tile;
								}							
							}
						}							
						
						if (tfUnit)
						{
							tfUnit._displaySelection.reset();
							unitsFlyingLayer[++unitsFlyingLayerCount] = tile;
						}
					}					
				}	
				
				if (yi <= bHeigth) ++yi;
				else ++xiStart;			
			}

			for (var i:int = 0; i <= objectsLayerCount; ++i)
			{	
				var tile:IsoTile = objectsLayer[i];
				obj = tile.object;
				
				if (obj._displayInfo.tile != tile)
					continue;
					
				//obj._displayInfo.reset();
				obj._displayInfo.tile = null;

				bd = obj._model.getCurrentRenderable().bitmap;	
				pRect = bd.rect;	
					
				p.x = obj._x - obj._y - dx - pRect.width/2;
				p.y = (( obj._x  + obj._y )>>1) - dy - pRect.height - obj._z;
										
				_offScreen.copyPixels(bd, pRect, p);
			}	

			var effects:Vector.<SpecialEffect> = game.effectManager.effects;
			var eLength:int = effects.length;
			for (var i:int = 0; i < eLength; ++i)
			{
				var effect:SpecialEffect = effects[i];
				if (effect.type.layer != SpecialEffectLayers.BeforeUnits)
					continue;
				 
				curSprite = effect.model.currentAnimation;
				pRect = effect.model.currentFrame;
				
				var cx:Number = effect.position.x + pRect.width/2;
				var cy:Number = effect.position.y + pRect.height/2;
				p.x = cx - cy - dx - pRect.width/2;
				p.y = ( cx + cy )/2 - dy - pRect.height + effect.type.z									
					
				_offScreen.copyPixels(curSprite.bitmap, pRect, p);
			}
			
			for (var i:int = 0; i <= itemsLayerCount; ++i)
			{
				var tile:IsoTile = itemsLayer[i];
				var item:InventoryItem = tile.items[0];
				if (gt % 3 == 0) item.model.nextFrame();
									
				pRect = item.model.currentFrame;
				p.x = tile.x - tile.y - dx - pRect.width/2;
				p.y = (( tile.x + tile.y )>>1) - dy - pRect.height;
															
				_offScreen.copyPixels(item.model.currentAnimation.bitmap, pRect, p);					
			}
						
			var hoverOverUnit:Unit = CursorManager.instance().getUnitUnderCursor();
			for (var i:int = 0; i <= unitsLayerCount; ++i)
			{												
				var tile:IsoTile = unitsLayer[i];
				var obj:IsoObject = tile.object;
				
				// draw cliff
				if (tile.cliffType)
				{
					pRect = tile.cliffType.tileTypeVariations[tile.cliffTypeVariation];
					p.x = tile.x - tile.y - dx - pRect.width/2;
					p.y = (( tile.x + tile.y )>>1) - dy - pRect.height;
																
					_offScreen.copyPixels(tilesetBitmaps[tile.tileVariation], pRect, p);
					
					if ( (obj && !obj.passable) || tile.unit)
					{
						cliffsLayer[++cliffsLayerCount] = tile;
					}
				}
				else 
				{
					if (obj && !obj.passable)
					{ 
						if (obj._displayInfo.tile != tile)
							continue;
						
						//obj._displayInfo.reset();
						obj._displayInfo.tile = null;
							
						bd = obj._model.getCurrentRenderable().bitmap;
						pRect = bd.rect;
						
						p.x = obj._x - obj._y - dx - pRect.width/2;
						p.y = (( obj._x  + obj._y )>>1) - dy - pRect.height - obj._z;
						
						_offScreen.copyPixels(bd, pRect, p);
					}					
					else 
					{
						var unit:Unit = tile.unit;
						if (!unit)
							continue;
						
						if (unit is Structure)
						{ 
							if (unit._displayInfo.tile != tile)
								continue;
							
							unit._displayInfo.reset();
								
							bd = unit._model.getCurrentRenderable().bitmap;
							pRect = bd.rect;
							
							p.x = unit._x - unit._y - dx - pRect.width/2;
							p.y = (( unit._x  + unit._y )>>1) - dy - pRect.height - unit._z - 7;
							
							sel = unit._displaySelection;
							if (sel.display && !sel.processed)
							{
								var diagonal:Number = (unit.xLength + unit.yLength)/2;
								var sWidth:Number = diagonal*Constants.TILE_WIDTH + 2;
								var sHeight:Number = diagonal*Constants.TILE_HEIGHT + 2;
								var px:Number = p.x;
								var py:Number = p.y;
								
								if (sWidth > bd.width)
									px -= ((sWidth - bd.width)/2);
									
								if (diagonal > 1)
								{
									// decrease selection size a bit
									sWidth -= Constants.TILE_U;
									sHeight -= Constants.TILE_V;
									// move from left for 1/4 of tile width
									px += Constants.TILE_V;
									// move from bottom for 1/4 of a tile height
									py -= Constants.TILE_V>>1;
								}
								
								// align at bottom
								py += pRect.height - sHeight + 10;
																	
								selectionGraphics.clear();
								selectionGraphics.lineStyle(1, sel.color);
								selectionGraphics.drawEllipse(px, py, sWidth, sHeight);
								_offScreen.draw(_selectionLayer);
							}
							sel.processed = true;
							
							_offScreen.copyPixels(bd, pRect, p);
	/* 						
							if (unit.linkedTo)
							{
								selectionGraphics.clear();
								selectionGraphics.lineStyle(1, LINK_COLOR);
								
								selectionGraphics.moveTo(p.x + bd.rect.width/2, p.y + bd.rect.height/2);
				
								p.x = unit.linkedTo.x - unit.linkedTo.y - dx;
								p.y = ( unit.linkedTo.x  + unit.linkedTo.y )/2 - dy - bd.rect.height/2;									
						
								selectionGraphics.lineTo(p.x, p.y);
								_offScreen.draw(_selectionLayer);
							} */
							
							if (unit == hoverOverUnit && unit.properties[UnitProperties.ArmorType] != ArmorType.DIVINE)
							{
								p.y -= 7;
								drawHealthBar(unit, p, pRect);
							}
							else if (unit.fraction.isEnemyOf(player))
							{
								p.y -= 7;
								drawHealthBar(unit, p, pRect, 1);
							}	
						}
						else
						{
							unit._displayInfo.reset();		
																				
							curPose = unit._model;
							bd = curPose.getCurrentRenderable().bitmap;
							
							pRect = curPose.currentFrame;
							
							p.x = unit._x - unit._y - dx - pRect.width/2;
							p.y = ( unit._x  + unit._y )/2 - dy - pRect.height + Constants.TILE_V - pRect.height/2 - unit._z;									
							
							sel = unit._displaySelection;
							if (sel.display)
							{							
								selectionGraphics.clear();
								selectionGraphics.lineStyle(1, sel.color);
								selectionGraphics.drawEllipse(p.x + (pRect.width - Constants.TILE_U - 10)/2, 
									p.y + pRect.height - Constants.TILE_V - 8, Constants.TILE_U + 10, Constants.TILE_V + 8);
								_offScreen.draw(_selectionLayer);
							}
							sel.processed = true;
							
							if (unit is Hero || unit.summoner)
							{
								selectionGraphics.clear();
								var color:uint = unit.fraction.glowColor;
								selectionGraphics.lineStyle();
								
								var hWidth:int = Constants.TILE_U + _heroGlowNum;
								var hHeight:int = Constants.TILE_V + _heroGlowNum - 2;
								var sx:int = p.x + (pRect.width - Constants.TILE_U - _heroGlowNum)/2;
								var sy:int = p.y + pRect.height - Constants.TILE_V - _heroGlowNum;
								
								var matrix:Matrix = new Matrix();
								matrix.createGradientBox(hWidth, hHeight, 0, sx, sy);
																
								selectionGraphics.beginGradientFill(GradientType.RADIAL, [color, color, color], [0.7 + _heroGlowAlpha, 0.41 + _heroGlowAlpha, 0.08], [0, 100, 255], matrix);
								selectionGraphics.drawEllipse(sx, sy, hWidth, hHeight);
								_offScreen.draw(_selectionLayer);									
							}
								
							if (curPose.transform)
							{
								_effectsBuffer.floodFill(0, 0, 0xFFFFFFFF);
								_effectsBuffer.copyPixels(bd, pRect, zeroPoint);
								var eRect:Rectangle = new Rectangle(0, 0, pRect.width, pRect.height);
								_effectsBuffer.colorTransform(eRect, curPose.transform);
								_offScreen.copyPixels(_effectsBuffer, eRect, p);
							}
							else
							{									
								_offScreen.copyPixels(bd, pRect, p);
							}
								
							if (unit == hoverOverUnit)
							{
								drawHealthBar(unit, p, pRect);
							}	
							else if (unit.fraction.isEnemyOf(player))
							{
								drawHealthBar(unit, p, pRect, 1);
							}	
						}
					}
				}
			}

			for (var i:int = 0; i <= cliffsLayerCount; ++i)
			{												
				var tile:IsoTile = cliffsLayer[i];			
				var obj:IsoObject = tile.object;
				
				if (obj && !obj.passable)
				{ 
					if (obj._displayInfo.tile != tile)
						continue;
					
					//obj._displayInfo.reset();
					obj._displayInfo.tile = null;
						
					bd = obj._model.getCurrentRenderable().bitmap;
					pRect = bd.rect;
					
					p.x = obj._x - obj._y - dx - pRect.width/2;
					p.y = (( obj._x  + obj._y )>>1) - dy - pRect.height - obj._z;
					
					_offScreen.copyPixels(bd, pRect, p);
				}					
				else 
				{
					var unit:Unit = tile.unit;
					
					if (unit is Structure)
					{ 
						if (unit._displayInfo.tile != tile)
							continue;
						
						unit._displayInfo.reset();
							
						bd = unit._model.getCurrentRenderable().bitmap;
						pRect = bd.rect;
						
						p.x = unit._x - unit._y - dx - pRect.width/2;
						p.y = (( unit._x  + unit._y )>>1) - dy - pRect.height - unit._z - 7;
						
						sel = unit._displaySelection;
						if (sel.display && !sel.processed)
						{
							var diagonal:Number = (unit.xLength + unit.yLength)/2;
							var sWidth:Number = diagonal*Constants.TILE_WIDTH;
							var sHeight:Number = diagonal*Constants.TILE_HEIGHT;
							var px:Number = p.x;
							var py:Number = p.y;
							
							if (sWidth > bd.width)
								px -= ((sWidth - bd.width)/2);
								
							if (diagonal > 1)
							{
								// decrease selection size a bit
								sWidth -= Constants.TILE_U;
								sHeight -= Constants.TILE_V;
								// move from left for 1/4 of tile width
								px += Constants.TILE_V;
								// move from bottom for 1/4 of a tile height
								py -= Constants.TILE_V>>1;
							}
							
							// align at bottom
							py += pRect.height - sHeight + 10;
																
							selectionGraphics.clear();
							selectionGraphics.lineStyle(1, sel.color);
							selectionGraphics.drawEllipse(px, py, sWidth, sHeight);
							_offScreen.draw(_selectionLayer);
						}
						sel.processed = true;
						
						_offScreen.copyPixels(bd, pRect, p);
						
						if (unit == hoverOverUnit && unit.properties[UnitProperties.ArmorType] != ArmorType.DIVINE)
						{
							p.y -= 7;
							drawHealthBar(unit, p, pRect);
						}	
						else if (unit.fraction.isEnemyOf(player))
						{
							p.y -= 7;
							drawHealthBar(unit, p, pRect, 1);
						}						
/* 						if (unit.linkedTo)
						{
							selectionGraphics.clear();
							selectionGraphics.lineStyle(1, LINK_COLOR);
							
							selectionGraphics.moveTo(p.x + bd.rect.width/2, p.y + bd.rect.height/2);
			
							p.x = unit.linkedTo.x - unit.linkedTo.y - dx;
							p.y = ( unit.linkedTo.x  + unit.linkedTo.y )/2 - dy - bd.rect.height/2;									
					
							selectionGraphics.lineTo(p.x, p.y);
							_offScreen.draw(_selectionLayer);
						} */
					}
				}
			}
			
			if (_screenMatrix)
				_offScreen.applyFilter(_offScreen, _offScreen.rect, zeroPoint, _screenMatrix);
				
			if (clickMark.lifeTime > 0)
			{
				var x3dObj:Number = clickMark.x - clickMark.y - dx - (ClickMark.WIDTH >> 1);
				var y3dObj:Number = (( clickMark.x  + clickMark.y )>>1) - dy - ClickMark.HEIGHT - (ClickMark.HEIGHT>>1);		
				
				selectionGraphics.clear();
				
				var color1:uint;
				var color2:uint;
				
				if (clickMark.lifeTime > ClickMark.TOTAL_LIFE_TIME*0.6)
				{
					color1 = SELECTION_COLOR;
					color2 = SELECTION_COLOR;
				}
				else if (clickMark.lifeTime > ClickMark.TOTAL_LIFE_TIME*0.3)
				{
					color1 = SELECTION_COLOR_ALT;
					color2 = SELECTION_COLOR;				
				}
				else
				{
					color1 = SELECTION_COLOR_ALT;
					color2 = SELECTION_COLOR_ALT;					
				}
				
				selectionGraphics.lineStyle(1, color1);	
				selectionGraphics.drawEllipse(x3dObj, y3dObj, ClickMark.WIDTH, ClickMark.HEIGHT);
				selectionGraphics.lineStyle(1, color2);	
				selectionGraphics.drawEllipse(x3dObj + 4, y3dObj + 2, ClickMark.WIDTH - 8, ClickMark.HEIGHT - 4);
				_offScreen.draw(_selectionLayer);			
				
				clickMark.lifeTime--;
			}	
						
			for (var i:int = 0; i <= unitsFlyingLayerCount; ++i)
			{
				var tile:IsoTile = unitsFlyingLayer[i];
				var unit:Unit = tile.unitFlying;
				
				curPose = unit._model;
				bd = curPose.getCurrentRenderable().bitmap;
				pRect = curPose.currentFrame;
				
				p.x = unit._x - unit._y - dx - pRect.width/2;
				p.y = ((unit._x  + unit._y) >> 1) - dy - (pRect.height - Constants.TILE_V + pRect.height/2) - unit._z;									
					
				sel = unit._displaySelection;
				if (sel.display && !sel.processed)
				{		
					selectionGraphics.clear();
					selectionGraphics.lineStyle(1, sel.color);
					selectionGraphics.drawEllipse(p.x + (pRect.width - Constants.TILE_U - 4)/2, 
						p.y + pRect.height - 3*Constants.TILE_V/2 - 2, Constants.TILE_U + 4, Constants.TILE_V + 4);
					_offScreen.draw(_selectionLayer);
				}
				sel.processed = true;
								
				_offScreen.copyPixels(bd, pRect, p);	
				
				if (unit == hoverOverUnit)
					drawHealthBar(unit, p, pRect);				
			}
						
			for (var i:int = 0; i < eLength; ++i)
			{
				var effect:SpecialEffect = effects[i];
				if (effect.type.layer != SpecialEffectLayers.AfterUnits)
					continue;
				
				curSprite = effect.model.currentAnimation;
				var pRect:Rectangle = effect.model.currentFrame;
				
				var cx:Number = effect.position.x + pRect.width/2;
				var cy:Number = effect.position.y + pRect.height/2;
				bd = curSprite.bitmap;
				
				p.x = cx - cy - dx - pRect.width/2;
				p.y = ( cx + cy )/2 - dy - pRect.height + effect.type.z;									
					
				_offScreen.copyPixels(bd, pRect, p);
			}

			var genEffects:Vector.<GeneratedEffect> = game.effectManager.generatedEffects;
			var gEffLen:int = genEffects.length;
			for (var i:int = 0; i < gEffLen; ++i)
			{
				var gEffect:GeneratedEffect = genEffects[i];
				gEffect.update(_genEffLayer, dx, dy);
				_offScreen.draw(_genEffLayer, null, null, BlendMode.ADD);
			}
						
			var projectiles:Vector.<Projectile> = game.projectileManager.projectiles;
			var projLen:int = projectiles.length;
			for (var i:int = 0; i < projLen; ++i)
			{
				var projectile:Projectile = projectiles[i];
				
				curSprite = projectile.model.currentAnimation;
				var pRect:Rectangle = projectile.model.currentFrame;
				
				var cx:Number = projectile.position.x + pRect.width/2;
				var cy:Number = projectile.position.y + pRect.height/2;

				bd = curSprite.bitmap;
				p.x = cx - cy - dx - pRect.width/2;
				p.y = ( cx + cy )/2 - dy - pRect.height;									
					
				_offScreen.copyPixels(bd, pRect, p);
			}
			
			var texts:Vector.<Text> = game.textManager._inGameTexts;
			for (var i:int = 0; i < texts.length; ++i)
			{
				var text:Text = texts[i];
				textfield.text = text.text;
				p.x = text.x - text.y - dx;
				p.y = (( text.x  + text.y )>>1) - dy - text.height - 12;
						
				textfield.x = p.x;
				textfield.y = p.y;
				textfield.alpha = text.alpha;
				
				_effectsBuffer.fillRect(textRect, 0x00000000);
				_effectsBuffer.draw(textfield);
								
 				_offScreen.copyPixels(_effectsBuffer, textRect, p);
			}
			
			if (highlightRegions.length > 0)
			{
				var coord:Vector.<Number> = new Vector.<Number>(10, true);
				var commands:Vector.<int> = new Vector.<int>(5, true);
					
				for (var i:int = 0; i < highlightRegions.length; ++i)
				{
					var tileSelection:Area = highlightRegions[i];
				
					if (tileSelection.ellips)
					{
						var width:int = (tileSelection.width - 1)*Constants.TILE_U;
						var height:int = tileSelection.height*Constants.TILE_V - Constants.TILE_V/2;
												
						var centerX:Number = tileSelection.x*Constants.TILE_U - tileSelection.y*Constants.TILE_U - dx - (width>>1);
						var centerY:Number = ( tileSelection.x*Constants.TILE_U + tileSelection.y*Constants.TILE_U )/2 - dy - (height>>1);
					
						_gridLayer.graphics.beginFill(tileSelection.color, 0.2);
						_gridLayer.graphics.drawEllipse(centerX, centerY, width, height);				
					}
					else
					{
						commands[0] = 1;
						commands[1] = 2;
						commands[2] = 2;
						commands[3] = 2;
						commands[4] = 2;
									
						coord[0] = tileSelection.x*Constants.TILE_U - tileSelection.y*Constants.TILE_U - dx;
						coord[1] = ( tileSelection.x*Constants.TILE_U + tileSelection.y*Constants.TILE_U )/2 - dy - Constants.TILE_V;
						coord[2] = tileSelection.right*Constants.TILE_U - tileSelection.y*Constants.TILE_U - dx;
						coord[3] = ( tileSelection.right*Constants.TILE_U + tileSelection.y*Constants.TILE_U )/2 - dy - Constants.TILE_V;
						
						coord[4] = tileSelection.right*Constants.TILE_U - tileSelection.bottom*Constants.TILE_U - dx;
						coord[5] = ( tileSelection.right*Constants.TILE_U + tileSelection.bottom*Constants.TILE_U )/2 - dy - Constants.TILE_V;				
						coord[6] = tileSelection.x*Constants.TILE_U - tileSelection.bottom*Constants.TILE_U - dx;
						coord[7] = ( tileSelection.x*Constants.TILE_U + tileSelection.bottom*Constants.TILE_U )/2 - dy - Constants.TILE_V;
						coord[8] = tileSelection.x*Constants.TILE_U - tileSelection.y*Constants.TILE_U - dx;
						coord[9] = ( tileSelection.x*Constants.TILE_U + tileSelection.y*Constants.TILE_U )/2 - dy - Constants.TILE_V;
														
						_gridLayer.graphics.beginFill(tileSelection.color, Constants.SELECTION_ALPHA);
						_gridLayer.graphics.drawPath(commands, coord, "nonZero");
					}
				}
			}
			
			if (selectionRegion)
			{
				_gridLayer.graphics.beginFill(SELECTION_COLOR, Constants.SELECTION_ALPHA);
				_gridLayer.graphics.drawRect(
					selectionRegion.x + visibleRect.x, 
					selectionRegion.y + visibleRect.y, 
					selectionRegion.width, selectionRegion.height);
				_gridLayer.graphics.endFill();
			}
		}
		
		public function applyScroll():void
		{		
			visibleRect.x -= _world.xGap;
			visibleRect.y -= _world.yGap;
				
			_world.xGap = 0;
			_world.yGap = 0;

			while( visibleRect.x >= (Constants.TILE_WIDTH<<1) ) {
				_world.xCenter++;
				_world.yCenter--;										
				visibleRect.x -= Constants.TILE_WIDTH;											
			} 
			while( visibleRect.x <= 0) {
				_world.xCenter--;
				_world.yCenter++;	
				visibleRect.x += Constants.TILE_WIDTH;								
			}
			while( visibleRect.y >= Constants.TILE_WIDTH ) {
				_world.xCenter++;
				_world.yCenter++;						
				visibleRect.y -= Constants.TILE_U;										
			}
			while( visibleRect.y <= 0) {
				_world.xCenter--;
				_world.yCenter--;							
				visibleRect.y += Constants.TILE_U;								
			}
		}
		
		public function render():void 
		{	
			_canvas.graphics.clear();
			_gridLayer.graphics.clear();
			_gridLayer.graphics.lineStyle(0.3,0x0000FF,0.3);

			fullRedraw();		
			
			if (selectionRegion || highlightRegions.length > 0 || _displayGrid)
			{		
				_offScreen.draw(_gridLayer);
			}
			
			_offScreen.scroll(-visibleRect.x, -visibleRect.y);
			
			var canvasGraphics:Graphics = _canvas.graphics;
			
			canvasGraphics.beginBitmapFill(_offScreen);
			canvasGraphics.drawRect(0, 0, visibleRect.width, visibleRect.height);
			canvasGraphics.endFill();			
		}
		
		public override function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			if (StrUtil.startsWith(type, "mouse") || StrUtil.startsWith(type, "key"))
				_canvas.removeEventListener(type, listener, useCapture);
			else
				super.removeEventListener(type, listener, useCapture);
		}
		
		public override function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			if (StrUtil.startsWith(type, "mouse") || StrUtil.startsWith(type, "key"))
				_canvas.addEventListener(type, listener, useCapture, priority, useWeakReference);
			else
				super.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function fadeInOut(duration:int):void
		{
			TweenMax.killTweensOf(_canvas);
			var params:TweenMaxVars = new TweenMaxVars({alpha:0, useFrames:true, ease:Linear.easeOut});
			params.onComplete(function():void 
			{
				TweenMax.to(_canvas, duration>>1, {alpha:1, useFrames:true, ease:Linear.easeOut});
			});
			TweenMax.to(_canvas, duration>>1, params);
		}
		
		public function cleanUp():void
		{
			if (_offScreen) _offScreen.dispose();
			_offScreen = null;
			
			if (_effectsBuffer) _effectsBuffer.dispose();
			_effectsBuffer = null;
		}		
	}
}