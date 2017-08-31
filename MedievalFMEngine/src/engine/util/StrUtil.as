package engine.util
{
	public final class StrUtil
	{
		public static function startsWith(string:String, pattern:String):Boolean
		{
			if (!string)
				return false;
				
			string  = string.toLowerCase();
			pattern = pattern.toLowerCase();
		
			return pattern == string.substr( 0, pattern.length );
		}
		
		public static function endsWith(string:String, pattern:String):Boolean
		{
			if (!string)
				return false;
				
			string  = string.toLowerCase();
			pattern = pattern.toLowerCase();
		
			return string.indexOf(pattern) == string.length - pattern.length;
		}
		
		public static function replace(pattern:String, repl:String, source:String):String
		{
			var regex:RegExp = new RegExp(pattern, "ig");
			return source.replace(regex, repl);
		}
	}
}