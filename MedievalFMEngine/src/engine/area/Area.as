package engine.area
{
	import computers.utils.Utils;
	
	import engine.core.fm_internal;
	import engine.core.isometric.IsoTile;
	import engine.game.Game;
	import engine.objects.BaseObject;
	import engine.units.Unit;
	import engine.units.groups.UnitGroup;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	use namespace fm_internal;
		
	public final class Area extends Rectangle
	{
		private var _name:String;
		private var _id:int;
		public var color:uint = 0x0099FF;
		public var _center:Point = new Point(0, 0);
		public var ellips:Boolean;
				
		public function get name():String{
			return _name;
		}
		
		public function set name(value:String):void{
			_name = value;
		}

		public function get id():int{
			return _id;
		}
		
		public function set id(value:int):void{
			_id = value;
		}
		
		public function get center():Point{
			return _center;
		}
	
		public function get centerTile():IsoTile{
			return Game.instance().world.getTile(_center.x, _center.y);
		}

		public function get randomTile():IsoTile{
			return Game.instance().world.getTile(Utils.rand(left, right), Utils.rand(top, bottom));
		}
								
		public function Area(name:String = null, x:int=0, y:int=0, w:int=0, h:int=0)
		{
			super(x, y, w, h);
			_center.x = x + w/2;
			_center.y = y + h/2;			
			_name = name;
		}
		
		public function setRect(x:int, y:int, w:int=1, h:int=1):void
		{
			this.x = x;
			this.y = y;
			this.width = w;
			this.height = h;
			_center.x = x + w/2;
			_center.y = y + h/2;
		}
		
		public function isInArea(objectOrUnit:BaseObject):Boolean
		{
			return contains(objectOrUnit.tile.xindex, objectOrUnit.tile.yindex);
		}
		
		public function isAnyUnitInArea(group:UnitGroup):Boolean
		{
			var len:int = group.length;
			for (var i:int = 0; i < len; ++i)
			{
				var unit:Unit = group.units[i];
				if (contains(unit._tile.xindex, unit._tile.yindex))
					return true;
			}
			return false;
		}
		
		public function isUnitsInArea(group:UnitGroup):Boolean
		{
			var len:int = group.length;
			for (var i:int = 0; i < len; ++i)
			{
				var unit:Unit = group.units[i];
				if (!contains(unit.tile.xindex, unit.tile.yindex))
					return false;
			}
			return true;
		}
	}
}