package engine.userAction
{
	import engine.game.Game;
	import engine.game.GameManager;
	import engine.heros.Hero;
	import engine.sound.SoundManager;
	import engine.structures.Structure;
	import engine.units.Unit;
	import engine.units.UnitProperties;
	import engine.units.groups.UnitGroup;
	import engine.util.TileUtil;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class UserActionOrderUnitSmartAction extends UserActionOrderUnitGroup
	{
		private var _selectedUnit:Unit;
		
		public function UserActionOrderUnitSmartAction(group:UnitGroup)
		{
			super(group);
			_needsSelection = true;
		}
		
		public override function onMouseDown(evt:MouseEvent):void
		{
			if (!_done)
			{
				if (!_group.isEmpty())
				{
					SoundManager.instance().clickSound();
										
					_currentTile = Game.instance().sceneManager.pickIsoTile(evt.localX, evt.localY);
					if (_currentTile)
					{
						_selectedUnit = Game.instance().sceneManager.getUnitAtScreenPosition(new Point(evt.localX, evt.localY)) || _currentTile.unit;
						
						if (checkPositionEnemy(evt.localX, evt.localY))
						{
							_selectedUnit.displaySelection.setActive(0xFF0000);
							_group.orderAttack(_selectedUnit);
						}
						else if (checkRepairablePosition(evt.localX, evt.localY))
						{
							_group.orderRepair(_selectedUnit);
						}
						else if (checkPositionTrader(evt.localX, evt.localY))
						{
							if (_selectedUnit.type.soundPack.what)
								SoundManager.instance().playSoundOnUnit(_selectedUnit, _selectedUnit.type.soundPack.what);
							GameManager.instance().showTradeDialog(_group.selectedUnit as Hero, _selectedUnit); 
						}
						else if (checkPosition(evt.localX, evt.localY) && !(_group.selectedUnit is Structure))
						{
							_group.orderMove(_currentTile);
							Game.instance().sceneManager.placeLandMark(evt.localX, evt.localY);
						}
						else
						{
							if (_selectedUnit)
								Game.instance().selectionManager.selectUnit(_selectedUnit);
						}
					}
				}
				
				done();
			}
		}
		
		private function checkPositionEnemy(x:int, y:int):Boolean
		{
			return _selectedUnit 
				&& _selectedUnit.visible
				&&  _group.selectedUnit.isAllowedEnemyTarget(_selectedUnit);
		}
		
		private function checkRepairablePosition(x:int, y:int):Boolean
		{
			return _group.selectedUnit.type.canRepair &&
				 _currentTile.unit is Structure && _group.selectedUnit.isAllowedAllyTarget(_currentTile.unit)
				 && _currentTile.unit.properties[UnitProperties.Health] < _currentTile.unit.properties[UnitProperties.MaxHealth];
				
		}
		
		private function checkPosition(x:int, y:int):Boolean
		{
			return _currentTile != null;
		}
		
		private function checkPositionTrader(x:int, y:int):Boolean
		{			
			if (_group.selectedUnit is Hero 
				&& _selectedUnit 
				&& !_group.selectedUnit.fraction.isEnemyOf(_selectedUnit.fraction)
				&& _selectedUnit.type.isTrader)
			{
				if (TileUtil.getTileDist(_currentTile, _group.selectedUnit.tile) > 3)
				{
					_group.selectedUnit.move(_selectedUnit.tile);
					_selectedUnit.displaySelection.setActive(0xF7D60D);
						
					GameManager.instance().showWarning("Move your Hero closer to the merchant to trade.");
				}
				return true;
			}
			
			return false;
		}
	}
}