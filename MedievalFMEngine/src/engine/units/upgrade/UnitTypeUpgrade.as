package engine.units.upgrade
{
	import engine.structures.Structure;
	import engine.units.*;
	import engine.util.Util;
	
	public class UnitTypeUpgrade extends UnitUpgrade
	{
		public var toType:UnitType;
		
		protected override function validate(unit:*):Boolean
		{
			var ret:Boolean = super.validate(unit);
			
			if (!toType || toType.type == UnitTypes.Structure && !unit is Structure)
				throw new Error("Attempt to apply apgrade to wrong unit");
				
			return ret;
		}
		
		/**
		 * Upgrades unit by changins its type to a different type. 
		 * @param _unit
		 */
		public override function apply(_unit:* = null):void
		{
			if (!validate(_unit))
				return;
		
			var unit:Unit = _unit as Unit;
			unit.setType(toType);	
		}
	}
}