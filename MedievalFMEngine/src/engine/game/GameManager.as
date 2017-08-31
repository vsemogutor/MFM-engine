package engine.game
{
	import engine.core.events.EngineEvents;
	import engine.core.events.GameEvent;
	import engine.core.events.GameEvents;
	import engine.heros.Hero;
	import engine.mission.IMissionPack;
	import engine.mission.Mission;
	import engine.shapes.UIShape;
	import engine.text.Text;
	import engine.text.TextPosition;
	import engine.units.Unit;
	import engine.util.Util;
	
	import flash.display.BitmapData;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
	public final class GameManager extends EventDispatcher
	{
		private static var _instance:GameManager = new GameManager();
		private var _options:GameOptions = new GameOptions();
		private var _missionPack:IMissionPack;
		private var _currentMission:Mission;
		private var _currentPlayer:Player = new Player();
		
		public static function instance():GameManager {
			return _instance;
		}
		
		public function get currentPlayer():Player {
			return _currentPlayer;
		} 
		
		public function set currentPlayer(value:Player):void {
			_currentPlayer = value;
		} 		
			
		public function get options():GameOptions {
			return _options;
		} 
		
		public function get missionPack():IMissionPack {
			return _missionPack;
		} 	
		
		public function get currentMission():Mission {
			return _currentMission;
		} 

		public function setMissionPack(pack:IMissionPack):void 
		{
			_missionPack = pack;
		} 	

		public function selectMission(mission:Mission):void 
		{
			if (!mission)
			{
				_currentMission = null;
				return;
			}
			
			if (_missionPack == null || _missionPack.getMissions().length == 0)
				throw new Error("Mission pack is not set or empty");
			var indx:int = _missionPack.getMissions().indexOf(mission);
		
			if (indx !=-1)
				_currentMission = mission;
			else
				throw new Error("Mission is not in current pack");
		} 		
		
		public function showInformation(caption:String, text:String, closeHandler:Function=null):void
		{
			if (Game.instance())
			{
				Game.instance().eventManager.dispatch(
					new GameEvent(GameEvents.SHOW_INFORMATION, {caption:caption, text:text, closeHandler:closeHandler}));
			}
		}	
		
		public function showUnitDialog(unitName:String, text:String, unitIcon:BitmapData=null, closeHandler:Function=null):void
		{
			if (Game.instance())
			{
				Game.instance().eventManager.dispatch(
					new GameEvent(GameEvents.SHOW_UNIT_DIALOG, {caption:unitName, text:text, unitIcon:unitIcon, closeHandler:closeHandler}));
			}
		}
				 
		public function showDialog(caption:String, subCaption:String = "", closeHandler:Function=null):void
		{
			if (Game.instance())
			{
				Game.instance().eventManager.dispatch(
					new GameEvent(GameEvents.SHOW_YES_NO_DIALOG, {caption:caption, subCaption:subCaption, closeHandler:closeHandler}));
			}
		}		
		
		public function showInGameMenu():void
		{
			if (Game.instance() && Game.instance().currentState == GameState.PLAYING)
			{
				Game.instance().eventManager.dispatch(new GameEvent(GameEvents.SHOW_IN_GAME_MENU));
			}
		}
		
		public function showWarning(warning:String, durationSec:Number=4, shadow:Boolean=true, color:uint=0xF7D60D):void
		{
			var game:Game = Game.instance();
			if (game && game.currentState == GameState.PLAYING)
			{
				var text:Text = new Text();
				text.color = color;
				text.relativeX = TextPosition.LEFT;
				text.relativeY = TextPosition.BOTTOM;
				text.text = warning;
				text.time = Util.secToFrames(durationSec);
				text.size = 11;
				text.shadow = shadow;
				game.textManager.addText(game.idManager.nextId().toString(), text);
			}
		}
		
		public function showTutorial():void
		{
			if (Game.instance() && Game.instance().currentState == GameState.PLAYING)
			{
				Game.instance().eventManager.dispatch(new GameEvent(GameEvents.SHOW_TUTORIAL));
			}
		}
		
		public function showSkillsDialog(hero:Hero):void
		{
			if (Game.instance() && Game.instance().currentState == GameState.PLAYING)
			{
				Game.instance().eventManager.dispatch(new GameEvent(GameEvents.SHOW_SKILLS_DIALOG, {unit:hero}));
			}
		}
		
		public function showTradeDialog(hero:Hero, trader:Unit):void
		{
			if (Game.instance() && Game.instance().currentState == GameState.PLAYING)
			{
				Game.instance().eventManager.dispatch(new GameEvent(GameEvents.SHOW_TRADE_DIALOG, {unit:hero, trader:trader}));
			}
		}				
	}
}