package engine.game
{
	import engine.animation.SpriteRepository;
	import engine.area.AreaManager;
	import engine.core.*;
	import engine.core.events.EngineEvents;
	import engine.core.events.EventManager;
	import engine.core.events.GameEvent;
	import engine.core.isometric.IsoWorld;
	import engine.cursor.CursorManager;
	import engine.dashboard.DashboardManager;
	import engine.display.IsometricView;
	import engine.fraction.FractionManager;
	import engine.fraction.FractionStatistics;
	import engine.heros.SkillTree;
	import engine.items.InventoryItemManager;
	import engine.loaders.*;
	import engine.localization.LocalizationManager;
	import engine.mission.MissionManager;
	import engine.objects.*;
	import engine.projectile.ProjectileManager;
	import engine.quests.QuestManager;
	import engine.rightClickSupport.RightClickMouseSupport;
	import engine.selection.SelectionManager;
	import engine.shapes.UIShapeManager;
	import engine.sound.SoundManager;
	import engine.specialEffects.SpecialEffectsManager;
	import engine.spells.SpellManager;
	import engine.text.TextManager;
	import engine.timer.TimerManager;
	import engine.units.*;
	import engine.units.groups.UnitGroupManager;
	import engine.userAction.UserActionManager;
	import engine.util.Constants;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import mx.core.Application;
	import mx.managers.ISystemManager;
	
	use namespace fm_internal;
	
	public final class Game extends EventDispatcher
	{
		private static var _game:Game;
		private var _mapLoader:MapLoader;
			
		private var _unitManager:UnitManager;			
		private var _sceneManager:SceneManager;		
		private var _objectManager:ObjectsManager;
		private var _missionManager:MissionManager;	
		private var _effectManager:SpecialEffectsManager;
		private var _projectileManager:ProjectileManager;	
		private var _idManager:IdManager;
		private var _spellManager:SpellManager;
		private var _fractionManager:FractionManager;
		private var _groupManager:UnitGroupManager;	
		private var _eventManager:EventManager;
		private var _world:IsoWorld;
		private var _areaManager:AreaManager;
		private var _selectionManager:SelectionManager;
		private var _userActionManager:UserActionManager;
		private var _timerManager:TimerManager;
		private var _questManager:QuestManager;
		private var _dashboardManager:DashboardManager;
		private var _textManager:TextManager;
		private var _inventoryItemsManager:InventoryItemManager;
		private var _skillTree:SkillTree;
		private var _localizationManager:LocalizationManager;
								
		private var _spriteRepository:SpriteRepository;	
		private var _missionResults:GameResults = new GameResults();
		
		private var _currentState:String = GameState.UNINITIALIZED;
		private var _gameTime:GameTime = new GameTime(0);
				
		public static function instance():Game
		{
			return _game;
		}
		
		public static function create():Game
		{
			if (_game)
			{
				_game.stop(GameResultType.NONE, false);
			}
			
			_game = new Game();
			return _game;
		}
		
		public function get gameTime():GameTime{
			return _gameTime;
		}
		public function get currentState():String{
			return _currentState;
		}
		public function set currentState(state:String):void{
			_currentState = state;
		}
		public function get mapLoader():MapLoader{
			return _mapLoader;
		}
		public function get unitManager():UnitManager{
			return _unitManager;
		}	
		public function get sceneManager():SceneManager{
			return _sceneManager;
		}	
		public function get objectManager():ObjectsManager{
			return _objectManager;
		}	
		public function get missionManager():MissionManager{
			return _missionManager;
		}
		public function get effectManager():SpecialEffectsManager{
			return _effectManager;
		}
		public function get projectileManager():ProjectileManager{
			return _projectileManager;
		}
		public function get spriteRepository():SpriteRepository{
			return _spriteRepository;
		}
		public function get idManager():IdManager{
			return _idManager;
		}
		public function get spellManager():SpellManager{
			return _spellManager;
		}
		public function get fractionManager():FractionManager{
			return _fractionManager;
		}
		public function get eventManager():EventManager{
			return _eventManager;
		}
		public function get world():IsoWorld{
			return _world;
		}
		public function get areaManager():AreaManager{
			return _areaManager;
		}
		public function get groupManager():UnitGroupManager{
			return _groupManager;
		}
		public function get selectionManager():SelectionManager{
			return _selectionManager;
		}
		public function get systemManager():ISystemManager{
			return _sceneManager.view.systemManager;
		}
		public function get userActionManager():UserActionManager{
			return _userActionManager;
		}
		public function get timerManager():TimerManager{
			return _timerManager;
		}
		public function get questManager():QuestManager{
			return _questManager;
		}
		public function get dashboardManager():DashboardManager{
			return _dashboardManager;
		}	
		public function get textManager():TextManager{
			return _textManager;
		}
		public function get inventoryItemManager():InventoryItemManager{
			return _inventoryItemsManager;
		}
		public function get skillTree():SkillTree{
			return _skillTree;
		}
		public function get localizationManager():LocalizationManager{
			return _localizationManager;
		}
																																								
		public function Game()
		{
			Application.application.frameRate = Constants.FRAME_RATE
		}
		
		public function init(bitmapList:Object):void
		{
			initLoaders();
			initManagers();
			loadResources(bitmapList);
			GameManager.instance().currentPlayer.misssionResults = _missionResults;
			RightClickMouseSupport.instance().enable();
			dispatchEvent(new Event(EngineEvents.GAME_INITIALIZED));
		}
		
		private function initLoaders():void
		{				
			_mapLoader = new MapLoader();
		}
		
		private function initManagers():void
		{
			// these 3 should be initialized first as others use them
			_idManager = new IdManager();
			_eventManager = new EventManager();
			_localizationManager = new LocalizationManager();
			
			
			_sceneManager = new SceneManager();
			_objectManager = new ObjectsManager();
			_unitManager = new UnitManager();
			_missionManager = new MissionManager();
			_missionManager.addEventListener(EngineEvents.MISSION_LOADED, onMissionLoaded);
			_effectManager = new SpecialEffectsManager();
			_projectileManager = new ProjectileManager();
			_spriteRepository = new SpriteRepository();
			_dashboardManager = new DashboardManager();
			_textManager = new TextManager();
			_spellManager = new SpellManager();
			_fractionManager = new FractionManager();
			_groupManager = new UnitGroupManager();
			_areaManager = new AreaManager();
			_selectionManager = new SelectionManager();
			_userActionManager = new UserActionManager();
			_timerManager = new TimerManager();
			_questManager = new QuestManager();
			_inventoryItemsManager = new InventoryItemManager();
			_skillTree = new SkillTree();
		}
		
		private function loadResources(bitmapList:Object):void
		{
			_spriteRepository.init(bitmapList);
		}
		
		public function initView(view:IsometricView):void
		{
			view.world = _world;
			_sceneManager.view = view;

			systemManager.stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyboard);
			systemManager.stage.addEventListener(KeyboardEvent.KEY_UP, handleUpKeyboard);			
			_sceneManager.render();
			_world.minimap.updateMinimap(true);
			view.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			_currentState = GameState.INITIALIZED;
			CursorManager.instance().beginTracking(view);
		}
				
		public function attachWorld(value:IsoWorld):void
		{
			_world = value;
		}

		private function onMissionLoaded(event:Event):void
		{
			_localizationManager.localizeAll();
			_currentState = GameState.LOADED;
			_missionManager.removeEventListener(EngineEvents.MISSION_LOADED, onMissionLoaded);
		}	
		
		private function onEnterFrame(evt:Event):void
		{
			tick();
		}
					
		public function tick():void
		{
			if (!_game) return;
			
			if (_currentState == GameState.PLAYING)
			{
				_gameTime.next();
				
				_unitManager.tick();
				_effectManager.processEffects();
				_projectileManager.processProjectiles();
				_spellManager.processSpells();
				_groupManager.processGroups();
				_selectionManager.process();
				_userActionManager.process();
				_sceneManager.processCamera();
				_textManager.processText();
				_timerManager.process();
				SoundManager.instance().playRandomAmbient();
				_world.minimap.updateMinimap();
				CursorManager.instance().process();
								
				_sceneManager.render();
			}
			else if (_currentState == GameState.EDITING)
			{
				_gameTime.next();
								
				_unitManager.processUnitStates();
				_unitManager.processUnits();
				
				_groupManager.processGroups();
				_selectionManager.process();
				_userActionManager.process();
				_sceneManager.processCamera();
				_world.minimap.updateMinimap();
				_sceneManager.render();
			}
			
			if (_currentState == GameState.STOPPED)
			{
				_game = null;
			}
		}	
		
		public function pause():Boolean
		{
			if (_currentState == GameState.PLAYING 
				|| _currentState == GameState.EDITING)
			{
				_currentState = GameState.PAUSED;
				return true;
			}
			
			return false;
		}
		
		public function start():void
		{
			if (_currentState == GameState.INITIALIZED)
			{
				_currentState = GameState.PLAYING;
				_missionManager.currentMission.beforeStart();
			}
		}
		
		public function resume():void
		{
			if (_currentState == GameState.PAUSED)
				_currentState = GameState.PLAYING;
				
			_sceneManager.view.setFocus();
		}
		
		public function stop(resultType:String=GameResultType.NONE, showDialog:Boolean=true):void
		{
			cleanUp();
		
			setScores(resultType);
			var playing:Boolean = _currentState == GameState.PLAYING;
			
			_currentState = GameState.STOPPED;
						
			this.dispatchEvent(
				new GameEvent(EngineEvents.MISSION_ENDED, {showDialog:showDialog, results:_missionResults}));
		}
		
		private function setScores(result:String):void
		{
			if (_fractionManager.player)
			{
				_missionResults.timeElapsed = gameTime.clone();
				_missionResults.result = result;
				var statistics:FractionStatistics = _fractionManager.player.statistics;
				statistics.copyTo(_missionResults);
			}
		}

		private function handleKeyboard(evt:KeyboardEvent): void
		{
			if (!_game || _game.currentState != GameState.PLAYING)
				return;
					
			if (_sceneManager.isInCinematicMode)
			{
				if (evt.keyCode == Keyboard.ESCAPE)
					GameManager.instance().showInGameMenu();	
				return;
			}
			
			if (evt.keyCode == Keyboard.UP)
				_game.sceneManager.setCameraScroll(Direction.UP);
			else if (evt.keyCode == Keyboard.LEFT)
				_game.sceneManager.setCameraScroll(Direction.Left);				
			else if (evt.keyCode == Keyboard.RIGHT)
				_game.sceneManager.setCameraScroll(Direction.Right);
			else if (evt.keyCode == Keyboard.DOWN)
				_game.sceneManager.setCameraScroll(Direction.Down);
			else if (evt.keyCode == Keyboard.ESCAPE)
				_game.userActionManager.defaultAction();
			else if (evt.keyCode == Keyboard.CONTROL)
				userActionManager.smartEnabled = false;
			else if (GameManager.instance().options.scrollWithWasd)
			{
				if (evt.keyCode == Keyboard.W)
					_game.sceneManager.setCameraScroll(Direction.UP);
				else if (evt.keyCode == Keyboard.S)
					_game.sceneManager.setCameraScroll(Direction.Down);				
				else if (evt.keyCode == Keyboard.A)
					_game.sceneManager.setCameraScroll(Direction.Left);					
				else if (evt.keyCode == Keyboard.D)
					_game.sceneManager.setCameraScroll(Direction.Right);									
			}				
		}
	
		private function handleUpKeyboard(evt:KeyboardEvent): void
		{
			if (!_game)
				return;
			
			if (evt.keyCode == Keyboard.SPACE || evt.keyCode == Keyboard.CONTROL)
			{
				userActionManager.smartEnabled = true;
			}
			else if (evt.keyCode == Keyboard.UP)
				_game.sceneManager.stopCameraScroll(Direction.UP);
			else if (evt.keyCode == Keyboard.LEFT)
				_game.sceneManager.stopCameraScroll(Direction.Left);
			else if (evt.keyCode == Keyboard.RIGHT)
				_game.sceneManager.stopCameraScroll(Direction.Right);
			else if (evt.keyCode == Keyboard.DOWN)
				_game.sceneManager.stopCameraScroll(Direction.Down);
			else if (GameManager.instance().options.scrollWithWasd)
			{
				if (evt.keyCode == Keyboard.W)
					_game.sceneManager.stopCameraScroll(Direction.UP);
				else if (evt.keyCode == Keyboard.S)
					_game.sceneManager.stopCameraScroll(Direction.Down);				
				else if (evt.keyCode == Keyboard.A)
					_game.sceneManager.stopCameraScroll(Direction.Left);					
				else if (evt.keyCode == Keyboard.D)
					_game.sceneManager.stopCameraScroll(Direction.Right);							
			}					
		}
		
		private function cleanUp():void
		{
			_world.minimap.cleanUp();
			_sceneManager.view.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			systemManager.stage.removeEventListener(KeyboardEvent.KEY_DOWN, handleKeyboard);
			systemManager.stage.removeEventListener(KeyboardEvent.KEY_UP, handleUpKeyboard);
						
			_sceneManager.exitCinematicMode();
			_timerManager.removeAll();
			_textManager.removeAllText();
			SoundManager.instance().stopAll();
			CursorManager.instance().endTracking(_sceneManager.view);
			UIShapeManager.hideAll();
		}
	}
}