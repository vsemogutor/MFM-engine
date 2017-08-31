package engine.ai.hero
{
	import __AS3__.vec.Vector;
	
	import computers.utils.Utils;
	
	import engine.ai.AiHintType;
	import engine.game.Game;
	import engine.heros.Hero;
	import engine.heros.Skill;
	import engine.heros.SkillBranch;
	import engine.heros.SkillTree;

	public class HeroLevelingStrategySimple extends HeroLevelingStrategyBase
	{
		protected var _mainBranch:SkillBranch;
		protected var _secondaryBranch:SkillBranch;
		protected var _skillTree:SkillTree;
		
		public function HeroLevelingStrategySimple(hero:Hero)
		{
			_skillTree = Game.instance().skillTree.getTreeForHero(hero.type);
						
			if (_skillTree.skillsBranches.length)
			{
				var rand:int = Utils.rand(0, _skillTree.skillsBranches.length - 1);
				_mainBranch = _skillTree.skillsBranches[rand];
				
				if (rand == _skillTree.skillsBranches.length - 1 && rand != 0)
					_secondaryBranch = _skillTree.skillsBranches[rand - 1];	
				else if (rand == 0 && rand < _skillTree.skillsBranches.length - 1)
					_secondaryBranch = _skillTree.skillsBranches[rand + 1];	
				else
					_secondaryBranch = _mainBranch;
			}
			
			super(hero);	
		}
		
		protected override function onLevelGained():void
		{
			var learnedPassive:int = 0;
			while (_hero.skillPoints > 0)
			{
				var learnedSmth:Boolean = false;
				
				if (_mainBranch && learnedPassive < 4)
				{
					var skills:Vector.<Skill> = getAvaliableSkillsForBranch(_mainBranch);
					if (skills.length)
					{
						var skill:Skill = skills[Utils.rand(0, skills.length - 1)];
						if (skill.aiHint != AiHintType.Passive || learnedPassive < 2)
						{
							learnedSmth = _hero.addSkill(skill);
							if (learnedSmth && skill.aiHint == AiHintType.Passive)
							{
								++learnedPassive;
							}
						} 
						else
						{
							++learnedPassive;
						}
					}
				}
				
				if (!learnedSmth && _secondaryBranch)
				{
					var skills:Vector.<Skill> = getAvaliableSkillsForBranch(_secondaryBranch);
					if (skills.length)
					{
						var skill:Skill = skills[Utils.rand(0, skills.length - 1)];
						learnedSmth = _hero.addSkill(skills[Utils.rand(0, skills.length - 1)]);
					}					
				}

				if (!learnedSmth) break;
			}
		}
	}
}