package engine.core
{
	import engine.core.events.EngineEvents;
	import engine.core.events.EventManager;
	import engine.core.isometric.IsoWorld;
	import engine.game.Game;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * @author Igor Novikov
	 * Base class for game managers, includes commonly used staff like game and game time 
	 * for easier access.
	 */
	public class ManagerBase extends EventDispatcher
	{
		// for performance reasons leave those as fields
		protected var game:Game;
		protected var world:IsoWorld;		
		protected var scene:SceneManager;
		protected var eventManager:EventManager;
		protected var idManager:IdManager;
		protected var gameTime:GameTime;
				
		public function ManagerBase()
		{
			game = Game.instance();
			gameTime = game.gameTime;
			eventManager = game.eventManager;
			idManager = game.idManager;
			
			game.mapLoader.addEventListener(EngineEvents.WORLD_CREATED, init, false, 0, true);
		}
		
		private function init(evt:Event):void
		{
			world = game.world;
			scene = game.sceneManager;

			game.mapLoader.removeEventListener(EngineEvents.WORLD_CREATED, init, false);
			game.dispatchEvent(new Event(EngineEvents.GAME_MANAGER_LOADED));
		}
	}
}