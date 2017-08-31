package computers.utils;
	
class Utils
{
	private static inline var DEGREE_PER_RAD:Float = 180/Math.PI;
	private static inline var DOWN_RIGHT:Int = 7;	
	
	public static function copySign(dest:Float, from:Float):Float
	{
		if (dest == 0)
			return dest;
			
		var abs:Float = dest < 0 ? -dest : dest;
		if (from < 0)
			return -abs;
		else
			return abs;
	}
	
	public static function getAngle(p1:flash.geom.Point, p2:flash.geom.Point):Float
	{
		var x:Float = (p1.x - p2.x);
		var y:Float = (p1.y - p2.y);

		if (x<0 && y>=0) 
		{
			var ax:Float = -x;
			var yx:Float = y/ax;
			return Math.atan(yx)*DEGREE_PER_RAD;
		}
		else if (x>=0 && y>0) 
		{
			var xy:Float = x/y;
			return (Math.atan(xy) + 0.5*Math.PI)*DEGREE_PER_RAD;
		}
		else if (x>0 && y<=0) 
		{
			var ay:Float = -y;
			var yx:Float = ay/x;
			return (Math.atan(yx) + Math.PI)*DEGREE_PER_RAD;
		}
		else if (x<=0 && y<0) 
		{
			var ax:Float = -x;
			var ay:Float = -y;
			var xy:Float = ax/ay;
			return (Math.atan(xy) + 1.5*Math.PI)*DEGREE_PER_RAD;
		}
		else return 0;
	}
	
	public static function getDir(p1:flash.geom.Point, p2:flash.geom.Point):Int
	{	
		var angle:Float = getAngle(p1, p2);
		var a:Int = Math.round(angle/45.0);
		if (a == 0)
			return DOWN_RIGHT;
		else
			return a - 1;
	}
	
	public static function getDistance(p1:flash.geom.Point, p2:flash.geom.Point):Float
	{
		var x:Float = p1.x-p2.x;
		var y:Float = p1.y-p2.y;
		x = x < 0 ? -x : x;
		y = y < 0 ? -y : y;			
		return x > y ? x : y; 
	}	
	
	public static function rand(min:Int, max:Int):Int
	{
		if (min == max) return min;
		return Std.int(Math.random() * (max - min) + min + 0.3);
	}
			
	public static function copyVector(source:flash.Vector<Int>, dest:flash.Vector<Int>):Void
	{
		var i:Int = source.length;
		while ( (--i) >= 0)
			dest[i] = source[i];
	}
}