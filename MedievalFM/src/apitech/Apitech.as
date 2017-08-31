package apitech
{
	import flash.display.MovieClip;
	import flash.net.LocalConnection;
	import flash.text.TextField;
	
	import mx.controls.Button;
	
	public class Apitech extends Object 
	{
		
		static private var _instance:Object;
		
		public function Apitech() {
			_instance = this;
		}
		
		private static function get instance():Object {
			if (!_instance) {
				return new Apitech();
			}
			return _instance;
		}
		
		private var inited:Boolean = false;
		
		private var conn:LocalConnection;
		private var sendConnName:String;
		private var recvConnName:String;
		
		static private var CONNECTION_PREFIX:String = '_apitech_';
		static private var CONNECTION_EXCLUDE:Array = [':', '/', '\\', '.'];
		static private var SEND_CONN_POSTFIX:String = '_avm2';
		static private var RECV_CONN_POSTFIX:String = '_avm1';
		
		private function getConnectionName(game:Object):String {
			var url:String = game.url;
			for (var i:Number = 0; i < CONNECTION_EXCLUDE.length; i++) {
				url = url.split(CONNECTION_EXCLUDE[i]).join('');
			}
			return CONNECTION_PREFIX + url;
		}
		
		public static function init(game:Object, name:String):void {
			name = name || null;
			instance.initInternal(game, name);
		}
		
		public function initInternal(game:Object, name:String):void {
			if (!inited) {
				
				inited = true;
				
				var connName:String = getConnectionName(game);
				sendConnName = connName + SEND_CONN_POSTFIX;
				recvConnName = connName + RECV_CONN_POSTFIX;
				
				conn = new LocalConnection();
				
				conn.allowDomain("*");
				conn.allowInsecureDomain("*");
							
				conn.connect( recvConnName );
				
				conn.send( sendConnName, 'init', name );
			}
		}
		
		
		static public function sendScores(score:Number):void {
			instance._sendScores(score);
		}
		
		public function _sendScores(score:Number):void {
			if (inited) {
				conn.send( sendConnName, 'sendScores', score);
			}
		}
		
		static public function showPopup(x:Number, y:Number, newGame:Object):void {
			x = x || NaN;
			y = y || NaN;
			newGame = newGame || null;
			instance._showPopup(x, y, newGame);
		}
		
		private var newGame:Object;
		public function _showPopup(x:Number, y:Number, newGame:Object):void {
			if (inited) {
				this.newGame = newGame;
				hideNewGame( newGame );
				conn.send( sendConnName, 'showPopup', x, y);
			}
		}
		
		private function hideNewGame(newGame:Object):void {
			if ((newGame instanceof MovieClip) || (newGame instanceof Button) || (newGame instanceof TextField)) {
				newGame._visible = false;
			}
		}
		
		private function showNewGame(newGame:Object):void {
			if ((newGame instanceof MovieClip) || (newGame instanceof Button) || (newGame instanceof TextField)) {
				newGame._visible = true;
			} else if (newGame instanceof Function) {
				newGame();
			}
		}
		
		public function _showNewGame():void {
			showNewGame(newGame);
			newGame = null;
		}
		
		private function conn_showNewGame():void {
			Apitech.instance._showNewGame();
		}
		
		static public function mouseHide():void {
			instance._mouseHide();
		}
		
		public function _mouseHide():void {
			if (inited) {
				conn.send( sendConnName, 'mouseHide');
			}
		}
		
		static public function mouseShow():void {
			instance._mouseShow();
		}
		
		public function _mouseShow():void {
			if (inited) {
				conn.send( sendConnName, 'mouseShow');
			}
		}
		
		public var _mouseManager:Boolean = true;
		public function _setMouseManager(value:Boolean):void {
			_mouseManager = value;
			if (inited) {
				if (value) {
					conn.send( sendConnName, 'mouseEnable' );
				} else {
					conn.send( sendConnName, 'mouseDisable' );
				}
			}
		}
		
		public static function get mouseManager():Boolean {
			return instance._mouseManager;
		}
		
		public static function set mouseManager(value:Boolean):void {
			instance._setMouseManager( value );
		}
		
		static public function log():void {
			instance._log.apply(instance, arguments);
		}
		
		public function _log():void {
			if (inited) {
				conn.send( sendConnName, 'log', [].join.call(arguments, ' ') );
			}
		}
		
		
	}
}