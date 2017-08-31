package engine.units
{
	import __AS3__.vec.Vector;
	
	import computers.utils.Utils;
	
	import engine.animation.*;
	import engine.core.IdManager;
	import engine.core.fm_internal;
	import engine.core.isometric.IsoTile;
	import engine.fraction.Fraction;
	import engine.fraction.FractionControllerType;
	import engine.game.Game;
	import engine.game.GameManager;
	import engine.items.InventoryItem;
	import engine.objects.*;
	import engine.spells.*;
	import engine.units.UnitOrders.*;
	import engine.units.support.UnitBuildItem;
	import engine.units.support.UnitSpellItem;
	
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	
	use namespace fm_internal;
		
	public class UnitBase extends BaseObject
	{
		fm_internal var _target:Unit;
		public var properties:Vector.<int>;
		public var baseProperties:Vector.<int>;
		protected var _spellEffects:Vector.<SpellEffectBase> = new Vector.<SpellEffectBase>();
		fm_internal var _direction:int;
		public var path: Vector.<IsoTile> = new Vector.<IsoTile>();
		protected var _order: UnitOrderBase;
		public var state:int;
		fm_internal var _tile:IsoTile;
		public var pathDemanded:Boolean;
		public var lastActionTime:int;
		public var lastMoveTime:int;	
		public var lastCastTime:int = int.MIN_VALUE;
		public var lastCallForHelpTime:int;	
		public var fraction:Fraction;
		protected var _type:UnitType;
		public var linkedTo:Unit;
		public var linkedUnits:ArrayCollection = new ArrayCollection();	
		protected var _activeSpell:SpellType;
		public var auraSpell:SpellType;		
		public var summoner:Unit;
		public var summonLifeTime:int;
		public var summons:Vector.<Unit> = new Vector.<Unit>();
		public var lastHitBy:Unit;
		public var lastCastSpell:SpellType;
		public var lastHitDamageType:int;	
		public var lastHitTime:int = int.MIN_VALUE;		
		protected var _name:String;
		protected var _items:Vector.<InventoryItem> = new Vector.<InventoryItem>();
		protected var _stockItems:Vector.<InventoryItem> = new Vector.<InventoryItem>();
		fm_internal var _spellsLastCastTime:Dictionary = new Dictionary();	
		public var attackRatingRand:int = 30;				
		public var visible:Boolean = true;
				
		// Properties ----------------------------------------
		public override function get tile():IsoTile {
			return _tile;
		}
		public override function set tile(tile:IsoTile):void {
			_tile = tile;
		}
				
		public function get direction():int {
			return _direction;
		}
		public function set direction(dir:int):void {
			this._direction = dir;
		}
		public function get order():UnitOrderBase {
			return _order;
		}		

		public function get activeSpell():SpellType {
			return _activeSpell;
		}
				
		public function get center():Point {
			var shift:int = (_model.frameHeight>>1) + _z;
			return new Point(_x - shift, _y - shift);
		}	
		public function set center(pos:Point):void {
			var shift:int = _model.frameHeight>>1;
			_x = pos.x + shift;
			_y = pos.y + shift;
		}
	
		public function get physicalCenter():Point {
			// 5/8 or 62.5 % height
			var shift:int = ((_model.frameHeight/3)<<1) + _z + 8;
			return new Point(_x - shift, _y - shift);
		}
			
		public function get position():Point {
			return new Point(_x, _y);
		}
		public function set position(pos:Point):void {
			_x = pos.x;
			_y = pos.y;
		}	
		
		public function get type():UnitType{
			return _type;
		}
		
		public function get spellEffects():Vector.<SpellEffectBase> {
			return _spellEffects;
		}

		public function get isReady():Boolean{
			return state != UnitState.UnderConstruction;
		}
		
		public function get isAIControlled():Boolean {
			return fraction.controllerType == FractionControllerType.Computer;	
		}

		public function get name():String{
		 	return _name;
		}

		public function set name(value:String):void{
		 	_name = value;
		 	if (_name)
		 		_id = IdManager.idByName(_name);
		 	else
		 		_id = Game.instance().idManager.nextId();
		}
		
		public function get items():Vector.<InventoryItem>{
			return _items;
		}	

		public function get stockItems():Vector.<InventoryItem>{
			return _stockItems;
		}
				
		fm_internal function setOrder(value:UnitOrderBase):Boolean {
			if (!_order || _order.canInterrupt)
			{
				_order = value;
				return true;
			}
			
			GameManager.instance().showWarning("Can't interrupt current order.");
			return false;
		}
		
		public function setActiveSpell(spellType:SpellType):void
		{
			if (!spellType || (_type.hasSpell(spellType) && spellType.autocastType))
				_activeSpell = spellType;
		}
		
		public function fromPhysicalCenterToCenter(pc:Point):Point
		{
			var pcshift:int = ((_model.frameHeight/3)<<1) + 8 - (_model.frameHeight>>1);
			return new Point(pc.x - pcshift, pc.y - pcshift);
		}
		
		public function turnToTile(tile:IsoTile):void
		{
			if (tile != this.tile)
				_direction = Utils.getDir(this.center, tile.center);
		}
		
		public function turnToUnit(unit:Unit):void
		{
			_direction = Utils.getDir(this.center, unit.center);
		}
			
		public function getSpellList():Vector.<UnitSpellItem>
		{
			var list:Vector.<UnitSpellItem> = new Vector.<UnitSpellItem>();
			var len:int = _type.spellList.length;
			for (var i:int = 0; i < len; ++i)
			{	
				var spType:SpellType = _type.spellList[i];
				if (spType.checkDependencies(this.fraction))
				{
					list.push( new UnitSpellItem(spType, spType.validateCost(Unit(this)), spType == activeSpell));
				}
			}
			
			return list;
		}
		
		public function getBuildList():Vector.<UnitBuildItem>
		{
			var list:Vector.<UnitBuildItem> = new Vector.<UnitBuildItem>();
			var len:int = _type.buildList.length;
			for (var i:int = 0; i < len; ++i)
			{
				var uType:UnitType = _type.buildList[i];
				if (uType.checkDependencies(fraction))
				{
					list.push( new UnitBuildItem(uType, uType.validateCost(fraction)));
				}
			}
			
			return list;
		}
		
		public function getClosestActiveTile(tile:IsoTile):IsoTile
		{
			return _tile;
		}
		
		public function setProp(propId:int, value:int):void
		{
			properties[propId] = value;
				
			if (properties[propId] < 0)
				properties[propId] = 0;
				
			setBaseProp(propId, properties[propId]);
		}
		
		public function changeProp(propId:int, value:int, maxVal:int = -1):void
		{
			properties[propId] += value;
				
			if (properties[propId] < 0)
				properties[propId] = 0;
				
			if (maxVal != -1 && properties[propId] > maxVal)
			{
				properties[propId] = maxVal;
			}
			
			setBaseProp(propId, properties[propId]);
		}
		
		private function setBaseProp(propId:int, value:int):void
		{
			if (propId == UnitProperties.Health || propId == UnitProperties.Mana)
			{
				baseProperties[propId] = value;
			}
		}
		
		public function setType(type:UnitType):void
		{
			if (_type != type)
			{
				fraction.detachUnit(this as Unit);
				Unit(this).stand();
				
				_type = type;
				_model = type.model.clone();
				_activeSpell = type.activeSpell;
				
				var len:int = properties.length;
				for (var i:int = 0; i < len; ++i)
				{
					if (i == UnitProperties.Health || i == UnitProperties.Mana)
					{
						// max type health - (base unit health - unit health)
						setProp(i, type.properties[i + 1] - (baseProperties[i] - properties[i]));
					}
					else
					{
						properties[i] = type.properties[i];
						baseProperties[i] = type.properties[i];
					}
				}
				
				fraction.attachUnit(this as Unit);
			}
		}
		
		protected function setSpellLastCastTime(spell:SpellType, time:int):void
		{
			_spellsLastCastTime[spell.id] = time;
		}
		
		protected function getSpellLastCastTime(spell:SpellType):int
		{
			return int(_spellsLastCastTime[spell.id] || -10000);			
		}		
	}
}