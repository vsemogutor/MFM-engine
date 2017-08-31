package engine.timer
{
	import __AS3__.vec.Vector;
	
	import flash.events.EventDispatcher;
	
	public final class TimerManager extends EventDispatcher
	{
		private var _timers:Vector.<Timer> = new Vector.<Timer>();
		
		public function add(timer:Timer, start:Boolean=false):void
		{		
			if (!getByName(timer.name))
			{
				_timers.push(timer);
				if (start)
					timer.start();
			}
		}
		
		public function remove(timer:Timer):void
		{
			var indx:int = _timers.indexOf(timer);
			if (indx != -1)
			{
				_timers.splice(indx, 1);
			}
		}
		
		public function getByName(name:String):Timer
		{
			for (var i:int = 0; i < _timers.length; ++i)
			{
				if (_timers[i].name == name)
					return _timers[i];
			}
			
			return null;
		}
		
		public function process():void
		{
			for (var i:int = 0; i < _timers.length; ++i)
			{
				if (_timers[i].tick() && _timers[i].removeWhenFinished)
				{
					remove(_timers[i]);
				}
			}
		}
		
		public function removeAll():void
		{
			for (var i:int = _timers.length - 1; i >= 0; --i)
			{
				remove(_timers[i]);
			}			
		}
	}
}