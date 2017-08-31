package engine.rightClickSupport
{

/**
 * Using right click js lib
 * Copyright 2007-2009
 * 
 * Paulius Uza
 * http://www.uza.lt
 * 
 * Dan Florio
 * http://www.polygeek.com
 * 
 * Arif Ali Saiyed
 * http://arif-ali-saiyed.blogspot.com/
 * 
 * Project website:
 * http://code.google.com/p/custom-context-menu/
 * 
 * --
 * RightClick for Flash Player. 
 * Version 0.6.2
 */


	import engine.core.events.EngineEvents;
	import engine.game.Game;
	import engine.game.GameState;
	import engine.util.Browser;
	import engine.util.BrowserUtil;
	import engine.util.ExternalUtil;
	
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	
	import mx.controls.Alert;

	public final class RightClickMouseSupport extends EventDispatcher
	{
		[Embed(source="rightClick.js",mimeType="application/octet-stream")]
		private static const _script:Class;
		private static var _instance:RightClickMouseSupport = new RightClickMouseSupport();	
		private var _enabled:Boolean;
		private var _avaliable:Boolean = true;		
		
		public function RightClickMouseSupport(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public static function instance():RightClickMouseSupport
		{ 
			return _instance;
		}
	
		public function enable():void
	    {
	    	if (_enabled || !_avaliable)
	    		return;
	    	
			var browser:String = BrowserUtil.getBrowserName();
	    	if (browser == Browser.Undefined || !ExternalInterface.available)
	    	{
	    		_avaliable = false;
	    		return;
	    	}
	    	
	    	try
	    	{	
				var script:String = new _script().toString().replace("[id]", ExternalInterface.objectID);
		        ExternalUtil.eval(script);
				ExternalInterface.addCallback("rightClick", rightClickCallback);
				_enabled = true;
	    	} 
	    	catch (error:Error) 
	    	{
	    		trace(error);
	    	}
	    }
	    
		public function disable():void
	    {
	        ExternalUtil.invoke("RightClick.UnInit");
	        _enabled = false;
	    }	    
	 
	    private function rightClickCallback(... rest):void
	    {
	    	var game:Game = Game.instance();
	    	if (game && game.currentState == GameState.PLAYING)
	    	{
	    		var stage:Stage = game.systemManager.stage;
				var mx:int = stage.mouseX;
				var my:int = stage.mouseY;
				if(my > 0 && my < stage.stageHeight && mx > 0 && mx < stage.stageWidth) 
				{				
					var event:MouseEvent = new MouseEvent(EngineEvents.RIGHT_CLICK);
					event.localX = mx;
					event.localY = my;
					dispatchEvent(event);
				}
	    	}
	    }	
	}
}