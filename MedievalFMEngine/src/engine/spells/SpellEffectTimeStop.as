package engine.spells
{
	import __AS3__.vec.Vector;
	
	import engine.game.Game;
	import engine.heros.Hero;
	import engine.structures.Structure;
	import engine.units.Unit;
	import engine.units.UnitProperties;
	
	import mx.utils.ObjectUtil;
	
	public class SpellEffectTimeStop extends SpellEffectBase
	{
		public var affectBuildings:Boolean = true;
		
		public function SpellEffectTimeStop()
		{
			super();
		}
		
		public override function apply(target:Unit):Object
		{
			if (!startTime)
				startTime = Game.instance().gameTime.value;
				
			if (lifeTime >= duration)
				return lifeTime;
				
			if ((lifeTime % period) == 0)
			{	
				if (target == owner)
				{
					var units:Vector.<Unit> = Game.instance().unitManager.units;
					var len:int = units.length;
					
					for (var i:int = 0; i < len; ++i)
					{
						var unit:Unit = units[i];
						if (unit != owner)
						{
							var eff:SpellEffectBase = ObjectUtil.copy(this) as SpellEffectBase;
							eff.owner = owner;
							eff.duration = period*2;
							eff.period = 1;
							unit.spellEffects.push(eff);
						}
					}		
				}
				else
				{
					if ( !(target is Hero) && (affectBuildings || !(target is Structure) && !target.summoner) && owner.isActive )
					{
						target.properties[UnitProperties.CanMove] = 0;
						target.properties[UnitProperties.AttackRange] = 0;
						target.properties[UnitProperties.CastDelay] = Spell.MAX_CAST_DELAY;
						target.properties[UnitProperties.SightRange] = 0;
					}
				}
			}

			return ++lifeTime;			
		}		
	}
}