package alderun
{
	import engine.ai.AiHintType;
	import engine.core.GameTime;
	import engine.game.Game;
	import engine.spells.*;
	import engine.units.UnitProperties;
	
	import mx.core.BitmapAsset;
	
	import resources.BitmapResources;
	import resources.SoundResources;
	
	public final class SpellTypesRepository
	{
		internal var poolRegenerationAuraLvl1:SpellType;		
		internal var etherStepLvl1:SpellType;

		private function poolRegenerationAuraLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.minChange = 12;
			effect.propertyId = UnitProperties.Health;
			effect.coeficientPropertyId = UnitProperties.MaxHealth;
			effect.opType = SpellEffectOperationType.Add;
			effect.stackable = false;

			var effect1:SpellEffect = new SpellEffect();
			effect1.minChange = 12;
			effect1.propertyId = UnitProperties.Mana;
			effect1.coeficientPropertyId = UnitProperties.MaxMana;
			effect1.opType = SpellEffectOperationType.Add;
			effect1.stackable = false;

			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1] );
			spell.aiHint = AiHintType.Heal;
			spell.name = "PoolRenenerationAuraLvl1";
			spell.locName = "SpPoolRenenerationAura";
			spell.description = "SpPoolRenenerationAuraDesc";	
			spell.castType = SpellCastType.Aura;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.targetType = TargetType.All;					
			spell.icon = new BitmapAsset(BitmapResources.icoSpellHolyLight.bitmapData);
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Heal;
			spell.specialEffect = typesRepository.effectTypes.Heal;
			spell.snapToUnit = true;
			spell.radius = 3;
			spell.duration = new GameTime(0, 3).value;
			spell.affectBuildings = false;
			game.spellManager.addSpellType(spell);	
			
			poolRegenerationAuraLvl1 = spell;
		}

		private function etherStepLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect3:SpellEffect = new SpellEffect();
			effect3.minChange = -80;
			effect3.maxChange = -90;
			effect3.dmgSubtype = SpellDamageSubtype.Frost;			
			effect3.propertyId = UnitProperties.Health;
			
			var effect5:SpellEffect = new SpellEffect();
			effect5.minChange = 0;
			effect5.propertyId = UnitProperties.CanMove;
			effect5.opType = SpellEffectOperationType.Set;
			effect5.duration = new GameTime(0, 5).value;
			effect5.affectedByMagicResistance = false; 			

			var effect2:SpellEffect = new SpellEffect();
			effect2.minChange = 0;
			effect2.propertyId = UnitProperties.AttackRange;
			effect2.opType = SpellEffectOperationType.Set;
			effect2.duration = new GameTime(0, 5).value; 		

			var effect4:SpellEffect = new SpellEffect();
			effect4.minChange = Spell.MAX_CAST_DELAY;
			effect4.propertyId = UnitProperties.CastDelay;
			effect4.duration = new GameTime(0, 6).value; 
			effect4.affectedByMagicResistance = false;	
						
			var spellStep:SpellType = new SpellType();
			spellStep.addEffects( [effect2, effect3, effect4, effect5] );
			spellStep.aiHint = AiHintType.Attack;
			spellStep.range = 8;
			spellStep.name = "StepSpellLvl1";
			//spellStep.castType = SpellCastType.;
			spellStep.autocastType = SpellAutocastType.NONE;	
			spellStep.targetType = TargetType.Enemy;			
			spellStep.soundPack.hit = SoundResources.magicHit4;		
			spellStep.soundPack.attack = SoundResources.magicShoot4;					
			spellStep.icon = new BitmapAsset(BitmapResources.icoSpellIceComet.bitmapData);
			spellStep.specialEffect = typesRepository.effectTypes.Ice2;
			spellStep.radius = 2;
			spellStep.affectBuildings = false;
			game.spellManager.addSpellType(spellStep);
			
			var effect:SpellEffectTeleport = new SpellEffectTeleport();

			var effect1:SpellEffectCastSpell = new SpellEffectCastSpell();
			effect1.spellTypeId = spellStep.id;
			effect1.nextTargetIsRandom = false; 
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1] );
			spell.aiHint = AiHintType.ProtectionCritical;
			spell.name = "EtherStepLvl1";
			spell.locName = "Ether Step";
			spell.description = "Teleports the caster to a nearby location.";	
			spell.castType = SpellCastType.Place;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 100;
			spell.targetType = TargetType.Place;			
			spell.soundPack.hit = SoundResources.magicHit7;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellBlink.bitmapData);
			spell.range = 12;
			spell.specialEffect = typesRepository.effectTypes.LeafsDark;
			spell.cooldown = new GameTime(0, 10).value;
			game.spellManager.addSpellType(spell);	
			
			etherStepLvl1 = spell;
		}
																																																																																										
		public function init(game:Game, typesRepository:TypesRepository):void
		{
			poolRegenerationAuraLvl1Init(game, typesRepository);
			etherStepLvl1Init(game, typesRepository);
		}
	}
}