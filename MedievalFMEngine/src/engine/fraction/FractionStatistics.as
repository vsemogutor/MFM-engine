package engine.fraction
{
	import __AS3__.vec.Vector;
	
	public class FractionStatistics
	{
		private var _resourcesTotal:Vector.<int> = new Vector.<int>(ResourceType.Count);
		public var unitsKilled:int = 0;
		public var buildingsDestroyed:int = 0;
		public var unitsLost:int = 0;
		public var buildingsLost:int = 0;
		public var unitsTrained:int = 0;	
		public var buildingsConstructed:int = 0;	
		
		public function getResourceTotal(type:int):int
		{
			return _resourcesTotal[type];
		}
		
		public function setResourceTotal(type:int, value:int):void
		{
			if (_resourcesTotal[type] < value)
				_resourcesTotal[type] = value;
		}	

		public function addResourceTotal(type:int, value:int):void
		{
			if (value)
				setResourceTotal(type, _resourcesTotal[type] + value);
		}	
		
		public function copyTo(other:FractionStatistics):FractionStatistics
		{
			other._resourcesTotal = this._resourcesTotal.concat();
			other.unitsLost = this.unitsLost;
			other.buildingsLost = this.buildingsLost;					
			other.unitsKilled = this.unitsKilled;	
			other.buildingsDestroyed = this.buildingsDestroyed;		
			other.unitsTrained = this.unitsTrained;
			other.buildingsConstructed = this.buildingsConstructed;	
			
			return other;			
		}
	}
}