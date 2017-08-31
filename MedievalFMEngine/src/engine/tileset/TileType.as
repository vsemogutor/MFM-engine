package engine.tileset
{
	import __AS3__.vec.Vector;
	
	import engine.core.fm_internal;
	import engine.util.Constants;
	
	import flash.geom.Rectangle;
	
	use namespace fm_internal;
		
	public class TileType
	{
		public static const TileTypeVariations:int = 15;
		public var id:int;
		public var name:String;
		public var color:uint;
		public var passable:Boolean;
		public var buildable:Boolean;
		internal var yOffset:int;
		public var primary:Boolean;
		public var animated:Boolean;
		public var primaryType:TileType;
			
		fm_internal var tileTypeVariations:Vector.<Rectangle> = new Vector.<Rectangle>(TileTypeVariations);
		
		public function TileType(name:String, passable:Boolean, buildable:Boolean, color:int, yOffset:int, primary:Boolean = false, animated:Boolean = false, primaryType:TileType=null)
		{
			this.name = name;
			this.passable = passable;
			this.buildable = buildable;
			this.yOffset = yOffset;
			this.primary = primary;
			for (var i:int = 0; i < TileTypeVariations; ++i)
				tileTypeVariations[i] = new Rectangle(i*Constants.TILE_WIDTH, yOffset*Constants.TILE_HEIGHT, Constants.TILE_WIDTH, Constants.TILE_HEIGHT);
			this.color = color;
			this.animated = animated;
			this.primaryType = primaryType;
		}
		
		public function getTileRect(variationId:int):Rectangle
		{
			return tileTypeVariations[variationId];
		}
	}
}