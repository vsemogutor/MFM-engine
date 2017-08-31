package engine.animation
{
	import __AS3__.vec.Vector;
	
	import engine.display.IRenderable;
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public final class AnimatedSequenceSprite implements IRenderable
	{
		internal var _frames:Vector.<Rectangle> = new Vector.<Rectangle>();
		private var _bitmap:BitmapData;
		private var _frameHeight:int;
		private var _frameWidth:int;
		private var _name:String;	
		
		public function get bitmap():BitmapData{
			return _bitmap;
		}	
		public function get name():String{
			return _name;
		}
		public function get frameHeight():int{
			return _frameHeight;
		}
		public function get frameWidth():int{
			return _frameWidth;
		}
		public function get frames():Vector.<Rectangle>{
			return _frames;
		}
		
		public function AnimatedSequenceSprite(bitmap:BitmapData = null, frameHeight:int = 0, frameWidth:int = 0, startPos:Point = null, numOfFrames:int = 0, frameIndx:int=0)
		{			
			if (bitmap)
			{
				if (!startPos)
					startPos = new Point(0, 0);
				
				if (!frameWidth)
					frameWidth = _bitmap.width;
	
				if (!frameHeight)
					frameHeight = _bitmap.height;
								
				_bitmap = bitmap;
				_frameHeight = frameHeight;
				_frameWidth = frameWidth;
				
				var indx:int = 0;
				for (var i:int = startPos.x; i < _bitmap.width - startPos.x; i += frameWidth, ++indx)
				{
					if (frameIndx == 0 || indx == frameIndx)
					{
						_frames.push(new Rectangle(i, startPos.y, frameWidth, frameHeight));
						if (numOfFrames > 0 && _frames.length >= numOfFrames)
							break;
					}
				}
			}
		}
		
		public function clone():AnimatedSequenceSprite
		{
			var seq:AnimatedSequenceSprite = new AnimatedSequenceSprite();
			seq._bitmap = _bitmap;
			seq._frameHeight = _frameHeight;
			seq._frameWidth = _frameWidth;
			seq._name = _name;
			seq._frames = _frames;
			return seq;
		}
	}
}