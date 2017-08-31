package engine.localization
{
	import engine.game.Game;
	
	public class Localizable
	{		
		public function Localizable()
		{
			Game.instance().localizationManager.addForLocalization(this);
		}
		
		protected function localize():void
		{
			throw new Error("Not implemented");
		}
		
		internal function localizeInternal():void
		{
			localize();
		}
		
		protected function locString(str:String):String
		{
			return Game.instance().localizationManager.localization.get(str);
		}
	}
}