package engine.computers
{
	import engine.units.DamageType;
	import engine.units.Unit;
	import engine.units.UnitProperties;
	
	public final class ArmorAndDamage
	{
		private static const ArmorDamageReduction:Number = 0.06;
		private static const ReductionCap:Number = 0.75;		
		
		private static const armorToDamageCoef:Array = [
			//ArmorType.NONE
			[
				0,  //Normal
				0.5,	//Piersing +50%
				0.5, //Siedge +50%
				0, //Magic
				0, //Astral 
				0, // Hero
			],
			//ArmorType.LIGHT
			[
				0,  //Normal
				1,	//Piersing +100%
				0, //Siedge +50%
				0.25, //Magic +25%
				0, //Astral 
				0 // Hero
			],
			//ArmorType.NORMAL
			[
				0.5,  //Normal +50%
				-0.25,	//Piersing -0.25%
				-0.5, //Siedge - 50%
				-0.25, //Magic -25%
				0, //Astral 
				0 // Hero
			],	
			//ArmorType.HEAVY
			[
				0,  //Normal - -33%
				0,	//Piersing - -30%
				0, //Siedge
				1, //Magic - +25%
				0, //Astral 
				0 // Hero
			],	
			//ArmorType.FORTIFIED
			[
				-0.3,  //Normal -30%
				-0.65,	//Piersing -65%
				0.5, //Siedge +50%
				-0.65, //Magic -65%
				0, //Astral 
				-0.5 // Hero - 50%
			],	
			//ArmorType.HERO
			[
				0,  //Normal
				-0.5,	//Piersing -65%
				-0.5, //Siedge -50%
				-0.5, //Magic -50%
				0, //Astral 
				-0.3 // Hero - 30%
			],	
			//ArmorType.DIVINE
			[
				-1,  //Normal -100%
				-1,	//Piersing -100%
				-1, //Siedge -100%
				-1, //Magic -100%
				-1, //Astral -100%
			]		
		];
		
		public static function getDamageReduction(armor:int):Number
		{
			var red:Number = ((armor)*ArmorDamageReduction)/(1+ArmorDamageReduction*(armor));
			if (red > ReductionCap)
				red = ReductionCap;
			
			return red;
			
		}
		
		private static function getDamage(rawDamage:int, damageType:int, armor:int, armorType:int):Number
		{
			var dmg:Number = getDamageAgainsArmor(rawDamage, armorType, damageType);
			dmg = dmg - dmg*getDamageReduction(armor); 
			if (dmg < 0) dmg = 0;
				
			return Math.floor(dmg);
		}
		
		private static function getSpellDamage(rawDamage:int, magicRes:int):Number
		{
			return rawDamage - (rawDamage/100)*(magicRes);
		}
		
		public static function getUnitDamage(rawDamage:int, damageType:int, target:Unit):Number
		{
			var dmg:Number
			if (damageType == DamageType.Spell || damageType == DamageType.Magic)
				dmg = getSpellDamage(rawDamage, target.properties[UnitProperties.MagicRes]);
			else
				dmg = getDamage(rawDamage, damageType, target.properties[UnitProperties.Armor], target.properties[UnitProperties.ArmorType]);
				
			return dmg;
		}		
		
		private static function getDamageAgainsArmor(rawDamage:int, armorType:int, damageType:int):Number
		{
			return rawDamage + rawDamage*armorToDamageCoef[armorType][damageType];
		}
	}
}