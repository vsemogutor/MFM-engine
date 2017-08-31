package engine.text
{
	import engine.util.Constants;
	
	import mx.controls.Text;
	
	public final class Text
	{
		private var _name:String;
		public function get name():String {
			return _name;
		}
		public function set name(value:String):void {
			_name = value;
		}
		
		public function Text(text:String = null, time:int = 0)
		{
			this.text = text;
			this.time = time;
		}
		
		public var x:int = Constants.UNDEFINED;
		public var y:int = Constants.UNDEFINED;
		public var relativeX:int = Constants.UNDEFINED;
		public var relativeY:int;	
		public var text:String;
		public var fadeIn:Boolean;
		public var fadeOut:Boolean = true;	
		public var color:uint = 0x000000;
		public var time:int = int.MAX_VALUE;	
		public var width:int;	
		public var height:int;		
		public var size:int = 10;	
		public var lifeTime:int = 0;	
		internal var label:mx.controls.Text;
		public var bold:Boolean;
		public var shadow:Boolean = true;
		public var alpha:Number = 1;
	}
}