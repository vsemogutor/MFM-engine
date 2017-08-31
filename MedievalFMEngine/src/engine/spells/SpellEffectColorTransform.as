package engine.spells
{
	import engine.game.Game;
	import engine.units.Unit;
	
	import flash.geom.ColorTransform;
	
	public class SpellEffectColorTransform extends SpellEffectBase
	{
		public var a:Number = 1;		
		public var r:int = -30;
		public var g:int = -30;		
		public var b:int = 130;
				
		public function SpellEffectColorTransform()
		{
			super();
		}

		public override function apply(target:Unit):Object
		{		
			if (!startTime)
				startTime = Game.instance().gameTime.value;
				
			if (lifeTime > duration)
				return lifeTime;
						
			if ((lifeTime % period) == 0)
			{
				target.model.transform = new ColorTransform(1, 1, 1, a, r, g, b);
			}
				
			return ++lifeTime;
		}
		
		public override function cleanup(target:Unit):void
		{
			target.model.transform = null;
		}		
	}
}