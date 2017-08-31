package engine.ai.schedules
{
	import __AS3__.vec.Vector;
	
	import engine.ai.AiContext;
	import engine.ai.schedules.tasks.AiTask;
	
	public class AiSchedule
	{
		protected var _allFinished:Boolean;
		protected var _interrupts:Array = new Array();
		protected var _negInterrupts:Array = new Array();
		protected var _tasks:Vector.<AiTask> = new Vector.<AiTask>();
		protected var _context:AiContext;
		
		public function get context():AiContext {
			return _context;
		}
		
		public function AiSchedule(context:AiContext)
		{
			_context = context;
		}
				
		public function isCompleted(context:AiContext):Boolean
		{
			var conditions:Array = context.conditions;
			for (var i:int = 0; i < conditions.length; ++i)
			{
				if (_interrupts.indexOf(conditions[i]) >= 0)
					return true;
			}
			
			for (var i:int = 0; i < _negInterrupts.length; ++i)
			{
				if (conditions.indexOf(_negInterrupts[i]) == -1)
					return true;
			}			
			
			return _allFinished;
		}
		
		public function execute(context:AiContext):Boolean
		{
			// run tasks
			_allFinished = true;
			for (var i:int = 0; i < _tasks.length; ++i)
			{
				if (!_tasks[i].execute(context))
				{
					_allFinished = false;
					break;
				}
			}
			
			return _allFinished;
		}
		
		public function addInterupts(interrupts:Array, interruptIfNotTrue:Boolean = false):void
		{
			for (var i:int = 0; i < interrupts.length; ++i)
			{
				if (interruptIfNotTrue)
					_negInterrupts.push(interrupts[i]);
				else
					_interrupts.push(interrupts[i]);
			}
		}

		public function addTasks(tasks:Array):void
		{
			for (var i:int = 0; i < tasks.length; ++i)
			{
				var task:AiTask = tasks[i];
				task._schedule = this;
				_tasks.push(task);
			}
		}		
	}
}