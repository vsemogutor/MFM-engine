package engine.units.support
{
	import engine.units.UnitType;
	
	import flash.events.EventDispatcher;
	
	[Bindable]
	public final class UnitBuildItem
	{
		public var type:UnitType;
		public var enabled:Boolean;
		
		public function UnitBuildItem(type:UnitType, enabled:Boolean)
		{
			this.type = type;
			this.enabled = enabled;
		}
	}
}