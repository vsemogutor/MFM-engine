package engine.spells
{
	import __AS3__.vec.Vector;
	
	import engine.game.Game;
	import engine.heros.Hero;
	import engine.heros.HeroProperties;
	import engine.specialEffects.SpecialEffects;
	import engine.units.*;
	
	public class SpellEffectMirrorImage extends SpellEffectBase
	{
		public var summonCount:int = 1;
		public var summonLifeTime:int;
		public var summonEffectId:int = 0;		
		public var summonMaxCount:int = 0;
						
		public function SpellEffectMirrorImage()
		{
		}
		
		public override function apply(target:Unit):Object
		{
			if (!startTime)
				startTime = Game.instance().gameTime.value;
				
			if (lifeTime >= duration)
				return lifeTime;
			
			if (checkFunction != null && !checkFunction(this))
				return lifeTime;
				
			if ((lifeTime % period) == 0)
			{
				var units:Vector.<Unit> = Game.instance().unitManager.
					createUnitsFromType(summonCount, owner.type, target.fraction);
					
				for (var i:int = 0; i < units.length; ++i)
				{
					units[i].summoner = target;
					units[i].summonLifeTime = summonLifeTime;
					
					if (target.fraction.isCurrentPlayer())
						Game.instance().effectManager.addEffectByTypeId(SpecialEffects.SummonMark, units[i].center, int.MAX_VALUE, units[i]);
					
					if (units[i] is Hero)
					{
						var hero:Hero = units[i] as Hero;
						hero.addExperience(-10000);
						hero.heroProperties[UnitProperties.SpellBonus] = -10000;
						hero.heroProperties[UnitProperties.AttackDmgMin] = owner.baseProperties[UnitProperties.AttackDmgMin]*0.3;
						hero.heroProperties[UnitProperties.AttackDmgMax] = owner.baseProperties[UnitProperties.AttackDmgMax]*0.3;
						hero.heroProperties[HeroProperties.Agility] = 1;
						hero.heroProperties[HeroProperties.Intellect] = 1;
						hero.heroProperties[HeroProperties.Stength] = 1;
						hero.heroProperties[UnitProperties.MaxHealth] = Hero(hero).baseProperties[UnitProperties.MaxHealth];
						hero.setProp(UnitProperties.Health, hero.heroProperties[UnitProperties.MaxHealth]);
						hero.skillPoints = 0;
					}
				}
					
				Game.instance().unitManager.placeUnitsOnWorld(units, target.tile, true);
				
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