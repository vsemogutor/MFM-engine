package engine.ai.schedules.tasks
{
	import engine.ai.AiContext;
	import engine.ai.schedules.AiSchedule;
	
	public class AiTask
	{
		public var _schedule:AiSchedule;
		
		public function AiTask(schedule:AiSchedule=null)
		{
			_schedule = schedule;
		}
		
		public function get schedule():AiSchedule
		{
			return _schedule;
		}
		
		public function execute(context:AiContext):Boolean
		{
			return true;
		}
	}
}