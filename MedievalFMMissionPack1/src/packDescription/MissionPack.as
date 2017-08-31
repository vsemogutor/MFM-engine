package packDescription
{
	import __AS3__.vec.Vector;
	
	import arena.Arena;
	
	import engine.mission.IMissionPack;
	import engine.mission.Mission;
	
	public class MissionPack implements IMissionPack
	{
		private var _missions:Vector.<Mission> = new Vector.<Mission>();
		
		public function MissionPack()
		{
			_missions.push(new Arena());			
		}
		
		public function getMissions():Vector.<Mission>
		{			
			return _missions;
		}
		
		public function getNext(mission:Mission):Mission
		{
			if (!mission)
				return null;
			
			var indx:int = _missions.indexOf(mission);
			if (indx != -1 && indx < _missions.length - 1)
			{
				return _missions[indx + 1];
			}
			
			return null;
		}
	}
}