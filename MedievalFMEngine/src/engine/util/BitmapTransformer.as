package engine.util
{
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Shape;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.GlowFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public final class BitmapTransformer
	{
		public static function recolorBitmap(bitmap:BitmapData,rcm:Number, 
			gcm:Number = 1, bcm:Number = 1, alphaM:Number = 1, add:Boolean = false):BitmapData
		{
			var transform:ColorTransform;
			if (add)
				transform =  new ColorTransform(1, 1, 1, alphaM, rcm, gcm, bcm);
			else
				transform = new ColorTransform(rcm, gcm, bcm, alphaM)
			
			var newBitmap:BitmapData = bitmap.clone();
			newBitmap.colorTransform(newBitmap.rect, transform);
			return newBitmap;
		}
		
		public static function flipHorisontal(bitmap:BitmapData, rect:Rectangle=null):BitmapData
		{
			if (!rect) rect = bitmap.rect;
			
			var frame:BitmapData = new BitmapData(rect.width, rect.height);
			var flipped:BitmapData = new BitmapData(rect.width, rect.height, true, 0x00FFFFFF);
						
			var matrix:Matrix = new Matrix( -1, 0, 0, 1, frame.width, 0);
			
			frame.copyPixels(bitmap, rect, new Point(0, 0));
			flipped.draw(frame, matrix);
			frame.dispose();
			
			return flipped;
		}		
		
		public static function addGlow(bitmap:BitmapData, color:uint, alpha:Number, blur:Number, rect:Rectangle=null):BitmapData
		{
			if (!rect) rect = bitmap.rect;
			
			var newBitmap:BitmapData = new BitmapData(rect.width, rect.height);	
			newBitmap.copyPixels(bitmap, rect, new Point(0, 0));
			
			var glow:GlowFilter = new GlowFilter(color, alpha, blur, blur, 3);
			newBitmap.applyFilter(newBitmap, newBitmap.rect, new Point(0,0), glow);
			
			return newBitmap;
		}
		
		public static function blackAndWhite(bitmap:BitmapData):BitmapData
		{
			var rLum:Number = 0.2225;
            var gLum:Number = 0.7169;
            var bLum:Number = 0.0606;
            
            var bwMatrix:Array = [rLum, gLum, bLum, 0, 0,
                            rLum, gLum, bLum, 0, 0,
                            rLum, gLum, bLum, 0, 0,
                            0, 0, 0, 1, 0];	
                            
            var filter:ColorMatrixFilter = new ColorMatrixFilter(bwMatrix);
            
            var newBitmap:BitmapData = bitmap.clone();
            newBitmap.applyFilter(newBitmap, newBitmap.rect, new Point(0,0), filter);
            
            return newBitmap;          		
		}
		
		public static function addNoise(bitmap:BitmapData, perlin:Boolean, strength:Number = 0.3):BitmapData
		{
			var newBitmap:BitmapData = bitmap.clone();			 
			var noiseTexture:BitmapData = new BitmapData(128, 128);
			var noise:Shape = new Shape();
			var srcXfrm:ColorTransform = new ColorTransform();
			srcXfrm.alphaMultiplier = strength;
							
			if (perlin)
			{
				noiseTexture.perlinNoise(3, 3, 8, Math.random()*int.MAX_VALUE, true, true, 7, true);
				noise.graphics.beginBitmapFill(noiseTexture);
				noise.graphics.drawRect(0, 0, bitmap.width, bitmap.height);
				noise.graphics.endFill();
				 
				newBitmap.draw(noise, null, srcXfrm, BlendMode.OVERLAY);				
			}												
			else
			{
				noiseTexture.noise(Math.random()*int.MAX_VALUE, 0, 27, 7, true);
				noise.graphics.beginBitmapFill(noiseTexture);
				noise.graphics.drawRect(0, 0, bitmap.width, bitmap.height);
				noise.graphics.endFill();
			
				newBitmap.draw(noise, null, srcXfrm, BlendMode.ADD);
			}
									
			newBitmap.merge(bitmap, bitmap.rect, new Point(0,0), 0, 0, 0, 0x100);
			noiseTexture.dispose();
			 
			return newBitmap;
		}
	}
}