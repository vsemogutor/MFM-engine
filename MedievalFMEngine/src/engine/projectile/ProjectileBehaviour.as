package engine.projectile
{
	public final class ProjectileBehaviour
	{
		public static const NORMAL:int = 0;
		public static const SNAP_TO_TARGET:int = 1;	
		public static const SNAP_TO_OWNER:int = 2;	
		
		public static const types:Array = [NORMAL, SNAP_TO_TARGET, SNAP_TO_OWNER];
		
		public static function getTypeName(type:int):String
		{
			switch (type)
			{
				case NORMAL: return "NORMAL";
				case SNAP_TO_TARGET: return "SNAP_TO_TARGET";
				case SNAP_TO_OWNER: return "SNAP_TO_OWNER";
			}
			
			return "Unknown";
		}
	}
}