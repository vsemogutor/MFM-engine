package engine.localization
{
	import engine.core.fm_internal;
	use namespace fm_internal;
	
	public class LocalizationManager
	{
		private var _loc:Localization;
		private var _locObjects:Vector.<Localizable> = new Vector.<Localizable>();
		
		public function get localization():Localization{
			return _loc;
		}
		
		fm_internal function setLocalization(loc:Localization):void
		{
			_loc = loc;
		}
		
		internal function addForLocalization(localizable:Localizable):void
		{
			_locObjects.push(localizable);
		}
		
		fm_internal function localizeAll():void
		{
			var len:int = _locObjects.length;
			for (var i:int = 0; i < len; ++i)
			{
				_locObjects[i].localizeInternal();
			}
			_locObjects = new Vector.<Localizable>();
		}
	}
}