package engine.quests
{
	import __AS3__.vec.Vector;
	
	import engine.core.ManagerBase;
	import engine.core.events.GameEvent;
	import engine.core.events.GameEvents;
	import engine.game.Game;
	
	public final class QuestManager extends ManagerBase
	{
		private var _quests:Vector.<QuestDescription> = new Vector.<QuestDescription>();
				
		public function get quests():Vector.<QuestDescription>{
			return _quests;
		}
		
		public function getQuests(optional:Boolean):Vector.<QuestDescription>
		{
			var quests:Vector.<QuestDescription> = new Vector.<QuestDescription>();
			
			for (var i:int = 0; i < _quests.length; ++i)
			{
				if (_quests[i].optional == optional)
				{
					quests.push(_quests[i]);
				}
			}
			return quests;
		}
		
		public function addQuest(quest:QuestDescription):void
		{
			if (getByName(quest.name) == null)
				_quests.push(quest);
		}
		
		public function removeQuest(quest:QuestDescription):void
		{
			var indx:int = _quests.indexOf(quest);
			if (indx != -1)
				_quests.splice(indx, 1);
		}		
		
		public function getByName(name:String):QuestDescription
		{
			for (var i:int = 0; i < _quests.length; ++i)
			{
				if (_quests[i].name == name)
				{
					return _quests[i];
				}
			}
			
			return null;
		}
		
		public function showQuest(quest:QuestDescription, closeHandler:Function=null):void
		{
			eventManager.dispatch(new GameEvent(GameEvents.SHOW_QUEST, {quest:quest, closeHandler:closeHandler}));
		}
	}
}