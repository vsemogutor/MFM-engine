package engine.units
{
	import computers.utils.Utils;
	
	import engine.animation.UnitSprite;
	import engine.core.Direction;
	import engine.core.fm_internal;
	import engine.fraction.Fraction;
	import engine.game.Game;
	import engine.heros.Hero;
	import engine.spells.SpellCastType;
	import engine.spells.SpellType;
	import engine.structures.Structure;
	
	use namespace fm_internal;
		
	public final class UnitFactory
	{
		public function createUnit(type:UnitType, fraction:Fraction):Unit
		{
			var unit:Unit;
			
			if (type.type == UnitTypes.Unit)
			{
				unit = new Unit(type, fraction);
				unit.direction = Utils.rand(0, Direction.Count - 1);
			}
			else if (type.type == UnitTypes.Structure)
			{
				unit = new Structure(type, fraction);
			}
			else if (type.type == UnitTypes.Hero)
			{
				unit = new Hero(type, fraction);
				unit.direction = Utils.rand(0, Direction.Count - 1);
				unit.name = getRandHeroName(type);
			}
	
			unit.setModel(type.model.clone());
					
			unit.setProp(UnitProperties.Health, unit.properties[UnitProperties.MaxHealth]);
			unit.setProp(UnitProperties.Mana, unit.properties[UnitProperties.MaxMana]);
			
			unit.state = UnitState.Waiting;
			unit.stand();
			unit._id = Game.instance().idManager.nextId();	
			unit.setActiveSpell(type.activeSpell);	
			
			var len:int = type.spellList.length;
			for (var i:int = 0; i < len; ++i)
			{
				var spellType:SpellType = type.spellList[i];
				if (spellType.castType == SpellCastType.Aura)
				{
					unit.auraSpell = spellType;
					break;
				}
			}
			return unit;
		}
		
		private function getRandHeroName(type:UnitType):String
		{
			var indx:int = Utils.rand(0, type.heroNames.length - 1);
			var name:String = type.heroNames[indx];
			
			if (type.heroNames.length > 2)
				type.heroNames.splice(indx, 1);
			
			return name;			
		}

	}
}