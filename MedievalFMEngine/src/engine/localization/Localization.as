package engine.localization
{
	import flash.utils.Dictionary;
	
	import mx.core.ByteArrayAsset;
	import mx.utils.StringUtil;
	
	public class Localization
	{
		private var _xml:XML;
		private var _strings: Dictionary = new Dictionary(); 
		
		public function Localization(xml:XML)
		{
			load(xml);
		}
		
		private function load(xml:XML):void
		{
			XML.ignoreWhitespace = false;
			
         	_xml = xml;
         	var list:XMLList = xml.children();
			var locString : XML;
				
			for each (locString in list) 
			{
				if (locString && locString.name()) 
					_strings[locString.name().toString()] = locString.toString();
			}
			
			XML.ignoreWhitespace = true;
		}
		
		public function get(id:String):String
		{
			var res:String = _strings[id];
			if (res == null)
				//throw new Error("loc with id:" + id + " is missing");
				return "";
				
			return res;
		}
		
		public function getFormat(id:String, ...rest):String
		{
			return StringUtil.substitute(get(id), rest);
		}	
	}
}