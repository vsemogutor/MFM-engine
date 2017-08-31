package engine.spells
{
	import computers.utils.Utils;
	
	import engine.game.Game;
	import engine.units.Unit;
	import engine.units.UnitProperties;
	
	public class SpellEffectDispell extends SpellEffectBase
	{
		public override function apply(target:Unit):Object
		{		
			if (!startTime)
				startTime = Game.instance().gameTime.value;
				
			if (lifeTime > duration)
				return lifeTime;
			
			if ((lifeTime % period) == 0)
			{
				if (target.properties[UnitProperties.MagicRes] < 100 && (!applyChance || Utils.rand(1, 100) <= applyChance))
				{
					for (var i:int = target.spellEffects.length - 1; i >= 0; --i)
					{
						if (!target.spellEffects[i].owner.fraction.isAllyOf(target.fraction))
						{
							target.spellEffects[i].cleanup(target);
							target.spellEffects.splice(i, 1);
						}
					}
				}
			}
				
			return ++lifeTime;
		}
	}
}