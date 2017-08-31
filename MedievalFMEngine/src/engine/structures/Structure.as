package engine.structures
{
	import __AS3__.vec.Vector;
	
	import engine.core.events.GameEvent;
	import engine.core.events.GameEvents;
	import engine.core.isometric.IsoTile;
	import engine.fraction.Fraction;
	import engine.game.Game;
	import engine.game.GameManager;
	import engine.objects.BaseObject;
	import engine.units.*;
	import engine.units.UnitOrders.UnitOrderTrainUpgrade;
	import engine.util.Constants;
	import engine.util.TileUtil;
	
	import flash.geom.Point;
	import engine.core.fm_internal;
	
	use namespace fm_internal;
		
	public class Structure extends Unit
	{
		fm_internal var _overTiles: Vector.<Vector.<IsoTile>>;
		private var _passablePattern:Array;
		private var _xL:int;
		private var _yL:int;
		private var _xLength:int;
		private var _yLength:int;		
		
		public override function get xLength():int {
			return _xLength;
		}
		public override function get yLength():int {
			return _yLength;
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
		public override function get overTiles():Vector.<Vector.<IsoTile>> {
			return _overTiles;
		}
		public override function isAllowedTarget(target:Unit):Boolean
		{
			return super.isAllowedTarget(target) && 
				TileUtil.getTileDist(target.tile, this.tile) <= properties[UnitProperties.AttackRange];
		}
		
		public function Structure(type:UnitType, fraction:Fraction)
		{
			super(type, fraction);
			_xLength = type.xLength;
			_yLength = type.yLength;
			
			_overTiles = new Vector.<Vector.<IsoTile>>(_xLength);

			
			for (var i:int = 0; i < _overTiles.length; ++i)
			{
				_overTiles[i] = new Vector.<IsoTile>(_yLength);	
			}
		}
		
		public override function move(tile:IsoTile):void
		{
			//structures can't move
		}
		
		public override function wander():void
		{
			//structures can't wander
		}
		
		public override function attackMove(tile:IsoTile):void
		{
			//structures can't move
		}
		
		public override function actionMoveToPoint(dest:Point):void
		{
			// do nothing obviously
		}
		
		public override function trainUpgrade(type:UnitType, maxQueueSize:int=Constants.MAX_TRAIN_QUEUE_SIZE):Boolean
		{
			if (!type.validateCost(fraction))
			{
				if (fraction.isCurrentPlayer())
					GameManager.instance().showWarning("Not enough resources.");
				return false;
			}
				
			var order:UnitOrderTrainUpgrade = _order as UnitOrderTrainUpgrade;
			
			if (order)
			{
				if (order.constructionQueue.length >= maxQueueSize)
					return false;
				order.addToConstruction(type);
			}
			else
			{
				if (!setOrder(new UnitOrderTrainUpgrade(this, type)))
				{
					if (fraction.isCurrentPlayer())
						GameManager.instance().showWarning("Current unit order can't be interrupted.");
					return false;
				}
			}
			return true;
		}

		public function setPassablePattern(pattern:Array):void
		{
			_passablePattern = pattern;
		}
		
		protected override function requestHelp(target:Unit):void
		{
			// structures can't move so no point to call them for help
			return;
		}
		
		public override function getClosestActiveTile(tile:IsoTile):IsoTile
		{
			var minDist:Number = int.MAX_VALUE;
			var minDistTile:IsoTile = _tile;
			var xLen:int = _overTiles.length;			
			for (var i:int = 0; i < xLen; ++i)
			{
				var yLen:int = _overTiles[i].length;
				for (var j:int = 0; j < yLen; ++j)
				{
					var tl:IsoTile = _overTiles[i][j];
					if (!tl.isFreeToBuild)
					{
						var dist:Number = TileUtil.getSqrtTileDist(tl, tile);
						if (dist < minDist)
						{
							minDist = dist;
							minDistTile = tl;
						}
					}
				}
			}
			
			return minDistTile;
		}
	}
}