package arena
{
	import engine.ai.hero.HeroAi;
	import engine.area.Area;
	import engine.game.Game;
	import engine.heros.Hero;
	
	public class HeroesAi
	{
		private static var _lightTopArea:Area;
		private static var _lightMiddleArea:Area;		
		private static var _lightBottomArea:Area;
		private static var _neutralTopArea:Area;
		private static var _neutralMiddleArea:Area;		
		private static var _neutralBottomArea:Area;	
		private static var _darkMiddleArea:Area;
		private static var _darkTopArea:Area;
		private static var _darkBottomArea:Area;				
		private static var _goodRetreatArea:Area;	
		private static var _badRetreatArea:Area;
				
		private static function getHeroAi(hero:Hero, enemy:Boolean):HeroAi
		{
			var game:Game = Game.instance();
			_lightTopArea = game.areaManager.getByName("LightTop");
			_lightMiddleArea = game.areaManager.getByName("LightMiddle");
			_lightBottomArea = game.areaManager.getByName("LightBottom");
			_neutralTopArea = game.areaManager.getByName("NeutralTop");
			_neutralMiddleArea = game.areaManager.getByName("NeutralMiddle");
			_neutralBottomArea = game.areaManager.getByName("NeutralBottom");
			
			_darkMiddleArea = game.areaManager.getByName("DarkMiddle");	
			_darkTopArea = game.areaManager.getByName("DarkTop");	
			_darkBottomArea = game.areaManager.getByName("DarkBottom");							
			_badRetreatArea = game.areaManager.getByName("BadHeroRetreat");	
			_goodRetreatArea = game.areaManager.getByName("GoodHeroRetreat");	
						
			var ai:HeroAi = new HeroAi(hero);
			
			if (enemy)
			{
				ai.setRetreatWaypoints([_badRetreatArea.centerTile]);
				ai.setAttackWaypoints([_lightMiddleArea.centerTile,  _lightTopArea.centerTile, _lightBottomArea.centerTile,
											_neutralTopArea.centerTile, _neutralMiddleArea.centerTile, _neutralBottomArea.centerTile]);
			}
			else
			{
				ai.setRetreatWaypoints([_goodRetreatArea.centerTile]);
				ai.setAttackWaypoints([_darkMiddleArea.centerTile,  _darkTopArea.centerTile, _darkBottomArea.centerTile,
											_neutralTopArea.centerTile, _neutralMiddleArea.centerTile, _neutralBottomArea.centerTile]);				
			}
										
			return ai;
		}
		
		public static function getHeroAiDark(hero:Hero):HeroAi
		{
			return getHeroAi(hero, true);
		}		

		public static function getHeroAiLight(hero:Hero):HeroAi
		{
			return getHeroAi(hero, false);
		}			
	}
}