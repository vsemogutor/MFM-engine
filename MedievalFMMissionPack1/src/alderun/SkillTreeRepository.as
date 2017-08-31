package alderun
{
	import engine.ai.AiHintType;
	import engine.game.Game;
	import engine.heros.Skill;
	import engine.heros.SkillBranch;
	import engine.heros.SkillTree;
	import engine.units.UnitProperties;
	import engine.units.UnitType;
	
	import mx.core.BitmapAsset;
	
	import resources.BitmapResources;
	
	public final class SkillTreeRepository
	{
		public var elemental:SkillBranch = new SkillBranch();
		
		public function init(game:Game, typesRepository:TypesRepository):void
		{
			fireBranchInit(game, typesRepository.unitTypes.HeroMage, typesRepository);						
		}
		
		private function fireBranchInit(game:Game, heroType:UnitType, typesRepository:TypesRepository):void
		{
			var skillTree:SkillTree = game.skillTree.getTreeForHero(heroType);
			elemental.name = "Fire";	

			var scorch1:Skill = new Skill();
			scorch1.name = "Scorch";
			scorch1.addSpells([typesRepository.spellTypes.etherStepLvl1]);
			elemental.add(scorch1);
																						
			skillTree.skillsBranches.push(elemental);		
		}		
	}
}