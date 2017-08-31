package engine.specialEffects
{
	import engine.animation.AnimatedSprite;
	import engine.util.Constants;
	
	public final class SpecialEffectType
	{
		public var model:AnimatedSprite;
		public var duration:int; // in seconds
		public var animCycleDuration:int;
		public var snapToObject:Boolean;
		public var id:int = Constants.UNDEFINED;
		public var name:String;
		public var layer:int = SpecialEffectLayers.AfterUnits;
		public var z:int;
		
		public function validate():SpecialEffectType
		{
			if (!animCycleDuration)
				animCycleDuration = model.currentAnimationFramesNum*3
			
			if (!duration)
				duration = animCycleDuration;
				
			return this;
		}
		
		public function validateDefinition():Boolean
		{
			if (!name)
				throw new Error("effect name not defined");
				
			if (id == Constants.UNDEFINED)
				throw new Error("effect id not defined: " + name);
			
			if (!model)
				throw new Error("effect model not defined: " + name);
				
			if (layer < SpecialEffectLayers.AfterUnits || layer > SpecialEffectLayers.BeforeUnits)
				throw new Error("effect layer is incorrect: " + name);
				
			return true;
		}
	}
}