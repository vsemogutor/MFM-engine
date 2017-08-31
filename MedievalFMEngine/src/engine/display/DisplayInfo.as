package engine.display
{
	import engine.core.isometric.IsoTile;
	import engine.objects.BaseObject;
	import engine.core.fm_internal;
	
	use namespace fm_internal;	
		
	public final class DisplayInfo
	{
		fm_internal var object:BaseObject;	
		fm_internal var tile:IsoTile;	
		
		public function DisplayInfo(object:BaseObject)
		{
			this.object = object;
		}
		
		fm_internal function reset():void
		{
			tile = null;
		}
	}
}