package dialogs
{
	import engine.game.Game;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import mx.containers.VBox;
	import mx.core.Application;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	import mx.managers.PopUpManager;
	
	import states.UIGameState;

	public class DialogCommon extends VBox
	{
		public function DialogCommon()
		{
			super();
			styleName = "dialogCommon";
		}
		
		private var _isPaused:Boolean;
		protected var _parent:UIComponent;
		protected var _closeHandler:Function;
		protected var _pauseGame:Boolean = true;
		protected var _modal:Boolean = true;
				
		public function get pauseGame():Boolean {
			return _pauseGame;
		}

		public function set pauseGame(value:Boolean):void {
			_pauseGame = value;
		}
				
		public function showDialog(parent:DisplayObject, closeHandler:Function=null):void
		{
			Application.application.addEventListener(FlexEvent.ENTER_FRAME, onChangeState, false, 0, true);
			
			PopUpManager.addPopUp(this, parent, _modal);
			PopUpManager.centerPopUp(this);
			isPopUp = false; // prevent draggable behaviour
			
			_closeHandler = closeHandler;
			
			if (_pauseGame)
			{
				_isPaused = Game.instance() && Game.instance().pause();
			}

			_parent = parent as UIComponent;
			if (_parent is DialogCommon)
				_parent.visible = false;
		}
		
		public function close():void
		{
			PopUpManager.removePopUp(this);
			
			if (_parent)
				_parent.visible = true;
				
			if (_isPaused)
				Game.instance().resume();
			
			if (_closeHandler != null)
				_closeHandler();
		}
		
		private function onChangeState(evt:Event):void
		{
			if (Application.application.currentState != UIGameState.PLAYING)
			{
				Application.application.removeEventListener(FlexEvent.ENTER_FRAME, onChangeState);
				PopUpManager.removePopUp(this);
			}
		}		
	}
}