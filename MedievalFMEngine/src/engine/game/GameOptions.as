package engine.game
{
	import engine.core.events.EngineEvents;
	import engine.core.events.GameEvent;
	
	import flash.net.SharedObject;
	
	[Bindable]
	public final class GameOptions
	{
		private var _soundVolume:Number = 0.7;
		private var _musicVolume:Number = 0.5;
		private var _rightClickSupportEnabled:Boolean = true;
		private var _scrollSpeed:int = 24;	
		private var _useSystemCursor:Boolean = false;
		private var _showTutorial:Boolean = true;
		private var _scrollWithWasd:Boolean = true;
		private var _scrollWithMouse:Boolean = true;
										
		public function get soundVolume():Number {
			return _soundVolume;
		}

		public function set soundVolume(value:Number):void {
			GameManager.instance().dispatchEvent(
				new GameEvent(EngineEvents.SOUND_VOLUME_CHANGED, {volume:value}));			
			_soundVolume = value;
			save();	
		}		

		public function get musicVolume():Number {
			return _musicVolume;
		}

		public function set musicVolume(value:Number):void {
			GameManager.instance().dispatchEvent(
				new GameEvent(EngineEvents.MUSIC_VOLUME_CHANGED, {volume:value}));
			_musicVolume = value;
			save();
		}
		
		public function get rightClickSupportEnabled():Boolean {
			return _rightClickSupportEnabled;
		}

		public function set rightClickSupportEnabled(value:Boolean):void {
			_rightClickSupportEnabled = value;
		}
		
		public function get scrollSpeed():int {
			return _scrollSpeed;
		}

		public function set scrollSpeed(value:int):void {
			_scrollSpeed = value;
			save();
		}	
		
		public function get useSystemCursor():Boolean {
			return _useSystemCursor;
		}
		
		public function get showTutorial():Boolean {
			return _showTutorial;
		}

		public function set showTutorial(value:Boolean):void {
			_showTutorial = value;
			save();
		}
		
		public function get scrollWithWasd():Boolean {
			return _scrollWithWasd;
		}				

		public function set scrollWithWasd(value:Boolean):void {
			_scrollWithWasd = value;
			save();
		}	

		public function get scrollWithMouse():Boolean {
			return _scrollWithMouse;
		}				

		public function set scrollWithMouse(value:Boolean):void {
			_scrollWithMouse = value;
			save();
		}
				
		public function set useSystemCursor(value:Boolean):void {
			GameManager.instance().dispatchEvent(
				new GameEvent(EngineEvents.CURSOR_SETTINGS_CHANGED, {useSystem:value}));			
			_useSystemCursor = value;
			save();
		}
		
		public function save():void
		{
			var options:SharedObject = SharedObject.getLocal("mfmoptions");
			options.data.soundVolume = _soundVolume;
			options.data.musicVolume = _musicVolume;			
			options.data.scrollSpeed = _scrollSpeed;
			options.data.useSystemCursor = _useSystemCursor;
			options.data.showTutorial = _showTutorial;	
			options.data.scrollWithWasd = _scrollWithWasd;	
			options.data.scrollWithMouse = _scrollWithMouse;				
		}
		
		public function load():void
		{
			var options:SharedObject = SharedObject.getLocal("mfmoptions");
			if (options.data.soundVolume != null) _soundVolume = options.data.soundVolume;
			if (options.data.musicVolume != null) _musicVolume = options.data.musicVolume;			
			if (options.data.scrollSpeed != null) _scrollSpeed = options.data.scrollSpeed;
			if (options.data.useSystemCursor != null) _useSystemCursor = options.data.useSystemCursor;
			if (options.data.showTutorial != null) _showTutorial = options.data.showTutorial;
			if (options.data.scrollWithWasd != null) _scrollWithWasd = options.data.scrollWithWasd;	
			if (options.data.scrollWithMouse != null) _scrollWithMouse = options.data.scrollWithMouse;										
		}							
	}
}