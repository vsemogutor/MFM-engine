package engine.quests
{
	import engine.spells.SpellType;
	import engine.units.UnitType;
	
	public class QuestDescriptionToken
	{
		public var text:String;
		public var unitType:UnitType;
		public var spellType:SpellType;
		
		public function QuestDescriptionToken(text:String=null, unitType:UnitType=null, spellType:SpellType=null)
		{
			this.text = text;
			this.unitType = unitType;
			this.spellType = spellType;
		}
	}
}