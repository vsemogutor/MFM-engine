package engine.computers
{
	import engine.heros.Hero;
	import engine.units.Unit;
	import engine.units.UnitProperties;
	import engine.units.UnitType;
	
	public final class ExperienceCalculator
	{
		public static const EXPERIENCE_COEF:Number = 3.1;		
		public static const EXPERIENCE_TO_LVL2:int = 200;
		public static const EXPERIENCE_FOR_HERO_LVL:int = 100;
		private static const EXPERIENCE_TO_LVL_INCREASE:int = 100;
		private static const EXPERIENCE_FOR_HERO:Array = [100, 100, 120, 160, 220, 300];
		private static const GRANT_XP_NORMAL:int = 25;

		private static var expGainCoeff:Number = EXPERIENCE_COEF;
		
		public static function setExpGainRate(rate:Number):void
		{
			expGainCoeff = EXPERIENCE_COEF*rate;
		}
				
		public static function canLevelUp(currentLevel:int, experience:int):Boolean
		{
			return experience > getExperienceToNextLevel(currentLevel);
		}
		
		public static function getExperienceToNextLevel(currentLevel:int):int
		{
			var exp:int;
			var expToLvl:int = EXPERIENCE_TO_LVL2;
			for (var i:int = 1; i <= currentLevel; ++i)
			{
				exp += expToLvl;
				expToLvl += EXPERIENCE_TO_LVL_INCREASE;
			}
			
			return exp;
		}
		
		public static function getExperienceForKill(unit:Unit):int
		{
			if (unit is Hero)
			{
				var level:int = Hero(unit).level;
				if (level < EXPERIENCE_FOR_HERO.length)
				{
					return EXPERIENCE_FOR_HERO[level];
				}
				return (level - 2)*EXPERIENCE_FOR_HERO_LVL;
			}
			return calcNormalUnitExp(unit.type.level)*expGainCoeff;
		}
		
		private static function calcNormalUnitExp(level:int):int
		{
			if (level <= 1) return GRANT_XP_NORMAL;
			else return calcNormalUnitExp(level-1) + 5 * level + 5;
		}
		
		public static function deductLevel(unitType:UnitType):int
		{
			return Math.max(1, (unitType.properties[UnitProperties.Health] + (unitType.properties[UnitProperties.Mana]/2) + unitType.properties[UnitProperties.AttackRange]*15) / 250);
		}
	}
}