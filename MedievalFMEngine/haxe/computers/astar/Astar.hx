package computers.astar;

/*
	NOTE: SquirrelRed 3/17/2011
	This class and it's supporting classes are highly OOP denormalized 
	from it's initial implementation.
	This is done for performance reasons.
	DO NOT try to follow OOP rules here, flash won't welcome you.
*/

class Astar
{
	private var startPoint:AstarPoint;	
	private var endPoint:AstarPoint;
	
	public var map:flash.Vector<AstarNode>;
	public var walkableMap:flash.Vector<AstarNode>;
	
	public inline static var standardCost:Float = 1;
	public inline static var diagonalCost:Float = 1.23;
	
	private var mapH:Int;
	private var mapW:Int;
	
	private var heap:BinaryHeap;
	
	// predefined surrounding tiles array and its lenght
	// this is needed to avoid creating new array for aech tile
	private var st:flash.Vector<AstarNode>;
	private var stCount:Int;
	
	public function new()
	{
		st = new flash.Vector<AstarNode>(8, true);
	}
	
	public function newMap(w:Int, h:Int, walkableFunction: Int -> Int -> Bool):Void
	{
		this.map = new flash.Vector<AstarNode>(w * h + 1, true);
		this.walkableMap = new flash.Vector<AstarNode>();
		for (y in 0...h) 
		{
			for (x in 0...w) 
			{
				var tile:AstarNode = new AstarNode(x, y, Astar.standardCost);
				tile.walkable = walkableFunction(x, y);
				map[x * h + y] = tile;
			}
		}
		
		this.mapW = w;
		this.mapH = h;
		
		initLod();
	}
	
	private function initLod():Void
	{
		for (y in 0...mapH) 
		{
			for (x in 0...mapW) 
			{
				var tile:AstarNode = map[x * mapH + y];
				tile.neighbours = findNeighboursTiles(tile);
				if (tile.walkable) walkableMap.push(tile);
			}
		}	
	}
	
	public inline function setStartPoint(x:Int, y:Int):Void
	{
		this.startPoint = new AstarPoint(x, y);
	}
		
	public inline function setEndPoint(x:Int, y:Int):Void
	{
		this.endPoint = new AstarPoint(x, y);
	}
	
	public function findPath():flash.Vector<AstarNode>
	{		
		if(!ready()) return null;

		openMap();
		
		heap = new BinaryHeap(mapW * mapH);
		
		var pathFound:Bool = false;
		
		var beginTile:AstarNode = map[startPoint.x * mapH + startPoint.y];
		
		beginTile.open();
		beginTile.setG(0);
		beginTile.setH(startPoint.x, startPoint.y);
		beginTile.parent = beginTile;
		heap.addToHeap(beginTile);
		
		var heapArray:flash.Vector<AstarNode> = heap.getHeap();
		var searchLimit:Int = 0;
		var px:Int = endPoint.x;
		var py:Int = endPoint.y;
		var current:AstarNode = beginTile;
		while(heap.heapLen - 1 > 0 && !pathFound)
		{			
			current = heap.getLowest();
			
			//check if the path is found (current tile = end tile)
			if( current.x == px && current.y == py)
			{
				pathFound = true;
				break;
			}
			
			
			// remove the current object from the open-array
			current.opened = false;
			current.closed = true;

			// find all the surrounding nodes
			findSurroundingTiles(current);
			
			if (stCount & 1 == 1)
			{
				for(i in 0...stCount)
				{
					var node:AstarNode = st[i];
					if(!node.opened)
					{
						node.opened = true;
						node.closed = false;
			
						node.parent = current;
						node.setH(node.x, node.y);
						node.setG(current.g);
						heap.addToHeap(node);
						
					} 
					else 
					{
						var nodeH:Float = node.h;
						var tempF:Float = nodeH + current.g + node.cost;
						var nodeF:Float = node.g + nodeH;
						if(tempF < nodeF)
						{
							node.parent = current;
							node.setG(current.g);
							heap.updateList(node);
						}
					}
				}			
			}
			else
			{
				var i:Int = 0;
				while(i < stCount)
				{
					var node:AstarNode = st[i];
					if(!node.opened)
					{
						node.opened = true;
						node.closed = false;
			
						node.parent = current;
						node.setH(node.x, node.y);
						node.setG(current.g);
						heap.addToHeap(node);
						
					} 
					else 
					{
						var nodeH:Float = node.h;
						var tempF:Float = nodeH + current.g + node.cost;
						var nodeF:Float = node.g + nodeH;
						if(tempF < nodeF)
						{
							node.parent = current;
							node.setG(current.g);
							heap.updateList(node);
						}
					}
					
					++i;
					
					node = st[i];
					if(!node.opened)
					{
						node.opened = true;
						node.closed = false;
			
						node.parent = current;
						node.setH(node.x, node.y);
						node.setG(current.g);
						heap.addToHeap(node);
						
					} 
					else 
					{
						var nodeH:Float = node.h;
						var tempF:Float = nodeH + current.g + node.cost;
						var nodeF:Float = node.g + nodeH;
						if(tempF < nodeF)
						{
							node.parent = current;
							node.setG(current.g);
							heap.updateList(node);
						}
					}

					++i;					
				}				
			}
		}
		
		// found?
		if (!pathFound)
			return null;
		
		//the path is calculated, so now we have to start at the end and work our way back:
		var path:flash.Vector<AstarNode> = new flash.Vector<AstarNode>();
		
		var node:AstarNode = map[px * mapH + py];
		path.push(node);
		var parent:AstarNode = node.parent;
		px = parent.x;
		py = parent.y;
		
		var sx:Int = startPoint.x;
		var sy:Int = startPoint.y;
		while (px != sx || py != sy)
		{
			node = map[px * mapH + py];
			path.push(node);
			
			parent = node.parent;
			
			px = parent.x;
			py = parent.y;
		}
		
		return path;
	}

