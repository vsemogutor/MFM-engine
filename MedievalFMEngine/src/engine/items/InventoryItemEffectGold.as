package engine.items
{
	import engine.fraction.ResourceType;
	import engine.spells.SpellEffectBase;
	import engine.units.Unit;
	
	public class InventoryItemEffectGold extends SpellEffectBase
	{
		public var change:int;
		
		public function InventoryItemEffectGold()
		{
		}

		public override function apply(target:Unit):Object
		{		
			var effChange:int = change;			

			target.fraction.addResource(ResourceType.Gold, effChange);
			
			return effChange;
		}
	}
}