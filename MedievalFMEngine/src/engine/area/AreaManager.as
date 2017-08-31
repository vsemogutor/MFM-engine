package engine.area
{
	import de.polygonal.ds.HashMap;
	import de.polygonal.ds.HashMapValIterator;
	
	import engine.core.ManagerBase;
	import engine.core.events.EngineEvents;
	import engine.util.Constants;
	
	import flash.events.Event;
	
	public final class AreaManager extends ManagerBase
	{
		private var _areas:HashMap = new HashMap();

		public function get areas():HashMap{
			return _areas;
		}
		
		public function addArea(_area:Area, id:int = 0):int
		{
			if (_areas.hasKey(_area.name))
				return Constants.FALSE;
			
			if (!id)
				_area.id = idManager.nextMapId(_areas);
				
			if (!_area.name)
				_area.name = _area.id.toString();
				
			_areas.set(_area.name, _area);
			dispatchEvent(new Event(EngineEvents.AREA_ADDED));
			return _area.id;
		}
		
		public function getByName(name:String):Area
		{
			return _areas.get(name) as Area;
		}
		
		public function displayAreas(display:Boolean = true):void
		{
			var iter:HashMapValIterator = _areas.iterator() as HashMapValIterator;
			while (iter.hasNext())
			{
			    displayArea(iter.next() as Area, display);
			}
		}
	
		public function displayArea(area:Area, display:Boolean = true):void
		{
			var indx:int = scene.view.highlightRegions.indexOf(area);
	
			if (!display)
			{
				if (indx != -1)
					scene.view.highlightRegions.splice(indx, 1);
			}
			else
			{
				if (indx == -1)
					scene.view.highlightRegions.push(area);
			}
		}

	}
}