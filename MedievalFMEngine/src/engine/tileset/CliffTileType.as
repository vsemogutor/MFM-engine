package engine.tileset
{
	import engine.core.fm_internal;
	import engine.util.Constants;
	
	import flash.geom.Rectangle;
	use namespace fm_internal;
		
	public final class CliffTileType extends TileType
	{
		public static const FLAT:int = 14;
		public var frameHeight:int;	
		public var height:int;	
				
		public function CliffTileType(name:String, color:int, yOffset:int, frameHeight: int, height:int)
		{
			this.frameHeight = frameHeight;
			this.height = height || (frameHeight - Constants.TILE_HEIGHT);
			
			super(name, false, false, color, yOffset, false);
			
			for (var i:int = 0; i < TileTypeVariations; ++i)
				tileTypeVariations[i] = new Rectangle(i*Constants.TILE_WIDTH, yOffset*Constants.TILE_HEIGHT, Constants.TILE_WIDTH, frameHeight);
		}
	}
}