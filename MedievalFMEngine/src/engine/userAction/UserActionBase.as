package engine.userAction
{
	import engine.core.SceneManager;
	import engine.core.events.EngineEvents;
	import engine.core.isometric.IsoTile;
	import engine.cursor.CursorType;
	import engine.display.IsometricView;
	import engine.game.Game;
	import engine.rightClickSupport.RightClickMouseSupport;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	public class UserActionBase
	{
		private static var _locked:Boolean;
		protected var _done:Boolean;
		protected var _currentTile:IsoTile;
		protected var _success:Boolean = true;
		protected var _needsSelection:Boolean;		
		protected var _cursorType:int = CursorType.NORMAL;
				
		public function get success():Boolean{
			return _success;
		}

		public function get needsSelection():Boolean{
			return _needsSelection;
		}

		public function get cursorType():int{
			return _cursorType;
		}
								
		internal function cleanup():void
		{
			done();
			var view:IsometricView = Game.instance().sceneManager.view;
			view.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			view.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			view.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			RightClickMouseSupport.instance().removeEventListener(EngineEvents.RIGHT_CLICK, onRightClick);
			afterCleanup();
		}
		
		protected function afterCleanup():void
		{
		}
		
		internal function enter():void
		{
			var game:Game = Game.instance();
			var scm:SceneManager = game.sceneManager;
			var view:IsometricView = scm.view; 
						
			if (scm.isInCinematicMode || _locked)
			{
				done();
				return;
			}
					
			view.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			view.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			view.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			RightClickMouseSupport.instance().addEventListener(EngineEvents.RIGHT_CLICK, onRightClick);
		}
		
		internal function process():Boolean
		{
			if (_done)
			{
				cleanup();
			}
			
			return _done;
		}
		
		public function onMouseDown(evt:MouseEvent):void
		{
		}
		
		protected function onMouseMove(evt:MouseEvent):void
		{
		}
			
		protected function onMouseUp(evt:MouseEvent):void
		{
		}
		
		protected function onRightClick(evt:MouseEvent):void
		{
			var stagePos:Point = new Point(evt.localX, evt.localY);
			
			var view:IsometricView = Game.instance().sceneManager.view;
			if (view.parent.hitTestPoint(stagePos.x, stagePos.y, true))
			{
				var viewPos:Point = view.globalToLocal(stagePos);
				evt.localX = viewPos.x;
				evt.localY = viewPos.y;
				var smartAction:UserActionBase = 
					new UserActionOrderUnitSmartAction(Game.instance().selectionManager.selectedUnitGroup);
				Game.instance().userActionManager.setAction(smartAction);
				smartAction.onMouseDown(evt);
			}
		}
				
		public function toString():String
		{
			return getDefinitionByName(getQualifiedClassName(this)).toString();
		}
		
		protected function done():void 
		{
			_done = true;
		}
	}
}