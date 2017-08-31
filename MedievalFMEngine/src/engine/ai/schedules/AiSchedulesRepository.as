package engine.ai.schedules
{
	import engine.ai.AiContext;
	import engine.ai.hero.HeroConditions;
	import engine.ai.schedules.heroTasks.AiPurchaseItemsTask;
	import engine.ai.schedules.heroTasks.AiTaskAttackUnit;
	import engine.ai.schedules.heroTasks.AiTaskCastSpell;
	import engine.ai.schedules.heroTasks.AiTaskGoToWaypoint;
	import engine.ai.schedules.heroTasks.AiTaskHeal;
	import engine.ai.schedules.heroTasks.WaypointTraversalMode;
	import engine.ai.schedules.tasks.AiTaskWait;
	import engine.ai.schedules.tasks.AiTaskWaitForInterrupt;
	import engine.heros.Hero;
	
	public class AiSchedulesRepository
	{
		public static function getRetreatSchedule(context:AiContext, unit:Hero):AiSchedule
		{
			var schedule:AiHeroSchedule = new AiHeroSchedule(context, unit);
			schedule.addTasks([new AiTaskGoToWaypoint(WaypointTraversalMode.Nearest, false),
							   new AiTaskWaitForInterrupt()]);
			schedule.addInterupts([HeroConditions.HEALTH_NORMAL, HeroConditions.CAN_HEAL, HeroConditions.CAN_SPEED_UP]);
			return schedule;
		}
		
		public static function getRetreatUntilAttackedSchedule(context:AiContext, unit:Hero):AiSchedule
		{
			var schedule:AiHeroSchedule = new AiHeroSchedule(context, unit);
			schedule.addTasks([new AiTaskGoToWaypoint(WaypointTraversalMode.Nearest, false)]);
			schedule.addInterupts([HeroConditions.HEALTH_VERY_LOW, HeroConditions.ULTIMATE_READY]);
			schedule.addInterupts([HeroConditions.UNDER_ATTACK], true);			
			return schedule;
		}		
		
		public static function getAttackSchedule(context:AiContext, unit:Hero):AiSchedule
		{
			var schedule:AiHeroSchedule = new AiHeroSchedule(context, unit);
			schedule.addTasks([new AiTaskGoToWaypoint(WaypointTraversalMode.Random, true)]);
			schedule.addInterupts([HeroConditions.HEALTH_VERY_LOW, HeroConditions.SEE_ENEMY_UNIT, HeroConditions.THREAT_LEVEL_HIGH, HeroConditions.SEE_LOOT]);
			return schedule;
		}	

		public static function getMoveSchedule(context:AiContext, unit:Hero):AiSchedule
		{
			var schedule:AiHeroSchedule = new AiHeroSchedule(context, unit);
			schedule.addTasks([new AiTaskGoToWaypoint(WaypointTraversalMode.Nearest, false)]);
			schedule.addInterupts([HeroConditions.HEALTH_VERY_LOW, HeroConditions.SEE_ENEMY_HERO, HeroConditions.THREAT_LEVEL_HIGH]);
			return schedule;
		}
		
		public static function getAttackUnitSchedule(context:AiContext, unit:Hero):AiSchedule
		{
			var schedule:AiHeroSchedule = new AiHeroSchedule(context, unit);
			schedule.addTasks([new AiTaskAttackUnit(schedule)]);
			schedule.addInterupts([HeroConditions.HEALTH_VERY_LOW, HeroConditions.THREAT_LEVEL_HIGH]);
			return schedule;
		}
		
		public static function getCastSchedule(context:AiContext, unit:Hero):AiSchedule
		{
			var schedule:AiHeroSchedule = new AiHeroSchedule(context, unit);
			schedule.addTasks([new AiTaskCastSpell()]);
			schedule.addInterupts([HeroConditions.HEALTH_VERY_LOW, HeroConditions.MANA_VERY_LOW, HeroConditions.UNDER_ATTACK, HeroConditions.SEE_ENEMY_HERO]);
			return schedule;
		}	
				
		public static function getHealSchedule(context:AiContext, unit:Hero):AiSchedule
		{
			var schedule:AiHeroSchedule = new AiHeroSchedule(context, unit);
			schedule.addTasks([new AiTaskHeal()]);
			schedule.addInterupts([HeroConditions.HEALTH_NORMAL]);
			return schedule;
		}
				
		public static function getPurchaseItemsSchedule(context:AiContext, unit:Hero):AiSchedule
		{
			var schedule:AiHeroSchedule = new AiHeroSchedule(context, unit);
			schedule.addTasks([new AiPurchaseItemsTask()]);
			return schedule;
		}
		
		public static function getWaitSchedule(context:AiContext, unit:Hero):AiSchedule
		{
			var schedule:AiHeroSchedule = new AiHeroSchedule(context, unit);
			schedule.addTasks([new AiTaskWait(schedule)]);
			return schedule;
		}			
	}
}