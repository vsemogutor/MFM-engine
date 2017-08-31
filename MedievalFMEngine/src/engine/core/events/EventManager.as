package engine.core.events
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	
	public final class EventManager extends EventDispatcher
	{
		public function EventManager(target:IEventDispatcher = null)
		{
			super(target);
		}
		
		public function dispatch(event:GameEvent):void
		{
			dispatchEvent(event);
		}
	}
}