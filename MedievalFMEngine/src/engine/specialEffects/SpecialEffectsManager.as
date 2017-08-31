package engine.specialEffects
{
	import __AS3__.vec.Vector;
	
	import de.polygonal.ds.HashMap;
	
	import engine.core.ManagerBase;
	import engine.specialEffects.generated.GeneratedEffect;
	import engine.units.Unit;
	import engine.util.Constants;
	
	import flash.geom.Point;
	
	public final class SpecialEffectsManager extends ManagerBase
	{
		private static const CACHE_SIZE:int = 3000;
		private var _cacheTop:int = CACHE_SIZE;
		private var _cache:Vector.<SpecialEffect> = new Vector.<SpecialEffect>(CACHE_SIZE);
		
		private var _effects:Vector.<SpecialEffect> = new Vector.<SpecialEffect>();		
		private var _generatedEffects:Vector.<GeneratedEffect> = new Vector.<GeneratedEffect>();		
		private var _effectTypes:HashMap = new HashMap();
		private var _generatedEffectTypes:HashMap = new HashMap();
						
		public function get effects():Vector.<SpecialEffect>
		{
			return _effects;
		}
		
		public function get generatedEffects():Vector.<GeneratedEffect>
		{
			return _generatedEffects;
		}		
		
		public function SpecialEffectsManager()
		{
			super();
			initCache();
		}
		
		private function addEffect(effect:SpecialEffect, pos:Point = null, duration:int = 0, snapObject:Unit=null):void
		{
			if (duration)
				effect.duration = duration;
			if (pos)
				effect.position = pos.clone();
				
			effect.snapObject = snapObject;
			
			_effects.push(effect);
		}

		public function addGeneratedEffect(effect:GeneratedEffect, posStart:Point = null, posEnd:Point = null, duration:int = 0,
			 snapObjectStart:Unit=null, snapObjectEnd:Unit=null):void
		{
			var newEffect:GeneratedEffect = effect.clone() as GeneratedEffect;
			
			if (duration)
				newEffect.duration = duration;
				
			if (posStart)
			{
				newEffect.startX = posStart.x;
				newEffect.startY = posStart.y;				
			}

			if (posEnd)
			{
				newEffect.endX = posEnd.x;
				newEffect.endY = posEnd.y;				
			}
							
			newEffect.snapObjectStart = snapObjectStart;
			newEffect.snapObjectEnd = snapObjectEnd;
						
			_generatedEffects.push(newEffect);
		}
		
		public function addEffectByTypeId(id:int, pos:Point = null, duration:int = 0, snapObject:Unit=null):void
		{
			addEffectByType(getEffectType(id), pos, duration, snapObject);
		}
		
		public function addEffectByType(type:SpecialEffectType, pos:Point = null, duration:int = 0, snapObject:Unit=null):void
		{
			addEffect(createEffectFromType(type), pos, duration, snapObject);
		}	
				
		public function createEffectFromType(type:SpecialEffectType):SpecialEffect
		{
			var effect:SpecialEffect = getFromCache();
			effect.type = type;
			effect.model = type.model.clone();
			effect.duration = type.duration;
			effect.snapToObject = type.snapToObject;
			effect.snapObject = null;
			effect.animCycleDuration = type.animCycleDuration;
			effect.lifeTime = 0;
			return effect;
		}		
				
		public function addEffectType(effect:SpecialEffectType, id:int = -1):int
		{
			if (id != Constants.UNDEFINED)
				effect.id = id; 
			else if (effect.id == Constants.UNDEFINED)
				effect.id = idManager.idByName(effect.name);
			
			
			effect.validateDefinition();
			_effectTypes.set(effect.id, effect.validate());
			return effect.id;
		}

		public function addGeneratedEffectType(effect:GeneratedEffect, id:int = -1):int
		{
			if (id != Constants.UNDEFINED)
				effect.id = id; 
			else if (effect.id == Constants.UNDEFINED)
				effect.id = idManager.idByName(effect.name);
			
			_generatedEffectTypes.set(effect.id, effect);
			return effect.id;
		}
				
		public function getEffectType(id:int):SpecialEffectType
		{
			return _effectTypes.get(id) as SpecialEffectType;
		}
		
		public function processEffects():void
		{
			for (var i:int = 0; i < _effects.length; ++i)
			{
				var effect:SpecialEffect = _effects[i];
				var remove:Boolean = false;
				
				if (effect.snapToObject)
				{
					var snapObject:Unit = effect.snapObject;
					if (snapObject && snapObject.isActive)
					{
						effect.position.x = snapObject.physicalCenter.x;
						effect.position.y = snapObject.physicalCenter.y;
					}
					else
					{
						remove = true;
					}
				}
				
				if (effect.lifeTime > effect.duration)
				{
					remove = true;
				}
				
				if (!remove)
				{
					++effect.lifeTime;
					effect.play();
				}
				else
				{
					effect.stop();
					returnToCache(effect);
					_effects.splice(i, 1);
				}
			}
			
			for (var i:int = 0; i < _generatedEffects.length; ++i)
			{
				var gEffect:GeneratedEffect = _generatedEffects[i];
				var remove:Boolean = false;
				
				if (gEffect.snapToStartObject)
				{
					var snapObjectStart:Unit = gEffect.snapObjectStart;				
					if (snapObjectStart && snapObjectStart.isActive)
					{
						gEffect.startX = snapObjectStart.physicalCenter.x;
						gEffect.startY = snapObjectStart.physicalCenter.y;						
					}
					else
					{
						++gEffect.lifeTime;
					}
				}
				
				if (gEffect.snapToEndObject)
				{
					var snapObjectEnd:Unit = gEffect.snapObjectEnd;					
					if (snapObjectEnd && snapObjectEnd.isActive)
					{					
						gEffect.endX = snapObjectEnd.physicalCenter.x;
						gEffect.endY = snapObjectEnd.physicalCenter.y;
					}
					else
					{
						++gEffect.lifeTime;
					}
				}
								
				if (gEffect.lifeTime > gEffect.duration)
				{
					remove = true;
				}
				
				if (!remove)
				{
					++gEffect.lifeTime;
				}
				else
				{
					gEffect.kill();
					_generatedEffects.splice(i, 1);
				}				
				
			}			
		}
	
		private function initCache():void
		{
			for (var i:int = 0; i < CACHE_SIZE; ++i)
				_cache[i] = new SpecialEffect();
		}
	
		private function getFromCache():SpecialEffect
		{
			if (_cacheTop <= 0)
				return new SpecialEffect();
			
			return _cache[--_cacheTop];
		}
		
		private function returnToCache(effect:SpecialEffect):void
		{
			if (_cacheTop >= CACHE_SIZE) return;
			_cache[_cacheTop] = effect;
			++_cacheTop;
		}
	}
}