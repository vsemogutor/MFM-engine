package engine.spells
{
	import engine.core.fm_internal;
	import engine.game.Game;
	import engine.units.Unit;
	
	import flash.utils.Dictionary;

	use namespace fm_internal;
			
	public class SpellEffectResetCooldowns extends SpellEffectBase
	{
		public function SpellEffectResetCooldowns()
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
				target.lastCastTime = int.MIN_VALUE;
				for (var id:Object in target._spellsLastCastTime)
				{
					var spell:SpellType = Game.instance().spellManager.getSpellTypeById(int(id));
					if (spell && spell.canBeReset)
					{
						target._spellsLastCastTime[int(id)] = null;
					}
				}
			}
				
			return ++lifeTime;			
		}
	}
}