package engine.units.upgrade
{
	import computers.utils.Utils;
	
	import engine.animation.UnitSprite;
	import engine.game.Game;
	import engine.units.*;
	
	public class TypeUpgrade extends UnitTypeUpgrade
	{
		protected override function validate(_fraction:*):Boolean
		{				
			if (!_fraction)
				throw new Error("Fraction is not set");
				
			if (!toType)
				throw new Error("Fraction is not set");
		
			return true;
		}
		
		
		/**
		 * Upgrades whole type of units
		 * Can change properties and model 
		 * @param _fraction
		 */
		public override function apply(_fraction:* = null):void
		{
			if (!validate(toType))
				return;
				
			var type:UnitType = toType;
			type.model = model.clone() as UnitSprite;
			
			Utils.copyVector(properties, type.properties);
			
			var upgrade:UnitUpgrade = new UnitUpgrade();
			
			for (var i:int = 0; i < Game.instance().unitManager.units.length; ++i)
			{
				var unit:Unit = Game.instance().unitManager.units[i];
				if (unit.type == type && unit.isActive && unit.fraction == _fraction)
					upgrade.apply(unit);
			}
		}
	}
}