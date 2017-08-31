package engine.game
{
	import engine.core.GameTime;
	import engine.fraction.FractionStatistics;
	import engine.fraction.ResourceType;
	
	[Bindable]
	public final class GameResults extends FractionStatistics
	{
		public var timeElapsed:GameTime = null;
		public var result:String = GameResultType.VICTORY;	
				
		public function get goldCollected():int {
			return getResourceTotal(ResourceType.Gold);
		}
		
		public function get crystalCollected():int {
			return getResourceTotal(ResourceType.Crystal);
		}
		
		public function get total():int {
			var totalRes:int = 0;
			
			totalRes += goldCollected/100;
			totalRes += crystalCollected/100;

			totalRes += unitsKilled;
			totalRes += buildingsDestroyed*2;
			
			totalRes += unitsTrained;	
			totalRes += buildingsConstructed*2;
			
			return totalRes;
		}			
	}
}