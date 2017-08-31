package engine.ai
{
	public class ItemAiHintType
	{
		public static const None:int = 0;
		public static const RestoreHealth:int = 1;
		public static const RestoreMana:int = 2;	
		public static const PowerUpStrength:int = 3;	
		public static const PowerUpAgility:int = 4;	
		public static const PowerUpIntellect:int = 5;
		public static const EquipableInt:int = 6;	
		public static const EquipableStrength:int = 7;	
		public static const EquipableAgility:int = 8;												
		public static const EquipableManaRegen:int = 9;
		public static const EquipableHealthRegen:int = 10;	
		public static const EquipableRaiseStats:int = 11;	
		public static const EquipableGeneric:int = 11;	
		
		
		public static function isPowerUp(aiHint:int):Boolean
		{
			return aiHint == PowerUpAgility || aiHint == PowerUpIntellect || aiHint == PowerUpStrength;
		}		
	}
}