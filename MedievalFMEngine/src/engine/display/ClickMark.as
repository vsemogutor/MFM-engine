package engine.display
{
	import engine.util.Constants;
	
	import flash.geom.Point;
	
	public final class ClickMark extends Point
	{
		internal static const WIDTH:int = 18;
		internal static const HEIGHT:int = WIDTH/2;
		internal static const TOTAL_LIFE_TIME:int = 10;
				
		internal var lifeTime:int;
		
		public function ClickMark(pos:Point, lifeTime:int = TOTAL_LIFE_TIME)
		{
			this.lifeTime = lifeTime;
			this.x = pos.x;
			this.y = pos.y;
		}
	}
}