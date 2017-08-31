package resources
{
	import flash.utils.Dictionary;
	
	import mx.core.ByteArrayAsset;
	
	public final class StringResources
	{
		private static var _isInitialized:Boolean = false;
		
		[Embed(source="../../Localization/LocalizationRU.xml", mimeType="application/octet-stream")]
		private static const _uiXmlClass:Class; 
		private static var _uiXml:XML;
		
		private static var _strings: Dictionary = new Dictionary(); 
		
		private static function init():void
		{
			var ba:ByteArrayAsset = ByteArrayAsset( new _uiXmlClass() );
         	_uiXml = new XML( ba.readUTFBytes(ba.length) );
         	var list:XMLList = _uiXml.children();
			var locString : XML;
				
			for each (locString in list) {
				_strings[locString.name().toString()] = locString.toString();
			}
		}
		
		public static function get(id:String):String
		{
			if (!_isInitialized) {
				init();
				_isInitialized = true;
			}
		
			return _strings[id];
		}
	}
}