package engine.objects
{
	import engine.animation.AnimatedSprite;
	import engine.util.Constants;
	
	public class ObjectType
	{
		public var id:int = Constants.UNDEFINED;
		public var name:String;
		public var description:String;		
		public var xLength:int = 1;
		public var yLength:int = 1;
		public var model:AnimatedSprite;
		public var passable:Boolean;
		public var color:uint;
		
		public function validateDefinition():Boolean
		{
			if (xLength <= 0 || yLength <= 0)
				throw new Error("object height or width is incorrect");

			if (id == Constants.UNDEFINED)
				throw new Error("id is not set");
				
			if (!model || !model is AnimatedSprite)
				throw new Error("model is not set or incorrect");
				
			if (!name)
				throw new Error("name is not set");
			
			return true;
		}
		
		public function setColor():void
		{
			color = model.currentAnimation.bitmap.getPixel(model.currentAnimation.frameWidth >> 1, model.currentAnimation.frameHeight >> 1);
		}
	}
}