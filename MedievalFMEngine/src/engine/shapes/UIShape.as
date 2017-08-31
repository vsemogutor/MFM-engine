package engine.shapes
{
	public class UIShape
	{
		private static var shapeNum:int = 1000;
		public var id:String;
		
		public function UIShape()
		{
			id = "uishape_" + (++shapeNum);
		}
	}
}