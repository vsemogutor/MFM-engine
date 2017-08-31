package engine.util
{
	import __AS3__.vec.Vector;
	
	import engine.core.Direction;
	
	import flash.geom.Point;
	import flash.utils.getQualifiedClassName;
	
	public final class Util
	{		
		public static function secToFrames(sec:Number):int
		{
			return sec*Constants.FRAME_RATE;
		}
		
		public static function minToFrames(min:Number):int
		{
			return min*Constants.FRAME_RATE*60;
		}
		
		public static function framesToSec(frames:Number):int
		{
			return frames/Constants.FRAME_RATE;
		}	

		public static function framesToMin(frames:Number):int
		{
			return (frames/Constants.FRAME_RATE)/60;
		}	
		
		public static function getClassAlias(classObject:Object):String
		{
			return getQualifiedClassName(classObject).replace("::", ".");
		}
		
		public static function parseBool(o:Object):Boolean
		{
			if (!o || o == "0")
				return false;
			else if (o == "1")
				return true;
			
			return (o.toString().toLowerCase() == "true");
		}
	}
}