package engine.ai.schedules.heroTasks
{
	import computers.utils.Utils;
	
	import engine.ai.AiContext;
	import engine.ai.schedules.AiSchedule;
	import engine.ai.schedules.tasks.AiHeroTask;

	public class AiTaskHeal extends AiHeroTask
	{
		public function AiTaskHeal(schedule:AiSchedule = null)
		{
			super(schedule);
		}
		
		public override function execute(context:AiContext):Boolean
		{
			if (context.items.length)
			{
				var items:Array = context.items;
				_hero.useItem(items[Utils.rand(0, items.length - 1)]);
				return true;
			}
			
			if (context.spells.length)
			{
				var spells:Array = context.spells;
				_hero.castSpell(_hero, spells[Utils.rand(0, spells.length - 1)]);
			}
			
			return true;
		}
	}
}