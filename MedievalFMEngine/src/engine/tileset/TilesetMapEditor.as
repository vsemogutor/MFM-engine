package engine.tileset
{
	import engine.core.isometric.*;
	import engine.util.Constants;
	
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	public final class TilesetMapEditor extends EventDispatcher
	{
		private var _world:IsoWorld;
		private var _tileset:Tileset;
				
		public function TilesetMapEditor(world:IsoWorld)
		{
			_world = world;
			_tileset = world.tileset;
		}
				
		public function resetTile(c:IsoTile, tileType:TileType = null):void
		{
			if (tileType)
			{
				c._tileTypeBL = c._tileTypeBR = c._tileTypeTL = c._tileTypeTR = tileType.id;
				c.type = tileType;
			}
			else //default
			{
				if (c._tileTypeBL != _tileset.primaryTileType.id) c.type = _tileset.tileTypes[c._tileTypeBL];
				else if (c._tileTypeBR != _tileset.primaryTileType.id) c.type = _tileset.tileTypes[c._tileTypeBR];
				else if (c._tileTypeTL != _tileset.primaryTileType.id) c.type = _tileset.tileTypes[c._tileTypeTL];
				else if (c._tileTypeTR != _tileset.primaryTileType.id) c.type = _tileset.tileTypes[c._tileTypeTR];
			}
			fixTileType(c);
		}
		
		private function fixTile(c:IsoTile):void
		{
			if (!c) return;
			
			var c1:IsoTile = _world.getTile(c.xindex, c.yindex + 1);
			var c2:IsoTile = _world.getTile(c.xindex - 1, c.yindex);
			var c3:IsoTile = _world.getTile(c.xindex - 1, c.yindex + 1);
			var c4:IsoTile = _world.getTile(c.xindex + 1, c.yindex);
			var c5:IsoTile = _world.getTile(c.xindex + 1, c.yindex + 1);
			var c6:IsoTile = _world.getTile(c.xindex, c.yindex - 1);
			var c7:IsoTile = _world.getTile(c.xindex + 1, c.yindex - 1);
			var c8:IsoTile = _world.getTile(c.xindex - 1, c.yindex - 1);
		
			//bl
			if (c1 && c1._tileTypeTL != c._tileTypeBL) c._tileTypeBL = c1._tileTypeTL;
			else if (c2 && c2._tileTypeBR != c._tileTypeBL) c._tileTypeBL = c2._tileTypeBR;
		
			//br
			if (c1 && c1._tileTypeTR != c._tileTypeBR) c._tileTypeBR = c1._tileTypeTR;
			else if (c4 && c4._tileTypeBL != c._tileTypeBR) c._tileTypeBR = c4._tileTypeBL;
		
			//tr
			if (c6 && c6._tileTypeBR != c._tileTypeTR) c._tileTypeTR = c6._tileTypeBR;
			else if (c4 && c4._tileTypeTL != c._tileTypeTR) c._tileTypeTR = c4._tileTypeTL;
		
			//tl
			if (c6 && c6._tileTypeBL != c._tileTypeTL) c._tileTypeTL = c6._tileTypeBL;
			else if (c2 && c2._tileTypeTR != c._tileTypeTL) c._tileTypeTL = c2._tileTypeTR;
		
			resetTile(c);
		}
		
		private function fixTileType(c:IsoTile):void
		{
			var tileNum:int = int(c._tileTypeTL == c.type.id) + (int(c._tileTypeTR == c.type.id)<<1) + 
				(int(c._tileTypeBR == c.type.id)<<2) + (int(c._tileTypeBL == c.type.id)<<3);
			var indxTable:Array = [0, 8, 6, 7, 1, 14, 4, 11, 3, 5, 13, 12, 2, 10, 9, 0];
			c.tileTypeVariation = indxTable[tileNum];
			if (tileNum == 0) 
				c.type = _tileset.primaryTileType;

			if (c.xindex == 0 || c.yindex == 0 || c.xindex >= _world.xGridSize - 1 || c.yindex >= _world.yGridSize - 1)
			{ 
				c.passable = false;
				c.buildable = false;
			}
			else if (!c.cliffType)
			{
				c.passable = c.type.passable;
				c.buildable = c.type.buildable;
			}
		}
	}
}