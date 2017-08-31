package utils
{
	import engine.core.isometric.*;
	import engine.game.Game;
	import engine.tileset.CliffTileType;
	import engine.tileset.TileType;
	import engine.tileset.Tileset;
	import engine.util.Constants;
	
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	public final class TilesetMapEditor extends EventDispatcher
	{
		private var _world:IsoWorld;
		private var _tileset:Tileset;
		private var _cliffMap:Dictionary;
		
		private static var _instance:TilesetMapEditor = new TilesetMapEditor();
		
		public static function instance():TilesetMapEditor
		{
			_instance._world = Game.instance().world;
			_instance._tileset = _instance._world.tileset;
			
			return _instance;
		}
				
		public function TilesetMapEditor()
		{
			_cliffMap = new Dictionary();
			
			_cliffMap[7] = 4;
			_cliffMap[28] = 1;
			_cliffMap[112] = 2;	
			_cliffMap[193] = 3;
			
			_cliffMap[31] = 6;	
			_cliffMap[124] = 5;		
			_cliffMap[241] = 8;	
			_cliffMap[199] = 7;		
			
			_cliffMap[253] = 12;	
			_cliffMap[247] = 9;
			_cliffMap[223] = 10;
			_cliffMap[127] = 11;
			
 			_cliffMap[60] = 1;
 			_cliffMap[30] = 1;			
 			_cliffMap[15] = 4;
 			_cliffMap[135] = 4;	
			_cliffMap[240] = 2;			
			_cliffMap[225] = 3;		
			_cliffMap[195] = 3;
			_cliffMap[120] = 2;	
								
  			_cliffMap[227] = 3;			
			_cliffMap[62] = 1;		
			_cliffMap[143] = 4;
			_cliffMap[248] = 2;	

			_cliffMap[63] = 6;				
			_cliffMap[126] = 5;
			_cliffMap[243] = 8;
			_cliffMap[252] = 5;
			_cliffMap[231] = 7;
			_cliffMap[159] = 6;
			_cliffMap[249] = 8;		
			_cliffMap[207] = 7;	
			_cliffMap[254] = 5;
			_cliffMap[239] = 7;
			_cliffMap[251] = 8;
																																			 			
			_cliffMap[255] = CliffTileType.FLAT;
		}
		
		private function setTileType(x:int, y:int, type:*):void
		{
			var c:IsoTile = _world.getTile(x, y);
			if (!c) return;
			
			var tileType:TileType;
			if (type is TileType)
				tileType = type;
			else
				tileType = _tileset.tileTypes[type];
				
			if (tileType is CliffTileType)
			{
				setCliff(c, tileType as CliffTileType);
				return;
			}
		
			if (tileType != _tileset.getPrimaryFor(c.type))
			{
				var c1:IsoTile = _world.getTile(c.xindex, c.yindex + 1);
				var c2:IsoTile = _world.getTile(c.xindex - 1, c.yindex);
				var c3:IsoTile = _world.getTile(c.xindex - 1, c.yindex + 1);
				var c4:IsoTile = _world.getTile(c.xindex + 1, c.yindex);
				var c5:IsoTile = _world.getTile(c.xindex + 1, c.yindex + 1);
				var c6:IsoTile = _world.getTile(c.xindex, c.yindex - 1);
				var c7:IsoTile = _world.getTile(c.xindex + 1, c.yindex - 1);
				var c8:IsoTile = _world.getTile(c.xindex - 1, c.yindex - 1);
		
				var primary:TileType = _tileset.getPrimaryFor(c.type);
				if (c1 && c1.type != primary && c1.type != tileType) 
					setTileTypeByTile(c1, primary);
				if (c2 && c2.type != primary && c2.type != tileType) 
					setTileTypeByTile(c2, primary);						
				if (c3 && c3.type != primary && c3.type != tileType) 
					setTileTypeByTile(c3, primary);					
				if (c4 && c4.type != primary && c4.type != tileType) 
					setTileTypeByTile(c4, primary);									
				if (c5 && c5.type != primary && c5.type != tileType) 
					setTileTypeByTile(c5, primary);						
				if (c6 && c6.type != primary && c6.type != tileType) 
					setTileTypeByTile(c6, primary);										
				if (c7 && c7.type != primary && c7.type != tileType) 
					setTileTypeByTile(c7, primary);										
				if (c8 && c8.type != primary && c8.type != tileType) 
					setTileTypeByTile(c8, primary);
			}
		
			if (x == 0 || y == 0 || x >= _world.xGridSize - 1 || y >= _world.yGridSize - 1)
			{ 
				c.passable = false;
				c.buildable = false;
			}
			else if (!c.cliffType)
			{
				c.passable = c.type.passable;
				c.buildable = c.type.buildable;
			}
		
			resetTile(c, tileType);
		
			fixTile(_world.getTile(x, y + 1));
			fixTile(_world.getTile(x, y - 1));
			fixTile(_world.getTile(x - 1, y));
			fixTile(_world.getTile(x + 1, y));
		
			fixTile(_world.getTile(x + 1, y + 1));
			fixTile(_world.getTile(x - 1, y + 1));
			fixTile(_world.getTile(x + 1, y - 1));
			fixTile(_world.getTile(x - 1, y - 1));
		}
		
		public function setTileTypeByTile(tile:IsoTile, tileType:*):void
		{
			if (tile)
				setTileType(tile.xindex, tile.yindex, tileType);
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
				if (c._tileTypeBL != _tileset.getPrimaryFor(c.type).id) c.type = _tileset.tileTypes[c._tileTypeBL];
				else if (c._tileTypeBR != _tileset.getPrimaryFor(c.type).id) c.type = _tileset.tileTypes[c._tileTypeBR];
				else if (c._tileTypeTL != _tileset.getPrimaryFor(c.type).id) c.type = _tileset.tileTypes[c._tileTypeTL];
				else if (c._tileTypeTR != _tileset.getPrimaryFor(c.type).id) c.type = _tileset.tileTypes[c._tileTypeTR];
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
				c.type = _tileset.getPrimaryFor(c.type);

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
		
		public function setCliff(tile:IsoTile, tileType:CliffTileType):void
		{			
			tile.cliffType = tileType;
			
			var neighbourTiles:Vector.<IsoTile> = _world.getTilesAroundTile(tile);

			for (var i:int = 0; i < neighbourTiles.length; ++i)
			{
				neighbourTiles[i].cliffType = tileType || neighbourTiles[i].cliffType;
			}
				
			setTileCliffVariation(tile, tileType ? CliffTileType.FLAT : Constants.UNDEFINED);
			
 			for (var i:int = 0; i < neighbourTiles.length; ++i)
			{
				if (tileType)
				{
					if (neighbourTiles[i].cliffType && !checkCliffValid(neighbourTiles[i]))
						setCliff(neighbourTiles[i], tileType);
				}
			}						
		}
				
		private function setTileCliffVariation(tile:IsoTile, variation:int):void
		{
			if (tile.cliffTypeVariation != variation)
			{
				tile.cliffTypeVariation = variation;
				
				if (tile.cliffType)
				{
					var isSlope:Boolean = (tile.cliffTypeVariation != CliffTileType.FLAT);
					tile.buildable = !isSlope;
					tile.passable = false;
					tile.z = isSlope ? tile.cliffType.height/2 : tile.cliffType.height;
				}
				else
				{
					tile.z = 0;
					tile.buildable = tile.type.buildable;
					tile.passable = tile.type.passable;
				}
	
				tile.object && (tile.object.z = tile.z);
				tile.unit && (tile.unit.z = tile.z);
												
				var tiles:Vector.<IsoTile> = _world.getTilesAroundTile(tile);
				for (var j:int = 0; j < tiles.length; ++j)
				{
					if (tiles[j].cliffType)
					{				
						setTileCliffVariation(tiles[j], _cliffMap[calcCliffVariation(tiles[j])]);
					}
				}	
			}		
		}

		private function checkCliffValid(tile:IsoTile):Boolean
		{
			var cliffVariation:int = calcCliffVariation(tile);
			return (_cliffMap[cliffVariation] != null);
		}
		
		private function calcCliffVariation(tile:IsoTile):int
		{
			var cliffVariation:int = 0;		
			var neighbourTiles:Vector.<IsoTile> = _world.getTilesAroundTile(tile, true);
						
			for (var i:int = 0; i < neighbourTiles.length; ++i)
			{
				if (neighbourTiles[i] && neighbourTiles[i].cliffType)
					cliffVariation += Math.pow(2, i);	
			}
			
			return cliffVariation;
		}
	
		public function removeCliff(tile:IsoTile):void
		{
			tile.cliffType = null;
			tile.z = 0;
			tile.buildable = tile.type.buildable;
			tile.passable = tile.type.passable;
			tile.cliffTypeVariation = Constants.UNDEFINED;
					
			var neighbourTiles:Vector.<IsoTile> = _world.getTilesAroundTile(tile);	
					
			for (var i:int = 0; i < neighbourTiles.length; ++i)
			{
				if (neighbourTiles[i].cliffType)
					setCliff(neighbourTiles[i], null);	
			}
		}
	}
}