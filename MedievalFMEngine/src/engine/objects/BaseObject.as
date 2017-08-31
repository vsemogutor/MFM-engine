package engine.objects
{
	import __AS3__.vec.Vector;
	
	import engine.animation.AnimatedSprite;
	import engine.core.isometric.IsoTile;
	import engine.display.DisplayInfo;
	import engine.display.DisplayUnitSelection;
	import engine.core.fm_internal;
	
	use namespace fm_internal;
	
	public class BaseObject
	{
		fm_internal var _x:int;
		fm_internal var _y:int;		
		fm_internal var _z:int;	
		fm_internal var _id:int;	
		fm_internal var _isActive:Boolean = true;
		fm_internal var _isInWorld:Boolean = false;
		fm_internal var _model:AnimatedSprite;
		fm_internal var _displaySelection:DisplayUnitSelection;
		fm_internal var _displayInfo:DisplayInfo;
								
		public function get x():int {
			return _x;
		}
		public function get y():int {
			return _y;
		}
		public function get z():int {
			return _z;
		}
		public function set x(x:int):void {
			this._x = x;
		}
		public function set y(y:int):void {
			this._y = y;
		}
		public function set z(z:int):void {
			this._z = z;
		}
		public function get xL():int{
			return 0;
		}
		public function get yL():int {
			return 0;
		}
		public function get xLength():int {
			return 1;
		}
		public function get yLength():int {
			return 1;
		}
		public function get overTiles():Vector.<Vector.<IsoTile>> {
			return null;
		}
		public function get id():int {
			return _id;
		}
		public function set id(id:int):void {
			_id = id;
		}
		public function get isActive():Boolean {
			return _isActive;
		}
		public function set isActive(isActive:Boolean):void {
			_isActive = isActive;
		}		
		public function get isInWorld():Boolean{
			return _isInWorld;
		}
		public function set isInWorld(value:Boolean):void{
			_isInWorld = value;
		}
		public function get tile():IsoTile {
			return null;
		}
		public function set tile(tile:IsoTile):void {
		}
		public function get model():AnimatedSprite {
			return _model;
		}
		public function setModel(model:AnimatedSprite):void 
		{
			_model = model;
		}
		public function get displaySelection():DisplayUnitSelection{
		 	return _displaySelection;
		}
		public function get displayInfo():DisplayInfo{
		 	return _displayInfo;
		}
	}

}