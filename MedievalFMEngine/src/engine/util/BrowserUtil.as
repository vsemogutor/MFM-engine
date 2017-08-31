package engine.util
{
	import flash.external.ExternalInterface;
	
	public final class BrowserUtil
	{
		public static function getBrowserName():String
		{
			try
			{
				if (ExternalInterface.available)
				{
					var userAgent:String = ExternalUtil.invoke("function() {return navigator.userAgent}") as String;
					userAgent = userAgent.toLowerCase();
					if (userAgent.indexOf(Browser.Opera.toLowerCase()) != -1)
			    		return Browser.Opera;
			    	else if (userAgent.indexOf(Browser.Chrome.toLowerCase()) != -1)
			    		return Browser.Chrome;
			    	else if (userAgent.indexOf(Browser.Firefox.toLowerCase()) != -1)
			    		return Browser.Firefox;
			    	else if (userAgent.indexOf(Browser.Safari.toLowerCase()) != -1)
			    		return Browser.Safari;
			    	else if (userAgent.indexOf("msie") != -1)
			    		return Browser.IE;
		  		}
	  		} 
	  		catch (error:Error) 
	  		{
	  			trace(error);
	  		}
	    		
	    	return Browser.Undefined;
		}

	}
}