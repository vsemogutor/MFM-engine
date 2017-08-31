package engine.ai.schedules.heroTasks
{
	import engine.ai.AiContext;
	import engine.ai.schedules.AiSchedule;
	import engine.ai.schedules.tasks.AiHeroTask;
	import engine.units.Unit;
	import engine.units.UnitProperties;

	public class AiTaskAttackUnit extends AiHeroTask
	{
		public function AiTaskAttackUnit(schedule:AiSchedule=null)
		{
			super(schedule);
		}
		
		public override function execute(context:AiContext):Boolean
		{
			var target:Unit = context.target as Unit;
			if (target && target.properties[UnitProperties.Health] < 50 && target.isActive)
			{
				_hero.attack(target);
				return false;
			}
			
			return true;
		}
	}
}