package components
{
	public class PropertyDescription
	{
		public var name:String;
		public var val:Object;
		public var type:String;				
		private var _editable:Boolean;
		
		public function get editable():Boolean {
			return _editable && (val is int || val is Number || val is String || val is Boolean || type == "String");
		}
		
		public function set editable(value:Boolean):void {
			_editable = value;
		}
	}
}