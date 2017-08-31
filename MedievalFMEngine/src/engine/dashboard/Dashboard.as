package engine.dashboard
{
	import engine.core.events.GameEvent;
	import engine.core.events.GameEvents;
	import engine.game.Game;
	
	public final class Dashboard
	{
		private var _name:String;
		private var _caption:String;
		private var _text:String;
		private var _type:int;
		
		public function Dashboard(name:String, caption:String=null, type:int=0)
		{
			_name = name;
			_caption = caption;
			_type = type;
		}
		
		public function get name():String{
			return _name;
		}
		
		public function get caption():String{
			return _caption;
		}
		
		public function set caption(value:String):void{
			_caption = value;
			Game.instance().eventManager.dispatch(new GameEvent(GameEvents.DASHBOARD_CHANGED, {dashboard:this}));
		}
		
		public function get value():String {
			return _text;
		}
		
		public function set value(value:String):void {
			_text = value;
			Game.instance().eventManager.dispatch(new GameEvent(GameEvents.DASHBOARD_CHANGED, {dashboard:this}));
		}
		
		public function get type():int {
			return _type;
		}
	}
}