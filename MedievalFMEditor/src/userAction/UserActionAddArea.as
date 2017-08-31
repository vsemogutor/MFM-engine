package userAction
{
	import engine.area.Area;
	import engine.core.isometric.IsoTile;
	import engine.game.Game;
	import engine.userAction.UserActionBase;
	
	import flash.events.MouseEvent;
	
	public class UserActionAddArea extends UserActionBase
	{
		private var _posStart:IsoTile;
		private var _area:Area = new Area(null, 0, 0, 1, 1);
		
		public function UserActionAddArea()
		{
		}
		
		public override function onMouseDown(evt:MouseEvent):void
		{
			_posStart = Game.instance().sceneManager.pickIsoTile(evt.localX, evt.localY);
			if (_posStart)
			{
				_area.setRect(_posStart.xindex, _posStart.yindex);
				Game.instance().areaManager.displayArea(_area);
			}
		}
	
		protected override function onMouseMove(evt:MouseEvent):void
		{
			_currentTile = Game.instance().sceneManager.pickIsoTile(evt.localX, evt.localY);
			if (_posStart && _currentTile)
			{
				_area.width = Math.abs(_posStart.xindex - _currentTile.xindex) + 1;
				_area.height = Math.abs(_posStart.yindex - _currentTile.yindex) + 1;				
				_area.x = Math.min(_posStart.xindex, _currentTile.xindex);
				_area.y = Math.min(_posStart.yindex, _currentTile.yindex);
			}
		}
			
		protected override function onMouseUp(evt:MouseEvent):void
		{
			_done = true;
			Game.instance().areaManager.addArea(_area);				
		}
	}
}