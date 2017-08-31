package engine.userAction
{
	import engine.core.events.GameEvent;
	import engine.core.events.GameEvents;
	import engine.cursor.CursorManager;
	import engine.game.Game;
	
	import flash.events.EventDispatcher;
	
	public class UserActionManager extends EventDispatcher
	{
		private var _currentAction:UserActionBase;
		private var _smartEnabled:Boolean = true;
		
		public function get currentAction():UserActionBase {
			return _currentAction;
		}
		
		public function get smartEnabled():Boolean {
			return _smartEnabled;
		}

		public function set smartEnabled(value:Boolean):void {
			_smartEnabled = value;
		}
				
		public function UserActionManager()
		{
		}
		
		public function process():void
		{
			if (!_currentAction)
			{
				defaultAction();
			}
			else if (_currentAction.process())
			{
				Game.instance().eventManager.dispatch(new GameEvent(GameEvents.USER_ACTION_COMPLETE, {action:currentAction}));
				CursorManager.instance().defaultCursor();
				defaultAction();
			}
		}
		
		public function setAction(action:UserActionBase):void
		{
			if (_currentAction == action)
				return;
				
			if (_currentAction)
				_currentAction.cleanup();
			
			_currentAction = action;
			
			if (_currentAction)
			{
				Game.instance().eventManager.dispatch(new GameEvent(GameEvents.USER_ACTION_ENTER, {action:_currentAction}));
				
				if (currentAction.needsSelection)
				{
					CursorManager.instance().setCursor(_currentAction.cursorType);
				}
					
				_currentAction.enter();
			}
		}
		
		public function defaultAction(preventSmart:Boolean = false):void 
		{
			setAction(new UserActionSelect());
			CursorManager.instance().defaultCursor();
		}

	}
}