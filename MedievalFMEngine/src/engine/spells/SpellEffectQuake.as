package engine.spells
{
	import engine.core.isometric.IsoTile;
	import engine.game.Game;
	
	public class SpellEffectQuake extends SpellEffectBase
	{
		public var amplitude:int = 3;
		
		public function SpellEffectQuake()
		{
			super();
		}
		
		public override function applyToTile(target:IsoTile):Object
		{		
			if (!startTime)
				startTime = Game.instance().gameTime.value;
				
			if (lifeTime > duration)
				return lifeTime;
						
			if ((lifeTime % period) == 0)
			{
				if (Game.instance().sceneManager.isUnitVisible(owner))
					Game.instance().sceneManager.cameraShake(amplitude, duration);
			}
				
			return ++lifeTime;
		}		
	}
}