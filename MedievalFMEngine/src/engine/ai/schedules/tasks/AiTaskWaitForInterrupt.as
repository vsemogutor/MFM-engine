package engine.ai.schedules.tasks
{
	import engine.ai.AiContext;
	import engine.ai.schedules.AiSchedule;
	
	public class AiTaskWaitForInterrupt extends AiTask
	{
		public function AiTaskWaitForInterrupt(schedule:AiSchedule=null)
		{
			super(schedule);
		}
		
		public override function execute(context:AiContext):Boolean
		{
			return false;
		}
	}
}