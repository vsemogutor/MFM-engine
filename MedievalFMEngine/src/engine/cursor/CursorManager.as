package engine.cursor
{
	import engine.core.Direction;
	import engine.core.events.EngineEvents;
	import engine.core.events.GameEvent;
	import engine.display.IsometricView;
	import engine.game.Game;
	import engine.game.GameManager;
	import engine.units.Unit;
	import engine.util.Constants;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public final class CursorManager extends EventDispatcher
	{
		private var _currentCursor:int = Constants.UNDEFINED;
		private static var _instance:CursorManager = new CursorManager();
		private var _currentMousePosition:Point = new Point();
		private var _currentStageMousePosition:Point = new Point();		
		private var _selectedUnit:Unit;
		private var _mouseInViewport:Boolean;
		private var _mouseInStage:Boolean;
		private var _mousePositionCheckTime:int;
		private var _mouseLastMove:Point = new Point();
		private var _view:IsometricView;
				
		public static function instance():CursorManager {
			return _instance;
		}
		
		public function get currentCursor():int {
			return _currentCursor;
		}
		
		public function get currentMousePosition():Point {
			return _currentMousePosition;
		}
		
		public function CursorManager()
		{
			GameManager.instance().addEventListener(EngineEvents.CURSOR_SETTINGS_CHANGED, onCursorSettings);
		}
		
		private function onCursorSettings(evt:GameEvent):void
		{
			if (evt.properties.useSystem)
			{
				dispatchEvent(new GameEvent(EngineEvents.CURSOR_CHANGED, {type:CursorType.SYSTEM}));
			}
			else
			{
				defaultCursor();
			}
		}
		
		public function setCursor(type:int):void
		{				
			if (_currentCursor != type)
			{
				_currentCursor = type;
				if (GameManager.instance().options.useSystemCursor)
				{
					if (type == CursorType.NORMAL || type == CursorType.NORMAL_ACTIVE) type = CursorType.SYSTEM;
				}

				dispatchEvent(new GameEvent(EngineEvents.CURSOR_CHANGED, {type:type}));
			}
		}

		public function defaultCursor():void
		{
			setCursor(CursorType.NORMAL);
		}
		
		public function beginTracking(view:IsometricView):void
		{
			_view = view;
			view.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			view.addEventListener(MouseEvent.MOUSE_OUT, onViewMouseOut);
			Game.instance().systemManager.stage.addEventListener(Event.MOUSE_LEAVE, onMouseLeave);			
			Game.instance().systemManager.stage.addEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
			Game.instance().systemManager.stage.addEventListener(Event.DEACTIVATE, onDeactivate);
		}
		
		public function endTracking(view:IsometricView):void
		{
			view.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			view.removeEventListener(MouseEvent.MOUSE_OUT, onViewMouseOut);	
			Game.instance().systemManager.stage.removeEventListener(Event.MOUSE_LEAVE, onMouseLeave);
			Game.instance().systemManager.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
			Game.instance().systemManager.stage.removeEventListener(Event.DEACTIVATE, onDeactivate);			
			_mouseInViewport = false;
			defaultCursor();
			_view = null;
			_selectedUnit = null;
		}		

		private function onMouseLeave(evt:Event):void
		{
			if ( Math.abs(_mouseLastMove.x) > Math.abs(_mouseLastMove.y))
			{
				if (_mouseLastMove.x > 0) Game.instance().sceneManager.setCameraScroll(Direction.Right);
				else Game.instance().sceneManager.setCameraScroll(Direction.Left);
				
				
				if (_currentStageMousePosition.y < 30) Game.instance().sceneManager.setCameraScroll(Direction.UP);
				else if (_currentStageMousePosition.y > _view.width - 40) Game.instance().sceneManager.setCameraScroll(Direction.Down);
			}
			else
			{
				if (_mouseLastMove.y > 0) Game.instance().sceneManager.setCameraScroll(Direction.Down);
				else Game.instance().sceneManager.setCameraScroll(Direction.UP);	
				
				if (_currentStageMousePosition.x < 40) Game.instance().sceneManager.setCameraScroll(Direction.Left);
				else if (_currentStageMousePosition.x > _view.width - 40) Game.instance().sceneManager.setCameraScroll(Direction.Right);						
			}
			
			_mouseInViewport = false;
			_mouseInStage = false;			
		}


		private function onDeactivate(evt:Event):void
		{
			Game.instance().sceneManager.stopCameraScrollAll();
		}
		
		private function onStageMouseMove(evt:MouseEvent):void
		{
			_mouseLastMove.x = evt.stageX - _currentStageMousePosition.x;
			_mouseLastMove.y = evt.stageY - _currentStageMousePosition.y;

			_currentStageMousePosition.x = evt.stageX;
			_currentStageMousePosition.y = evt.stageY;
						
			if (!_mouseInStage)
			{
				_mouseInStage = true;
				Game.instance().sceneManager.stopCameraScrollAll();
			}
		}
						
		private function onMouseMove(evt:MouseEvent):void
		{						
			_currentMousePosition.x = evt.localX;
			_currentMousePosition.y = evt.localY;
			_mouseInViewport = true;
		}
		
		private function onViewMouseOut(evt:MouseEvent):void
		{
			_mouseInViewport = false;
		}		
		
		public function getUnitUnderCursor():Unit
		{
			return _selectedUnit;
		}
		
		public function process():void
		{
			var game:Game = Game.instance();
			
			if (game.gameTime.isEven()) // every 2 frames
			{
				if (!_mouseInViewport)
				{
					_selectedUnit = null;
				}
				else
				{
					var selectedUnit:Unit = game.sceneManager.getUnitAtScreenPosition(_currentMousePosition);
					if (selectedUnit != _selectedUnit)
					{
						_selectedUnit = selectedUnit;
						if (_currentCursor >= CursorType.NORMAL_ACTIVE)
						{
							defaultCursor();
						}
					}					
				}

				if (_selectedUnit)
				{
					if (_currentCursor == CursorType.NORMAL) 
					{
						if (_selectedUnit.type.isTrader)
						{
							setCursor(CursorType.TRADE);
						}
						else if (_selectedUnit.fraction.isCurrentPlayer())
						{
							setCursor(CursorType.NORMAL_ACTIVE);
						}
						else if (_selectedUnit.fraction.isEnemyOf(game.fractionManager.player))
						{ 
							setCursor(CursorType.ATTACK_ACTIVE);
						}
						else
						{ 
							setCursor(CursorType.NORMAL_ACTIVE);						
						}
					}
				}
				else
				{
					if (_currentCursor >= CursorType.NORMAL_ACTIVE)
					{
						defaultCursor();
					}
				}
			}		
		}
	}
}