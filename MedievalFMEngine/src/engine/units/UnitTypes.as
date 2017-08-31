package engine.units
{
	public final class UnitTypes
	{
		public static const Unit:int = 0;
		public static const Hero:int = 1;		
		public static const Structure:int = 2;
		
		public static const types:Array = [Unit, Hero, Structure];
		
		public static function getTypeName(type:int):String
		{
			if (type == Unit)
				return "Unit";
			if (type == Hero)
				return "Hero";
			if (type == Structure)
				return "Structure";	
			return "";			
		}			
	}
}