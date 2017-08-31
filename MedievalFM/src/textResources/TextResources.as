package textResources
{
	import computers.utils.Utils;
	
	import engine.units.ArmorType;
	import engine.units.DamageType;
	import engine.util.Util;
	
	import resources.StringResources;
	
	public final class TextResources
	{
		public static const HELP_CONTENT:String = StringResources.get("HelpContent");
	
		public static const HELP_CONTENT_SHORT:String = StringResources.get("HelpContentShort");
			
		public static function getSpeedCaption(speed:int):String
        {
        	if (speed <= 0)
        		return StringResources.get("None");
        	else if (speed <= Util.secToFrames(1))
        		return StringResources.get("Fast");
        	else if (speed <= Util.secToFrames(1.5))
        		return StringResources.get("Normal");
        	else return StringResources.get("Slow");
        }
        
        public static function getRangeCaption(range:int):String
        {
        	if (range <= 1)
        		return StringResources.get("Melee");
        	else if (range <= 3)
        		return StringResources.get("Close");
        	else if (range <= 4)
        		return StringResources.get("Medium");
        	else return StringResources.get("Long");
        }
        
       	public static function getDamageTypeCaption(type:int):String
        {
        	if (type == DamageType.Hero)
        		return StringResources.get("Hero");
        	if (type == DamageType.Piersing)
        		return StringResources.get("Piersing");
        	else if (type == DamageType.Magic)
        		return StringResources.get("Magic");
        	else if (type == DamageType.Normal)
        		return StringResources.get("Normal");
        	else if (type == DamageType.Siedge)
        		return StringResources.get("Siedge");
        	else if (type == DamageType.Astral)
        		return StringResources.get("Astral");
        	else return "";
        }
        
       	public static function getDamageDescriptionCaption(type:int):String
        {
        	if (type == DamageType.Hero)
        		return StringResources.get("HeroDamageDescription");
        	if (type == DamageType.Piersing)
        		return StringResources.get("PiersingDamageDescription");
        	else if (type == DamageType.Magic)
        		return StringResources.get("MagicDamageDescription");
        	else if (type == DamageType.Normal)
        		return StringResources.get("NormalDamageDescription");
        	else if (type == DamageType.Siedge)
        		return StringResources.get("SiedgeDamageDescription");
        	else if (type == DamageType.Astral)
        		return StringResources.get("AstralDamageDescription");
        	else return "";
        }
        
       	public static function getArmorTypeCaption(type:int):String
        {
        	if (type == ArmorType.NONE)
        		return StringResources.get("None");
        	else if (type == ArmorType.NORMAL)
        		return StringResources.get("Normal");
        	else if (type == ArmorType.HERO)
        		return StringResources.get("Hero");
        	else if (type == ArmorType.HEAVY)
        		return StringResources.get("Heavy");
        	else if (type == ArmorType.FORTIFIED)
        		return StringResources.get("Fortified");
        	else if (type == ArmorType.DIVINE)
        		return StringResources.get("Divine");
        	else return "";
        }
        
        public static function getArmorDescriptionCaption(type:int):String
        {
        	if (type == ArmorType.NONE)
        		return StringResources.get("ArmorTypeNoneDescription");
        	else if (type == ArmorType.NORMAL)
        		return StringResources.get("ArmorTypeNormalDescription");
        	else if (type == ArmorType.HERO)
        		return StringResources.get("ArmorTypeHeroDescription");
        	else if (type == ArmorType.HEAVY)
        		return StringResources.get("ArmorTypeHeavyDescription");
        	else if (type == ArmorType.FORTIFIED)
        		return StringResources.get("ArmorTypeFortifiedDescription");
        	else if (type == ArmorType.DIVINE)
        		return StringResources.get("ArmorTypeDevineDescription");
        	else return "";
        }
        
        public static function getMoveSpeedCaption(speed:int):String
        {
        	if (speed <= 0)
        		return StringResources.get("None");
        	else if (speed <= Util.secToFrames(0.8))
        		return StringResources.get("Fast");
        	else if (speed < Util.secToFrames(1))
        		return StringResources.get("Normal");
        	else return StringResources.get("Slow");
        }
	}
}