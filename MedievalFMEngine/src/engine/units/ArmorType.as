package engine.units
{
	public final class ArmorType
	{
		public static const NONE:int = 0;
		public static const LIGHT:int = 1;
		public static const NORMAL:int = 2;
		public static const HEAVY:int = 3;
		public static const FORTIFIED:int = 4;
		public static const HERO:int = 5;
		public static const DIVINE:int = 6;	
		
		public static const types:Array = [NONE, LIGHT, NORMAL, HEAVY, FORTIFIED, HERO, DIVINE];
		
		public static function getTypeName(type:int):String
		{
			switch (type)
			{
				case NONE: return "NONE";
				case LIGHT: return "LIGHT";				
				case NORMAL: return "NORMAL";
				case HEAVY: return "HEAVY";
				case FORTIFIED: return "FORTIFIED";
				case HERO: return "HERO";				
				case DIVINE: return "DIVINE";
			}
			
			return "Unknown";
		}
	}
}