package engine.core.events
{
	import flash.events.Event;
	
	public final class GameEvent extends Event
	{
		private var _properties:Object = {};
		
		public function get properties():Object {
			return _properties;
		}
		
		public function GameEvent(type:String, properties:Object = null)
		{
			_properties = properties;
			super(type);
		}
	}
}