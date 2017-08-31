package engine.objects.isometric
{
	import __AS3__.vec.Vector;
	
	import engine.animation.AnimatedSprite;
	import engine.core.isometric.IsoTile;
	import engine.display.DisplayInfo;
	import engine.display.DisplayUnitSelection;
	import engine.objects.*;
	import engine.core.fm_internal;
	
	use namespace fm_internal;
	
	public class IsoObject extends BaseObject
	{
		fm_internal var _overTiles:Vector.<Vector.<IsoTile>>;
		private var _type:ObjectType;
		private var _passable:Boolean;
		private var _xL:int;
		private var _yL:int;
		
						
		public function get type():ObjectType {
			return _type;
		}
				
		public override function get tile():IsoTile {
			return _overTiles[0][0];
		}

		public function get passable():Boolean{
			return _passable;
		}
		public function set passable(value:Boolean):void{
			_passable = value;
		}
		
		public override function get xL():int{
			return _xL;
		}
		public override function get yL():int {
			return _yL;
		}
		public function set xL(xL:int):void {
			this._xL = xL;
		}
		public function set yL(yL:int):void {
			this._yL = yL;
		}
		public override function get xLength():int{
			return _type.xLength;
		}
		public override function get yLength():int{
			return _type.yLength;
		}
		public override function get overTiles():Vector.<Vector.<IsoTile>> {
			return _overTiles;
		}
			
		public function IsoObject(type:ObjectType)
		{		
			_displaySelection = new DisplayUnitSelection(this);
			_displayInfo = new DisplayInfo(this);
			_type = type;
			_overTiles = new Vector.<Vector.<IsoTile>>(type.xLength);
			for (var i:int = 0; i < _overTiles.length; ++i)
				_overTiles[i] = new Vector.<IsoTile>(type.yLength);
			_passable = type.passable;
		}
	}
}