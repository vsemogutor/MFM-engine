package engine.trigger
{
	import engine.core.GameTime;
	import engine.game.Game;
	import engine.timer.Timer;
	
	public final class Trigger
	{
		public static const INFINITE:int = -1;
		public static const NONE:Object = null;
				
		public static function add(name:String, condition:Function, onTriggerFunction:Function, 
			checkInterval:GameTime, repeatTimes:int = 1, startDelay:GameTime=null, duration:GameTime=null):void
		{
			var state:Object = {};
			Game.instance().timerManager.add(new Timer(name || Game.instance().idManager.nextId().toString(), checkInterval, 
				function(t:Timer):void {
					if (condition == null || condition(state))
					{
						if (t.firedCount >= repeatTimes) t.remove();
						onTriggerFunction(state);
					}
				}, startDelay, duration, false),
				true
			);
		}

		public static function addRepeat(onTriggerFunction:Function, 
			repeatInterval:GameTime, repeatTimes:int = INFINITE, duration:GameTime=null, state:Object = null):void
		{
			afterPeriodRepeat(null, repeatInterval, repeatTimes, null, onTriggerFunction, state);
		}
				
		public static function afterPeriod(period:GameTime, fun:Function):void
		{
			Game.instance().timerManager.add(
				new Timer(Game.instance().idManager.nextId().toString(), null, 
				function(t:Timer):void {
					fun();
				}, period, null, true),
				true
			);
		}
		
		
		public static function afterPeriodRepeat(startDelay:GameTime, period:GameTime, repeatTimes:int, 
			condition:Function, fun:Function, state:Object = null):void
		{
			Game.instance().timerManager.add(
				new Timer(Game.instance().idManager.nextId().toString(), period, 
				function(t:Timer):void {
					if (condition == null || condition(state)){
						if (repeatTimes > 0 && t.firedCount >= repeatTimes) t.remove();
						fun(state, t);
					}
				}, startDelay, null, true),
				true
			);
		}
	}
}