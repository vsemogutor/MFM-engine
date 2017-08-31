package engine.spells
{
	import engine.units.Unit;
	import engine.units.UnitProperties;
	
	public class SpellEffectDrainSummon extends SpellEffectDrain
	{
		public var unitTypeId:int;
		public var summonCount:int = 1;
		public var summonLifeTime:int;
		public var summonEffectId:int = 0;
		
		public function SpellEffectDrainSummon()
		{
			super();
		}

		public override function apply(target:Unit):Object
		{
			var change:int = int(super.apply(target));
			
			if (change > 0 && target.properties[UnitProperties.Health] <= 0 && target.lastHitBy == owner)
			{
				var summonEffect:SpellEffectSummon = new SpellEffectSummon();
				summonEffect.owner = owner;
				summonEffect.unitTypeId = unitTypeId;
				summonEffect.summonLifeTime = summonLifeTime;
				summonEffect.summonCount = summonCount;
				summonEffect.summonEffectId = summonEffectId;
				summonEffect.apply(target);
			}
			
			return change;
		}		
	}
}