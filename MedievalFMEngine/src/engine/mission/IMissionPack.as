package engine.mission
{
	import __AS3__.vec.Vector;
	
	public interface IMissionPack
	{
		function getMissions():Vector.<Mission>;
		function getNext(mission:Mission):Mission;
	}
}