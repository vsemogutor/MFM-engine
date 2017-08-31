package engine.units
{
	import __AS3__.vec.Vector;
	
	import engine.core.isometric.IsoTile;
	
	public final class VisibleUnits
	{
		public var friendly:Vector.<Unit> = new Vector.<Unit>();
		public var enemy:Vector.<Unit> = new Vector.<Unit>();
		public var items:Array = [];				
	}
}