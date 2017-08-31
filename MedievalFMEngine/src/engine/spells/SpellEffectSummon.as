package engine.spells
{
	import __AS3__.vec.Vector;
	
	import computers.utils.Utils;
	
	import engine.core.isometric.IsoTile;
	import engine.game.Game;
	import engine.heros.Hero;
	import engine.heros.Skill;
	import engine.specialEffects.SpecialEffects;
	import engine.units.*;
	
	public class SpellEffectSummon extends SpellEffectBase
	{
		public var unitTypeId:int;
		public var summonCount:int = 1;
		public var summonLifeTime:int;
		public var summonEffectId:int = 0;		
		public var summonMaxCount:int = 0;
						
		public function SpellEffectSummon()
		{
		}
		
		public function checkSummonLimit(summoner:Unit):Boolean
		{
			if (summonMaxCount)
			{
				var units:Vector.<Unit> = summoner.summons;
				var len:int = units.length;
				var count:int = 0; 
				for (var i:int = 0; i < len; ++i)
				{
					if (units[i].type.id == unitTypeId) 
					{
						if (++count >= summonMaxCount)
							return false;
					}
				}
			}
			
			return true;			
		}		
		
		private function ensureSummonLimit(summoner:Unit):void
		{
			if (summonMaxCount)
			{
				var units:Vector.<Unit> = summoner.summons;
				var len:int = units.length;
				var count:int = 0; 
				for (var i:int = len - 1; i >= 0; --i)
				{
					if (units[i].type.id == unitTypeId) 
					{
						if (++count > summonMaxCount)
							Game.instance().unitManager.removeUnit(units[i]);
					}
				}
			}			
		}
		
		public override function applyToTile(target:IsoTile):Object
		{
			if (!startTime)
				startTime = Game.instance().gameTime.value;
				
			if (lifeTime >= duration)
				return lifeTime;
			
			if (checkFunction != null && !checkFunction(this))
				return lifeTime;
				
			if ((lifeTime % period) == 0 && (!applyChance || applyChance > Utils.rand(1, 100)))
			{
				var units:Vector.<Unit> = Game.instance().unitManager.
					createUnitsFromType(summonCount, unitTypeId, owner.fraction);
					
				for (var i:int = 0; i < units.length; ++i)
				{
					units[i].summoner = owner;
					units[i].summonLifeTime = summonLifeTime;
					units[i].attackRatingRand = 1;
					owner.summons.push(units[i]);
					
					if (owner.fraction.isCurrentPlayer())
						Game.instance().effectManager.addEffectByTypeId(SpecialEffects.SummonMark, units[i].center, int.MAX_VALUE, units[i]);
					
					if (owner is Hero)
					{
						var hero:Hero = owner as Hero;
						
						for (var skillObject:Object in hero.skills)
						{
							var skill:Skill = skillObject as Skill;
							if (skill.applyToSummon)
							{
								skill.apply(units[i], hero.getSkillLevel(skill));
							}
						}
					}
				}
				
				ensureSummonLimit(owner);
					
				Game.instance().unitManager.placeUnitsOnWorld(units, target, true);
				
				if (summonEffectId)
				{
					for (var i:int = 0; i < units.length; ++i)
					{
						Game.instance().effectManager.addEffectByTypeId(summonEffectId, units[i].physicalCenter);
					}
				}
			}

			return ++lifeTime;
		}
	}
}