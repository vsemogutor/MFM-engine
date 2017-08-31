package engine.spells
{
	import engine.units.Unit;
	
	public class SpellEffectDrain extends SpellEffect
	{
		public var tansferCoeff:Number = 1;
		
		public function SpellEffectDrain()
		{
			super();
		}
		
		public override function apply(target:Unit):Object
		{
			var change:int = Math.abs(int(super.apply(target)));
			owner.changeProp(propertyId*tansferCoeff, change);
			return change;
		}
	}
}