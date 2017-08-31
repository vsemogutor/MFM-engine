package engine.mission
{
	import engine.core.*;
	import engine.core.events.EngineEvents;
	import engine.game.*;
	
	import flash.events.Event;
	use namespace fm_internal;	
	
	public final class MissionManager extends ManagerBase
	{
		private var _currentMission:Mission;
		
		public function get currentMission():Mission {
			return _currentMission;
		}
		
		public function startMission(mission:Mission):void
		{
			_currentMission = mission;
			_currentMission.init(game);
			_currentMission.beforeWorldInitInternal();
			game.mapLoader.addEventListener(EngineEvents.MAP_LOADED, onMapLoaded);
			game.mapLoader.loadMap(_currentMission.mapXml);
		}
		
		private function onMapLoaded(event:Event):void
		{
			_currentMission.afterWorldInitInternal();
			dispatchEvent(new Event(EngineEvents.MISSION_LOADED));
			game.mapLoader.removeEventListener(EngineEvents.MAP_LOADED, onMapLoaded);
		}
		
	}
}