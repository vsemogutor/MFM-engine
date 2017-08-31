package engine.units
{
	public final class DamageType
	{
		public static const Normal:int = 0;
		public static const Piersing:int = 1;	
		public static const Siedge:int = 2;
		public static const Magic:int = 3;	
		public static const Astral:int = 4;	
		public static const Hero:int = 5;
		public static const Spell:int = 6;		
				
		public static const types:Array = [Normal, Piersing, Siedge, Magic, Astral, Hero, Spell];
		
		public static function getTypeName(type:int):String
		{
			switch (type)
			{
				case Normal: return "Normal";
				case Piersing: return "Piersing";
				case Siedge: return "Siedge";
				case Magic: return "Magic";
				case Astral: return "Astral";
				case Spell: return "Spell";
				case Hero: return "Hero";
			}
			
			return "Unknown";
		}
	}
}