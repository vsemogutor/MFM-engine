package engine.ai
{
	import engine.ai.schedules.AiSchedule;
	import engine.game.Game;
	
	import flash.events.EventDispatcher;
				
	public class AiBase extends EventDispatcher
	{
		protected var _currentSchedule:AiSchedule;
		protected var _game:Game;
		protected var _context:AiContext;
		
		public function AiBase()
		{
			_game = Game.instance();
			_context = new AiContext(this);
		}
		
		public function get currentSchedule():AiSchedule {
			return _currentSchedule;
		}
		
		public function execute():void
		{
			var context:AiContext = createContext();			
			gatherConditions(context);
			
			if (!_currentSchedule || _currentSchedule.isCompleted(context))
			{
				_currentSchedule = selectNewSchedule(context);
			}
			
			prescheduleThink();
			
			if (_currentSchedule) 
			{
				_currentSchedule.execute(context);
			}
			
			postScheduleThink();
		}
		
		private function createContext():AiContext
		{
			var context:AiContext = new AiContext(this);
			for (var i:int = 0; i < _context.signals.length; ++i)
			{
				context.conditions.push(_context.signals[i]);
			}
			
			_context = context;
			return context;			
		}
		
		protected function selectNewSchedule(context:AiContext):AiSchedule
		{
			throw new Error("Not implemented");
		}
		
		protected function gatherConditions(context:AiContext):void
		{
			throw new Error("Not implemented");
		}	
				
		protected function prescheduleThink():void
		{
			// does nothing by default;
		}	
		
		protected function postScheduleThink():void 
		{
			// does nothing by default;			
		}
		
		public function cleanUp():void
		{
			// does nothing by default;	
		}
		
		public function reset():void
		{
			_currentSchedule = null;
		}			
	}
}