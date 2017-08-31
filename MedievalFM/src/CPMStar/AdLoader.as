package CPMStar {
	public class AdLoader {
		import flash.display.*;
		import flash.net.*;
		import flash.system.*;
		
		private static var cpmstarLoader:Loader;
		public static function LoadAd():DisplayObject {
			Security.allowDomain("server.cpmstar.com");	
			Security.allowDomain("cdn1.cpmstar.com");	
			Security.allowDomain("cdn2.cpmstar.com");
			Security.allowDomain("cdn3.cpmstar.com");											
			var cpmstarViewSWFUrl:String = "http://server.cpmstar.com/adviewas3.swf";
			cpmstarLoader = new Loader();
			cpmstarLoader.load(new URLRequest(cpmstarViewSWFUrl + "?poolid=****"));
			return cpmstarLoader;
		}
	}
}
