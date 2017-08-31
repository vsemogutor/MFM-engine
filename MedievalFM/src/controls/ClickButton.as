package controls
{
	import engine.core.events.EngineEvents;
	import engine.game.Game;
	import engine.game.GameManager;
	import engine.game.GameState;
	import engine.rightClickSupport.RightClickMouseSupport;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import mx.controls.Button;
	import mx.core.SoundAsset;
	
	import sound.Sounds;

	public class ClickButton extends Button
	{
		public var clickSound:SoundAsset;
		public var doubleClickSound:SoundAsset;
		private var _quickInit:Boolean;
		private var _initComplete:Boolean;
		private var _quickButon:String;
						
		public var onClickHandler:Function;		
		private var _onDoubleClickHandler:Function;
		
		public function get onDoubleClickHandler():Function{
			return _onDoubleClickHandler;
		}

		public function set onDoubleClickHandler(value:Function):void{
			_onDoubleClickHandler = value;
			doubleClickEnabled = (_onDoubleClickHandler != null);
		}

		public function get quickButton():String
		{
			return _quickButon;
		}
						
		public function set quickButton(value:String):void
		{
			_quickButon = value;
			if (_initComplete && !_quickInit)
			{
				_quickInit = true;
				systemManager.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyHandler, false, 0, true);
			}
		}
			
		public function ClickButton()
		{
			clickSound = Sounds.buttonClick;
			super();
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function addedToStageHandler(evt:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener(MouseEvent.DOUBLE_CLICK, doubleClickHandler);
			addEventListener(MouseEvent.MOUSE_DOWN, singleClickHandler);
			RightClickMouseSupport.instance().addEventListener(EngineEvents.RIGHT_CLICK, rightClickHandler, false, 0, true);	
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			if (_quickButon && !_quickInit) systemManager.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyHandler, false);		
		}

		private function removedFromStageHandler(evt:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			removeEventListener(MouseEvent.DOUBLE_CLICK, doubleClickHandler);
			removeEventListener(MouseEvent.MOUSE_DOWN, singleClickHandler);
			RightClickMouseSupport.instance().removeEventListener(EngineEvents.RIGHT_CLICK, rightClickHandler, false);	
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);	
			if (_quickButon) systemManager.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyHandler, false);
			_quickInit = false;	
		}
				
		protected override function initializationComplete():void
		{
			super.initializationComplete();
			_initComplete = true;
			if (quickButton && !_quickInit)
			{
				systemManager.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyHandler, false, 0, true);
				_quickInit = true;
			}
		}
		
		protected override function keyDownHandler(e : KeyboardEvent) : void 
		{
        	if (e.keyCode == 32) { // Spacebar
            	return;
            }

            super.keyDownHandler (e);
        }

		
		protected override function clickHandler(event:MouseEvent):void
		{
			super.clickHandler(event);
			
			if (Game.instance() && Game.instance().currentState == GameState.PLAYING)
			{
				Game.instance().userActionManager.defaultAction();
			}
			
			if (!enabled)
	            return;
			if (onClickHandler != null)
				onClickHandler(this);
		}
		
		protected function singleClickHandler(event:MouseEvent):void
		{
			if (!enabled)
	            return;
	            
			Sounds.play(clickSound);
		}
				
		private function doubleClickHandler(event:MouseEvent):void
		{
			if (!enabled)
	            return;
	            
			Sounds.play(doubleClickSound);
			if (onDoubleClickHandler != null)	
				onDoubleClickHandler(this);		
		}

		private function rightClickHandler(event:MouseEvent):void
		{
			if (!enabled)
	            return;
	            
	        if (this.hitTestPoint(event.localX, event.localY))
	        {   
				doubleClickHandler(event);
	        }
		}
				
		private function onKeyHandler(event:KeyboardEvent):void
	    {
	        if (!enabled || (!this.visible && _quickButon != "space"))
	            return;
	          
	        if (GameManager.instance().options.scrollWithWasd &&    
	       			(event.keyCode == 87 || event.keyCode == 65
	        		|| event.keyCode ==  83 || event.keyCode == 68))
	        		return;
	            
	        var parent:DisplayObjectContainer = this.parent;
	        while (parent)
	        {
	        	if (!parent.visible &&  _quickButon != "space")
	        		return;
	        	parent = parent.parent;
	        }
	
			var quickCode:uint;
			if (_quickButon == "esc")
				quickCode = 27;
			else if (_quickButon == "space")
				quickCode = 32;
			else
				quickCode = quickButton.charCodeAt(0);
				
	        if (_quickButon && event.charCode == quickCode)
	        {
	        	clickHandler(new MouseEvent(MouseEvent.CLICK));
	        	dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN));
	        	dispatchEvent(new MouseEvent(MouseEvent.CLICK));
	        }
	        
	       	super.keyUpHandler(event);
	    }
	}
}