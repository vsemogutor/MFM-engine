package engine.core
{
	import de.polygonal.ds.HashMap;
	
	public class IdManager
	{
		public static const SYSTEM_IDS_MAX:int = 700;	
		public static const IDS_INC:int = 100;
				
		private var _currId:int = SYSTEM_IDS_MAX;
		
		public function nextId():int
		{
			return _currId++;
		}
		
		public function idByName(name:String):int
		{
			return IdManager.idByName(name);
		}
		
		public static function idByName(name:String):int
		{
			if (!name)
				throw new ArgumentError("Name is null");
			
			var id:int = name.length;
			for (var i:int = 0; i < name.length; ++i)
			{
				id += name.charCodeAt(i)*i ^ name.charCodeAt(i) ^ name.charCodeAt(i) << i;
			}
			
			return id;
		}

		public function nextMapId(map:HashMap):int
		{
			_currId = nextId();
			while (map.hasKey(_currId))
			{
				nextId();
			}
			return _currId;
		}
		
		public function setSeed(seed:int):void
		{
			if (_currId < seed)
				_currId = seed;
		}
		
		public function incSeed(inc:int=IDS_INC):void
		{
			_currId += inc;
		}
	}
}