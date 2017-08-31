package engine.units.groups
{
	import __AS3__.vec.Vector;
	
	import flash.events.EventDispatcher;
	
	public final class UnitGroupManager extends EventDispatcher
	{
		private var _groups:Vector.<UnitGroup> = new Vector.<UnitGroup>();
		public function UnitGroupManager()
		{
			for (var i:int = BuildInGroups.FastGroup1; i < BuildInGroups.Count; ++i)
			{
				watch(new UnitGroup(i), false);
			}
		}
		
		public function watch(group:UnitGroup, removeIfEmpty:Boolean = true):void
		{
			if (!group.isWatched)
			{
				_groups.push(group);
				group.isWatched = true;
				group.removeIfEmpty = removeIfEmpty;
			}
		}
		
		public function processGroups():void
		{
			for (var i:int = 0; i < _groups.length; ++i)
			{	
				var group:UnitGroup = _groups[i];
				
				for (var j:int = 0; j < group.units.length; ++j)
				{
					if (!group.units[j].isActive)
						group.removeUnit(group.units[j]);
				}
				
				if (group.isEmpty() && group.removeIfEmpty)
				{
					_groups[i].isWatched = false;
					_groups.splice(i, 1);
				}
			}
		}
	}
}