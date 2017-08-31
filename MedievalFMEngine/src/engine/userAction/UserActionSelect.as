package engine.userAction
{
	import computers.utils.Utils;
	
	import engine.core.isometric.IsoTile;
	import engine.fraction.Fraction;
	import engine.game.Game;
	import engine.game.GameManager;
	import engine.sound.SoundManager;
	import engine.structures.Structure;
	import engine.units.Unit;
	import engine.units.UnitOrders.UnitOrderRepair;
	import engine.units.groups.UnitGroup;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class UserActionSelect extends UserActionBase
	{
		private static const SELECT_UNITS_OF_TYPE_DELAY:int = 12;
				
		private var _posStart:Point;
		private var _posEnd:Point;	
		private var _fraction:Fraction;			
		private var _mouseDown:Boolean;
		private var _area:Rectangle = new Rectangle(0,0,1,1);
		private static var _lastSelectTime:int;
		private static var _lastSelectUnit:Unit;
		
		public function UserActionSelect(playerFraction:Fraction=null)
		{
			if (_fraction) _fraction = playerFraction;
			else _fraction  = Game.instance().fractionManager.player;
		}
		
		internal override function process():Boolean
		{
			if (_done)
			{
				if (_posStart)
				{
					var tiles:* = Game.instance().sceneManager.pickIsoTiles(_area);
					
					var group:UnitGroup = new UnitGroup();
					var selectedUnit:Unit = null;
					
					if (tiles.length == 1)
					{
						selectedUnit = Game.instance().sceneManager.getUnitAtScreenPosition(_area.topLeft);
						
						if (!selectedUnit)
						{
							var tile:IsoTile = tiles[0];
							if (tile.unitFlying && tile.unitFlying.visible) selectedUnit = tile.unitFlying;
							else if (tile.unit && tile.unit.visible) selectedUnit = tile.unit;
						}
					}
					else
					{
						// mass select unit - only for friendly non structures
						// if several player unit selected - do not select structures or enemies
						// else select single friendly structure or enemy
						for (var i:int = 0; i < tiles.length; ++i)
						{
							var tile:IsoTile = tiles[i];
							
							// select any unit in case no player units in zone
							// or select single player structure in zone if present
							if (!selectedUnit && tile.unitFlying) selectedUnit = tile.unitFlying;
							if (!selectedUnit || (selectedUnit.fraction != _fraction && 
								tile.unit && tile.unit.fraction == _fraction)) 
								selectedUnit = tile.unit;

							
							 // select only player units
							if (tile.unitFlying && (!_fraction || tile.unitFlying.fraction == _fraction))
							{
								group.units.push(tile.unitFlying);
							}
													
							if (tile.unit && !(tile.unit is Structure)  // select only player units
								&& (!_fraction || tile.unit.fraction == _fraction) )
							{
								group.units.push(tile.unit);
							}
						}
					}
					
					if (group.length > 0)
					{
						Game.instance().selectionManager.selectUnitGroup(group);
					}
					else if (selectedUnit)
					{
						Game.instance().selectionManager.selectUnit(selectedUnit);
						
						if (checkPositionTrader())
						{
							var trader:Unit = Game.instance().selectionManager.selectedUnit;
							if (trader.type.soundPack.what)
								SoundManager.instance().playSoundOnUnit(trader, trader.type.soundPack.what);
							GameManager.instance().showTradeDialog(null, trader); 
						}			
						//else selectSimilarUnits(selectedUnit);
							
						_lastSelectTime = Game.instance().gameTime.value;
					}
					
					_lastSelectUnit = selectedUnit;
					SoundManager.instance().clickSound();
				}
				cleanup();
			}
			
			return _done;
		}
		
		private function selectSimilarUnits(selectedUnit:Unit):void 
		{
			if (Game.instance().gameTime.value < _lastSelectTime + SELECT_UNITS_OF_TYPE_DELAY) 
			{
				var units:UnitGroup = new UnitGroup();
				if (_lastSelectUnit && _lastSelectUnit == selectedUnit && 
					selectedUnit.fraction == Game.instance().fractionManager.player)
				{
					var tiles:Vector.<IsoTile> = Game.instance().world.tiles;
					for (var i:int = 0; i < tiles.length; ++i)
					{
						var tile:IsoTile = tiles[i];
						if (tile.unit && Game.instance().sceneManager.isUnitVisible(tile.unit) 
							&& tile.unit.fraction == selectedUnit.fraction 
							&& tile.unit.type == _lastSelectUnit.type)
						{
							units.addUnit(tile.unit);
						}
					}
					
					Game.instance().selectionManager.selectUnitGroup(units);
					Game.instance().selectionManager.selectedUnitGroup.selectUnit(selectedUnit);
				}
			}
		}
		
		private function checkIsSmartActionAvaliable(pos:Point):Boolean
		{
			if (!Game.instance().userActionManager.smartEnabled || !pos) return false;
			
			var currentTile:IsoTile = Game.instance().sceneManager.pickIsoTile(pos.x, pos.y);
			var selUnit:Unit = Game.instance().selectionManager.selectedUnit;
			return (currentTile
				&& Utils.getDistance(_posStart, _posEnd) < 18 
				&& selUnit
				&& selUnit.fraction.isCurrentPlayer()
				&& selUnit != currentTile.unit
				&& !(selUnit.order is UnitOrderRepair));
		}
		
		public override function onMouseDown(evt:MouseEvent):void
		{
			_posStart = _posEnd = new Point(evt.localX, evt.localY);
			_area.x = _posStart.x;
			_area.y = _posStart.y;

			_mouseDown = true;
			
			if (Game.instance().userActionManager.currentAction == this && !_done)
			{
				Game.instance().sceneManager.view.selectionRegion = _area;
			}
			else
			{
				cleanup();
				done();
			}
		}
	
		protected override function onMouseMove(evt:MouseEvent):void
		{
			_posEnd = new Point(evt.localX, evt.localY);
			
			if (_mouseDown && _posStart)
			{
				_area.width = Math.abs(_posStart.x - _posEnd.x) + 1;
				_area.height = Math.abs(_posStart.y - _posEnd.y) + 1;				
				_area.x = Math.min(_posStart.x, _posEnd.x);
				_area.y = Math.min(_posStart.y, _posEnd.y);
			}
		}
			
		protected override function onMouseUp(evt:MouseEvent):void
		{
			if (checkIsSmartActionAvaliable(_posStart))
			{
				var smartAction:UserActionBase = new UserActionOrderUnitSmartAction(
					Game.instance().selectionManager.selectedUnitGroup);
				
				Game.instance().userActionManager.setAction(smartAction);
				smartAction.onMouseDown(evt);
			}
			else
			{
				_mouseDown = false;
				done();
				Game.instance().sceneManager.view.selectionRegion = null;
			}
		}
		
		private function checkPositionTrader():Boolean
		{	
			var selUnit:Unit = Game.instance().selectionManager.selectedUnit;		
			return selUnit && selUnit.type.isTrader && Utils.getDistance(_posStart, _posEnd) < 5;
		}		
		
		internal override function cleanup():void
		{
			Game.instance().sceneManager.view.selectionRegion = null;
			super.cleanup();
		}
	}
}