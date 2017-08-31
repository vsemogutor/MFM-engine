package engine.selection
{
	import engine.core.ManagerBase;
	import engine.core.events.EngineEvents;
	import engine.core.events.GameEvent;
	import engine.game.Game;
	import engine.units.Unit;
	import engine.units.groups.UnitGroup;
	
	public final class SelectionManager extends ManagerBase
	{
		private var _selectedUnitGroup:UnitGroup = new UnitGroup();
		
		public function get selectedUnit():Unit {
			return _selectedUnitGroup.selectedUnit;
		}
	
		public function get selectedUnitGroup():UnitGroup {
			return _selectedUnitGroup;
		}
		
		public function SelectionManager()
		{
			super();
			game.groupManager.watch(_selectedUnitGroup, false);
		}
		
		public function selectUnit(unit:Unit):void
		{
			clearSelection();
			if (unit && unit.isActive)
				_selectedUnitGroup.units.push(unit);
			dispatchEvent(new GameEvent(EngineEvents.UNIT_SELECTED, {units:_selectedUnitGroup.units, unit:selectedUnit}));
		}
		
		public function selectUnitInGroup(unit:Unit):void
		{
			_selectedUnitGroup.selectUnit(unit);
			dispatchEvent(new GameEvent(EngineEvents.UNIT_SELECTED, {units:_selectedUnitGroup.units, unit:selectedUnit}));
		}
	
		public function selectUnitGroup(group:UnitGroup):void
		{
			if (group != _selectedUnitGroup)
			{
				clearSelection();
				_selectedUnitGroup.copy(group, UnitGroup.MAX_UI_GROUP_SIZE);
			}
				
			dispatchEvent(new GameEvent(EngineEvents.UNIT_SELECTED, {units:_selectedUnitGroup.units, unit:selectedUnit}));
		}	
		
		public function clearSelection():void
		{
			_selectedUnitGroup.clear();
		}
		
		public function isSomethingSelected():Boolean
		{
			return _selectedUnitGroup.length > 0;
		}
		
		public function process():void
		{

		}
	}
}