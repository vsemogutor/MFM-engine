package engine.core.isometric
{
	import __AS3__.vec.Vector;
	
	import com.greensock.TweenMax;
	
	import de.polygonal.ds.LinkedQueue;
	import de.polygonal.ds.Queue;
	
	import engine.area.Area;
	import engine.computers.PathFinder;
	import engine.minimap.Minimap;
	import engine.objects.BaseObject;
	import engine.objects.ObjectType;
	import engine.objects.isometric.IsoObject;
	import engine.structures.Structure;
	import engine.tileset.Tileset;
	import engine.tileset.TilesetMapEditor;
	import engine.units.Unit;
	import engine.units.UnitType;
	import engine.units.UnitTypes;
	import engine.util.Constants;
	import engine.util.TileUtil;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public final class IsoWorld
	{
	    public var tiles: Vector.<IsoTile>;
	    private var _openList:Vector.<Boolean>;
		public var xGridSize:int;
		public var yGridSize:int;
		public var zGridSize:int;
		private var _boundary:Rectangle;
		public var xCenter:int;
		public var yCenter:int;
		public var xGap:int = 0;
		public var yGap:int = 0;
		public var tileset:Tileset;
		public var tilesetMapEditor:TilesetMapEditor;	
		public var pathFinder:PathFinder;	
		public var minimap:Minimap;
		public var area:Area;
		
		private static const _ignoreObject:Object = {};
				
		public function get boundary():Rectangle {
			return _boundary;
		}
				
		public function get centerTile():IsoTile {
			var x:int = xCenter;
			if (x < 0) x = 0;
			else if (x >= xGridSize) x = xGridSize - 1;
			
			var y:int = yCenter;
			if (y < 0) y = 0;
			else if (y >= yGridSize) y = yGridSize - 1;			
			
			return getTileUnsafe(x, y);
		}	
		
	    public function IsoWorld(width:int, height:int)
	    {
	    	xGridSize = width;
	    	yGridSize = height;
	    	// excluding border tiles
	    	_boundary = new Rectangle(1, 1, xGridSize - 2, yGridSize - 2);
	    	tiles = new Vector.<IsoTile>(xGridSize * yGridSize);
	    	_openList = new Vector.<Boolean>(tiles.length, true);
	    	minimap = new Minimap();
	    	area = new Area("world", 0, 0, xGridSize, yGridSize);
	    }
	    
		public function placeUnitOnWorld(_object:BaseObject, position:Point, forced:Boolean = false):Boolean 
		{
			var ret:Boolean = true;
			var object:Unit = _object as Unit;
			
			var indx:int = (position.x)*yGridSize + position.y;
			if (indx < 0 || indx >= tiles.length)
				return false;
					
			var tile:IsoTile;
			if (forced)
			{
				tile = getFreeTileAroundPoint(position, 7, null, object.type.isFlying) as IsoTile;
			}
			else
			{	
				tile = tiles[indx] as IsoTile;
			}
			if (!canPlaceUnit(tile, object.type))
				return false;
			
			TweenMax.killTweensOf(object);
			object.setTile(tile);
			object.order.targetTile = tile;
			object.center = tile.center;
			object.resetPath();	
																 
			return ret;
		}

		public function removeUnitFromWorld(unit:Unit):void
		{
			if (unit is Structure)
			{
				for (var i:int = 0; i < unit.overTiles.length; ++i)
				{
					for (var j:int = 0; j < unit.overTiles[i].length; ++j)
					{
						var tile:IsoTile = unit.overTiles[i][j];
						if (tile)
						{
							if (tile.unit == unit)
								tile.unit = null;
							pathFinder.setWalkableLand(tile, true);
						}
					}
				}
			}
			else
			{
				unit.setTile(null);
			}
			unit.isInWorld = false;
			unit.isActive = false;
		}
		
		public function placeObjectOnWorld(_object:BaseObject, position:Point):Boolean 
		{
			var ret:Boolean = true;
			var object:IsoObject = _object as IsoObject;
			if( position.x <= 0 || position.y <= 0 || position.x >= xGridSize || position.y >= yGridSize) {
				return false;
			}
			
			if (!canPlaceObject(position, object.type))
				return false;
			
			var xL:int = object.xLength-1;
			var yL:int = object.yLength-1;
						
			object.x = position.x*Constants.TILE_U + Constants.TILE_V + xL*Constants.TILE_U;
			object.y = position.y*Constants.TILE_U + Constants.TILE_V + yL*Constants.TILE_U;
			
			for( var iy:int = 0 ; iy < object.yLength ; iy++ ) {
				for( var ix:int = 0 ; ix < object.xLength ; ix++ ) 
				{
					var tile:IsoTile = getTileUnsafe(ix + position.x, iy + position.y);																					
					tile.object = object;
					object.overTiles[ix][iy] = tile;
					if (!object.passable)
					{
						pathFinder.setWalkableLand(tile, false);
						tile.passable = false;
					}
										
					object.xL = ix;
					object.yL = iy;	
					object.z = Math.max(object.z, tile.z);
				}						
			}
										 
			return ret;
		}
		
		public function removeObjectFromWorld(_object:BaseObject):void 
		{
			var object:IsoObject = _object as IsoObject;
			for( var ix:int = 0 ; ix <  object.overTiles.length; ix++ ) 
			{
				for( var iy:int = 0 ; iy <  object.overTiles[ix].length; iy++ ) 
				{
					var oldIsoTile:IsoTile = object.overTiles[ix][iy];
					if( oldIsoTile && oldIsoTile.object == _object) 
						oldIsoTile.object = null;	

					pathFinder.setWalkableLand(oldIsoTile, oldIsoTile.type.passable);
					oldIsoTile.passable = oldIsoTile.type.passable;					
				}	
			}
			object.isActive = false;
			object.isInWorld = false;
		}
		
		public function placeStructureOnWorld(structure:Structure, position:Point, ignoreUnbuildable:Boolean=false):Boolean 
		{
			var ret:Boolean = true;
			var object:Structure = structure as Structure;
			if( position.x <= 0 || position.y <= 0 || position.x >= xGridSize || position.y >= yGridSize) {
				return false;
			}
			
			if (!canPlaceUnit(position, structure.type, ignoreUnbuildable))
				return false;
			
			var xL:int = object.xLength-1;
			var yL:int = object.yLength-1;
			
			object.x = position.x*Constants.TILE_U + (Constants.TILE_U>>1) + xL*Constants.TILE_U;
			object.y = position.y*Constants.TILE_U + (Constants.TILE_U>>1) + yL*Constants.TILE_U;
						
			for( var iy:int = 0 ; iy < object.yLength ; iy++ ) {
				for( var ix:int = 0 ; ix < object.xLength ; ix++ ) {
					var tile:IsoTile = getTile(ix + position.x, iy + position.y);			
					if(tile) 
					{																			
						tile.unit = object;
						object.overTiles[ix][iy] = tile;
						pathFinder.setWalkableLand(tile, false);
								
						object.xL = ix;
						object.yL = iy;
						object.z = Math.max(object.z, tile.z);
					}
				}						
			}
				
			object.tile = object.overTiles[0][0];											 
			return ret;
		}
		
		public function getTile(x:int,y:int):IsoTile
		{
			if (x < 1 || x >= xGridSize - 1 || y < 1 || y >= yGridSize - 1)
				return null;
				
			return tiles[x*yGridSize + y];
		}
	
		public function getTileUnsafe(x:int,y:int):IsoTile
		{
			return tiles[x*yGridSize + y];
		}
			
		public function getRangeAroundTile(tile:IsoTile, range:int = 1):Rectangle
		{
			var rect:Rectangle = new Rectangle(tile.xindex - range, tile.yindex - range, 
				(range<<1) + 1, (range<<1) + 1);
			
			return rect.intersection(boundary);
		}
	
		public function getRangeAroundPoint(pos:Point, range:int = 1):Rectangle
		{
			var rect:Rectangle = new Rectangle(pos.x - range, pos.y - range, 
				(range<<1) + 1, (range<<1) + 1);
			
			return rect.intersection(boundary);
		}
			
		public function getFreeTileAroundPoint(pos:*, range:int, ignoreObject:* = null, flying:Boolean = false, useRegions:Boolean = false):IsoTile
		{
			var startPoint:Point;
			if (pos is Point)
				startPoint = pos;
			else
				startPoint = new Point(pos.xindex, pos.yindex);
				
			ignoreObject = ignoreObject || _ignoreObject;

			var boundary:Rectangle = getRangeAroundPoint(startPoint, range);			
			var len:int = _openList.length;
			var bRight:int = boundary.right;
			var bBottom:int = boundary.bottom;
			for (var i:int = boundary.x; i < bRight; ++i)
			{
				for (var j:int = boundary.y; j < bBottom; ++j)
				{
					_openList[i*yGridSize + j] = false;
				}
			}

			var q:Queue = new LinkedQueue;
			q.enqueue(startPoint);
			_openList[startPoint.x*yGridSize + startPoint.y] = true;
			
			var resultList:Vector.<IsoTile> = new Vector.<IsoTile>();
			var unit:Unit = ignoreObject as Unit;
			
			while (!q.isEmpty())
			{
				var p:Point = q.dequeue() as Point;
				var tile:IsoTile = tiles[p.x*yGridSize + p.y];
				if ((!flying && (tile.isFreeToMove || tile.unit == ignoreObject) && (!useRegions || tile.region == unit.tile.region))
					|| (flying && (tile.isFreeToFly || tile.unitFlying == ignoreObject)))
				{
					if (ignoreObject is Unit)
					{
						resultList.push(tile);
						if (resultList.length >= 8)
							break;
					}
					else
					{
						return tile;
					}
				}
				else
				{
					var np:Point = new Point(p.x, p.y - 1);
					var indx:int;
					if (boundary.containsPoint(np))
					{
						indx = np.x*yGridSize + np.y;
						if (!_openList[indx])
						{
							q.enqueue(np);
							_openList[indx] = true;
						}
					}

					np = new Point(p.x, p.y + 1);
					if (boundary.containsPoint(np))
					{
						indx = np.x*yGridSize + np.y;
						if (!_openList[indx])
						{
							q.enqueue(np);
							_openList[indx] = true;
						}
					}

					np = new Point(p.x + 1, p.y);
					if (boundary.containsPoint(np))
					{
						indx = np.x*yGridSize + np.y;
						if (!_openList[indx])
						{
							q.enqueue(np);
							_openList[indx] = true;
						}
					}
					
					np = new Point(p.x - 1, p.y);
					if (boundary.containsPoint(np))
					{
						indx = np.x*yGridSize + np.y;
						if (!_openList[indx])
						{
							q.enqueue(np);
							_openList[indx] = true;
						}
					}
					
					np = new Point(p.x - 1, p.y - 1);
					if (boundary.containsPoint(np))
					{
						indx = np.x*yGridSize + np.y;
						if (!_openList[indx])
						{
							q.enqueue(np);
							_openList[indx] = true;
						}
					}

					np = new Point(p.x - 1, p.y + 1);
					if (boundary.containsPoint(np))
					{
						indx = np.x*yGridSize + np.y;
						if (!_openList[indx])
						{
							q.enqueue(np);
							_openList[indx] = true;
						}
					}
					
					np = new Point(p.x + 1, p.y + 1);
					if (boundary.containsPoint(np))
					{
						indx = np.x*yGridSize + np.y;
						if (!_openList[indx])
						{
							q.enqueue(np);
							_openList[indx] = true;
						}
					}
					
					np = new Point(p.x + 1, p.y - 1);
					if (boundary.containsPoint(np))
					{
						indx = np.x*yGridSize + np.y;
						if (!_openList[indx])
						{
							q.enqueue(np);
							_openList[indx] = true;
						}
					}
				}
			}
			
			var tl:IsoTile;
			if (ignoreObject is Unit)
				tl = ignoreObject.tile;
			
			var minDist:Number = int.MAX_VALUE;
			var bestTile:IsoTile = null;
			
			if (tl && resultList.length)
			{
				// get tile with min dist
				var startTile:IsoTile = tiles[startPoint.x*yGridSize + startPoint.y];
				var len:int = resultList.length;
				for (var i:int = 0; i < len; ++i)
				{
					var ctile:IsoTile = resultList[i];
					var dist:int = TileUtil.getSqrtTileDist(ctile, tl) + (TileUtil.getTileDist(ctile, startTile)<<3);
					if (minDist > dist)
					{
						minDist = dist;
						bestTile = ctile;
					}
				}
			}

			return bestTile;
		}
		
		public function getFreeTileInArea(area:Rectangle, flying:Boolean = false):IsoTile
		{
			var boundary:Rectangle = boundary.intersection(area);
			for (var i:int = boundary.left; i <= boundary.right; ++i)
			{
				for (var j:int = boundary.top; j <= boundary.bottom; ++j)
				{
					var tile:IsoTile = tiles[i*yGridSize + j];
					if ((!flying && tile.isFreeToMove) || (flying && tile.isFreeToFly))
						return tile;
				}
			}
			
			return null;
		}
		
		public function canPlaceUnit(position:*, type:UnitType, ignoreUnbuildableFlag:Boolean=false):Boolean
		{
			var pos:Point;
			if (position is Point)
				pos = position;
			else if (position is IsoTile)
				pos = new Point(position.xindex, position.yindex);
			else
				return false;
			
			var structBoundary:Rectangle = new Rectangle(pos.x, pos.y, type.xLength, type.yLength);
			
			if (!boundary.containsRect(structBoundary))
				return false;
			
			if (type.type == UnitTypes.Structure)
			{
				for (var i:int = structBoundary.left; i < structBoundary.right; ++i)
				{
					for (var j:int = structBoundary.top; j < structBoundary.bottom; ++j)
					{
						var tile:IsoTile = tiles[i*yGridSize + j];
						if (ignoreUnbuildableFlag)
						{
							if (!tile.isEditorFreeBuild)
								return false;
						}
						else if (!tile.isFreeToBuild)
							return false;
					}
				}
			}
			else if (type.isFlying)
			{
				var tile:IsoTile = tiles[pos.x*yGridSize + pos.y];
				return tile.isFreeToFly;
			}
			else
			{
				var tile:IsoTile = tiles[pos.x*yGridSize + pos.y];
				return tile.isFreeToMove;			
			}
			
			return true;
		}
		
		public function canPlaceObject(position:*, objectType:ObjectType):Boolean
		{
			var pos:Point;
			if (position is Point)
				pos = position;
			else if (position is IsoTile)
				pos = new Point(position.xindex, position.yindex);
			else
				return false;
				
			var objBoundary:Rectangle = new Rectangle(pos.x, pos.y, objectType.xLength, objectType.yLength);
			
			if (!boundary.containsRect(objBoundary))
				return false;
			
			for (var i:int = objBoundary.left; i < objBoundary.right; ++i)
			{
				for (var j:int = objBoundary.top; j < objBoundary.bottom; ++j)
				{
					var tile:IsoTile = tiles[i*yGridSize + j];
					if (tile.object || (tile.unit && !objectType.passable))
						return false;
				}
			}
			
			return true;
		}
		
		public function getTilesAroundTile(tile:IsoTile, includeEmpty:Boolean = false):Vector.<IsoTile>
		{
			// the order tiles are pushed does matter
			// 3 2 1
			// 4 * 0
			// 5 6 7
			var tiles:Vector.<IsoTile> = new Vector.<IsoTile>();
			var c1:IsoTile = getTile(tile.xindex + 1, tile.yindex);
			var c2:IsoTile = getTile(tile.xindex + 1, tile.yindex - 1);
			var c3:IsoTile = getTile(tile.xindex, tile.yindex - 1);
			var c4:IsoTile = getTile(tile.xindex - 1, tile.yindex - 1);
			var c5:IsoTile = getTile(tile.xindex - 1, tile.yindex);
			var c6:IsoTile = getTile(tile.xindex - 1, tile.yindex + 1);							
			var c7:IsoTile = getTile(tile.xindex, tile.yindex + 1);
			var c8:IsoTile = getTile(tile.xindex + 1, tile.yindex + 1);

			if (c1 || includeEmpty) tiles.push(c1);
			if (c2 || includeEmpty) tiles.push(c2);
			if (c3 || includeEmpty) tiles.push(c3);
			if (c4 || includeEmpty) tiles.push(c4);
			
			if (c5 || includeEmpty) tiles.push(c5);
			if (c6 || includeEmpty) tiles.push(c6);
			if (c7 || includeEmpty) tiles.push(c7);
			if (c8 || includeEmpty) tiles.push(c8);	
			
			return tiles;
		}
		
		public function calculateRegions():void
		{
			// clear all regions
			for (var i:int = 0; i < xGridSize; ++i)
			{
				for (var j:int = 0; j < yGridSize; ++j)
				{
					var tile:IsoTile = getTileUnsafe(i, j);
					tile.region = 0;
				}
			}
			
			var region:int = 1;
			for (var i:int = 0; i < xGridSize; ++i)
			{
				for (var j:int = 0; j < yGridSize; ++j)
				{
					var tile:IsoTile = getTileUnsafe(i, j);
					if (tile.region) continue;
					
					var queue:Array = [];
					var cur:int = 0;
					queue.push(tile);
					++region;
					
					while (cur < queue.length)
					{
						var sTile:IsoTile = queue[cur];
						queue[cur] = null;
						sTile.region = region;
						cur++;
						
						var tiles:Vector.<IsoTile> = getTilesAroundTile(sTile);
						for (var t:int = 0; t < tiles.length; ++t)
						{
							if (tiles[t].region) continue;
							
							if (tile.isTypePassable == tiles[t].isTypePassable)
							{
								tiles[t].region = region;
								queue.push(tiles[t]);
							}
						}
					}
				}
			}
		}
	}
}