	private function getNode(indx:Int):AstarNode
	{
		if (indx >= 0 && indx < Std.int(map.length))
			return map[indx];
		else
			return null;
	}
	
	private function findNeighboursTiles(current:AstarNode):flash.Vector<AstarNode>
	{
		var x:Int = current.x;
		var y:Int = current.y;
		var result:flash.Vector<AstarNode> = new flash.Vector<AstarNode>();
		
			
		//check left, right, down and up. Check: walkable & not closed	
		var nypx:AstarNode = getNode( (x+1)*mapH + y );
		var nymx:AstarNode = getNode( (x-1)*mapH + y );
		var npyx:AstarNode = getNode( x*mapH + (y+1) );		
		var nmyx:AstarNode = getNode( x*mapH + (y-1) );
		var npypx:AstarNode = getNode( (x+1)*mapH + (y+1) );
		var nmymx:AstarNode = getNode( (x-1)*mapH + (y-1) );
		var npymx:AstarNode = getNode( (x-1)*mapH + (y+1) );		
		var nmypx:AstarNode = getNode( (x+1)*mapH + (y-1) );						
				
		if(nmymx != null && nmymx.walkable)
		{
			result.push(nmymx);
		}
		if(nmypx != null && nmypx.walkable)
		{
			result.push(nmypx);
		}
		if(npypx != null && npypx.walkable )
		{
			result.push(npypx);
		}
		if(npymx != null && npymx.walkable )
		{
			result.push(npymx);
		}
		
		if(nymx != null && nymx.walkable )
		{
			result.push(nymx);
		}
		if(nypx != null && nypx.walkable )
		{
			result.push(nypx);
		}
		if(npyx != null && npyx.walkable)
		{
			result.push(npyx);
		}
		if(nmyx != null && nmyx.walkable )
		{
			result.push(nmyx);
		}
		
		return result;
	}
	
	private function findSurroundingTiles(current:AstarNode):Void
	{
		var x:Int = current.x;
		var y:Int = current.y;
		stCount = 0;
		
		var neighbours:flash.Vector<AstarNode> = current.neighbours;
		var len:Int = neighbours.length;
		for (i in 0...len)
		{
			var nbr:AstarNode = neighbours[i];
			if(nbr.walkable && !nbr.closed)
			{
				st[stCount] = nbr;
				++stCount;
				nbr.increaseG = ((nbr.x != x && nbr.y != y) ? diagonalCost : standardCost);
			}
		}
	}
	
	private function ready():Bool
	{			
		if(startPoint.x < 0 || startPoint.x >= mapW)
		{
			return false;
		} 
		else if(startPoint.y < 0 || startPoint.y >= mapH)
		{
			return false;
		}
		
		if(endPoint.x < 0 || endPoint.x >= mapW)
		{
			return false;
		} 
		else if(endPoint.y < 0 || endPoint.y >= mapH)
		{
			return false;
		}
		
		return true;
	}
	
	public function setWalkable(x:Int, y:Int, b:Bool):Void
	{
		map[x * mapH + y].walkable = b;
	}
		
	private function openMap():Void
	{
		var mSize:Int = walkableMap.length;
		for(i in 0...mSize)
		{
			walkableMap[i].reset();
		}
	}
}
