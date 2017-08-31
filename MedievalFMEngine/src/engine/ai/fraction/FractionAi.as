package engine.ai.fraction
{
	import engine.ai.AiBase;
	import engine.core.events.GameEvent;
	import engine.core.events.GameEvents;
	import engine.fraction.Fraction;
	import engine.game.Game;
	import engine.heros.Hero;
	import engine.units.Unit;

	public class FractionAi extends AiBase
	{
		protected var _fraction:Fraction;
		public var getHeroAi:Function;
				
		public function FractionAi()
		{
			super();
		}
		
		public function init(fraction:Fraction):void
		{
			_fraction = fraction;
			_game.eventManager.addEventListener(GameEvents.UNIT_ADDED, onUnitAdded, false, 0, true);			
		}
		
		private function onUnitAdded(evt:GameEvent):void
		{
			var unit:Unit = evt.properties.unit;
			if (unit is Hero && unit.fraction == _fraction && getHeroAi != null)
			{
				if (!Hero(unit).ai)
        			Hero(unit).setAi(getHeroAi(unit as Hero));
			}
		}
		
		public override function cleanUp():void
		{
			_game.eventManager.removeEventListener(GameEvents.UNIT_ADDED, onUnitAdded, false);
			getHeroAi = null;
			super.cleanUp();
		}
	}
}