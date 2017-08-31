package engine.core
{
	import computers.utils.Utils;
	
	import engine.util.Util;
	
	public class GameTime
	{
		public static const SEC_IN_MINUTE:int = 60;
		public static const SEC_IN_HOUR:int = 360;
		
		public var value:int;
		
		public function GameTime(frames:int, seconds:Number = 0, minutes:Number = 0)
		{
			value = frames + Util.secToFrames(seconds) + Util.minToFrames(minutes);
		}
		
		public function get seconds():int {
			return Util.framesToSec(value);
		}
		
		public function get minutes():int {
			return Util.framesToMin(value);
		}
		
		public function clone():GameTime
		{
			return new GameTime(value);
		}
		
		public function add(time:GameTime):GameTime
		{
			value += time.value;
			return this;
		}
		
		public function next():int
		{
			return ++value;
		}
		
		public function isEven():Boolean
		{
			return (value & 1) == 0;
		}
				
		public function toString():String
		{		
			var hours:int = this.minutes / 60;
			var minutes:int = this.minutes -  hours*60;
			var seconds:int = this.seconds -  minutes*60 - hours*360;	
			
			return hours.toString() + ":" + minutes.toString() + ":" + seconds.toString();
		}	
	}
}