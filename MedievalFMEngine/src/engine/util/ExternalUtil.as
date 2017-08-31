package engine.util
{
	import flash.external.ExternalInterface;
	
	public final class ExternalUtil
	{
		public static function invoke(script:String, param:String=null):Object
		{
			return ExternalInterface.call(script, param);
		}
		
		public static function eval(script:String):Object
		{
			return ExternalInterface.call("eval", script);
		}
	}
}