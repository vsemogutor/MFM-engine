package engine.timer
{
	import engine.core.GameTime;
	import engine.game.Game;
	
	public final class Timer
	{		
		public var interval:GameTime;
		public var startDelay:GameTime;
		public var startedTime:GameTime;
		public var passedTime:GameTime;	
		public var duration:GameTime;
		public var enabled:Boolean;
		private var _name:String;
		private var _callback:Function;
		private var _firedCount:int;
		public var removeWhenFinished:Boolean;
		private var _remove:Boolean;
		
		public function get name():String {
			return _name;
		}

		public function get runningPassedTime():GameTime {
			if (passedTime.value > startDelay.value)
				return new GameTime(passedTime.value - startDelay.value);
			else
				return new GameTime(0)
		}
				
		public function get firedCount():int {
			return _firedCount;
		}
		
		public function Timer(name:String, interval:GameTime, callback:Function, 
			startDelay:GameTime=null, duration:GameTime=null, removeWhenFinished:Boolean=false)
		{
			_callback = callback;
			this.interval = interval || new GameTime(1);
			this.startDelay = startDelay || new GameTime(0);
			this.duration = duration || (interval != null ? new GameTime(int.MAX_VALUE) : new GameTime(1));
			this.passedTime = new GameTime(0);
			_name = name;
			this.removeWhenFinished = removeWhenFinished;
		}
		
		public function start():void
		{
			startedTime = Game.instance().gameTime.clone();
			enabled = true;
		}
	
		public function stop():void
		{
			enabled = false;
		}
		
		public function remove():void
		{
			stop();
			_remove = true;
			removeWhenFinished = true;
		}		
		
		public function reset():void
		{
			passedTime.value = 0;
		}	
		
		internal function tick():Boolean
		{
			if (_remove)
				return true;
			
			if (!enabled)
				return false;
			
			if (passedTime.value >= startDelay.value + duration.value)
			{
				enabled = false;
				return true;
			}
			
			if (passedTime.value < startDelay.value)
			{
				passedTime.value++;
				return false;
			}
			else if (passedTime.value == startDelay.value)
			{
				passedTime.value = 0;
				startDelay.value = 0;
			}
			
			if (passedTime.value % interval.value == 0)
			{
				_firedCount++;
				_callback(this);
			}
			
			passedTime.value++;
			
			return false;
		}
		
		public function toString(reversed:Boolean=false):String
		{
			var time:GameTime = passedTime;
			if (reversed)
				time = new GameTime(Math.abs(duration.value - passedTime.value));
		
			var hours:int = time.minutes / GameTime.SEC_IN_MINUTE;
			var minutes:int = time.minutes -  hours*GameTime.SEC_IN_MINUTE;
			var seconds:int = time.seconds -  minutes*GameTime.SEC_IN_MINUTE - hours*GameTime.SEC_IN_HOUR;	
			
			
			return hours.toString() + ":" + minutes.toString() + ":" + seconds.toString();
		}
	}
}