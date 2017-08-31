package engine.units.groups
{
	import __AS3__.vec.Vector;
	
	import computers.utils.Utils;
	
	import engine.core.isometric.IsoTile;
	import engine.core.isometric.IsoWorld;
	import engine.fraction.Fraction;
	import engine.game.Game;
	import engine.objects.BaseObject;
	import engine.spells.SpellType;
	import engine.units.Unit;
	import engine.units.UnitOrders.UnitOrderStand;
	import engine.util.TileUtil;
	
	import flash.geom.Rectangle;
	
	public final class UnitGroup
	{
		public static const MAX_GROUP_SIZE:int = 50;
		public static const MAX_UI_GROUP_SIZE:int = 16;
		
		private var _units:Vector.<Unit> = new Vector.<Unit>();
		private var _id:int;
		private var _isWatched:Boolean;
		internal var removeIfEmpty:Boolean;
		private var _selectedUnit:Unit;
		
		public function get units():Vector.<Unit> {
			return _units;
		}
		
		public function get selectedUnit():Unit {;
			return _selectedUnit || getUnit(0);
		}
		
		public function get isWatched():Boolean {
			return _isWatched;
		}
		
		public function set isWatched(value:Boolean):void {
			_isWatched = value;
		}
		
		public function isEmpty():Boolean {
			return _units.length == 0;
		}
		
		public function get length():int {
			return _units.length;
		}
		
		public function get fraction():Fraction {
			return _units.length > 0 ? _units[0].fraction : null;
		}
		
		public function get isStanding():Boolean
		{
			var len:int = _units.length;
			for (var i:int = 0; i < len; ++i)
			{
				if ( !(_units[i].order is UnitOrderStand) )
					return false;
			}
			
			return true;
		}
			
		public function UnitGroup(id:int = -1)
		{
			if (id >= 0)
				_id = id;
			else
				_id = Game.instance().idManager.nextId();
		}
		
		public function getUnit(indx:int):Unit 
		{
			if (indx < _units.length)
				return _units[indx];
			else	
				return null;
		}
		
		public function selectUnit(unit:Unit):void
		{
			if (contains(unit) && unit.isActive)
				_selectedUnit = unit;
		}
		
		public function removeUnit(unit:Unit):void
		{
			var indx:int = _units.indexOf(unit);
			
			if (indx != -1)
				_units.splice(indx, 1);
		}	
		
		public function addUnit(unit:Unit):void
		{
			if (!contains(unit))
				_units.push(unit);
		}
		
		public function addUnits(units:Vector.<Unit>):void
		{
			var len:int = units.length;
			for (var i:int = 0; i < len; ++i)
			{
				var unit:Unit = units[i];
				if (unit && unit.isInWorld && !contains(unit))
					_units.push(unit);
			}
		}			
		
		public function clear():void
		{
			_units.splice(0, _units.length);
			_selectedUnit = null;
		}
		
		public function copy(group:UnitGroup, max:int = MAX_GROUP_SIZE):void
		{
			if (group == this)
				return;
				
			clear();
			var len:int = Math.min(group._units.length, max);
			for (var i:int = 0; i < len; ++i)
			{
				_units.push(group._units[i]);
			}
		}
		
		public function contains(unit:BaseObject):Boolean
		{
			return _units.indexOf(unit) != -1;
		}
		
		public static function fromArea(area:Rectangle, fraction:Fraction = null):UnitGroup
		{
			var group:UnitGroup = new UnitGroup();
			var world:IsoWorld = Game.instance().world;
			var boundary:Rectangle = world.boundary.intersection(area);
			for (var i:int = boundary.left; i < boundary.right; ++i)
			{
				for (var j:int = boundary.top; j < boundary.bottom; ++j)
				{
					var tile:IsoTile = world.getTileUnsafe(i, j);
					if (tile.unit && (!fraction || tile.unit.fraction == fraction))
						group._units.push(tile.unit);
				}
			}
			
			return group;
		}
		
		public function orderAttackMove(pos:*):void
		{
			orderMoveInternal(pos, true);
		}
	
		public function orderMove(pos:*):void
		{
			orderMoveInternal(pos, false);
		}
				
		private function orderMoveInternal(pos:*, attack:Boolean = false):void
		{
			if (!_units.length) return;
		
			var tile:IsoTile;
			if (pos is IsoTile)
				tile = pos;
			else
				tile = Game.instance().world.getTile(pos.x, pos.y);
			
			if (!tile) return;
					
			var units:Vector.<Unit> = _units.concat();					
			sortUnitsByDist(units, tile);
			
			var width:int = Math.sqrt.apply(null, [units.length]);
			var x:int = tile.xindex;
			var y:int = tile.yindex;
		
			// this voodoo mojo here is to force units keeping formation while moving
			var firstUnit:Unit = units[0];
			var nx:int = x, ny:int = y;
			var dx:int = firstUnit.tile.xindex - x;
			if (dx) nx = x - Utils.copySign(width>>1,dx);
			var dy:int = firstUnit.tile.yindex - y;
			if (dy) ny = y - Utils.copySign(width>>1, dy);		
			
			var world:IsoWorld = Game.instance().world;
			var uLen:int = units.length;
			for (var i:int = 0; i < uLen; ++i)
			{
				var unit:Unit = units[i];
								
				if (!unit.type.canMove()) continue;
					
				var _x:int = firstUnit.tile.xindex - unit.tile.xindex;
				if ( Math.abs(_x) > width - 1) _x = Utils.copySign(Math.abs(nx-x), _x);
				var _y:int = firstUnit.tile.yindex - unit.tile.yindex;
				if ( Math.abs(_y) > width - 1) _y = Utils.copySign(Math.abs(ny-y), _y);
					
				var targetTile:IsoTile = world.getTile(nx - _x, ny - _y);
				if (attack)
					unit.attackMove(targetTile ? targetTile : tile);
				else
					unit.move(targetTile ? targetTile : tile);
			}
		}
			
		public function orderAttack(unit:Unit):void
		{
			if (isEmpty()) return;
					
			sortUnitsByDist(_units, unit.tile);
			var len:int = _units.length;
			for (var i:int = 0; i < len; ++i)
				_units[i].attack(unit);
		}
	
		public function orderCastSpell(target:*, spellType:SpellType):void
		{	
			var len:int = _units.length;
			for (var i:int = 0; i < len; ++i)
			{
				_units[i].castSpell(target, spellType);
			}
		}
			
		public function orderRepair(unit:Unit):void
		{
			if (isEmpty()) return;
			
			sortUnitsByDist(_units, unit.tile);		
			for (var i:int = 0; i < _units.length; ++i)
			{
				_units[i].repair(unit);
			}
		}
		
		public function orderStand():void
		{
			var len:int = _units.length;
			for (var i:int = 0; i < len; ++i)
				_units[i].stand();
		}
		
		private function sortUnitsByDist(units:Vector.<Unit>, dest:IsoTile):void
		{
			// flying and unmovable units screw up formations, so push them to the back
			function sort(u1:Unit, u2:Unit):Number {
				var dist1:int = TileUtil.getTileDist(u1.tile, dest) * 10 
					+ TileUtil.getFullTileDist(u1.tile, dest) + (u1.type.isFlying ? 100 : 0) + (!u1.type.canMove() ? 1000 : 0);
				var dist2:int = TileUtil.getTileDist(u2.tile, dest) * 10 
					+ TileUtil.getFullTileDist(u2.tile, dest) + (u2.type.isFlying ? 100 : 0) + (!u2.type.canMove() ? 1000 : 0);
				if (dist1 > dist2)
					return 1;
				else if (dist1 < dist2)
					return -1;
				else return 0;
			}

			units.sort(sort);
		}
	}
}