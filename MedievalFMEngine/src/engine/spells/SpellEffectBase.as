package engine.spells
{
	import engine.core.isometric.IsoTile;
	import engine.units.Unit;
	
	public class SpellEffectBase
	{
		public var id:int;
		public var duration:int = 1;
		public var period:int = 1;
		internal var lifeTime:int = 0;
		internal var startTime:int;
		public var stackable:Boolean = true;	
		internal var owner:Unit;
		public var applyChance:int = 100;
		public var checkFunction:Function;
		public var canReset:Boolean = true;	
				
		public function SpellEffectBase()
		{
		}
		
		public function apply(target:Unit):Object
		{
			return applyToTile(target.tile);
		}

		public function applyToTile(target:IsoTile):Object
		{
			return null;
		}
				
		public function cleanup(target:Unit):void
		{
		}
		
		public function validate():Boolean
		{
			return true;
		}
		
		public function isExpired():Boolean
		{
			return lifeTime >= duration;
		}
	}
}