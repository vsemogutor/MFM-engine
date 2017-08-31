package engine.items
{
	import engine.heros.Hero;
	import engine.spells.SpellEffectOperationType;
	import engine.units.Unit;

	public class InventoryItemEffectPermament extends InventoryItemEffect
	{		
		public function InventoryItemEffectPermament()
		{
			super();
		}
		
		public override function apply(target:Unit):Object
		{		
			var hero:Hero = target as Hero;
			
			var effChange:int = change;			
			if (coeficientPropertyId != -1)
			{
				effChange = target.properties[coeficientPropertyId] * (effChange/100);
			}
			
			switch (opType)
			{
				case SpellEffectOperationType.Add:
					hero.heroProperties[propertyId] += effChange;
				break;
				
				case SpellEffectOperationType.Set:
					hero.heroProperties[propertyId] = effChange;
				break;
				
				case SpellEffectOperationType.Multiply:
					hero.heroProperties[propertyId] *= effChange;
				break;
			}
			
			return effChange;
		}		
	}
}