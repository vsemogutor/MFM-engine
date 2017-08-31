package engine.units.upgrade
{
	import engine.structures.Structure;
	import engine.units.*;
	
	public class UnitUpgrade extends UnitType
	{
		public function UnitUpgrade()
		{
			isUpgrade = true;
		}
		
		protected function validate(unit:*):Boolean
		{
			if (!(unit is Unit))
				throw new Error("Type upgrade applied to a wrong target");
				
			if (!unit || !unit.isActive)
				return false;
				
			return true;
		}
	
	
		/**
		 * Upgrades specific unit by changing its properties
		 * @param unit
		 */
		public function apply(unit:* = null):void
		{
			if (!validate(unit))
				return;
			
			for (var i:int = 0; i < unit.properties.length; ++i)
			{
				if (i == UnitProperties.Health || i == UnitProperties.Mana)
				{
					unit.setProp(i, properties[i] - (unit.originalProperties[i] - unit.properties[i]));
				}
				else
				{
					unit.properties[i] = properties[i];
				}
			}
		}
	}
}