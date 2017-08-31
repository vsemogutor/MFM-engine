package engine.userAction
{
	import engine.area.Area;
	import engine.game.Game;
	import engine.sound.SoundManager;
	import engine.units.UnitType;
	import engine.units.groups.UnitGroup;
	
	import flash.events.MouseEvent;
	
	public class UserActionOrderUnitConstruct extends UserActionOrderUnitGroup
	{
		private var _type:UnitType;
		private var _area:Area;
		private static const AreaValidColor:int = 0x00FF11;
		private static const AreaInvalidColor:int = 0xFF0000;
		
		public function UserActionOrderUnitConstruct(group:UnitGroup, type:UnitType)
		{
			super(group);
			_type = type;
			_area = new Area(null, -10, -10, type.xLength, type.yLength);
		}
		
		internal override function enter():void
		{
			super.enter();
			Game.instance().areaManager.displayArea(_area);
		}
		
		public override function onMouseDown(evt:MouseEvent):void
		{			
			checkPosition(evt.localX, evt.localY);
		}
	
		protected override function onMouseMove(evt:MouseEvent):void
		{
			checkPosition(evt.localX, evt.localY);
		}
		
		protected override function onMouseUp(evt:MouseEvent):void
		{
			_success = checkPosition(evt.localX, evt.localY);
			if (_success)
			{
				if (_group.selectedUnit)
				{
					_group.selectedUnit.construct(_type, _currentTile);
					SoundManager.instance().clickSound();
				}
				
				done();
			}
		}
		
		private function checkPosition(x:int, y:int, tileCoord:Boolean=false):Boolean
		{
			if (tileCoord)
				_currentTile = Game.instance().world.getTile(x, y);
			else 
				_currentTile = Game.instance().sceneManager.pickIsoTile(x, y);
				
			if (_currentTile)
			{
				_area.x = _currentTile.xindex;
				_area.y = _currentTile.yindex;
			}
			
			if (Game.instance().world.canPlaceUnit(_currentTile, _type))
			{
				_area.color = AreaValidColor;
				return true;
			}
			else 
			{
				_area.color = AreaInvalidColor;
				return false;
			}
		}
		
		internal override function cleanup():void
		{
			super.cleanup();
			Game.instance().areaManager.displayArea(_area, false);
		}
	}
}