package engine.spells
{
	import engine.game.Game;
	import engine.units.Unit;
	
	import flash.geom.ColorTransform;
	
	public class SpellEffectInvisibility extends SpellEffectBase
	{
		private var applied:Boolean = false;
		public var constant:Boolean = false;
				
		public function SpellEffectInvisibility()
		{
			super();
		}

		public override function apply(target:Unit):Object
		{
			if (!startTime)
				startTime = Game.instance().gameTime.value;
				
			if (lifeTime > duration)
				return lifeTime;
						

			if ( (!applied || constant) && (lifeTime % period) == 0)
			{
				target.visible = false;
				target.model.transform = new ColorTransform(1, 1, 1, 0.6);
				applied = true;
			}
			else
			{
				if (target.visible)
				{
					var indx:int = target.spellEffects.indexOf(this);
					if (indx >= 0) 
					{
						cleanup(target);
						if (!constant) target.spellEffects.splice(indx, 1);
					}
				}
			}	
			
			return ++lifeTime;					
		}
		
		public override function cleanup(target:Unit):void
		{
			target.visible = true;
			target.model.transform = null;
		}				
	}
}