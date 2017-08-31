package engine.animation
{
	import de.polygonal.ds.HashMap;
	import de.polygonal.ds.HashMapValIterator;
	
	import engine.core.Direction;
	import engine.game.Game;
	import engine.util.BitmapTransformer;
	import engine.util.Constants;
	import engine.util.StrUtil;
	
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public final class SpriteRepository extends EventDispatcher
	{
		private var _sprites:HashMap = new HashMap();
		private var _spritesByName:HashMap = new HashMap();
		public var isInitialized:Boolean = false;
		private var _constructionPlaceModels:Array = [];
		private var _bitmapList:Object;
		private var _painter:Shape = new Shape();
		
		public function get sprites():HashMap {
			return _sprites;
		}
				
		public function SpriteRepository()
		{
		}
		
		public function init(bitmapsList:Object):void
		{
			_bitmapList = bitmapsList;
			var actionPattern:RegExp = /(Attack|Move|Flying|Stand)$/gi;
			
			for (var key:String in bitmapsList)
			{
				if (!StrUtil.startsWith(key, "sprite"))
					continue;
					
				var name:String = key.slice(6);
					
				var tokens:Array = name.split("_");
				if (tokens.length < 3)
					continue;
				
				var attackFrame:int = 0;
				var frameHeight:int = 0;
				var token:String = tokens.pop();
				if (StrUtil.startsWith(token, "a"))
				{
					attackFrame = parseInt(token.substr(1));
					frameHeight = parseInt(tokens.pop());
				}
				else
				{
					frameHeight = parseInt(token);
				}
				
				var frameWidth:int = parseInt(tokens.pop());
				name = tokens.pop().slice(0, name.length - 1);
				
				var sprite:AnimatedSprite;
				if (StrUtil.startsWith(name, "unit"))
				{
					var unitName:String = name.replace(actionPattern, "");
					
					if (_spritesByName.get(unitName))
						continue;
					
					var bitmapName:String = getUnitBitmapName("Move", unitName, frameWidth, frameHeight, attackFrame);
					var moveSeq:BitmapData = getNormalBitmap(bitmapName, frameWidth, frameHeight);
					var standSeq:BitmapData = null;
					
					if (!moveSeq)
					{
						bitmapName = getUnitBitmapName("Flying", unitName, frameWidth, frameHeight, attackFrame);
						moveSeq = getNormalBitmap(bitmapName, frameWidth, frameHeight);
						standSeq = moveSeq;
					}
					
					if (!standSeq)
					{
						bitmapName = getUnitBitmapName("Stand", unitName, frameWidth, frameHeight, attackFrame);
						standSeq = getNormalBitmap(bitmapName, frameWidth, frameHeight);
					}
					
					bitmapName = getUnitBitmapName("Attack", unitName, frameWidth, frameHeight, attackFrame);					
					var attackSeq:BitmapData = getNormalBitmap(bitmapName, frameWidth, frameHeight);
															
					sprite = new UnitSprite(frameHeight, frameWidth, moveSeq, standSeq, attackSeq, attackFrame);
					name = unitName;
				}
				else if (StrUtil.startsWith(name, "building"))
				{
					var baseSeq:BitmapData = getNormalBitmap("sprite" + name + "_" + frameWidth + "_" + frameHeight, frameWidth, frameHeight);														
					sprite = new UnitSprite(frameHeight, frameWidth, baseSeq, baseSeq, baseSeq);
				}
				else if (StrUtil.startsWith(name, "projectile"))
				{
					var bitmap:BitmapData = getNormalBitmap("sprite" + name + "_" + frameWidth + "_" + frameHeight, frameWidth, frameHeight);
					sprite = new AnimatedSprite(frameHeight, frameWidth, bitmap, Direction.Count);
				}
				else
				{
					var bitmap:BitmapData = getNormalBitmap("sprite" + name + "_" + frameWidth + "_" + frameHeight, frameWidth, frameHeight);
					sprite = new AnimatedSprite(frameHeight, frameWidth, bitmap);
				}
				
				if (_spritesByName.get(name))
					continue;
				
				sprite.name = name;
				addSprite(sprite);
			}
		}
		
		private function getUnitBitmapName(type:String, unitName:String, frameWidth:int, frameHeight:int, attackFrame:int):String
		{
			var name:String =  "sprite" + unitName + type + "_" + frameWidth + "_" + frameHeight;
			if (attackFrame > 0)
				name += "_a" + attackFrame;
			
			return name;
		}
		
		private function findAnimSeq(startsWith:String):BitmapData
		{
			for (var n:String in _bitmapList)
			{
				if (StrUtil.startsWith(n, startsWith))
					return _bitmapList[n];
			}
			return null;
		}
		
		private function convertFlippedToNormal(bitmap:BitmapData, frameWidth:int, frameHeight:int):BitmapData
		{
			var newBitmap:BitmapData = new BitmapData(bitmap.width, frameHeight * Direction.Count);
			var rect:Rectangle = new Rectangle(0, 0, bitmap.width, frameHeight * 3);
			newBitmap.copyPixels(bitmap, rect, new Point(0, 0));

			rect = new Rectangle(0, frameHeight * 3, bitmap.width, frameHeight * 2);			
			newBitmap.copyPixels(bitmap, rect, new Point(0, frameHeight * 5));	
			
			for (var i:int = 0; i < bitmap.width; i += frameWidth)
			{
				var flipped:BitmapData = BitmapTransformer.flipHorisontal(bitmap, new Rectangle(i, frameHeight * 1, frameWidth, frameHeight));			
				newBitmap.copyPixels(flipped, flipped.rect, new Point(i, frameHeight * 3));	
				flipped.dispose();
				
				flipped = BitmapTransformer.flipHorisontal(bitmap, new Rectangle(i, 0, frameWidth, frameHeight));			
				newBitmap.copyPixels(flipped, flipped.rect, new Point(i, frameHeight * 4));	
				flipped.dispose();
					
				flipped = BitmapTransformer.flipHorisontal(bitmap, new Rectangle(i, frameHeight * 3, frameWidth, frameHeight));		
				newBitmap.copyPixels(flipped, flipped.rect, new Point(i, frameHeight * 7));		
				flipped.dispose();		
			}	
			
			return newBitmap;	
		}
		
		private function getNormalBitmap(name:String, frameWidth:int, frameHeight:int):BitmapData
		{
			var bitmap:BitmapData = _bitmapList[name];	
			if (bitmap && bitmap.height/frameHeight == 5)
			{
				_bitmapList[name] = convertFlippedToNormal(bitmap, frameWidth, frameHeight);
			}
			
			return _bitmapList[name];
		}	
		
		public function addRecoloredUnitSprite(name:String, baseSprite:UnitSprite, rcm:Number, 
			gcm:Number = 1, bcm:Number = 1, alphaM:Number = 1, add:Boolean=false):UnitSprite
		{
			var moveBitmap:BitmapData = BitmapTransformer.recolorBitmap(
				baseSprite.animations[UnitAnimation.Move].bitmap, rcm, gcm, bcm, alphaM, add);
			var standBitmap:BitmapData;
			var attackBitmap:BitmapData;
			
			if (baseSprite.animations[UnitAnimation.Stand].bitmap != baseSprite.animations[UnitAnimation.Move].bitmap)
			{				
				standBitmap = BitmapTransformer.recolorBitmap(baseSprite.animations[UnitAnimation.Stand].bitmap, rcm, 
					gcm, bcm, alphaM, add);
			}
			
			if (baseSprite.animations[UnitAnimation.Attack].bitmap != baseSprite.animations[UnitAnimation.Stand].bitmap)
			{
				attackBitmap = BitmapTransformer.recolorBitmap(baseSprite.animations[UnitAnimation.Attack].bitmap, rcm, 
					gcm, bcm, alphaM, add);		
			}
			
			var sprite:UnitSprite = new UnitSprite(baseSprite.frameHeight, baseSprite.frameWidth, moveBitmap, standBitmap, attackBitmap, baseSprite.attackFrame);
			if (baseSprite.animations[UnitAnimation.Stand].frames.length == baseSprite.animations[UnitAnimation.Move].frames.length)
				sprite.copyStandFromMoving();
			if (baseSprite.animations[UnitAnimation.Stand].frames.length == baseSprite.animations[UnitAnimation.Attack].frames.length
				&& !attackBitmap)
				sprite.copyAttackFromStand();				
			
			sprite.name = name;
			addSprite(sprite);
			
			return sprite;
		}
		
		public function addRecoloredSprite(name:String, baseSprite:AnimatedSprite, rcm:Number, 
			gcm:Number = 1, bcm:Number = 1, alphaM:Number = 1, add:Boolean=false):AnimatedSprite
		{
			var newBitmap:BitmapData = BitmapTransformer.recolorBitmap(
				baseSprite.animations[0].bitmap, rcm, gcm, bcm, alphaM, add);
			
			var sprite:AnimatedSprite = new AnimatedSprite(baseSprite.frameHeight, baseSprite.frameWidth, newBitmap, baseSprite.animations.length);
			sprite.name = name;
			addSprite(sprite);
			return sprite;
		}	
		
		public function addBlackAndWhiteSprite(name:String, baseSprite:AnimatedSprite):void
		{
			var newBitmap:BitmapData = BitmapTransformer.blackAndWhite(baseSprite.animations[0].bitmap);
			
			var sprite:AnimatedSprite = new AnimatedSprite(baseSprite.frameHeight, baseSprite.frameWidth, newBitmap);
			sprite.name = name;
			addSprite(sprite);
		}	
		
		public function addFlippedSprite(name:String, baseSprite:AnimatedSprite, horisontal:Boolean=true):void
		{
			var newBitmap:BitmapData = BitmapTransformer.flipHorisontal(baseSprite.animations[0].bitmap);
			
			var sprite:AnimatedSprite = new AnimatedSprite(baseSprite.frameHeight, baseSprite.frameWidth, newBitmap);
			sprite.name = name;
			addSprite(sprite);
		}				

		public function addGlowSprite(name:String, baseSprite:AnimatedSprite, color:uint, alpha:Number, blur:Number):void
		{
			var newBitmap:BitmapData = BitmapTransformer.addGlow(baseSprite.animations[0].bitmap, color, alpha, blur);
			
			var sprite:AnimatedSprite = new AnimatedSprite(baseSprite.frameHeight, baseSprite.frameWidth, newBitmap, baseSprite.animations.length);
			sprite.name = name;
			addSprite(sprite);
		}	
		
		public function addGlowUnitSprite(name:String, baseSprite:UnitSprite, color:uint, alpha:Number, blur:Number):UnitSprite
		{
			var frameWidth:int = baseSprite.frameWidth;
			var frameHeight:int = baseSprite.frameHeight;
			
			
			var moveBitmap:BitmapData = addGlowToSequence(baseSprite.animations[UnitAnimation.Move].bitmap, frameWidth, frameHeight, color, alpha, blur);
				
			var standBitmap:BitmapData;
			var attackBitmap:BitmapData;
			
			if (baseSprite.animations[UnitAnimation.Stand].bitmap != baseSprite.animations[UnitAnimation.Move].bitmap)
			{				
				standBitmap = addGlowToSequence(baseSprite.animations[UnitAnimation.Stand].bitmap, frameWidth, frameHeight, color, alpha, blur);
			}
			
			if (baseSprite.animations[UnitAnimation.Attack].bitmap != baseSprite.animations[UnitAnimation.Stand].bitmap)
			{
				attackBitmap = addGlowToSequence(baseSprite.animations[UnitAnimation.Attack].bitmap, frameWidth, frameHeight, color, alpha, blur);		
			}
			
			var sprite:UnitSprite = new UnitSprite(baseSprite.frameHeight, baseSprite.frameWidth, moveBitmap, standBitmap, attackBitmap);
			if (baseSprite.animations[UnitAnimation.Stand].frames.length == baseSprite.animations[UnitAnimation.Move].frames.length)
				sprite.copyStandFromMoving();
			
			sprite.name = name;
			addSprite(sprite);
			
			return sprite;
		}
		
		private function addGlowToSequence(baseBitmap:BitmapData, frameWidth:int, frameHeight:int, color:uint, alpha:Number, blur:Number):BitmapData
		{
			var newBitmap:BitmapData = new BitmapData(baseBitmap.width, baseBitmap.height);
			
			for (var i:int = 0; i < baseBitmap.width; i += frameWidth)
			{
				for (var j:int = 0; j < baseBitmap.height; j += frameHeight)
				{
					var glow:BitmapData = BitmapTransformer.addGlow(baseBitmap, color, alpha, blur, new Rectangle(i, j, frameWidth, frameHeight));			
					newBitmap.copyPixels(glow, glow.rect, new Point(i, j));	
					glow.dispose();
				}		
			}
			
			return newBitmap;			
		}
				
		public function addSprite(sprite:AnimatedSprite, id:int = -1):int
		{
			if (id != Constants.UNDEFINED)
				sprite.id = id;
			else if (sprite.id == Constants.UNDEFINED)
				sprite.id = Game.instance().idManager.idByName(sprite.name);
			
			_sprites.set(sprite.id, sprite);
			_spritesByName.set(sprite.name, sprite);
			return sprite.id;
		}
		
		public function getById(id:int, copy:Boolean=true):AnimatedSprite
		{
			var sprite:AnimatedSprite = _sprites.get(id) as AnimatedSprite;
			if (sprite)
			{
				if (copy) return sprite.clone();
				else return sprite;
			}
			return null;
		}

		public function getByName(name:String, copy:Boolean=true):AnimatedSprite
		{
			var sprite:AnimatedSprite = _spritesByName.get(name) as AnimatedSprite;
			if (sprite)
			{
				if (copy) return sprite.clone();
				else return sprite;
			}
				
			return null;
		}
	
		public function getConstructionPlaceModel(width:int, height:int):UnitSprite
		{
			var model:UnitSprite = _constructionPlaceModels[width*2 + height] as UnitSprite;
			
			if (!model)
			{
				var bitmap:BitmapData = generateConstructionPlaceBitmap(width, height);
				model = new UnitSprite(bitmap.height, bitmap.width, bitmap, bitmap, bitmap);
				_constructionPlaceModels.push(_constructionPlaceModels);
			}
			
			return model.clone() as UnitSprite;
		}
		
		private function generateConstructionPlaceBitmap(width:int, height:int):BitmapData
		{
			var destrMaskIndx:int = 0;
			var test:int;
			var bitmap:BitmapData = new BitmapData(width*Constants.TILE_WIDTH, height*Constants.TILE_HEIGHT + Constants.TILE_HEIGHT, true, 0xffffff);
			
			// mumbo-jumbo calculations begin...
			// now I can't remember even how it works at all					
			for (var j:int = 0; j < height; ++j)
			{
				for (var i:int = 0; i < width; ++i)
				{
					destrMaskIndx = 0;
					if (width > 1 && height > 1)
					{
						var coef:int = 0;
						if (i > 0) 
						{
							if (i == width - 1) coef = 6;
							else coef = 8;
						}
						if (j == 0) destrMaskIndx = 6 + coef;
						else if (j == height - 1) destrMaskIndx = 3 + coef;
						else  destrMaskIndx = 7 + coef;
					}
					else if (width > 1 && height == 1)
					{
						if (i == 0) destrMaskIndx = 2;
						if (i == width - 1) destrMaskIndx = 8;
						else destrMaskIndx = 10;
					}
					else if (width == 1 && height > 1)
					{
						if (j == 0) destrMaskIndx = 4;
						if (j == height - 1) destrMaskIndx = 1;
						else destrMaskIndx = 5;
					}
					
					var temp:BitmapData = new BitmapData(bitmap.width, bitmap.height, true, 0xffffff);
					var dy:int = (width - height)*Constants.TILE_V - Constants.TILE_HEIGHT;	
					var dx:int = ((width + height) / 2)*Constants.TILE_U - dy - Constants.TILE_WIDTH;				
					var x:int = ((i - j) / 2)*Constants.TILE_WIDTH + dx;
					var y:int = ((i + j) / 2)*Constants.TILE_HEIGHT - dy;
					var rect:Rectangle = new Rectangle(destrMaskIndx*Constants.TILE_WIDTH, 0, Constants.TILE_WIDTH,  Constants.TILE_HEIGHT);
					temp.copyPixels(_bitmapList["constructionPlace"], rect, new Point(x, y));
					
					_painter.graphics.clear();
					_painter.graphics.beginBitmapFill(temp);
					_painter.graphics.drawRect(0, 0, temp.width, temp.height);
					_painter.graphics.endFill();
					
					bitmap.draw(_painter);
					temp.dispose();
				}
			}
			
			return bitmap;
		}
		
		public function getSprites(type:String):Array 
		{
			var sprites:Array = [];
			var iter:HashMapValIterator = _sprites.iterator() as HashMapValIterator;
			while (iter.hasNext())
			{
				var sprite:AnimatedSprite = iter.next() as AnimatedSprite;
				if (StrUtil.startsWith(sprite.name, type))
					sprites.push(sprite);
			}
			
			return sprites;
		}
	}
}