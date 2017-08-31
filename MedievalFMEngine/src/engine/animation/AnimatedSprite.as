package engine.animation
{
	import __AS3__.vec.Vector;
	
	import com.greensock.TweenMax;
	import com.greensock.data.TweenMaxVars;
	import com.greensock.easing.Linear;
	
	import engine.core.Direction;
	import engine.display.IRenderable;
	import engine.util.Constants;
	
	import flash.display.BitmapData;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class AnimatedSprite
	{
		protected var _animations: Vector.<AnimatedSequenceSprite> = new Vector.<AnimatedSequenceSprite>(Direction.Count);
		protected var _currentAnimationIndx:int = 0;		
		protected var _frameWidth:int;
		protected var _frameHeight:int;	
		protected var _id:int = Constants.UNDEFINED;
		protected var _name:String;
		public var transform:ColorTransform;
		public var currentFrameIndx:int = 0;
		private var _complete:Boolean;
		internal var _currentAnimation:AnimatedSequenceSprite;
		
										
		public function get id():int
		{
			return _id;
		}
		public function set id(newId:int):void
		{
			_id = newId;
		}	
		public function get frameWidth():int
		{
			return _frameWidth;
		}
		public function get frameHeight():int
		{
			return _frameHeight;
		}
		
		public function get currentAnimation():AnimatedSequenceSprite
		{
			return _currentAnimation;
		}

		public function get currentAnimationFramesNum():int
		{
			return _currentAnimation._frames.length;
		}
				
		public function get currentAnimationIndx():int
		{
			return _currentAnimationIndx;
		}
		
		public function set currentAnimationIndx(indx:int):void
		{
			if (indx == _currentAnimationIndx)
				return;
				
			stop();
			_currentAnimationIndx = indx;
			currentFrameIndx = 0;
			_currentAnimation = _animations[_currentAnimationIndx];
		}

		public function get complete():Boolean {
			return currentFrameIndx == _currentAnimation._frames.length - 1;
		}

		public function get currentFrame():Rectangle{
			return _currentAnimation._frames[currentFrameIndx];
		}				
		
		public function setCurrent(type:int, dir:int):void
		{
			currentAnimationIndx = dir;
		}
		
		public function get animations():Vector.<AnimatedSequenceSprite>
		{
			return _animations;
		}	
		
		public function get name():String
		{
			return _name;
		}
		public function set name(value:String):void
		{
			_name = value;
		}
		
		public function AnimatedSprite(frameHeight:int, frameWidth:int, bitmap:BitmapData = null, numOfAnimations:int=0)
		{
			_frameHeight = frameHeight;
			_frameWidth = frameWidth;
				
			if (bitmap)
				addAnimationsFromBitmap(0, numOfAnimations || (bitmap.height/_frameHeight), bitmap);
		}
		
		public function addAnimationsFromBitmap(startIndx:int, endIndx:int, bitmap:BitmapData, numOfFrames:int = 0, frameIndx:int=0):void
		{
			for (var i:int = startIndx; i <= endIndx; ++i)
			{
				var y:int = (i - startIndx)*_frameHeight;
				if (y >= bitmap.height)
					y = 0;
				_animations[i] = new AnimatedSequenceSprite(bitmap, _frameHeight, _frameWidth, 
					new Point(0, y), numOfFrames, frameIndx);
			}
			
			if (!_currentAnimation && _animations.length > 0) _currentAnimation = _animations[_currentAnimationIndx];	
		}
		
		public function setRenderable(renderable:BitmapData, direction:int = 0):void {
			addAnimationsFromBitmap(0, direction, renderable);
		}
		
		public function getCurrentRenderable():IRenderable
		{
			return _currentAnimation;
		}
		
		public function play(duration:int = 0, repeatTimes:int = -1):Boolean
		{
			var frames:Vector.<Rectangle> = _currentAnimation._frames;
			
			if (frames.length <= 1) return true;
			
			if (!duration) duration = frames.length*3;
							
			if (!TweenMax.isTweening(this) && !_complete)
			{	
				currentFrameIndx = 0;
				var params:TweenMaxVars = new TweenMaxVars({currentFrameIndx:frames.length - 1, useFrames:true, ease:Linear.easeOut});
				if (repeatTimes != -1)
				{
					var self:AnimatedSprite = this;
					params.onComplete(function():void 
					{
						TweenMax.to(self, 2*duration/frames.length, {currentFrameIndx:0, useFrames:true, ease:easeSet});
						_complete = true;
					});
				}
				
				if (repeatTimes != 1)
				{
					params.repeat(repeatTimes);
					params.repeatDelay(duration / frames.length);
				}	

										
				TweenMax.to(this, duration, params);
			}
			
			if (_complete)
			{
				_complete = false;
				return true;
			}
			return false;
		}	

		private static function easeSet (t:Number, b:Number, c:Number, d:Number):Number {
			return t == d ? 1 : 0;
		}		
		
		public function stop():void
		{
			_complete = false;
			TweenMax.killTweensOf(this);
		}
		
		public function nextFrame():void
		{
			if (currentFrameIndx < currentAnimation.frames.length - 1)
				++currentFrameIndx;
			else
				currentFrameIndx = 0;	
		}		

		public function clone():AnimatedSprite
		{
			var sprite:AnimatedSprite = new AnimatedSprite(_frameHeight, _frameWidth);
			sprite._id = id;
			sprite._name = _name;
			sprite._currentAnimationIndx = _currentAnimationIndx;
			sprite._animations = _animations;
			sprite._currentAnimation = _currentAnimation;
			
			return sprite;
		}
	}
}