package engine.units.support
{
	import engine.spells.SpellType;
	
	public final class UnitSpellItem
	{
		public var type:SpellType;
		public var avaliable:Boolean;
		public var active:Boolean;
		public var cooldown:int;
				
		public function UnitSpellItem(type:SpellType, enabled:Boolean, active:Boolean, cooldown:int=0)
		{
			this.type = type;
			this.avaliable = enabled;
			this.active = active;
			this.cooldown = cooldown;
		}
	}
}