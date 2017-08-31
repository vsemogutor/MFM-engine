package engine.spells
{
	import computers.utils.Utils;
	
	import engine.game.Game;
	import engine.text.Text;
	import engine.units.Unit;
	import engine.units.UnitProperties;
	import engine.util.Constants;
	import engine.util.Util;
	
	public class AbilityEffect extends SpellEffectBase
	{
		public var propertyId:int;
		public var ownerPropertyIdMin:int;
		public var ownerPropertyIdMax:int = Constants.UNDEFINED;
		public var coefficient:Number;
		public var critOnStunned:Boolean = false;
						
		public function AbilityEffect()
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
				if (ownerPropertyIdMax == Constants.UNDEFINED)
				{
					ownerPropertyIdMax = ownerPropertyIdMin;
				}
				
				var effChange:int = Utils.rand(owner.properties[ownerPropertyIdMin], owner.properties[ownerPropertyIdMax])*coefficient;
				var critChance:int = 8 - owner.properties[UnitProperties.Armor];
				if (critChance > Utils.rand(1, 100)) 
				{
					effChange *= 1.5;
					Game.instance().textManager.addTextOnUnit(target, new Text("crit", Util.secToFrames(1.2)));
				}
				
				if (propertyId == UnitProperties.Health && effChange < 0)
				{
					if (effChange < 0)
					{
						if (critOnStunned && target.type.canAttack() && target.properties[UnitProperties.AttackRange] == 0)
						{
							effChange *= 2;
							Game.instance().textManager.addTextOnUnit(target, new Text("crit", Util.secToFrames(1.2)));
						}
							
						owner.makeDamage(target, -effChange, -effChange, owner.properties[UnitProperties.AttackDmgType]);
					}
				}
				else
					target.changeProp(propertyId, effChange);			
			}

			return ++lifeTime;			
		}
	}
}