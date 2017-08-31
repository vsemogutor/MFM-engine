package engine.specialEffects
{
	import engine.animation.AnimatedSprite;
	import engine.units.Unit;
	
	import flash.geom.Point;
	
	public final class SpecialEffect
	{
		public var type:SpecialEffectType;
		public var position:Point;
		public var model:AnimatedSprite;
		internal var lifeTime:int;
		internal var duration:int; // in seconds
		internal var animCycleDuration:int;
		internal var snapToObject:Boolean;
		internal var snapObject:Unit;
			
		public function SpecialEffect(type:SpecialEffectType = null)
		{
			this.type = type;
		}
			
		public function play():void
		{
			model.play(animCycleDuration);
		}
		
		public function stop():void
		{
			model.stop();
		}
	}
}