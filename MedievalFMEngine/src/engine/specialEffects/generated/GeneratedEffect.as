package engine.specialEffects.generated
{
	import engine.units.Unit;
	
	import flash.display.Shape;
	
	public class GeneratedEffect
	{
		public var id:int;	
		public var name:String;			
		public var startX:Number;
		public var startY:Number;
		public var endX:Number;
		public var endY:Number;
		
		public var displayStartX:Number;
		public var displayStartY:Number;
		public var displayEndX:Number;
		public var displayEndY:Number;
				
		public var duration:int;
		public var lifeTime:int;
		public var snapToStartObject:Boolean;
		public var snapToEndObject:Boolean;		
		public var snapObjectStart:Unit;
		public var snapObjectEnd:Unit;
		
		public function update(shape:Shape, sdx:int, sdy:int):void 
		{	
		} 
		
		public function kill():void 
		{
		}	
		
		public function clone():Object
		{
			return null;
		}						
	}
}