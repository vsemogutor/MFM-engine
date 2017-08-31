package engine.quests
{
	import __AS3__.vec.Vector;
	
	[Bindable]
	public class QuestDescription
	{		
		public var name:String; // logical quest name
		public var locName:String; // localized display name of the quest
		public var completed:Boolean;
		public var optional:Boolean;
		public var description:String;
		private var _tokens:Vector.<QuestDescriptionToken> = new Vector.<QuestDescriptionToken>();
		
		public function QuestDescription(name:String=null, description:String=null, optional:Boolean=false)
		{
			this.name = this.locName = name;
			this.description = description;
			this.optional = optional;
		}
		
		public function get tokens():Vector.<QuestDescriptionToken> {
			return _tokens;
		}
	}
}