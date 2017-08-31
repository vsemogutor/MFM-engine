package arena
{
	import engine.ai.fraction.FractionAi;
	import engine.fraction.Fraction;
	import engine.fraction.FractionControllerType;
	import engine.fraction.FractionRelationshipType;
	import engine.fraction.ResourceType;
	import engine.game.Game;
	import engine.mission.Mission;
	
	import flash.geom.Point;
	
	public class Fractions
	{
		internal var darkForces:Fraction;
		internal var lightForces:Fraction;  
		internal var player:Fraction; 		
		internal var darkForcesHero:Fraction;
		internal var lightForcesHero:Fraction;
		internal var undeadKing:Fraction;
												
		public function init(game:Game, typesRepository:TypesRepository):void
		{
			var goodPlaceStart:Point = new Point(40,144);		
			var badPlaceStart:Point = new Point(34,17);	
					
			var mission:Mission = game.missionManager.currentMission;
			
			player = new Fraction("Player", FractionControllerType.Human, 0x2828FF, typesRepository.loc.get("FractPlayer"));
			player.setResource(ResourceType.Gold, game.missionManager.currentMission.stateBag.startMoney);
			player.startPoint = goodPlaceStart;
			game.fractionManager.addFraction(player);
			game.fractionManager.setPlayerFraction(player);
			
			darkForces = new Fraction("Dark Forces", FractionControllerType.Passive, 0xFF0000, "Dark Forces");
			game.fractionManager.addFraction(darkForces);

			lightForces = new Fraction("Light Forces", FractionControllerType.Passive, 0x05D7B7, "Light Forces");
			game.fractionManager.addFraction(lightForces);

			undeadKing = new Fraction("UndeadKing", FractionControllerType.Passive, 0xFF00FF, "Undead King");
			game.fractionManager.addFraction(undeadKing);
						
			game.fractionManager.setRelationships(player, darkForces, FractionRelationshipType.Enemy);
			game.fractionManager.setRelationships(player, lightForces, FractionRelationshipType.Ally);						
			game.fractionManager.setRelationships(lightForces, darkForces, FractionRelationshipType.Enemy);			

			game.fractionManager.setRelationships(player, undeadKing, FractionRelationshipType.Enemy);
			game.fractionManager.setRelationships(darkForces, undeadKing, FractionRelationshipType.Enemy);			
			game.fractionManager.setRelationships(lightForces, undeadKing, FractionRelationshipType.Enemy);
															
			const ENEMY_COLORS:Array = [0x540081, 0x106246, 0xFF0303, 0xE55BB0, 0x959697];
			var playerFractions:Array = [];
			for (var i:int = 0; i < mission.playerTeams[1].slots.length; ++i)
			{
				if (mission.playerTeams[1].slots[i].controllerType == FractionControllerType.Computer)
				{
					var darkAi:FractionAi = new FractionAi();			
					darkAi.getHeroAi = HeroesAi.getHeroAiDark;
			
					darkForcesHero = new Fraction("DarkPlayer" + (i+1), FractionControllerType.Computer, ENEMY_COLORS[i], "Dark Player " + (i+1), darkAi);
					darkForcesHero.setResource(ResourceType.Gold, game.missionManager.currentMission.stateBag.startMoney);			
					darkForcesHero.startPoint = badPlaceStart;
					game.fractionManager.addFraction(darkForcesHero);
					playerFractions.push(darkForcesHero);
					game.fractionManager.setRelationships(player, darkForcesHero, FractionRelationshipType.Enemy);
					game.fractionManager.setRelationships(darkForcesHero, lightForces, FractionRelationshipType.Enemy);	
					game.fractionManager.setRelationships(darkForcesHero, darkForces, FractionRelationshipType.Ally);
					game.fractionManager.setRelationships(darkForcesHero, undeadKing, FractionRelationshipType.Enemy);
				}					
			}	
			
			const ALLY_COLORS:Array = [0x1CE6B9, 0xFFFC01, 0x7EBFF1, 0x20C000];				
			for (var i:int = 0; i < mission.playerTeams[0].slots.length; ++i)
			{
				if (mission.playerTeams[0].slots[i].controllerType == FractionControllerType.Computer)
				{
					var lightAi:FractionAi = new FractionAi();
					lightAi.getHeroAi = HeroesAi.getHeroAiLight;
			
					lightForcesHero = new Fraction("LightPlayer" + (i+1), FractionControllerType.Computer, ALLY_COLORS[i], "Light Player " + (i+1), lightAi);
					lightForcesHero.setResource(ResourceType.Gold, game.missionManager.currentMission.stateBag.startMoney);			
					lightForcesHero.startPoint = goodPlaceStart;
					game.fractionManager.addFraction(lightForcesHero);	
					playerFractions.push(lightForcesHero);
					game.fractionManager.setRelationships(player, lightForcesHero, FractionRelationshipType.Ally);
					game.fractionManager.setRelationships(lightForcesHero, darkForces, FractionRelationshipType.Enemy);
					game.fractionManager.setRelationships(lightForcesHero, lightForces, FractionRelationshipType.Ally);
					game.fractionManager.setRelationships(lightForcesHero, undeadKing, FractionRelationshipType.Enemy);					
				}					
			}	
			
			for (var i:int = 0; i < playerFractions.length; ++i)
			{
				for (var j:int = 0; j < playerFractions.length; ++j)
				{
					if (playerFractions[i].isEnemyOf(player))
					{
						if (playerFractions[j].isEnemyOf(player))
						{
							game.fractionManager.setRelationships(playerFractions[i], playerFractions[j], FractionRelationshipType.Ally);
						}
						else
						{
							game.fractionManager.setRelationships(playerFractions[i], playerFractions[j], FractionRelationshipType.Enemy);	
						}
					}
					else
					{
						if (playerFractions[j].isAllyOf(player))
						{
							game.fractionManager.setRelationships(playerFractions[i], playerFractions[j], FractionRelationshipType.Ally);
						}
						else
						{
							game.fractionManager.setRelationships(playerFractions[i], playerFractions[j], FractionRelationshipType.Enemy);	
						}						
					}
				}
			}								
		}
	}
}