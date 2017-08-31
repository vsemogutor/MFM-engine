package engine.display
{
	import flash.display.BitmapData;
	
	import mx.core.BitmapAsset;

	public class BitmapDataRenderer implements IRenderable
	{
		//[Embed(source="../assets/simple_tile.png")]
	    [Bindable]
	    private static var simpleTileCls: Class;
        
		public var _bitmap:BitmapData;
		public var _name:String;
		
		public function BitmapDataRenderer(bitmap:BitmapData = null, name:String = null)
		{
			_name = name;
			if (bitmap)
			{
				_bitmap = bitmap;
			}
			else
			{
				var ba:BitmapAsset = new simpleTileCls() as BitmapAsset;
				_bitmap = ba.bitmapData;
			}
		}
		public function get bitmap():BitmapData {
			return _bitmap;
		}
		public function get name():String {
			return _name;
		}
		public function set name(name:String):void {
			this._name = name;
		}

	}
}