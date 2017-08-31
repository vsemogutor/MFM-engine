package engine.ai.schedules
{
	import engine.ai.AiContext;
	import engine.ai.schedules.tasks.AiHeroTask;
	import engine.heros.Hero;

	public class AiHeroSchedule extends AiSchedule
	{
		protected var _hero:Hero;
		
		public function AiHeroSchedule(context:AiContext, hero:Hero)
		{
			super(context);
			context.hero = hero;
			_hero = hero;
		}
		
		public override function addTasks(tasks:Array):void
		{
			for (var i:int = 0; i < tasks.length; ++i)
			{
				var task:AiHeroTask = tasks[i] as AiHeroTask;
				if (task != null) task._hero = _hero;
			}
			
			super.addTasks(tasks);
		}
	}
}