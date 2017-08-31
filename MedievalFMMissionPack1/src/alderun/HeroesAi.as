package alderun
{
	import engine.ai.hero.HeroAi;
	import engine.area.Area;
	import engine.game.Game;
	import engine.heros.Hero;
	
	public class HeroesAi
	{
		private static var _patrol1:Area;
		private static var _patrol2:Area;		
		private static var _patrol3:Area;
		private static var _patrol4:Area;	
		private static var _retreatArea:Area;
				
		public static function getHeroAi(hero:Hero):HeroAi
		{
			var game:Game = Game.instance();
			_patrol1 = game.areaManager.getByName("patrolArea1");
			_patrol2 = game.areaManager.getByName("patrolArea2");
			_patrol3 = game.areaManager.getByName("patrolArea3");
			_patrol4 = game.areaManager.getByName("patrolArea4");
				
			_retreatArea = game.areaManager.getByName("retreatArea");	
						
			var ai:HeroAi = new HeroAi(hero);
			
			ai.setRetreatWaypoints([_retreatArea.centerTile]);
			ai.setAttackWaypoints([_patrol1.centerTile,  _patrol2.centerTile, _patrol3.centerTile, _patrol4.centerTile]);
					
			return ai;
		}					
	}
}