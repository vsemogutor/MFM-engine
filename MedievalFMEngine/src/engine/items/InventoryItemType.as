package engine.items
{
	public final class InventoryItemType
	{
		public static const NONE:int = 0;
		public static const USABLE:int = 1;	
		public static const USABLE_IMMEDIATE:int = 2;			
		public static const EQUIPABLE:int = 3;
		public static const HEAD:int = 3;
		public static const ARMOR:int = 4;
		public static const HAND:int = 5;
		public static const OFF_HAND:int = 6;
		public static const RING:int = 7;
		public static const AMULET:int = 8;			
		public static const COUNT:int = 9;
		
		public static const types:Array = [NONE, HEAD, ARMOR, HAND, OFF_HAND, RING, AMULET, USABLE, USABLE_IMMEDIATE];
		
		public static function getTypeName(type:int):String
		{
			switch (type)
			{
				case NONE: return "None";
				case HEAD: return "Head";
				case ARMOR: return "Armor";
				case HAND: return "Hand";
				case OFF_HAND: return "Off Hand";
				case RING: return "Ring";
				case AMULET: return "Amulet";
				case USABLE: return "Usable";
				case USABLE_IMMEDIATE: return "Usable";
			}
			
			return "Unknown";
		}						
	}
}