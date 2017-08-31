package engine.shapes
{
	import __AS3__.vec.Vector;
	
	import engine.core.events.EngineEvents;
	import engine.core.events.GameEvent;
	import engine.game.Game;
	
	import flash.geom.Point;
	
	public final class UIShapeManager
	{
		private static var shapes:Vector.<UIShape> = new Vector.<UIShape>();
		
		public static function showArrow(from:Point, dest:Point):UIShape
		{
			if (Game.instance())
			{	
				var arrow:UIShape = new UIShape();
				shapes.push(arrow);
				Game.instance().eventManager.dispatch(
					new GameEvent(EngineEvents.ADD_SHAPE, {shape:arrow, show:true, dest:dest, from:from}));
					
				return arrow;
			}
			
			return null;
		}
		
		public static function hideShape(shape:UIShape):void
		{
			if (shape && Game.instance())
			{
				var indx:int = shapes.indexOf(shape);
				
				if (indx >= 0) 
				{
					Game.instance().eventManager.dispatch(
						new GameEvent(EngineEvents.ADD_SHAPE, {shape:shape, show:false}));
					shapes.splice(indx, 1);	
				}
			}
		}
		
		public static function hideAll():void
		{
			for (var i:int; i < shapes.length; ++i)
			{
				hideShape(shapes[i]);
			}
			
			shapes = new Vector.<UIShape>();
		}
	}
}