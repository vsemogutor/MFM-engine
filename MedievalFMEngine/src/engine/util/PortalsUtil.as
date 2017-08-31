package engine.util
{
	import flash.net.LocalConnection;
	
	public final class PortalsUtil
	{
		private static var _isInitialized:Boolean = false;
		private static var _isNewgrounds:Boolean = false;
		private static var _isKong:Boolean = false;
						
		private static function init():void
		{
			if (_isInitialized) return;
			_isInitialized = true;
			
			var lc:LocalConnection = new LocalConnection();
			var dom:String = lc.domain.toLowerCase();
		    _isKong = (dom.indexOf("kongregate") != -1);
		    _isNewgrounds = (dom.indexOf("newgrounds") != -1);
		    			
		}
		
		public static function isKongregate():Boolean
		{
			init();
		    return _isKong;
		}

		public static function isNewgrounds():Boolean
		{
			init();
		    return _isNewgrounds;
		}
	}
}