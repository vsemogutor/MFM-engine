package engine.items
{
	import engine.spells.SpellEffectBase;
	import engine.spells.SpellEffectOperationType;
	import engine.units.Unit;
	
	/**
	 * @author Igor Novikov
	 * Simple effect class that just change one of the unit properties when applied
	 */
	public class InventoryItemEffect extends SpellEffectBase
	{
		public var propertyId:int;
		public var change:int;
		public var opType:int = SpellEffectOperationType.Add;	
		public var coeficientPropertyId:int = -1;	
		
		public function InventoryItemEffect()
		{
			super();
		}
		
		public override function apply(target:Unit):Object
		{		
			var effChange:int = change;			
			if (coeficientPropertyId != -1)
			{
				effChange = target.properties[coeficientPropertyId] * (effChange/100);
			}
			
			switch (opType)
			{
				case SpellEffectOperationType.Add:
					target.changeProp(propertyId, effChange);
				break;
				
				case SpellEffectOperationType.Set:
					target.setProp(propertyId, effChange);
				break;
				
				case SpellEffectOperationType.Multiply:
					target.setProp(propertyId, target.properties[propertyId]*effChange);
				break;
			}
			
			return effChange;
		}		
	}
}