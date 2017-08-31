package engine.spells
{
	import computers.utils.Utils;
	
	import engine.game.Game;
	import engine.heros.Hero;
	import engine.structures.Structure;
	import engine.units.DamageType;
	import engine.units.Unit;
	import engine.units.UnitProperties;
	
	public class SpellEffectInstantKill extends SpellEffectBase
	{
		public var resitDamageCoeff:Number = 1;
		public var affectNonOrganic:Boolean = true;
		public var hpCap:int = 3000;
				
		public function SpellEffectInstantKill()
		{
			super();
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
				if (!affectNonOrganic && target.properties[UnitProperties.IsMechanical]) return 0;
				
				if (target is Structure || target is Hero || target.properties[UnitProperties.MaxHealth] > hpCap)
				{
					var dmg:int = owner.properties[UnitProperties.AttackDmgMax]*resitDamageCoeff;
					owner.makeDamage(target, dmg, dmg, DamageType.Astral);
				}	
				else
				{
					var res:int = target.properties[UnitProperties.MagicRes];
					var curApplyChance:int = applyChance || 100;
					if (res >= 30)
					{
						curApplyChance -= (res>>2);
					}
					
					if ((Utils.rand(1, 50) + Utils.rand(0, 50)) <= curApplyChance)
					{
						owner.makeDamage(target, 1000000, 1000000, DamageType.Astral);
					}
					else
					{
						var dmg:int = owner.properties[UnitProperties.AttackDmgMax]*resitDamageCoeff;
						owner.makeDamage(target, dmg, dmg, DamageType.Astral);						
					}
				}		
			}

			return ++lifeTime;			
		}		
	}
}