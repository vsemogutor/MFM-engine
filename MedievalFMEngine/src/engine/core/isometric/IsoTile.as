package engine.core.isometric
{
	import computers.utils.Utils;
	
	import engine.area.Area;
	import engine.items.InventoryItem;
	import engine.objects.isometric.IsoObject;
	import engine.tileset.CliffTileType;
	import engine.tileset.TileType;
	import engine.units.Unit;
	import engine.util.Constants;
	
	import flash.geom.Point;

	public final class IsoTile
	{
	    public var object:IsoObject;
	    public var unit:Unit;
	    public var unitFlying:Unit;
	    public var items:Array;	    
		public var xindex:int;
		public var yindex:int;
		public var x:int;
		public var y:int;
		public var passable:Boolean = true;
		public var buildable:Boolean = true;
		public var z:int;
		public var region:int;
		public var tileVariation:int;
		
		public var type:TileType;	
		public var cliffType:CliffTileType;
		public var _tileTypeBL:int;
		public var _tileTypeBR:int;
		public var _tileTypeTL:int;
		public var _tileTypeTR:int;	
		public var tileTypeVariation:int;
		public var cliffTypeVariation:int = Constants.UNDEFINED;
		
		public function IsoTile() {
			tileVariation = Utils.rand(0, 3);
		}
		
		public function get center():Point {
			return new Point(x - Constants.TILE_V, y - Constants.TILE_V);
		}	
		public function get isFreeToBuild():Boolean {
			return buildable && !unit && !object;
		}
		public function get isEditorFreeBuild():Boolean {
			return !unit && !object;
		}	
		public function get isFreeToMove():Boolean {
			return passable && !unit;
		}		
		public function get isFreeToFly():Boolean {
			return !unitFlying;
		}
		public function isFreeFor(_unit:Unit):Boolean {
			return ( ( !_unit.type.isFlying && (_unit == unit || isFreeToMove)) 
				|| (_unit.type.isFlying && (unitFlying == _unit || isFreeToFly)));
		}
		public function get isTypePassable():Boolean {
			return type.passable && (!cliffType || cliffTypeVariation == CliffTileType.FLAT);
		}	
		
		public function placeItem(item:InventoryItem):void
		{
			if (!items) items = [];
			items.push(item);
		}
		
		public function transferItems(unit:Unit):void
		{
			if (items)
			{
				unit.addItems(items);
				items = null;
			}
		}		
	}
}