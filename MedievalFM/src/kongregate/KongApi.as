package kongregate
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.Security;
			
	public class KongApi extends Sprite
	{
		// Kongregate API reference
		private static var _kongregate:*;
		private static var _api:KongApi = new KongApi();
		
				
		public static function get services():Object {
			return _kongregate.services;
		}

		public static function get stats():Object {
			return _kongregate.stats;
		}
		
		public static function get users():Object {
			return _kongregate.users;
		}
		
		public static function get scores():Object {
			return _kongregate.scores;
		}
		
		public static function get instance():KongApi {
			return _api;
		}		
									
		public function init(root:DisplayObject, initComplete:Function):void
		{
			// Pull the API path from the FlashVars
			var paramObj:Object = LoaderInfo(root.loaderInfo).parameters;
			
			// The API path. The "shadow" API will load if testing locally. 
			var apiPath:String = paramObj.kongregate_api_path || 
			  "http://www.kongregate.com/flash/API_AS3_Local.swf";
			
			// Allow the API access to this SWF
			Security.allowDomain(apiPath);

			// This function is called when loading is complete
			function loadComplete(event:Event):void
			{
			    // Save Kongregate API reference
			    _kongregate = event.target.content;
			
			    // Connect to the back-end
			    _kongregate.services.connect();
				
				if (initComplete != null) initComplete();
			}
					
			// Load the API
			var request:URLRequest = new URLRequest(apiPath);
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete);
			loader.load(request);	
			addChild(loader);
		}		
	}
}