package engine.animation
{
	public final class UnitAnimation
	{	
		public static const Stand:int = 0;		
		public static const StandRight:int = 0;		
		public static const StandUpRight:int = 1;
		public static const StandUp:int = 2;	
		public static const StandUpLeft:int = 3;
		public static const StandLeft:int = 4;	
		public static const StandDownLeft:int = 5;
		public static const StandDown:int = 6;
		public static const StandDownRight:int = 7;	

		public static const Move:int = 8;	
		public static const MoveRight:int = 8;	
		public static const MoveUpRight:int = 9;			
		public static const MoveUp:int = 10;
		public static const MoveUpLeft:int = 11;
		public static const MoveLeft:int = 12;
		public static const MoveDownLeft:int = 13;	
		public static const MoveDown:int = 14;		
		public static const MoveDownRight:int = 15;	

		public static const Attack:int = 16;	
		public static const AttackRight:int = 16;
		public static const AttackUpRight:int = 17;		
		public static const AttackUp:int = 18;
		public static const AttackUpLeft:int = 19;
		public static const AttackLeft:int = 20;
		public static const AttackDownLeft:int = 21;	
		public static const AttackDown:int = 22;	
		public static const AttackDownRight:int = 23;	

		public static const Cast:int = 24;	
		public static const CastRight:int = 25;
		public static const CastUpRight:int = 26;		
		public static const CastUp:int = 27;
		public static const CastUpLeft:int = 28;
		public static const CastLeft:int = 29;
		public static const CastDownLeft:int = 30;	
		public static const CastDown:int = 31;	
		public static const CastDownRight:int = 32;	
		
		public static const Count:int = 32;		
		
		public static function isStandAnimation(animation:int):Boolean
		{
			return animation >= StandUp && animation <= StandUpLeft;
		}
				
		public static function isMoveAnimation(animation:int):Boolean
		{
			return animation >= MoveUp && animation <= MoveUpLeft;
		}
		
		public static function isAttackAnimation(animation:int):Boolean
		{
			return animation >= AttackUp && animation <= AttackUpLeft;
		}

		public static function isCastAnimation(animation:int):Boolean
		{
			return animation >= CastUp && animation <= CastUpLeft;
		}
				
		public static function sameType(animation1:int, animation2:int):Boolean
		{
			return isStandAnimation(animation1) && isStandAnimation(animation2)
				|| isMoveAnimation(animation1) && isMoveAnimation(animation2)
				|| isAttackAnimation(animation1) && isAttackAnimation(animation2)
				|| isCastAnimation(animation1) && isCastAnimation(animation2);
		}
		
		public static function fromDirection(type:int, dir:int):int
		{
			return type + dir;
		}
	}
}