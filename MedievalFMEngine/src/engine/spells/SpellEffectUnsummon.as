package engine.spells
{
	import engine.units.Unit;
	
	public class SpellEffectUnsummon extends SpellEffect
	{
		public function SpellEffectUnsummon()
		{
			super();
		}
		
		public override function apply(target:Unit):Object
		{
			if (target.summoner != null)
			{
				return super.apply(target);
			}
			return 0;
		}
	}
}