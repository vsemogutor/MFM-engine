package engine.spells
{
	import __AS3__.vec.Vector;
	
	import computers.utils.Utils;
	
	import engine.animation.AnimatedSprite;
	import engine.core.isometric.IsoTile;
	import engine.game.Game;
	import engine.specialEffects.SpecialEffectType;
	import engine.units.Unit;
	import engine.units.UnitProperties;
	import engine.util.Constants;
	import engine.util.TileUtil;
	import engine.util.Util;
	
	import flash.geom.Point;
	
	import mx.utils.ObjectUtil;
	
	public class Spell
	{
		public static const MAX_CAST_DELAY:int = Util.secToFrames(60);
		
		public var type:SpellType;
		private var _effects:Vector.<SpellEffectBase> = new Vector.<SpellEffectBase>();
		public var lifeTime:int = 0;
		private var _target:Unit;
		internal var targetPos:Point;
		protected var targetTile:IsoTile;		
		public var projectileModel:AnimatedSprite;
		internal var specialEffect:SpecialEffectType;
		public var owner:Unit;
		private var _targetNum:int = 0;		
		private static var _lastRandomX:int = 0;
		private static var _lastRandomY:int = 0;
							
		public function get target():Unit{
			return _target;
		}
		public function get effects():Vector.<SpellEffectBase>{
			return _effects;
		}
					
		public function Spell(type:SpellType, target:*, owner:Unit=null)
		{
			this.type = type;
			setTarget(target);
			this.owner = owner;
		}
		
		public function setTarget(target:*):void
		{
			if (target is Point)
			{
				targetPos = target.clone();
			}
			else if (target is Unit)
			{
				_target = target;
				targetPos = target.physicalCenter;
			}
			else if (target is IsoTile)
			{
				targetTile = target;
				targetPos = targetTile.center;
			}			
			else
			{
				throw new Error("Wrong spell target");
			}
		}
		
		public function getTarget():*
		{
			return _target || targetPos;
		}

		public function getRandomTargetInRadius():Point
		{
			var radius:int = type.radius || 1;
			
			var target:Point = targetPos.clone();
			var dy:int = (Utils.rand(0, radius) + Utils.rand(-radius, 0))*(Constants.TILE_U);
			var dx:int = (Utils.rand(0, radius) + Utils.rand(-radius, 0))*(Constants.TILE_U);
			
			if (_lastRandomX == dx) dx = Utils.rand(-radius,radius)*(Constants.TILE_V);	
			if (_lastRandomY == dy) dy = Utils.rand(-radius, radius)*(Constants.TILE_V);		
			_lastRandomX = dx;
			_lastRandomY = dy;
			
			target.y += dy;
			target.x += dx;			
				
			return target;
		}
				
		public function getTile():IsoTile
		{
			if (type.targetType == TargetType.Self)
			{
				return owner.tile;
			}
			else if (type.snapToUnit && target)
			{
				return target.getClosestActiveTile(owner.tile);
			}
			else if (type.targetType == TargetType.Place && targetTile)
			{
				return targetTile;
			}
			else
			{
				var pos:Point;
				if (_target) pos = _target.fromPhysicalCenterToCenter(targetPos);
				else pos = targetPos;
				pos = TileUtil.isoToTile(pos.x, pos.y);
				var tile:IsoTile = Game.instance().world.getTile(pos.x, pos.y);
				if (!tile && _target) return _target.getClosestActiveTile(owner.tile);
				
				return tile;
			}
		}
		
		public function apply(tile:IsoTile):void
		{	
			if (tile.unit)		
				addEffectsToTarget(tile.unit);
			else
				addEffectsToTile(tile);
		}

		public function addEffectsToTile(tile:IsoTile):void
		{
			if (type.targetType == TargetType.Place)
			{
				var cEffects:Vector.<SpellEffectBase> = Vector.<SpellEffectBase>(ObjectUtil.copy(type.effects));
				
				for (var i:int = 0; i < cEffects.length; ++i)
				{
					var effect:SpellEffectBase = cEffects[i];
					effect.owner = owner;
					
					effect.applyToTile(tile);
					
					if (type.spellEffectSpecialEffect) 
						Game.instance().effectManager.addEffectByType(type.spellEffectSpecialEffect, 
							new Point(tile.x - (Constants.TILE_WIDTH>>1), tile.y - (Constants.TILE_HEIGHT>>1)));					
				}				
			}
		}
		
		public function addEffectsToTarget(unit:Unit):void
		{
			if (isApplicable(unit))
			{
				var cEffects:Vector.<SpellEffectBase> = Vector.<SpellEffectBase>(ObjectUtil.copy(type.effects));
				
				for (var i:int = 0; i < cEffects.length; ++i)
				{
					var effect:SpellEffectBase = cEffects[i];
					effect.owner = owner;
					
					if (effect.stackable)
					{
						unit.spellEffects.push(effect);
					}
					else
					{
						var found:Boolean = false;
						for (var effId:int = 0; effId < unit.spellEffects.length; ++effId)
						{
							if (unit.spellEffects[effId].id == effect.id)
							{
								if (effect.canReset) unit.spellEffects[effId] = effect;
								found = true;
								break;
							}
						}
						if (!found)
							unit.spellEffects.push(effect);
					}
					
					if (type.spellEffectSpecialEffect) 
						Game.instance().effectManager.addEffectByType(type.spellEffectSpecialEffect, 
							unit.physicalCenter, type.effectSfxDuration, unit);
				}
			}
		}
		
		private function isApplicable(unit:Unit):Boolean
		{
			if (!unit) return false;
			if (type.targetType >= TargetType.All) return true;
			if (type.targetType == TargetType.Ally) return owner.fraction.isAllyOf(unit.fraction);
			if (type.targetType == TargetType.Enemy) return owner.fraction.isEnemyOf(unit.fraction); 
			if (type.targetType == TargetType.Self) return unit == owner;
			return true;			
		}
		
		public function isAllowedTarget(unit:Unit):Boolean
		{
			return type.isAllowedTarget(owner, unit);					
		}
		
		public function canCast():Boolean
		{
			if (effects.length)
			{
				var effect:SpellEffectBase = type.effects[0];
				if (effect is SpellEffectUnsummon)
				{
					if (target.summoner == null) return false;
				}
			}
						
			// unit can't commit suicide using health cost spells
			return (type.costProperty != UnitProperties.Health 
				|| (owner.properties[UnitProperties.Health] - type.cost) > 0)
				&& owner.properties[type.costProperty] >= type.cost;
		}
	}
}