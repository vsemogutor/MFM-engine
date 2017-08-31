package engine.animation
{
	import __AS3__.vec.Vector;
	
	import engine.core.Direction;
	import engine.util.Constants;
	
	import flash.display.BitmapData;
	
	public final class UnitSprite extends AnimatedSprite
	{		
		public var attackFrame:int;
		
		public override function set currentAnimationIndx(indx:int):void
		{
			if (indx == _currentAnimationIndx)
				return;
				
			stop();
			if (UnitAnimation.sameType(indx, _currentAnimationIndx))
			{
				var frameIndx:int = currentFrameIndx;
				_currentAnimationIndx = indx;
				currentFrameIndx = frameIndx;
			}
			else
			{
				_currentAnimationIndx = indx;
				currentFrameIndx = 0;
			}
			_currentAnimation = _animations[_currentAnimationIndx];
		}
		
		public override function setCurrent(type:int, dir:int):void
		{
			currentAnimationIndx = UnitAnimation.fromDirection(type, dir);
		}
				
		public function copyStandFromMoving():void
		{
			if (animations[UnitAnimation.Move].frames.length != animations[UnitAnimation.Stand].frames.length)
			{
				addAnimationsFromBitmap(UnitAnimation.Stand, UnitAnimation.Stand + Direction.Count - 1, 
					animations[UnitAnimation.Move].bitmap);
			}
		}
		
		public function copyAttackFromStand():void
		{
			if (animations[UnitAnimation.Attack].frames.length != animations[UnitAnimation.Stand].frames.length)
			{
				addAnimationsFromBitmap(UnitAnimation.Attack, UnitAnimation.Attack + Direction.Count - 1, 
					animations[UnitAnimation.Stand].bitmap);
				addAnimationsFromBitmap(UnitAnimation.Cast, UnitAnimation.Cast + Direction.Count - 1, 
					animations[UnitAnimation.Stand].bitmap);					
			}
		}
				
		public function UnitSprite(frameHeight:int, frameWidth:int, moveBitmap:BitmapData = null, 
			standBitmap:BitmapData = null, attackBitmap:BitmapData = null, attackFrame:int = 0)
		{
			super(frameHeight, frameWidth);
			
			_animations = new Vector.<AnimatedSequenceSprite>(UnitAnimation.Count);
				
			if (attackBitmap)
			{
				addAnimationsFromBitmap(UnitAnimation.Attack, UnitAnimation.Attack + Direction.Count - 1, attackBitmap);
				addAnimationsFromBitmap(UnitAnimation.Cast, UnitAnimation.Cast + Direction.Count - 1, attackBitmap);
				if (!moveBitmap)
				{
					addAnimationsFromBitmap(UnitAnimation.Move, UnitAnimation.Move + Direction.Count - 1, attackBitmap, 1);
					if (!standBitmap)
						addAnimationsFromBitmap(UnitAnimation.Stand, UnitAnimation.Stand + Direction.Count - 1, attackBitmap, 1);
				}
			}
			
			if (standBitmap)
			{
				addAnimationsFromBitmap(UnitAnimation.Stand, UnitAnimation.Stand + Direction.Count - 1, standBitmap);
				if (!moveBitmap && !attackBitmap)
				{
					addAnimationsFromBitmap(UnitAnimation.Move, UnitAnimation.Move + Direction.Count - 1, standBitmap);
					addAnimationsFromBitmap(UnitAnimation.Attack, UnitAnimation.Attack + Direction.Count - 1, standBitmap);
					addAnimationsFromBitmap(UnitAnimation.Cast, UnitAnimation.Cast + Direction.Count - 1, standBitmap);
				}
			}
			
			if (moveBitmap)
			{
				addAnimationsFromBitmap(UnitAnimation.Move, UnitAnimation.Move + Direction.Count - 1, moveBitmap);
				if (!standBitmap)
				{
					var indx:int = Math.max(0, animations[UnitAnimation.Move].frames.length/2 - 1);
					addAnimationsFromBitmap(UnitAnimation.Stand, UnitAnimation.Stand + Direction.Count - 1, moveBitmap, Constants.UNDEFINED, indx);
				}
				if (!attackBitmap)
				{
					addAnimationsFromBitmap(UnitAnimation.Attack, UnitAnimation.Attack + Direction.Count - 1, standBitmap || moveBitmap, 1);
					addAnimationsFromBitmap(UnitAnimation.Cast, UnitAnimation.Cast + Direction.Count - 1, standBitmap || moveBitmap, 1);
				}
			}
			
			if (attackFrame == 0)
				this.attackFrame = animations[UnitAnimation.Attack].frames.length/2;
			else if (attackFrame > 0)
				this.attackFrame = attackFrame;
		}
		
		public override function clone():AnimatedSprite
		{
			var sprite:UnitSprite = new UnitSprite(_frameHeight, _frameWidth, null, null, null, Constants.UNDEFINED);
			sprite._id = id;
			sprite._name = _name;
			sprite._currentAnimationIndx = _currentAnimationIndx;
			sprite._animations = _animations;
			sprite.attackFrame = attackFrame;
			sprite._currentAnimation = _currentAnimation;
			
			return sprite;
		}
	}
}