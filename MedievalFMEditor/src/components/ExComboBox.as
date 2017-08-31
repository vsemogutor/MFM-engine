package components
{
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import mx.controls.ComboBox;

	public class ExComboBox extends ComboBox
	{
		public var state:Object;
		public var targetProp:Object;
						
		public function ExComboBox()
		{
			super();
			addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		private function onKeyUp(evt:KeyboardEvent):void
		{
			if (evt.keyCode == Keyboard.ESCAPE)
			{
				selectedIndex = -1;
			}
		}
	}
}