package computers.astar;

class AstarNode
{
	public var opened:Bool;
	public var closed:Bool; 
	
	public var parent:AstarNode;
	
	private static var ids:Int = 0;
	
	public var increaseG:Float;
	
	public var h:Float;
	public var g:Float;
	
	public var cost:Float;
	
	public var x:Int;
	public var y:Int;
	public var id:Int;
	public var walkable:Bool;
	public var neighbours:flash.Vector<AstarNode>;
	
	public function new(xp:Int, yp:Int, _cost:Float)
	{
		x = xp;
		y = yp;
		id = ids++;
		cost = _cost;
		walkable = true;
	}
	
	public inline function open():Void
	{
		opened = true;
		closed = false;
	}
	
	public inline function setH(ex:Int, ey:Int):Void
	{
		var dx:Int = ex - x;
		var dy:Int = ey - y;
		h = ((dx ^ (dx >> 31)) - (dx >> 31)) + ((dy ^ (dy >> 31)) - (dy >> 31));
	}
	
	public inline function setG(_g:Float):Void
	{
		g = _g + increaseG;
	}
	
	public inline function getF():Float 
	{
		return g + h;
	}
	
	public inline function getCost():Float
	{
		return cost * increaseG;
	}
	
	public inline function reset():Void
	{
		opened = false;
		closed = false;
		parent = null;
		h = 0;
		g = 0;
		increaseG = 1;
	}
}
