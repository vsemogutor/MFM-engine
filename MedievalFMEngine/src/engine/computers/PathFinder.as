package engine.computers
{
	import __AS3__.vec.Vector;
	
	import computers.astar.Astar;
	import computers.astar.AstarNode;
	
	import engine.core.isometric.IsoTile;
	import engine.core.isometric.IsoWorld;
	import engine.game.Game;
	import engine.structures.Structure;
	import engine.units.Unit;
	import engine.units.UnitType;
	import engine.util.Constants;
	
	public final class PathFinder
	{		
		private var astar:Astar;
		private var astarFlying:Astar;
		private var _pathfindingQuota:int = 1;
		public var pathExpirationTime:int = Constants.PATH_EXPIRATION_TIME;
			
		public function get pathFindingQuota():int {
			return _pathfindingQuota;
		}
						
		public function PathFinder(world:IsoWorld)
		{
			astar = new Astar();
			astar.newMap(world.xGridSize, world.yGridSize, landUnitWalkable);
			
			astarFlying = new Astar();
			astarFlying.newMap(world.xGridSize, world.yGridSize, flyingUnitWalkable);
			
			// if map is small - we can increase quota
			if (world.xGridSize + world.yGridSize <= 68)
	    	{
	    		_pathfindingQuota = 2;
	    		pathExpirationTime -= Constants.FRAME_RATE>>1;
	    	}
		}
		
		private function landUnitWalkable(x:int, y:int):Boolean
		{
			var tile:IsoTile = Game.instance().world.getTile(x, y);
			return tile && tile.isFreeToMove;
		}
		
		private function flyingUnitWalkable(x:int, y:int):Boolean
		{
			var tile:IsoTile = Game.instance().world.getTile(x, y);
			return tile && tile.isFreeToFly;
		}
		
		public function getPath(from:IsoTile, dest:IsoTile, unitType:UnitType): Vector.<IsoTile>
		{
			var astar:Astar;
			
			if (unitType.isFlying) 
				astar = this.astarFlying;
			else 
				astar = this.astar;				
			
			astar.setStartPoint(from.xindex, from.yindex);
			astar.setEndPoint(dest.xindex, dest.yindex);
			var result:Vector.<AstarNode> = astar.findPath();
			
			if (result)
			{
				// need to reverse returned result
				var resLen:int = result.length;
				var path:Vector.<IsoTile> = new Vector.<IsoTile>(resLen);
				var world:IsoWorld = Game.instance().world;
				
				for (var i:int = resLen - 1; i >= 0; --i)
				{
					var node:AstarNode = result[i];
					path[resLen - i - 1] = world.getTileUnsafe(node.x, node.y);
				}
				
				return path;
			}
			else
				return new Vector.<IsoTile>();
		}
		
		public function setWalkable(unit:Unit, walkable:Boolean):void
		{
			if (unit.type.isFlying)
				astarFlying.setWalkable(unit.tile.xindex, unit.tile.yindex, walkable);
			else if (!(unit is Structure))
				astar.setWalkable(unit.tile.xindex, unit.tile.yindex, walkable);
		}
		
		public function setWalkableLand(tile:IsoTile, walkable:Boolean):void
		{
			astar.setWalkable(tile.xindex, tile.yindex, walkable);
		}
	}
	
}