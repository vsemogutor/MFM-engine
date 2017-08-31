package engine.game
{
	import engine.fraction.Fraction;
	
	public class PlayerTeam
	{
		private var _slots:Array = new Array();
		private var _name:String = "";
		
		public  function get slots():Array {
			return _slots;
		}

		public  function get name():String {
			return _name;
		}
		
		public  function set name(value:String):void {
			_name = value;
		}
						
		public function addSlots(num:int=1):void
		{
			for (var i:int = 0; i < num; ++i)
				_slots.push(new PlayerSlot());
		}
	}
}