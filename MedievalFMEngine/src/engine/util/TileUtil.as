package engine.util
{
	import __AS3__.vec.Vector;
	
	import engine.core.isometric.IsoTile;
	
	import flash.geom.Point;
	
	public final class TileUtil
	{	
		public static function getTileDist(tile1:IsoTile, tile2:IsoTile):int
		{
			// perf critical so no Math calls
			var x:int = tile1.xindex-tile2.xindex;
			var y:int = tile1.yindex-tile2.yindex;
			x = x < 0 ? -x : x;
			y = y < 0 ? -y : y;
			return x > y ? x : y; 
		}
	
		public static function getFullTileDist(tile1:IsoTile, tile2:IsoTile):int
		{
			var x:int = tile1.xindex-tile2.xindex;
			var y:int = tile1.yindex-tile2.yindex;
			x = x < 0 ? -x : x;
			y = y < 0 ? -y : y;		
			return x + y; 
		}

		public static function getSqrtTileDist(tile1:IsoTile, tile2:IsoTile):Number
		{
			var x:int = tile1.xindex-tile2.xindex;
			var y:int = tile1.yindex-tile2.yindex;		
			return Math.sqrt(x*x + y*y); 
		}
					
		public static function tileToIso(xtile:int,ytile:int):Point
		{			
			var x:int = xtile*Constants.TILE_U + Constants.TILE_V;
			var y:int = ytile*Constants.TILE_U + Constants.TILE_V;
						
			return new Point(x, y);
		}
		
		public static function isoToTile(x:int,y:int):Point
		{			
			var xtile:int = (x - Constants.TILE_V)/Constants.TILE_U;
			var ytile:int = (y - Constants.TILE_V)/Constants.TILE_U;
						
			return new Point(xtile, ytile);
		}
		
		public static function getClosestTile(target:IsoTile, tiles:Array):IsoTile
		{
			var minDist:int = int.MAX_VALUE;
			var result:IsoTile;
			for (var i:int = 0; i < tiles.length; ++i)
			{
				var dist:int = getTileDist(tiles[i], target);
				if (dist < minDist)
				{
					result = tiles[i];
					minDist = dist;
				}
			}	
			
			return result;		
		}
	}
}