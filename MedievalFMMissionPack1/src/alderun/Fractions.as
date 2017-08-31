package alderun
{
	import engine.ai.fraction.FractionAi;
	import engine.fraction.Fraction;
	import engine.fraction.FractionControllerType;
	import engine.fraction.FractionRelationshipType;
	import engine.fraction.ResourceType;
	import engine.game.Game;
	import engine.mission.Mission;
	
	public class Fractions
	{
		internal var darkForces:Fraction;
		internal var lightForces:Fraction;  
		internal var player:Fraction; 		
		internal var darkForcesHero:Fraction;
		internal var lightForcesHero:Fraction;
												
		public function init(game:Game, typesRepository:TypesRepository):void
		{
			var mission:Mission = game.missionManager.currentMission;
			
			player = new Fraction("Player", FractionControllerType.Human, 0x2828FF, typesRepository.loc.get("FractPlayer"));
			player.setResource(ResourceType.Gold, game.missionManager.currentMission.stateBag.startMoney);
			game.fractionManager.addFraction(player);
			game.fractionManager.setPlayerFraction(player);
			
			darkForces = new Fraction("Dark Forces", FractionControllerType.Passive, 0xFF0000, "Dark Forces");
			game.fractionManager.addFraction(darkForces);

			lightForces = new Fraction("Light Forces", FractionControllerType.Passive, 0x05D7B7, "Light Forces");
			game.fractionManager.addFraction(lightForces);
						
			game.fractionManager.setRelationships(player, darkForces, FractionRelationshipType.Enemy);
			game.fractionManager.setRelationships(player, lightForces, FractionRelationshipType.Ally);						
			game.fractionManager.setRelationships(lightForces, darkForces, FractionRelationshipType.Enemy);			
															
			var playerFractions:Array = [];
				
			const ALLY_COLORS:Array = [0x1CE6B9, 0xFFFC01, 0x7EBFF1, 0x20C000];				
			for (var i:int = 0; i < mission.playerTeams[0].slots.length; ++i)
			{
				if (mission.playerTeams[0].slots[i].controllerType == FractionControllerType.Computer)
				{
					var lightAi:FractionAi = new FractionAi();
					lightAi.getHeroAi = HeroesAi.getHeroAi;
			
					lightForcesHero = new Fraction("LightPlayer" + (i+1), FractionControllerType.Computer, ALLY_COLORS[i], "Light Player " + (i+1), lightAi);
					lightForcesHero.setResource(ResourceType.Gold, game.missionManager.currentMission.stateBag.startMoney);			
					game.fractionManager.addFraction(lightForcesHero);	
					playerFractions.push(lightForcesHero);
					game.fractionManager.setRelationships(player, lightForcesHero, FractionRelationshipType.Ally);
					game.fractionManager.setRelationships(lightForcesHero, darkForces, FractionRelationshipType.Enemy);
					game.fractionManager.setRelationships(lightForcesHero, lightForces, FractionRelationshipType.Ally);					
				}					
			}	
			
			for (var i:int = 0; i < playerFractions.length; ++i)
			{
				for (var j:int = 0; j < playerFractions.length; ++j)
				{
					game.fractionManager.setRelationships(playerFractions[i], playerFractions[j], FractionRelationshipType.Ally);
				}
			}								
		}
	}
}