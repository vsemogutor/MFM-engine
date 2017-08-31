package engine.util
{
	import flash.net.LocalConnection;
	
	public final class SiteLockUtil
	{
		private static const Domains:Array = [];
		
		public static function check():Boolean
		{
			return isDomainAllowed(Domains);
		}
		
		public static function getAllowed():Array
		{
			return Domains;
		}
		
		private static function isDomainAllowed( allowed:Array ):Boolean
		{
			if (!allowed || !allowed.length)
				return true;
				
		    var lc:LocalConnection = new LocalConnection();
		    var dom:String = lc.domain;
		
		    for( var i:int = 0; i < allowed.length; ++i )
		    {
		    	if (!allowed[i])
		    		return false;
		    		
		        if( dom.toLowerCase() == allowed[i].toString().toLowerCase() )
		        {
		            return true;
		        }
		    }
		   
		    for( var i:int = 0; i < allowed.length; ++i )
		    {		    		
		    	var regex:RegExp = new RegExp("^(http://)?(www.)?" + allowed[i] + "\\..*", "ig");
		    			    
		        if (dom.match(allowed))
		        {
		            return true;
		        }
		    }
		    return false;
		}
	}
}