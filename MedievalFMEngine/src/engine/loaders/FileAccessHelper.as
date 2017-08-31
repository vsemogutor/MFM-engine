package engine.loaders
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.net.URLRequest;
	
	import mx.rpc.IResponder;
	
	public final class FileAccessHelper
	{
		private var responder : IResponder;
		private var pictLdr:Loader= new Loader();	
		public function FileAccessHelper(responder:IResponder)
		{
			this.responder = responder;
		}
		
		public function onPNGImgLoaded(event:Event):void {	
			var pictLoad:Bitmap = Bitmap(pictLdr.content);
			responder.result(pictLoad.bitmapData);
		}
		
		public function loadPNGFile(name:String) : void
		{
		  	pictLdr.contentLoaderInfo.addEventListener(Event.COMPLETE, onPNGImgLoaded);			
		  	pictLdr.load(new URLRequest(name));	
		}
	}
}