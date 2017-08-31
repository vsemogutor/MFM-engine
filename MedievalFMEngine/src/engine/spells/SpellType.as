package engine.spells
{
	import __AS3__.vec.Vector;
	
	import engine.ai.AiHintType;
	import engine.animation.AnimatedSprite;
	import engine.fraction.Fraction;
	import engine.localization.Localizable;
	import engine.sound.SoundPack;
	import engine.specialEffects.SpecialEffectType;
	import engine.specialEffects.generated.GeneratedEffect;
	import engine.structures.Structure;
	import engine.units.Unit;
	import engine.units.UnitProperties;
	import engine.units.UnitType;
	import engine.util.Constants;
	import engine.util.Util;
	
	import mx.core.BitmapAsset;
	
	public class SpellType extends Localizable
	{
		public var id:int = Constants.UNDEFINED;
		public var name:String; // logical name of the spell
		public var locName:String; // localized display  name of the spell
		public var description:String;		
		public var effects:Vector.<SpellEffectBase> = new Vector.<SpellEffectBase>();	
		public var duration:int = 1;
		public var period:int = 1;				
		public var projectileModel:AnimatedSprite;
		public var projectileTrajectory:int;
		public var specialEffect:SpecialEffectType;
		public var specialGeneratedEffect:GeneratedEffect;		
		public var spellEffectSpecialEffect:SpecialEffectType;
		public var projectileSpeed:int = 1;
		public var radius:int = 0;
		public var cone:Boolean;
		public var targetType:int;
		public var castType:int = SpellCastType.Unit;
		public var range:int = 1;		
		public var snapToUnit:Boolean;
		public var cost:int;
		public var costProperty:int = UnitProperties.Mana;
		public var cooldown:int = 2;
		public var dependencies:Vector.<UnitType> = new Vector.<UnitType>();
		public var autocastType:int = SpellAutocastType.NONE;
		public var sfxDuration:int = 0;
		public var effectSfxDuration:int = 0;				
		public var soundPack:SoundPack = new SoundPack();
		public var icon:BitmapAsset;
		public var aiHint:int;
		public var visualType:int = SpellVisualType.Normal;
		public var rainDelay:int;
		public var rainHeight:int = 3*Constants.TILE_HEIGHT;
		public var affectBuildings:Boolean = true;		
		public var quakeDuration:int = 0;		
		public var canBeReset:Boolean = true;
		public var canCastOnlyIfNotVisible:Boolean = false;
								
		public function addEffects(spEffects:Array):void
		{
			for (var i:int = 0; i < spEffects.length; ++i)
				effects.push(spEffects[i]);
		}
		
		public function isAllowedTarget(unit:Unit, target:Unit):Boolean
		{
			if (!unit)
				return false;
			
			var res:Boolean = true;
			if (targetType >= TargetType.All)
				res = true;	
			if (targetType == TargetType.Enemy)
			{
				if (castType == SpellCastType.Self)
					res = (unit == target);
				else
					res = unit.isValidEnemyTarget(target) && (!cost || target.properties[UnitProperties.MagicRes] < 100);
			}
			if (targetType == TargetType.Ally)
				res = unit.isAllowedAllyTarget(target);
			if (targetType == TargetType.Self)	
				return unit == target;	
				
			if (aiHint == AiHintType.DrainMana)
				return res && (target.properties[UnitProperties.MaxMana] > 0);
			if (aiHint == AiHintType.DrainHealth)
				return res && (target.properties[UnitProperties.IsMechanical] == 0);
				
			if (target is Structure && !affectBuildings) return false;		
					
			return res;						
		}
		
		public function checkDependencies(fraction:Fraction):Boolean
		{
			return fraction.checkDependenceies(dependencies);
		}
		
		public function validateCost(unit:Unit):Boolean
		{
			return unit.properties[costProperty] >= cost && castType != SpellCastType.Aura;
		}

		public function subtractCost(unit:Unit):void
		{
			unit.changeProp(costProperty, -cost);
		}
				
		public function validateDefinition():Boolean
		{
			if (id == Constants.UNDEFINED)
				throw new Error("spell id is not set: " + name);
				
			if (!name)
				throw new Error("spell name is not set: " + name);
				
			if (costProperty != UnitProperties.Mana && costProperty != UnitProperties.Health)
				throw new Error("wrong spell costProperty: " + name); 
				
			if (targetType < TargetType.Enemy || targetType > TargetType.Place)
				throw new Error("wrong spell target type: " + name);

			if (castType < SpellCastType.Unit || castType > SpellCastType.Aura)
				throw new Error("wrong spell cast type: " + name);
			else if (castType == SpellCastType.Aura && !snapToUnit) //this error is not severe, so just correct
				snapToUnit = true;
				
			if (range <= 0)
				throw new Error("wrong spell range: " + name);	
				
			if (targetType == TargetType.Self && (castType != SpellCastType.Unit && castType != SpellCastType.Self))
				throw new Error("self targeted spells must have cast type unit or self: " + name);	
								
			return true;
		}
		
		public function hasEffect(eff:SpellEffectBase):Boolean
		{
			for (var i:int = 0; i < effects.length; ++i)
			{
				if (effects[i].id == eff.id) return true;
			}
			
			return false;
		}
		
		private function validateEffects():void
		{
			for (var i:int = 0; i < effects.length; ++i)
			{
				var effect:SpellEffectBase = effects[i];
				
				if (effect is SpellEffectSummon)
				{
					if (targetType == TargetType.Enemy)
					{
						throw new Error("summon spels can't target enemies: " + name);
					} 
				}
			}
		}
		
		public function checkAutocastTarget(unit:Unit):Boolean
		{
			if (aiHint == AiHintType.Heal)
			{
				return unit.properties[UnitProperties.Health] < unit.properties[UnitProperties.MaxHealth]*0.8;
			}
			else if (aiHint == AiHintType.Protection)
			{
				for (var effId:int = 0; effId < unit.spellEffects.length; ++effId)
				{
					if (unit.spellEffects[effId].id == effects[0].id)
						return false;
				}
				return true;
			}
			else return aiHint != AiHintType.None;
		}
		
		protected override function localize():void
		{
			if (!locName)
				locName = locString(name) || name;
			if (!description)
				description = locString(name + "Desc");
		}
		
		public function getDescription():String
		{
			var desc:String = description || "";
			for (var i:int = 0; i < effects.length; ++i) 
			{
				var bEff:SpellEffectBase = effects[i];
				desc = desc.replace("{cost}", cost).replace("{duration}", Util.framesToSec(duration)).replace("{applyChance" + i  + "}", bEff.applyChance);
				
				var eff:SpellEffect = bEff as SpellEffect;
				if (eff) 
				{
					desc = desc.replace(new RegExp("{minChange" + i  + "}", "g"), Math.abs(eff.minChange))
						.replace("{maxChange" + i  + "}", Math.abs(eff.maxChange))
						.replace("{period" + i  + "}", Util.framesToSec(eff.period))
						.replace("{minChangePerc" + i  + "}", Math.abs(eff.minChange) - 100);
				}
				
				var sEff:SpellEffectSummon = bEff as SpellEffectSummon;
				if (sEff) desc = desc.replace("{summonLifeTime" + i + "}", Util.framesToSec(sEff.summonLifeTime));
				
				var aEff:AbilityEffect = bEff as AbilityEffect;
				if (aEff) desc = desc.replace("{coeff" + i + "}", Math.abs(aEff.coefficient) * 100);
				
				desc = desc.replace("{effDuration" + i + "}", Util.framesToSec(bEff.duration));
			}
			
			return desc;
		}
	}
}