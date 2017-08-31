package engine.units.UnitOrders
{
	import engine.core.fm_internal;
	import engine.core.isometric.IsoTile;
	import engine.game.Game;
	import engine.heros.Hero;
	import engine.objects.BaseObject;
	import engine.units.Unit;
	import engine.util.Constants;
	import engine.util.TileUtil;
	
	import flash.events.EventDispatcher;
	
	use namespace fm_internal;
		
	public class UnitOrderBase extends EventDispatcher
	{
		public static var CurrentPriority:int = Constants.UNDEFINED;
		
		public static const IN_PROGRESS:int = 0;	
		public static const COMPLETE:int = 1;	
		public static const ABORTED:int = 2;	

		protected var _parentOrder:UnitOrderBase;					
		protected var _unit:Unit;
		protected var _target:BaseObject;
		protected var _targetTile:IsoTile;
		protected var _priority:int;
		protected var _completed:Boolean;
						
		public function UnitOrderBase(unit:Unit, targetTile:IsoTile, hasPriority:Boolean=false)
		{
			this._unit = unit;
			this._targetTile = targetTile;
			
			if (unit.order && unit.order.targetTile != _targetTile)
				unit.path.length = 0;		
			if (hasPriority)
				_priority = ++CurrentPriority;
		}

		public function get unit():Unit{
			return _unit;
		}
		
		public function get target():BaseObject{
			return _target;
		}
		
		public function set target(target:BaseObject):void{
			_target = target;
		}
		
		public function set completed(value:Boolean):void{
			_completed = value;
		}
		
		public function get completed():Boolean {
			return _completed;
		}				
		
		public function get targetTile():IsoTile{
			return _targetTile;
		}
		
		public function set targetTile(targetTile:IsoTile):void{
			_targetTile = targetTile;
		}
		
		public function getTarget():*
		{
			return _target || _targetTile;
		}	

		public function get priority():int {
			return _priority;
		}	

		public function get canInterrupt():Boolean {
			return true;
		}
							
		public function execute():int 
		{
			return COMPLETE;
		}
		
		protected function executeOtherFirst(order:UnitOrderBase):void
		{
			order._parentOrder = this;
			unit.setOrder(order);
		}
		
		public function nextOrder():void
		{
			if (unit.order != this)
				return;
			if (!_parentOrder)
				unit.stand();
			else
				unit.setOrder(_parentOrder);
		}
		
		protected function setTargetTileAndResetPath(tile:IsoTile, distToTarget:int):void
		{
			if (_targetTile != tile)
			{
				var pLength:int = unit.path.length;
				if (pLength)
				{
					var dDist:int = TileUtil.getTileDist(unit.path[pLength - 1], tile);
					if (distToTarget < 4 || dDist > 2)
					{
						unit.path.length = 0;
					}
					if (distToTarget < 3 || dDist > 1)
					{
						Game.instance().unitManager.unitDemandPath(unit, unit is Hero);
					}
				}	
											
				_targetTile = tile;
			}			
		}	
	}
}