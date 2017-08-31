package engine.ai.hero
{
	import __AS3__.vec.Vector;
	
	import engine.core.events.GameEvent;
	import engine.core.events.GameEvents;
	import engine.game.Game;
	import engine.heros.Hero;
	import engine.heros.Skill;
	import engine.heros.SkillBranch;
	import engine.heros.SkillTree;
	
	public class HeroLevelingStrategyBase
	{
		protected var _hero:Hero;
				
		public function HeroLevelingStrategyBase(hero:Hero)
		{
			_hero = hero;
			Game.instance().eventManager.addEventListener(GameEvents.HERO_LEVEL_UP, onLevelGainedInternal, false, 0, true);
			onLevelGained();
		}

		private function onLevelGainedInternal(ev:GameEvent):void
		{
			if (ev.properties.unit == _hero && _hero.skillPoints)
			{
				onLevelGained();
			}
		}

		protected function onLevelGained():void
		{
			// do something in descendant class
		}
		
		protected function getAvaliableSkillsForBranch(branch:SkillBranch):Vector.<Skill>
		{
			var skills:Vector.<Skill> = new Vector.<Skill>();
			
			for (var i:int = 0; i < branch.skills.length; ++i)
			{
				var skill:Skill = branch.skills[i];
				if (skill.aiHint && skill.isAvaliable(_hero, _hero.getSkillLevel(skill) + 1))
				{
					if (!_hero.auraSpell || !skill.isAura)
						skills.push(skill);
				}
			}
			
			return skills;
		}
	}
}