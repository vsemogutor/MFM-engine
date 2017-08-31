package engine.tileset
{
	import __AS3__.vec.Vector;
	
	import computers.utils.Utils;
	
	import engine.game.Game;
	import engine.util.BitmapTransformer;
	import engine.util.Constants;
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	public final class Tileset
	{ 
		public const TILE_VARIATIONS:int = 3;
		
		private var _tileTypes:Vector.<TileType> = new Vector.<TileType>(); 
		private var _bitmap:BitmapData;
		private var _bitmaps:Vector.<BitmapData> = new Vector.<BitmapData>();
		private var _cycleBitmaps:Vector.<BitmapData> = new Vector.<BitmapData>();
		private var _cycle:int;
		
		public var primaryTileType:TileType;
		
		public function get bitmap(): BitmapData {
			return _bitmap;
		}

		public function get bitmaps(): Vector.<BitmapData> {
			return _bitmaps;
		}
				
		public function get tileTypes(): Vector.<TileType> {
			return _tileTypes;
		}
		
		public function getPrimaryFor(tileType:TileType): TileType
		{
			return tileType.primaryType || primaryTileType;
		}
		
		public function load(bitmap:BitmapData):void
		{
			_bitmap = bitmap;
			_bitmaps.push(bitmap);
			
			for (var i:int = 0; i < TILE_VARIATIONS; ++i)
			{
				_bitmaps.push(BitmapTransformer.addNoise(bitmap, false, Utils.rand(1, 3)/10));		
				_cycleBitmaps.push(BitmapTransformer.addNoise(_bitmap, true, 0.4));			
			}
												
			if (!_tileTypes.length)
			{
				addTileType("Grass", true, true, 0, 0, true);
				addTileType("Dirt", true, true, 0, 1);
				addTileType("Stone", true, true, 0, 2);
				addTileType("Grass[NonPassable,Buildable]", false, true, 0, 0);
				addTileType("Dirt[Passable,NonBuildable]", true, false, 0, 1);
				addTileType("Stone[Passable,NonBuildable]", true, false, 0, 2);
			}
			
			setTilesColor();
		}
		
		public function addTileType(name:String, passable:Boolean, buildable:Boolean, color:uint, 
			yOffset:int, primary:Boolean = false, animated:Boolean = false, primaryType:TileType=null):int
		{	
			var tile:TileType = new TileType(name, passable, buildable, color, yOffset, primary, animated, primaryType);
			tile.id = _tileTypes.length;
			
			_tileTypes.push(tile);
			if (primary)
			{			
				if (!primaryTileType)
					primaryTileType = tile;
				else
					tile.primaryType = tile;
			}
			
			return tile.id;
		}
		
		public function addCliffType(name:String, color:uint, yOffset:int, frameHeight:int=0, height:int=0):int
		{
			if (!frameHeight)
				frameHeight = 3*Constants.TILE_HEIGHT;
			
			var tile:CliffTileType = new CliffTileType(name, color, yOffset, frameHeight, height);
			tile.id = _tileTypes.length;
			
			_tileTypes.push(tile);
			
			return tile.id;		
		}
		
		private function setTilesColor():void
		{
			for (var i:int = 0; i < _tileTypes.length; ++i)
			{
				if (_tileTypes[i].color != 0) continue;
				var tlRect:Rectangle = _tileTypes[i].getTileRect(0);
				_tileTypes[i].color = bitmap.getPixel(tlRect.left + (tlRect.width >> 1), tlRect.top + (tlRect.height >> 1));
			}
		}
		
		public function getCycleBitmap(): BitmapData 
		{
			if (Game.instance().gameTime.value % int(Constants.FRAME_RATE/3) == 0)
			{
				if (++_cycle >= TILE_VARIATIONS)
					_cycle = 0;
			}
				
			return _cycleBitmaps[_cycle];
		}
		
		public function getById(id:int):TileType
		{
			for (var i:int = 0; i < _tileTypes.length; ++i)
			{
				if (id == _tileTypes[i].id) return _tileTypes[i];
			}
			
			return null;
		}
	}
}