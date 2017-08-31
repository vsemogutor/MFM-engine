package engine.ai.schedules.tasks
{
	import engine.ai.AiContext;
	import engine.ai.schedules.AiSchedule;

	public class AiTaskWait extends AiHeroTask
	{
		public function AiTaskWait(schedule:AiSchedule=null)
		{
			super(schedule);
		}
		
		public override function execute(context:AiContext):Boolean
		{
			_hero.stand();
			return true;
		}		
	}
}