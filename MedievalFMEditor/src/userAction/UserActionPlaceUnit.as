package userAction
{
	import engine.area.Area;
	import engine.fraction.Fraction;
	import engine.game.Game;
	import engine.units.Unit;
	import engine.units.UnitType;
	import engine.userAction.UserActionBase;
	
	import flash.events.MouseEvent;
	
	public class UserActionPlaceUnit extends UserActionBase
	{
		private var type:UnitType;	
		private var fraction:Fraction;
		private var _area:Area;
		private static const AreaValidColor:int = 0x00FF11;
		private static const AreaInvalidColor:int = 0xFF0000;	
			
		public function UserActionPlaceUnit(type:UnitType, fraction:Fraction)
		{
			this.type = type;
			this.fraction = fraction;
			_area = new Area(null, -100, -100, type.xLength, type.yLength);
			Game.instance().areaManager.displayArea(_area);
		}
		
		public override function onMouseDown(evt:MouseEvent):void
		{
			checkPosition(evt.localX, evt.localY);
			if (_currentTile)
				Game.instance().areaManager.displayArea(_area);
		}
	
		protected override function onMouseMove(evt:MouseEvent):void
		{
			checkPosition(evt.localX, evt.localY);
		}
		
		private function checkPosition(x:int, y:int):void
		{
			_currentTile = Game.instance().sceneManager.pickIsoTile(x, y);
			if (_currentTile)
			{
				_area.x = _currentTile.xindex;
				_area.y = _currentTile.yindex;
			}
			
			if (Game.instance().world.canPlaceUnit(_currentTile, type))
			{
				_area.color = AreaValidColor;
			}
			else 
			{
				_area.color = AreaInvalidColor;
			}
		}
			
		protected override function onMouseUp(evt:MouseEvent):void
		{
			if (_currentTile)
			{
				var unit:Unit = Game.instance().unitManager.unitFactory.createUnit(type, fraction);
				Game.instance().unitManager.placeUnitOnWorld(unit, _currentTile);
				//Game.instance().areaManager.displayArea(_area, false);
			}
		}
		
		protected override function afterCleanup():void
		{
			Game.instance().areaManager.displayArea(_area, false);
		}
	}
}