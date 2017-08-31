package engine.ai.schedules.tasks
{
	import engine.ai.schedules.AiSchedule;
	import engine.heros.Hero;

	public class AiHeroTask extends AiTask
	{
		public var _hero:Hero;
		
		public function AiHeroTask(schedule:AiSchedule=null)
		{
			super(schedule);
		}
	}
}