package engine.items
{
	import engine.heros.Hero;
	import engine.spells.SpellEffectBase;
	import engine.spells.SpellType;
	import engine.units.Unit;
	
	public class InventoryItemEffectAddSpell extends SpellEffectBase
	{
		public var spellType:SpellType;
		
		public function InventoryItemEffectAddSpell()
		{
		}

		public override function apply(target:Unit):Object
		{		
			var hero:Hero = target as Hero;
			if (hero)
			{
				if (!hero.hasSpell(spellType))
					hero.addSpell(spellType);
			}
			
			return 0;
		}
		
		public override function cleanup(target:Unit):void
		{
			var hero:Hero = target as Hero;
			if (hero)
			{
				hero.removeSpell(spellType);
			}			
		}
	}
}