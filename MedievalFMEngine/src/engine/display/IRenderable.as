package engine.display
{
	import flash.display.BitmapData;
	
	public interface IRenderable
	{
		function get bitmap():BitmapData;
		function get name():String;
	}
}