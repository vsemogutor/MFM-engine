package arena
{
	import engine.ai.AiHintType;
	import engine.core.GameTime;
	import engine.game.Game;
	import engine.projectile.ProjectileTrajectory;
	import engine.spells.*;
	import engine.units.ArmorType;
	import engine.units.DamageType;
	import engine.units.UnitProperties;
	import engine.util.Constants;
	import engine.util.Util;
	
	import mx.core.BitmapAsset;
	
	import resources.BitmapResources;
	import resources.SoundResources;
	
	public final class SpellTypesRepository
	{
		internal var implosion:SpellType;
		internal var waterJet:SpellType;		
		internal var dispell:SpellType;	
		internal var eathquake:SpellType;		
		internal var heal:SpellType;	
		internal var shield:SpellType;
		internal var fortitudeAura:SpellType;
		internal var slow1:SpellType;
		internal var slow2:SpellType;
		internal var damageUndead:SpellType;
		internal var manaBurn:SpellType;		
		internal var desintegrate:SpellType;
		internal var activateHolyGround:SpellType;
		
		internal var summonSkeletonLvl1:SpellType;
		internal var summonSkeletonLvl2:SpellType;
		internal var summonSkeletonLvl3:SpellType;

		internal var lifeTapLvl1:SpellType;
		internal var drainLifeLvl1:SpellType;
		internal var drainManaLvl1:SpellType;

		internal var curseOfWeaknessLvl1:SpellType;
						
		internal var shadowFormLvl1:SpellType;

		internal var fireballLvl1:SpellType;
		internal var fireballLvl2:SpellType;		
		internal var iceShackleLvl1:SpellType;
		internal var iceCometLvl1:SpellType;
		internal var earthQuakeLvl1:SpellType;
		internal var chainLightningLvl1:SpellType;

		internal var preparateLvl1:SpellType;
		internal var elementalProtectionLvl1:SpellType;
		internal var summonTotemLvl1:SpellType;
		
		internal var arcaneBlastLvl1:SpellType;
		internal var silenceLvl1:SpellType;
		internal var silenceNeutral:SpellType;
		internal var brillianceAuraLvl1:SpellType;
		internal var mirrorImageLvl1:SpellType;
		internal var banishLvl1:SpellType;
		internal var blinkLvl1:SpellType;
		
		internal var shieldBashLvl1:SpellType;
		internal var heroicStrikeLvl1:SpellType;
		internal var thunderClapLvl1:SpellType;
		internal var cleaveLvl1:SpellType;
		internal var combatAuraLvl1:SpellType;
		internal var chargeLvl1:SpellType;
		internal var defensiveStanceLvl1:SpellType;
		
		internal var healLvl1:SpellType;
		internal var devoutionAuraLvl1:SpellType;
		internal var devoutionAuraLvl2:SpellType;
		internal var devoutionAuraLvl3:SpellType;				
		internal var holyShockLvl1:SpellType;
		internal var devineShield1Lvl1:SpellType;
		internal var cleanseLvl1:SpellType;
		internal var blessLvl1:SpellType;
		internal var holyBoltLvl1:SpellType;
		
		internal var manaBurnLvl1:SpellType;
		internal var irradiateLvl1:SpellType;
		internal var burningSwordLvl1:SpellType;
		internal var burningShield1Lvl1:SpellType;
		internal var smiteLvl1:SpellType;
		internal var sacrificeLvl1:SpellType;
		internal var lifeStealLvl1:SpellType;
		internal var poolRegenerationAuraLvl1:SpellType;
		
		internal var weaponThrowLvl1:SpellType;
		internal var bloodThirstLvl1:SpellType;
		internal var enragedSwingLvl1:SpellType;
		internal var warCryLvl1:SpellType;
		internal var deathWishLvl1:SpellType;
		internal var berserkLvl1:SpellType;
		
		internal var iceArrowLvl1:SpellType;
		internal var iceBlockLvl1:SpellType;
		internal var iceStormLvl1:SpellType;
		internal var summonWaterElementalLvl1:SpellType;
		internal var iceShieldLvl1:SpellType;
		
		internal var scorchLvl1:SpellType;
		internal var scorchLvl2:SpellType;		
		internal var fireStormLvl1:SpellType;
		
		internal var polymorphLvl1:SpellType;
		internal var drainLifeLvl2:SpellType;
		
		internal var avatarOfWarLvl1:SpellType;
		internal var imprisonLvl1:SpellType;
		internal var deathBlowLvl1:SpellType;
		internal var deathCallLvl1:SpellType;
		internal var healingLightLvl1:SpellType;
		internal var summonTotemLvl2:SpellType;
		internal var arcaneBlastLvl2:SpellType;
		internal var burningSwordLvl2:SpellType;
		internal var arcaneBlastLvl3:SpellType;
		internal var earthQuakeLvl2:SpellType;
		internal var burningShield1Lvl2:SpellType;
		internal var smiteLvl2:SpellType;
		internal var thunderClapLvl2:SpellType;
		internal var heroicStrikeLvl2:SpellType;
		internal var chainLightningLvl2:SpellType;
		internal var iceShackleLvl2:SpellType;
		internal var iceShackleLvl3:SpellType;
		internal var iceArrowLvl2:SpellType;
		internal var iceShieldLvl2:SpellType;
		internal var holyBoltLvl2:SpellType;
		internal var scorchLvl3:SpellType;
		internal var warCryLvl2:SpellType;
		internal var iceCometLvl2:SpellType;
		internal var drainLifeLvl3:SpellType;
		internal var combatAuraLvl2:SpellType;
		internal var cleaveLvl2:SpellType;
		internal var berserkLvl2:SpellType;
		internal var bloodThirstLvl2:SpellType;		
		internal var smiteLvl3:SpellType;
		internal var healLvl2:SpellType;
		internal var devineShieldLvl2:SpellType;	
		internal var holyShockLvl2:SpellType;
		internal var drainManaLvl2:SpellType;
		internal var earthQuakeLvl3:SpellType;
		
		internal var itemStunLvl1:SpellType;
		internal var etherFormLvl1:SpellType;
		internal var rejuvenateLvl1:SpellType;
		internal var discordLvl1:SpellType;
		internal var lightningStrike:SpellType;
		internal var teleportOtherLvl1:SpellType;
		internal var lightningStormLvl1:SpellType;
		internal var webLvl1:SpellType;
		internal var fireRayLvl1:SpellType;
		internal var runeLvl1:SpellType;
		internal var timeStopLong:SpellType;
		internal var timeStop:SpellType;
		internal var titanShell:SpellType;
		internal var townPortal:SpellType;
		
		internal var dashLvl1:SpellType;
		internal var trapLvl1:SpellType;
		internal var hideLvl1:SpellType;
		internal var fanOfKnivesLvl1:SpellType;
		
		internal var fanOfKnivesLvl2:SpellType;
		internal var fanOfKnivesLvl3:SpellType;	
		internal var fanOfKnivesLvl4:SpellType;		
		
		internal var sapLvl1:SpellType;	
		internal var sapLvl2:SpellType;	
		
		internal var poisonDaggerLvl1:SpellType;	
		internal var poisonDaggerLvl2:SpellType;
		internal var poisonDaggerLvl3:SpellType;
		internal var stabLvl1:SpellType;
		internal var kickLvl1:SpellType;
		internal var kickLvl2:SpellType;
		internal var summonAncientProtectorLvl1:SpellType;
		internal var banishItem:SpellType;
		internal var hideLvl2:SpellType;
		internal var shadowLvl1:SpellType;
						
		private function timeStopLongInit(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffectTimeStop = new SpellEffectTimeStop();
			effect.duration = new GameTime(0, 0, 1).value;
			effect.period = new GameTime(0, 1).value;
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.Summon;
			spell.name = "TimeStopLongLvl1";
			spell.locName = "Time Stop";
			spell.description = "";	
			spell.castType = SpellCastType.Unit;
			spell.snapToUnit = true;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 100;
			spell.targetType = TargetType.All;				
			spell.range = 6;		
			spell.cooldown = new GameTime(0, 3).value;
			spell.icon = new BitmapAsset(BitmapResources.icoSpellDispell.bitmapData);
			spell.canBeReset = false;
			game.spellManager.addSpellType(spell);	
			
			timeStopLong = spell;
		}

		private function timeStopLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffectTimeStop = new SpellEffectTimeStop();
			effect.duration = new GameTime(0, 20).value;
			effect.period = new GameTime(0, 1).value;
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.Summon;
			spell.name = "TimeStopLvl1";
			spell.locName = "Time Stop";
			spell.description = "Halts the passage of time, freezing all units in place for {effDuration0} sec. Will not affect Heroes or their summons.";	
			spell.castType = SpellCastType.Self;
			spell.snapToUnit = true;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 100;
			spell.targetType = TargetType.All;				
			spell.range = 6;		
			spell.cooldown = new GameTime(0, 120).value;
			spell.soundPack.hit = SoundResources.gong;			
			spell.icon = new BitmapAsset(BitmapResources.icoItemTimeDagger.bitmapData);
			spell.specialEffect = typesRepository.effectTypes.Time1;	
			spell.canBeReset = false;		
			game.spellManager.addSpellType(spell);	
			
			timeStop = spell;
		}
																						
		private function summonSkeletonLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffectSummon = new SpellEffectSummon();
			effect.unitTypeId = typesRepository.unitTypes.Skeleton.id;
			effect.summonLifeTime = new GameTime(0, 60).value;
			effect.summonEffectId = typesRepository.effectTypes.GroundFirePurple.id;
			effect.summonMaxCount = 1;

			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.Summon;
			spell.name = "SummonSkeletonLvl1";
			spell.locName = "Summon Skeleton (1)";
			spell.description = "Summons a Skeleton that will protect you for {summonLifeTime0} sec. More powerful Skeletons are summoned at higher skill levels. You can only summon 1 Skeleton per skill level.";	
			spell.castType = SpellCastType.Place;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 100;
			spell.targetType = TargetType.Place;			
			spell.soundPack.hit = SoundResources.magicShoot5;	
			spell.range = 6;		
			spell.cooldown = new GameTime(0, 3).value;
			spell.icon = new BitmapAsset(BitmapResources.icoSkeleton.bitmapData);
			game.spellManager.addSpellType(spell);	
			
			summonSkeletonLvl1 = spell;
		}

		private function summonSkeletonLvl2Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffectSummon = new SpellEffectSummon();
			effect.unitTypeId = typesRepository.unitTypes.SkeletonSwordsman.id;
			effect.summonLifeTime = new GameTime(0, 80).value;
			effect.summonEffectId = typesRepository.effectTypes.GroundFirePurple.id;
			effect.summonMaxCount = 2;

			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.Summon;
			spell.name = "SummonSkeletonLvl2";
			spell.locName = "Summon Skeleton (2)";
			spell.description = "Summons a Skeleton that will protect you for {summonLifeTime0} sec. More powerful Skeletons are summoned at higher skill levels. You can only summon 1 Skeleton per skill level.";	
			spell.castType = SpellCastType.Place;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 105;
			spell.range = 6;	
			spell.cooldown = new GameTime(0, 3).value;
			spell.targetType = TargetType.Place;			
			spell.soundPack.hit = SoundResources.magicShoot5;		
			spell.icon = new BitmapAsset(BitmapResources.icoSkeleton.bitmapData);
			game.spellManager.addSpellType(spell);	
			
			summonSkeletonLvl2 = spell;
		}
		
		private function summonSkeletonLvl3Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffectSummon = new SpellEffectSummon();
			effect.unitTypeId = typesRepository.unitTypes.SkeletonKing.id;
			effect.summonLifeTime = new GameTime(0, 80).value;
			effect.summonEffectId = typesRepository.effectTypes.GroundFirePurple.id;
			effect.summonMaxCount = 3;

			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.Summon;
			spell.name = "SummonSkeletonLvl3";
			spell.locName = "Summon Skeleton (3)";
			spell.description = "Summons a Skeleton that will protect you for {summonLifeTime0} sec. More powerfull Skeletons are summoned at higher skill levels. You can only summon 1 Skeleton per skill level.";	
			spell.castType = SpellCastType.Place;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 110;
			spell.targetType = TargetType.Place;	
			spell.range = 6;
			spell.cooldown = new GameTime(0, 3).value;		
			spell.soundPack.hit = SoundResources.magicShoot5;			
			spell.icon = new BitmapAsset(BitmapResources.icoSkeleton.bitmapData);
			game.spellManager.addSpellType(spell);	
			
			summonSkeletonLvl3 = spell;
		}

		private function lifeTapLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.minChange = 55;
			effect.propertyId = UnitProperties.Mana;
			effect.opType = SpellEffectOperationType.Add;
			effect.affectedByMagicResistance = false;
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.HealthToMana;
			spell.name = "LiveTapLvl1";
			spell.locName = "Life Tap";
			spell.description = "You Life Tap for {cost} of your health, converting it to {minChange0} points of mana.";	
			spell.castType = SpellCastType.Self;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 50;
			spell.cooldown = new GameTime(0, 1).value;
			spell.costProperty = UnitProperties.Health;
			spell.targetType = TargetType.Self;			
			spell.soundPack.hit = SoundResources.magicHit8;			
			spell.icon = new BitmapAsset(BitmapResources.icoRuneMagnetta.bitmapData);
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.LeafsDark;
			game.spellManager.addSpellType(spell);	
			
			lifeTapLvl1 = spell;
		}
		
		private function drainLifeLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffectDrain = new SpellEffectDrain();
			effect.minChange = -42;
			effect.propertyId = UnitProperties.Health;
			effect.opType = SpellEffectOperationType.Add;
			effect.duration = new GameTime(0, 1).value;
			effect.stackable = false;
			effect.canReset = false;
			effect.period = new GameTime(0, 1).value;
			effect.tansferCoeff = 0.7;

			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.DrainHealth;
			spell.range = 6;
			spell.name = "DrainHealthLvl1";
			spell.locName = "Drain Health (1)";
			spell.description = "Drains the life from the target, causing {minChange0} damage and transferring 60% of that to the caster every {period0} sec. Lasts {duration} sec.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 90;
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.magicHit8;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellDrainLife.bitmapData);
			spell.specialGeneratedEffect = typesRepository.effectTypes.GeneratedRayGreen;
			spell.specialEffect = typesRepository.effectTypes.SparksGreenSnap;
			spell.duration = new GameTime(0, 3).value;
			spell.sfxDuration = spell.duration;
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 10).value;
			spell.affectBuildings = false;
			game.spellManager.addSpellType(spell);	
			
			drainLifeLvl1 = spell;
		}

		private function drainLifeLvl2Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffectDrainSummon = new SpellEffectDrainSummon();
			effect.minChange = -44;
			effect.propertyId = UnitProperties.Health;
			effect.opType = SpellEffectOperationType.Add;
			effect.duration = new GameTime(0, 1).value;
			effect.stackable = false;
			effect.canReset = false;
			effect.period = new GameTime(0, 1).value;
			effect.unitTypeId = typesRepository.unitTypes.SkeletonDrain.id;
			effect.summonLifeTime = new GameTime(0, 60).value;
			effect.summonEffectId = typesRepository.effectTypes.GroundFirePurple.id;
			effect.tansferCoeff = 0.65;
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.DrainHealth;
			spell.range = 6;
			spell.name = "DrainHealthLvl2";
			spell.locName = "Drain Health (2)";
			spell.description = "Drains the life from the target, causing {minChange0} damage and transferring 65% of that the caster every {period0} sec. Lasts {duration} sec. If target dies during drain it will be raised as Skeleton.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 100;
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.magicHit8;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellDrainLife.bitmapData);
			spell.duration = new GameTime(0, 3).value;
			spell.specialGeneratedEffect = typesRepository.effectTypes.GeneratedRayGreen;
			spell.specialEffect = typesRepository.effectTypes.SparksGreenSnap;
			spell.sfxDuration = spell.duration;			
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 10).value;
			spell.affectBuildings = false;
			game.spellManager.addSpellType(spell);	
			
			drainLifeLvl2 = spell;
		}

		private function drainLifeLvl3Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffectDrainSummon = new SpellEffectDrainSummon();
			effect.minChange = -62;
			effect.propertyId = UnitProperties.Health;
			effect.opType = SpellEffectOperationType.Add;
			effect.duration = new GameTime(0, 1).value;
			effect.stackable = false;
			effect.canReset = false;
			effect.period = new GameTime(0, 1).value;
			effect.unitTypeId = typesRepository.unitTypes.SkeletonDrain.id;
			effect.summonLifeTime = new GameTime(0, 60).value;
			effect.summonEffectId = typesRepository.effectTypes.GroundFirePurple.id;
			effect.tansferCoeff = 0.65;
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.DrainHealth;
			spell.range = 6;
			spell.name = "DrainHealthLvl2";
			spell.locName = "Drain Health (3)";
			spell.description = "Drains the life from the target, causing {minChange0} damage and transferring 70% of that to the caster every {period0} sec. Lasts {duration} sec. If target dies during drain it will be raised as Skeleton.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 100;
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.magicHit8;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellDrainLife.bitmapData);
			spell.duration = new GameTime(0, 3).value;
			spell.specialGeneratedEffect = typesRepository.effectTypes.GeneratedRayGreen;
			spell.specialEffect = typesRepository.effectTypes.SparksGreenSnap;
			spell.sfxDuration = spell.duration;	
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 10).value;
			spell.affectBuildings = false;
			game.spellManager.addSpellType(spell);	
			
			drainLifeLvl3 = spell;
		}
				
		private function drainManaLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffectDrain = new SpellEffectDrain();
			effect.minChange = -2;
			effect.propertyId = UnitProperties.Mana;
			effect.coeficientPropertyId = UnitProperties.Mana;
			effect.opType = SpellEffectOperationType.Add;
			effect.duration = new GameTime(0, 1).value;
			effect.stackable = false;
			effect.canReset = false;
			effect.period = new GameTime(0, 1).value;

			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.DrainMana;
			spell.range = 6;
			spell.name = "DrainManaLvl1";
			spell.locName = " Drain Mana";
			spell.description = "Drains the mana from the target restoring {minChange0}% of the caster's mana every {period0} sec. Lasts {duration} sec.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 45;
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.magicHit8;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellDrainMana.bitmapData);
			spell.duration = new GameTime(0, 5).value;
			spell.specialGeneratedEffect = typesRepository.effectTypes.GeneratedRayBlue;
			spell.specialEffect = typesRepository.effectTypes.SparksBlueSnap;
			spell.sfxDuration = spell.duration;
			spell.cooldown = new GameTime(0, 15).value;
			spell.snapToUnit = true;
			spell.affectBuildings = false;
			game.spellManager.addSpellType(spell);	
			
			drainManaLvl1 = spell;
		}

		private function drainManaLvl2Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffectDrain = new SpellEffectDrain();
			effect.minChange = -4;
			effect.propertyId = UnitProperties.Mana;
			effect.coeficientPropertyId = UnitProperties.Mana;
			effect.opType = SpellEffectOperationType.Add;
			effect.duration = new GameTime(0, 1).value;
			effect.stackable = false;
			effect.canReset = false;
			effect.period = new GameTime(0, 1).value;

			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.DrainMana;
			spell.range = 6;
			spell.name = "DrainManaLvl2";
			spell.locName = " Drain Mana (2)";
			spell.description = "Drains the mana from the target restoring {minChange0}% of the caster's mana every {period0} sec. Lasts {duration} sec.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 65;
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.magicHit8;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellDrainMana.bitmapData);
			spell.duration = new GameTime(0, 5).value;
			spell.specialGeneratedEffect = typesRepository.effectTypes.GeneratedRayBlue;
			spell.specialEffect = typesRepository.effectTypes.SparksBlueSnap;
			spell.sfxDuration = spell.duration;
			spell.cooldown = new GameTime(0, 15).value;
			spell.snapToUnit = true;
			spell.affectBuildings = false;
			game.spellManager.addSpellType(spell);	
			
			drainManaLvl2 = spell;
		}
				
		private function shadowFormLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffectChangeModel = new SpellEffectChangeModel();
			effect.modelName = "UnitShadowForm";
			effect.duration = new GameTime(0, 60).value;
			effect.period = effect.duration;
			effect.stackable = false;
			
			// set armor
			var effect1:SpellEffect = new SpellEffect();
			effect1.propertyId = UnitProperties.Armor;
			effect1.duration = new GameTime(0, 45).value;
			effect1.minChange = 35;	
			effect1.stackable = false;
			effect1.affectedByMagicResistance = false;
			
			// prohibit attacks
			var effect2:SpellEffect = new SpellEffect();
			effect2.propertyId = UnitProperties.AttackRange;
			effect2.duration = new GameTime(0, 45).value;
			effect2.minChange = 0;
			effect2.opType = SpellEffectOperationType.Set;	
			effect2.stackable = false;
			effect2.affectedByMagicResistance = false;			

			var effect3:SpellEffect = new SpellEffect();
			effect3.propertyId = UnitProperties.ManaRegen;
			effect3.coeficientPropertyId = UnitProperties.ManaRegen;			
			effect3.duration = new GameTime(0, 45).value;
			effect3.stackable = false;
			effect3.minChange = 10;
			effect3.opType = SpellEffectOperationType.Add;
			effect3.affectedByMagicResistance = false;				
									
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1, effect2, effect3] );
			spell.aiHint = AiHintType.Ultimate;
			spell.name = "ShadowFormLvl1";
			spell.locName = "Shadow Form";
			spell.description = "Assume a Shadowform, making You very resilient to physical attacks and increasing your mana regeneration by 10%. In Shadowform You can not attack, but spellcasting is still possible. Lasts {effDuration0} sec.";	
			spell.castType = SpellCastType.Self;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 50;
			spell.costProperty = UnitProperties.Mana;
			spell.targetType = TargetType.Self;			
			spell.soundPack.hit = SoundResources.magicHit8;	
			spell.cooldown = new GameTime(0, 120).value;		
			spell.icon = new BitmapAsset(BitmapResources.icoShadow.bitmapData);
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.LeafsDark;
			spell.snapToUnit = true;
			game.spellManager.addSpellType(spell);	
			
			shadowFormLvl1 = spell;
		}
		
		private function etherFormLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffectColorTransform = new SpellEffectColorTransform();
			effect.a = 0.4;
			effect.r = 0;
			effect.g = 0;
			effect.b = 0;
			effect.duration = new GameTime(0, 3.2).value;
			effect.period =  new GameTime(0, 1).value;
			effect.stackable = false;
			
			// set armor
			var effect1:SpellEffect = new SpellEffect();
			effect1.propertyId = UnitProperties.ArmorType;
			effect1.duration = effect.duration;
			effect1.minChange = ArmorType.DIVINE;	
			effect1.stackable = false;
			effect1.opType = SpellEffectOperationType.Set;
			effect1.affectedByMagicResistance = false;
			
			// prohibit attacks
			var effect2:SpellEffect = new SpellEffect();
			effect2.propertyId = UnitProperties.AttackRange;
			effect2.duration = effect.duration;
			effect2.minChange = 0;
			effect2.opType = SpellEffectOperationType.Set;	
			effect2.stackable = false;
			effect2.affectedByMagicResistance = false;			

			var effect3:SpellEffect = new SpellEffect();
			effect3.propertyId = UnitProperties.MagicRes;
			effect3.minChange = 0;
			effect3.duration = effect.duration;			
			effect3.opType = SpellEffectOperationType.Set;
			effect3.affectedByMagicResistance = false;				

			var effect4:SpellEffect = new SpellEffect();
			effect4.propertyId = UnitProperties.MoveSpeed;
			effect4.coeficientPropertyId = UnitProperties.MoveSpeed;			
			effect4.duration = effect.duration;
			effect4.minChange = 100;
			effect4.opType = SpellEffectOperationType.Add;	
			effect4.stackable = false;
			effect4.affectedByMagicResistance = false;	
												
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1, effect2, effect3, effect4] );
			spell.aiHint = AiHintType.Ultimate;
			spell.name = "EtherFormLvl1";
			spell.locName = "Ether Form";
			spell.description = "Converts target or caster into etherial form for {effDuration1} sec. In etherial form target can not attack or be attacked but still can cast spells. Magic resistance is set to 0 and movement speed is reduced by {minChange4}%. Lasts {effDuration0} sec.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 80;
			spell.range = 4;
			spell.costProperty = UnitProperties.Mana;
			spell.targetType = TargetType.All;			
			spell.soundPack.hit = SoundResources.magicHit8;	
			spell.cooldown = new GameTime(0, 20).value;		
			spell.icon = new BitmapAsset(BitmapResources.icoItemEtherSword.bitmapData);
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.LeafsDark;
			spell.snapToUnit = true;
			spell.affectBuildings = false;
			game.spellManager.addSpellType(spell);	
			
			etherFormLvl1 = spell;
		}		
		
		private function curseOfWeaknessLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.minChange = -15;
			effect.propertyId = UnitProperties.AttackDmgMin;
			effect.coeficientPropertyId = UnitProperties.AttackDmgMin;
			effect.opType = SpellEffectOperationType.Add;
			effect.duration = new GameTime(0, 20).value;
			effect.stackable = false;

			var effect1:SpellEffect = new SpellEffect();
			effect1.minChange = -15;
			effect1.coeficientPropertyId = UnitProperties.AttackDmgMax;
			effect1.propertyId = UnitProperties.AttackDmgMax;
			effect1.opType = SpellEffectOperationType.Add;
			effect1.duration = new GameTime(0, 20).value;
			effect1.stackable = false;
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1] );
			spell.aiHint = AiHintType.Debuff;
			spell.range = 6;
			spell.name = "CurseOfWeaknessLvl1";
			spell.locName = "Curse Of Weakness";
			spell.description = "Physical damage done by all enemies in selected area is reduced by {minChange0}% for {effDuration0} sec.";	
			spell.castType = SpellCastType.Place;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 75;
			spell.radius = 3;
			spell.cooldown = new GameTime(0, 15).value;
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.magicHit8;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellCurse.bitmapData);
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Acid;
			spell.affectBuildings = false;
			game.spellManager.addSpellType(spell);	
			
			curseOfWeaknessLvl1 = spell;
		}

		private function fireballLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.minChange = -100;
			effect.maxChange = -120;
			effect.propertyId = UnitProperties.Health;
			effect.dmgSubtype = SpellDamageSubtype.Fire;

			var effect1:SpellEffect = new SpellEffect();
			effect1.minChange = -2;
			effect1.maxChange = -2;
			effect1.propertyId = UnitProperties.Health;
			effect1.dmgSubtype = SpellDamageSubtype.Fire;
			effect1.duration = new GameTime(0, 5).value;
			effect1.period =  new GameTime(0, 1).value;
			effect1.dmgSubtype = SpellDamageSubtype.Fire;
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1] );
			spell.aiHint = AiHintType.Attack;
			spell.range = 9;
			spell.name = "FireballLvl1";
			spell.locName = "Fireball";
			spell.description = "Hurls a fiery ball that causes {minChange0} to {maxChange0} Magic damage in selected area and immolates targets for 10 damage over {effDuration1} sec. May remove freezing effects from the target.";
			spell.castType = SpellCastType.Place;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 100;
			spell.targetType = TargetType.Enemy;	
			spell.soundPack.attack = SoundResources.magicShoot2;							
			spell.soundPack.hit = SoundResources.magicHit2;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellFireball.bitmapData);
			spell.specialEffect = typesRepository.effectTypes.FireExplosion1;
			spell.projectileSpeed = 4;
			spell.projectileModel = Game.instance().spriteRepository.getByName("ProjectileFireball1");
			spell.radius = 2;
			spell.cooldown = new GameTime(0, 11).value;
			game.spellManager.addSpellType(spell);	
			
			fireballLvl1 = spell;
		}

		private function fireballLvl2Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.minChange = -140;
			effect.maxChange = -160;
			effect.propertyId = UnitProperties.Health;
			effect.dmgSubtype = SpellDamageSubtype.Fire;

			var effect1:SpellEffect = new SpellEffect();
			effect1.minChange = -6;
			effect1.maxChange = -6;
			effect1.propertyId = UnitProperties.Health;
			effect1.dmgSubtype = SpellDamageSubtype.Fire;
			effect1.duration = new GameTime(0, 5).value;
			effect1.period =  new GameTime(0, 1).value;
			effect1.dmgSubtype = SpellDamageSubtype.Fire;
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1] );
			spell.aiHint = AiHintType.Attack;
			spell.range = 9;
			spell.name = "FireballLvl2";
			spell.locName = "Fireball (2)";
			spell.description = "Hurls a fiery ball that causes {minChange0} to {maxChange0} Magic damage in selected area and immolates targets for 30 damage over {effDuration1} sec. May remove freezing effects from the target.";	
			spell.castType = SpellCastType.Place;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 110;
			spell.targetType = TargetType.Enemy;	
			spell.soundPack.attack = SoundResources.magicShoot2;							
			spell.soundPack.hit = SoundResources.magicHit2;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellFireball.bitmapData);
			spell.specialEffect = typesRepository.effectTypes.FireExplosion1;
			spell.projectileSpeed = 4;
			spell.projectileModel = Game.instance().spriteRepository.getByName("ProjectileFireball1");
			spell.radius = 2;
			spell.cooldown = new GameTime(0, 11).value;
			game.spellManager.addSpellType(spell);	
			
			fireballLvl2 = spell;
		}
		
		private function iceShackleLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.minChange = -90;
			effect.maxChange = -110;
			effect.dmgSubtype = SpellDamageSubtype.Frost;			
			effect.propertyId = UnitProperties.Health;
			effect.critChance = 3;
			
			var effect1:SpellEffect = new SpellEffect();
			effect1.minChange = 200;
			effect1.propertyId = UnitProperties.MoveSpeed;
			effect1.coeficientPropertyId = UnitProperties.MoveSpeed;
			effect1.duration = new GameTime(0, 5).value; 
			effect1.stackable = false;
			effect1.dmgSubtype = SpellDamageSubtype.Frost;
			effect1.opType = SpellEffectOperationType.Set;			

			var effect2:SpellEffect = new SpellEffect();
			effect2.minChange = 200;
			effect2.propertyId = UnitProperties.AttackSpeed;
			effect2.coeficientPropertyId = UnitProperties.AttackSpeed;
			effect2.duration = new GameTime(0, 5).value; 
			effect2.dmgSubtype = SpellDamageSubtype.Frost;
			effect2.opType = SpellEffectOperationType.Set;		

			var effect3:SpellEffectColorTransform = new SpellEffectColorTransform();
			effect3.duration = effect1.duration;
			effect3.period = new GameTime(0, 1).value;

			var effect4:SpellEffect = new SpellEffect();
			effect4.minChange = 200;
			effect4.propertyId = UnitProperties.CastSpeed;
			effect4.coeficientPropertyId = UnitProperties.CastSpeed;
			effect4.duration = new GameTime(0, 5).value; 
			effect4.dmgSubtype = SpellDamageSubtype.Frost;
			effect4.opType = SpellEffectOperationType.Set;	
									
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1, effect2, effect3, effect4] );
			spell.aiHint = AiHintType.Attack;
			spell.range = 9;
			spell.name = "IceShackleLvl1";
			spell.locName = "Ice Shackle";
			spell.description = "Inflicts {minChange0} to {maxChange0} Frost damage to target, slowing attack and move speed by {minChangePerc1}% for up to {effDuration1} sec.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 100;
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.magicHit1;
			spell.cooldown = new GameTime(0, 15).value;		
			spell.icon = new BitmapAsset(BitmapResources.icoSpellIceFace.bitmapData);
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Ice1;
			spell.specialEffect = typesRepository.effectTypes.Sparks3;
			spell.snapToUnit = true;
			spell.affectBuildings = false;
			game.spellManager.addSpellType(spell);	
			
			iceShackleLvl1 = spell;
		}

		private function iceShackleLvl2Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.minChange = -130;
			effect.maxChange = -150;
			effect.dmgSubtype = SpellDamageSubtype.Frost;			
			effect.propertyId = UnitProperties.Health;
			effect.critChance = 3;
			
			var effect1:SpellEffect = new SpellEffect();
			effect1.minChange = 200;
			effect1.propertyId = UnitProperties.MoveSpeed;
			effect1.coeficientPropertyId = UnitProperties.MoveSpeed;
			effect1.duration = new GameTime(0, 6.5).value; 
			effect1.stackable = false;
			effect1.dmgSubtype = SpellDamageSubtype.Frost;
			effect1.opType = SpellEffectOperationType.Set;			

			var effect2:SpellEffect = new SpellEffect();
			effect2.minChange = 200;
			effect2.propertyId = UnitProperties.AttackSpeed;
			effect2.coeficientPropertyId = UnitProperties.AttackSpeed;
			effect2.duration = new GameTime(0, 6.5).value; 
			effect2.dmgSubtype = SpellDamageSubtype.Frost;
			effect2.opType = SpellEffectOperationType.Set;		

			var effect3:SpellEffectColorTransform = new SpellEffectColorTransform();
			effect3.duration = effect1.duration;
			effect3.period = new GameTime(0, 1).value;

			var effect4:SpellEffect = new SpellEffect();
			effect4.minChange = 200;
			effect4.propertyId = UnitProperties.CastSpeed;
			effect4.coeficientPropertyId = UnitProperties.CastSpeed;
			effect4.duration = new GameTime(0, 6.5).value; 
			effect4.dmgSubtype = SpellDamageSubtype.Frost;
			effect4.opType = SpellEffectOperationType.Set;
									
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1, effect2, effect3, effect4] );
			spell.aiHint = AiHintType.Attack;
			spell.range = 9;
			spell.name = "IceShackleLvl2";
			spell.locName = "Ice Shackle (2)";
			spell.description = "Inflicts {minChange0} to {maxChange0} Frost damage to target, slowing attack and move speed by {minChangePerc1}% for up to {effDuration1} sec.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 100;
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.magicHit1;
			spell.cooldown = new GameTime(0, 15).value;		
			spell.icon = new BitmapAsset(BitmapResources.icoSpellIceFace.bitmapData);
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Ice1;
			spell.specialEffect = typesRepository.effectTypes.Sparks3;
			spell.snapToUnit = true;
			spell.affectBuildings = false;
			game.spellManager.addSpellType(spell);	
			
			iceShackleLvl2 = spell;
		}

		private function iceShackleLvl3Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.minChange = -160;
			effect.maxChange = -210;
			effect.dmgSubtype = SpellDamageSubtype.Frost;			
			effect.propertyId = UnitProperties.Health;
			effect.critChance = 3;
			
			var effect1:SpellEffect = new SpellEffect();
			effect1.minChange = 200;
			effect1.propertyId = UnitProperties.MoveSpeed;
			effect1.coeficientPropertyId = UnitProperties.MoveSpeed;
			effect1.duration = new GameTime(0, 8).value; 
			effect1.stackable = false;
			effect1.dmgSubtype = SpellDamageSubtype.Frost;
			effect1.opType = SpellEffectOperationType.Set;			

			var effect2:SpellEffect = new SpellEffect();
			effect2.minChange = 200;
			effect2.propertyId = UnitProperties.AttackSpeed;
			effect2.coeficientPropertyId = UnitProperties.AttackSpeed;
			effect2.duration = new GameTime(0, 8).value; 
			effect2.dmgSubtype = SpellDamageSubtype.Frost;
			effect2.opType = SpellEffectOperationType.Set;		

			var effect3:SpellEffectColorTransform = new SpellEffectColorTransform();
			effect3.duration = effect1.duration;
			effect3.period = new GameTime(0, 1).value;

			var effect4:SpellEffect = new SpellEffect();
			effect4.minChange = 200;
			effect4.propertyId = UnitProperties.CastSpeed;
			effect4.coeficientPropertyId = UnitProperties.CastSpeed;
			effect4.duration = new GameTime(0, 8).value; 
			effect4.dmgSubtype = SpellDamageSubtype.Frost;
			effect4.opType = SpellEffectOperationType.Set;
									
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1, effect2, effect3, effect4] );
			spell.aiHint = AiHintType.Attack;
			spell.range = 9;
			spell.name = "IceShackleLvl3";
			spell.locName = "Ice Shackle (3)";
			spell.description = "Inflicts {minChange0} to {maxChange0} Frost damage to target, slowing attack and move speed by {minChangePerc1}% for up to {effDuration1} sec.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 110;
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.magicHit1;
			spell.cooldown = new GameTime(0, 15).value;		
			spell.icon = new BitmapAsset(BitmapResources.icoSpellIceFace.bitmapData);
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Ice1;
			spell.specialEffect = typesRepository.effectTypes.Sparks3;
			spell.snapToUnit = true;
			spell.affectBuildings = false;
			game.spellManager.addSpellType(spell);	
			
			iceShackleLvl3 = spell;
		}
				
		private function iceCometLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.minChange = -80;
			effect.maxChange = -90;
			effect.dmgSubtype = SpellDamageSubtype.Frost;			
			effect.propertyId = UnitProperties.Health;
			
			var effect1:SpellEffect = new SpellEffect();
			effect1.minChange = 0;
			effect1.propertyId = UnitProperties.CanMove;
			effect1.opType = SpellEffectOperationType.Set;
			effect1.duration = new GameTime(0, 5).value;
			effect1.affectedByMagicResistance = false; 			

			var effect2:SpellEffect = new SpellEffect();
			effect2.minChange = 0;
			effect2.propertyId = UnitProperties.AttackRange;
			effect2.opType = SpellEffectOperationType.Set;
			effect2.duration = new GameTime(0, 5).value; 

			var effect3:SpellEffect = new SpellEffect();
			effect3.minChange = 100;
			effect3.propertyId = UnitProperties.MoveSpeed;
			effect3.coeficientPropertyId = UnitProperties.MoveSpeed;
			effect3.duration = new GameTime(0, 8).value; 
			effect3.affectedByMagicResistance = false;			

			var effect4:SpellEffectColorTransform = new SpellEffectColorTransform();
			effect4.duration = effect1.duration;
			effect4.period =  new GameTime(0, 1).value;

			var effect5:SpellEffect = new SpellEffect();
			effect5.minChange = Spell.MAX_CAST_DELAY;
			effect5.propertyId = UnitProperties.CastDelay;
			effect5.duration = new GameTime(0, 6).value; 
			effect5.affectedByMagicResistance = false;	
						
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1, effect2, effect3, effect4, effect5] );
			spell.aiHint = AiHintType.Attack;
			spell.range = 8;
			spell.name = "IceCometLvl1";
			spell.locName = "Ice Comet";
			spell.description = "Inflicts {minChange0} to {maxChange0} Frost damage to enemies in selected area, freezing them in place for up to {effDuration1} sec.";	
			spell.castType = SpellCastType.Place;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 110;
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.magicHit4;		
			spell.soundPack.attack = SoundResources.magicShoot4;					
			spell.icon = new BitmapAsset(BitmapResources.icoSpellIceComet.bitmapData);
			spell.specialEffect = typesRepository.effectTypes.Ice2;
			spell.radius = 2;
			spell.projectileSpeed = 6;
			spell.cooldown = new GameTime(0, 20).value;
			spell.projectileModel = Game.instance().spriteRepository.getByName("ProjectileWaterBall");
			spell.affectBuildings = false;
			game.spellManager.addSpellType(spell);	
			
			iceCometLvl1 = spell;
		}

		private function iceCometLvl2Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.minChange = -100;
			effect.maxChange = -110;
			effect.dmgSubtype = SpellDamageSubtype.Frost;			
			effect.propertyId = UnitProperties.Health;
			
			var effect1:SpellEffect = new SpellEffect();
			effect1.minChange = Constants.FALSE;
			effect1.propertyId = UnitProperties.CanMove;
			effect1.opType = SpellEffectOperationType.Set;
			effect1.duration = new GameTime(0, 6).value; 
			effect1.affectedByMagicResistance = false; 							

			var effect2:SpellEffect = new SpellEffect();
			effect2.minChange = 0;
			effect2.propertyId = UnitProperties.AttackRange;
			effect2.opType = SpellEffectOperationType.Set;
			effect2.duration = new GameTime(0, 6).value; 

			var effect3:SpellEffect = new SpellEffect();
			effect3.minChange = 100;
			effect3.propertyId = UnitProperties.MoveSpeed;
			effect3.coeficientPropertyId = UnitProperties.MoveSpeed;
			effect3.duration = new GameTime(0, 10).value; 
			effect3.affectedByMagicResistance = false;				

			var effect4:SpellEffectColorTransform = new SpellEffectColorTransform();
			effect4.duration = effect1.duration;
			effect4.period = new GameTime(0, 1).value;

			var effect5:SpellEffect = new SpellEffect();
			effect5.minChange = Spell.MAX_CAST_DELAY;
			effect5.propertyId = UnitProperties.CastDelay;
			effect5.duration = new GameTime(0, 6).value; 
			effect5.affectedByMagicResistance = false;	
						
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1, effect2, effect3, effect4, effect5] );
			spell.aiHint = AiHintType.Attack;
			spell.range = 8;
			spell.name = "IceCometLvl1";
			spell.locName = "Ice Comet";
			spell.description = "Inflicts {minChange0} to {maxChange0} Frost damage to enemies in selected area, freezing them in place for up to {effDuration1} sec.";	
			spell.castType = SpellCastType.Place;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 110;
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.magicHit4;		
			spell.soundPack.attack = SoundResources.magicShoot4;					
			spell.icon = new BitmapAsset(BitmapResources.icoSpellIceComet.bitmapData);
			spell.specialEffect = typesRepository.effectTypes.Ice2;
			spell.radius = 2;
			spell.projectileSpeed = 6;
			spell.cooldown = new GameTime(0, 15).value;
			spell.projectileModel = Game.instance().spriteRepository.getByName("ProjectileWaterBall");
			spell.affectBuildings = false;
			game.spellManager.addSpellType(spell);	
			
			iceCometLvl2 = spell;
		}
				
		private function earthQuakeLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.minChange = -100;
			effect.maxChange = -120;
			effect.propertyId = UnitProperties.Health;
			effect.dmgType = DamageType.Siedge;

			var effect1:SpellEffect = new SpellEffect();
			effect1.minChange = 40;
			effect1.propertyId = UnitProperties.MoveSpeed;
			effect1.coeficientPropertyId = UnitProperties.MoveSpeed;
			effect1.duration = new GameTime(0, 4).value; 

			var effect2:SpellEffect = new SpellEffect();
			effect2.minChange = 0;
			effect2.propertyId = UnitProperties.AttackRange;
			effect2.duration = new GameTime(0, 1.5).value;
			effect2.opType = SpellEffectOperationType.Set;
						
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1, effect2] );
			spell.aiHint = AiHintType.Attack;
			spell.range = 8;
			spell.name = "EarthQuakeLvl1";
			spell.locName = "Earthquake";
			spell.description = "You cause the earth at the target location to tremble and break, dealing {minChange0} to {maxChange0} Siege damage and slowing enemies by {minChange1} for {effDuration1} sec.";	
			spell.castType = SpellCastType.Place;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 100;
			spell.cooldown = new GameTime(0, 20).value;
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.eathquake;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellEathQuake.bitmapData);
			spell.specialEffect = typesRepository.effectTypes.Quake;
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Stun;
			spell.radius = 3;
			spell.quakeDuration = Util.secToFrames(1);
			game.spellManager.addSpellType(spell);	
			
			earthQuakeLvl1 = spell;
		}

		private function earthQuakeLvl2Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.minChange = -120;
			effect.maxChange = -150;
			effect.propertyId = UnitProperties.Health;
			effect.dmgType = DamageType.Siedge;

			var effect1:SpellEffect = new SpellEffect();
			effect1.minChange = 40;
			effect1.propertyId = UnitProperties.MoveSpeed;
			effect1.coeficientPropertyId = UnitProperties.MoveSpeed;
			effect1.duration = new GameTime(0, 3.5).value; 

			var effect2:SpellEffect = new SpellEffect();
			effect2.minChange = 0;
			effect2.propertyId = UnitProperties.AttackRange;
			effect2.duration = new GameTime(0, 1.5).value;
			effect2.opType = SpellEffectOperationType.Set;
									
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1, effect2] );
			spell.aiHint = AiHintType.Attack;
			spell.range = 8;
			spell.name = "EarthQuakeLvl2";
			spell.locName = "Earthquake (2)";
			spell.description = "You cause the earth at the target location to tremble and break, dealing {minChange0} to {maxChange0} Siege damage and dazing enemies by {minChange1} for {effDuration1} sec.";	
			spell.castType = SpellCastType.Place;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 110;
			spell.cooldown = new GameTime(0, 20).value;
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.eathquake;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellEathQuake.bitmapData);
			spell.specialEffect = typesRepository.effectTypes.Quake;
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Stun;
			spell.radius = 3;
			spell.quakeDuration = Util.secToFrames(1);
			game.spellManager.addSpellType(spell);	
			
			earthQuakeLvl2 = spell;
		}

		private function earthQuakeLvl3Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.minChange = -140;
			effect.maxChange = -170;
			effect.propertyId = UnitProperties.Health;
			effect.dmgType = DamageType.Siedge;

			var effect1:SpellEffect = new SpellEffect();
			effect1.minChange = 40;
			effect1.propertyId = UnitProperties.MoveSpeed;
			effect1.coeficientPropertyId = UnitProperties.MoveSpeed;
			effect1.duration = new GameTime(0, 3.0).value; 
			effect1.affectedByMagicResistance = false;

			var effect2:SpellEffect = new SpellEffect();
			effect2.minChange = 0;
			effect2.propertyId = UnitProperties.AttackRange;
			effect2.duration = new GameTime(0, 3.0).value;
			effect2.opType = SpellEffectOperationType.Set;
			effect2.affectedByMagicResistance = false;
			
			var effect3:SpellEffect = new SpellEffect();
			effect2.minChange = Spell.MAX_CAST_DELAY;
			effect2.propertyId = UnitProperties.CastDelay;
			effect2.duration = new GameTime(0, 3.0).value;
			effect2.opType = SpellEffectOperationType.Set;
									
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1, effect2, effect3] );
			spell.aiHint = AiHintType.Attack;
			spell.range = 8;
			spell.name = "EarthQuakeLvl3";
			spell.locName = "Earthquake (3)";
			spell.description = "You cause the earth at the target location to tremble and break, dealing {minChange0} to {maxChange0} Siege damage and stunning enemies by {minChange1} for {effDuration1} sec.";	
			spell.castType = SpellCastType.Place;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 110;
			spell.cooldown = new GameTime(0, 20).value;
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.eathquake;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellEathQuake.bitmapData);
			spell.specialEffect = typesRepository.effectTypes.Quake;
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Stun;
			spell.radius = 3;
			spell.quakeDuration = Util.secToFrames(1);
			game.spellManager.addSpellType(spell);	
			
			earthQuakeLvl3 = spell;
		}
				
		private function preparateLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffectResetCooldowns = new SpellEffectResetCooldowns();

			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.Ultimate;
			spell.name = "PreparateLvl1";
			spell.locName = "Preparate";
			spell.description = "Instantly resets all spells cooldowns.";	
			spell.castType = SpellCastType.Self;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 30;
			spell.targetType = TargetType.Self;			
			spell.soundPack.hit = SoundResources.magicHit7;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellPreparate.bitmapData);
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Time1;
			spell.cooldown = new GameTime(0, 120).value;
			spell.canBeReset = false;
			game.spellManager.addSpellType(spell);	
			
			preparateLvl1 = spell;
		}
		
		private function runeLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffectResetCooldowns = new SpellEffectResetCooldowns();
			
			var effect1:SpellEffect = new SpellEffect();
			effect1.minChange = 50;
			effect1.propertyId = UnitProperties.CastSpeed;	
			effect1.coeficientPropertyId = UnitProperties.CastSpeed;
			effect1.opType = SpellEffectOperationType.Set;
			effect1.affectedByMagicResistance = false;
			effect1.duration = Util.secToFrames(15);

			var effect2:SpellEffect = new SpellEffect();
			effect2.minChange = 50;
			effect2.propertyId = UnitProperties.CastDelay;	
			effect2.coeficientPropertyId = UnitProperties.CastSpeed;
			effect2.opType = SpellEffectOperationType.Set;
			effect2.duration = Util.secToFrames(15);
			effect2.affectedByMagicResistance = false;			
			
			var effect3:SpellEffect = new SpellEffect();
			effect3.minChange = 30;
			effect3.coeficientPropertyId = UnitProperties.SpellBonus;
			effect3.opType = SpellEffectOperationType.Add;
			effect3.duration = Util.secToFrames(15);
			effect3.affectedByMagicResistance = false;														

			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1, effect2, effect3] );
			spell.aiHint = AiHintType.Ultimate;
			spell.name = "RuneLvl1";
			spell.locName = "Rune";
			spell.description = "Instantly resets all spells cooldowns. For {effDuration1} sec casting speed is doubled and all spells deal {minChange3}% more damage.";	
			spell.castType = SpellCastType.Self;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 30;
			spell.targetType = TargetType.Self;			
			spell.soundPack.hit = SoundResources.magicHit7;			
			spell.icon = new BitmapAsset(BitmapResources.icoItemRuneAmulet.bitmapData);
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Time1;
			spell.cooldown = new GameTime(0, 120).value;
			spell.canBeReset = false;
			game.spellManager.addSpellType(spell);	
			
			runeLvl1 = spell;
		}		
		
		private function chainLightningLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect2:SpellEffect = new SpellEffect();
			effect2.minChange = -100;
			effect2.minChange = -110;
			effect2.propertyId = UnitProperties.Health;
			
			var lightning:SpellType = new SpellType();
			lightning.addEffects( [effect2] );
			lightning.aiHint = AiHintType.Attack;
			lightning.range = 4;
			lightning.name = "ChainLightningForkLvl1";
			lightning.locName = "SpChainLightningFork";
			lightning.description = "SpChainLightningForkDesc";	
			lightning.castType = SpellCastType.Unit;
			lightning.autocastType = SpellAutocastType.NONE;	
			lightning.targetType = TargetType.Enemy;			
			lightning.soundPack.hit = SoundResources.magicHit3;		
			lightning.soundPack.attack = SoundResources.magicShoot3;					
			lightning.icon = new BitmapAsset(BitmapResources.icoSpellLightning.bitmapData);
			lightning.spellEffectSpecialEffect = typesRepository.effectTypes.Sparks2;
			lightning.specialGeneratedEffect = typesRepository.effectTypes.GeneratedLightning;
			lightning.sfxDuration = Util.secToFrames(0.3);
			lightning.snapToUnit = true;
			game.spellManager.addSpellType(lightning);
			
			var effect:SpellEffect = new SpellEffect();
			effect.minChange = -100;
			effect.maxChange = -130;
			effect.propertyId = UnitProperties.Health;
			effect.critChance = 5;

			var effect1:SpellEffectCastSpell = new SpellEffectCastSpell();
			effect1.spellTypeId = lightning.id;
			effect1.castFromTargetPosition = false;

			var effect2:SpellEffect = new SpellEffect();
			effect2.applyChance = 30;
			effect2.propertyId = UnitProperties.AttackRange;
			effect2.opType = SpellEffectOperationType.Set;
			effect2.minChange = 0;
			effect2.duration = new GameTime(0, 3).value;

			var effect3:SpellEffect = new SpellEffect();
			effect3.applyChance = 30;
			effect3.propertyId = UnitProperties.CastDelay;
			effect3.opType = SpellEffectOperationType.Set;
			effect3.minChange = Spell.MAX_CAST_DELAY;
			effect3.duration = new GameTime(0, 3).value;

			var effect4:SpellEffect = new SpellEffect();
			effect4.applyChance = 30;
			effect4.propertyId = UnitProperties.CanMove;
			effect4.opType = SpellEffectOperationType.Set;
			effect4.minChange = 0;
			effect4.duration = new GameTime(0, 3).value;
									
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1, effect2, effect3, effect4] );
			spell.aiHint = AiHintType.Attack;
			spell.range = 5;
			spell.name = "ChainLightningLvl1";
			spell.locName = "Chain Lightning";
			spell.description = "Hurls a lightning bolt at the enemy, dealing {minChange0} to {maxChange0} Magic damage and then jumping to additional nearby enemies. Has a {applyChance2}% chance to daze first target. Jumps 1 time.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 110;
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.magicHit3;		
			spell.soundPack.attack = SoundResources.magicShoot3;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellLightning.bitmapData);
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Sparks2;
			spell.cooldown = new GameTime(0, 12).value;
			spell.specialGeneratedEffect = typesRepository.effectTypes.GeneratedLightning;
			spell.sfxDuration = Util.secToFrames(0.3);
			spell.snapToUnit = true;
			game.spellManager.addSpellType(spell);	
			
			chainLightningLvl1 = spell;
		}

		private function chainLightningLvl2Init(game:Game, typesRepository:TypesRepository):void
		{
			var lightning:SpellType = new SpellType();
			lightning.aiHint = AiHintType.Attack;
			lightning.range = 4;
			lightning.name = "ChainLightningForkLvl1";
			lightning.castType = SpellCastType.Unit;
			lightning.autocastType = SpellAutocastType.NONE;	
			lightning.targetType = TargetType.Enemy;			
			lightning.soundPack.hit = SoundResources.magicHit3;		
			lightning.soundPack.attack = SoundResources.magicShoot3;					
			lightning.icon = new BitmapAsset(BitmapResources.icoSpellLightning.bitmapData);
			lightning.spellEffectSpecialEffect = typesRepository.effectTypes.Sparks2;
			lightning.specialGeneratedEffect = typesRepository.effectTypes.GeneratedLightning;
			lightning.sfxDuration = Util.secToFrames(0.3);
			lightning.snapToUnit = true;
		
			game.spellManager.addSpellType(lightning);
			
			var effectE2:SpellEffect = new SpellEffect();
			effectE2.minChange = -120;
			effectE2.minChange = -130;
			effectE2.propertyId = UnitProperties.Health;
			
			lightning.addEffects( [effectE2] );					
						
			//--------------------------------------------------------------						
			var effect:SpellEffect = new SpellEffect();
			effect.minChange = -160;
			effect.maxChange = -180;
			effect.propertyId = UnitProperties.Health;
			effect.critChance = 8;

			var effect1:SpellEffectCastSpell = new SpellEffectCastSpell();
			effect1.spellTypeId = lightning.id;
			effect1.castTimes = 2;
			effect1.castFromTargetPosition = false;			

			var effect2:SpellEffect = new SpellEffect();
			effect2.applyChance = 30;
			effect2.propertyId = UnitProperties.AttackRange;
			effect2.opType = SpellEffectOperationType.Set;
			effect2.minChange = 0;
			effect2.duration = new GameTime(0, 3).value;

			var effect3:SpellEffect = new SpellEffect();
			effect3.applyChance = 30;
			effect3.propertyId = UnitProperties.CastDelay;
			effect3.opType = SpellEffectOperationType.Set;
			effect3.minChange = Spell.MAX_CAST_DELAY;
			effect3.duration = new GameTime(0, 3).value;

			var effect4:SpellEffect = new SpellEffect();
			effect4.applyChance = 30;
			effect4.propertyId = UnitProperties.CanMove;
			effect4.opType = SpellEffectOperationType.Set;
			effect4.minChange = 0;
			effect4.duration = new GameTime(0, 3).value;
									
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1, effect2, effect3, effect4] );
			spell.aiHint = AiHintType.Attack;
			spell.range = 6;
			spell.name = "ChainLightningLvl2";
			spell.locName = "Chain Lightning (2)";
			spell.description = "Hurls a lightning bolt at the enemy, dealing {minChange0} to {maxChange0} Magic damage and then jumping to additional nearby enemies. Has a {applyChance2}% chance to daze first target. Jumps 2 times.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 110;
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.magicHit3;		
			spell.soundPack.attack = SoundResources.magicShoot3;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellLightning.bitmapData);
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Sparks2;
			spell.cooldown = new GameTime(0, 11).value;
			spell.specialGeneratedEffect = typesRepository.effectTypes.GeneratedLightning;
			spell.sfxDuration = Util.secToFrames(0.3);
			spell.snapToUnit = true;
			game.spellManager.addSpellType(spell);	
			
			chainLightningLvl2 = spell;
		}
				
		private function elementalProtectionLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.propertyId = UnitProperties.MagicRes;
			effect.minChange = 35;
			effect.opType = SpellEffectOperationType.Add;
			effect.duration = new GameTime(0, 60).value;
			effect.stackable = false;
			effect.affectedByMagicResistance = false;
						
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.ProtectionMagic;
			spell.name = "ElementalProtectionLvl1";
			spell.locName = "Elemental Protection";
			spell.description = "Protection spell that increases the magic resistance by {minChange0}% for {effDuration0} seconds.";	
			spell.castType = SpellCastType.Self;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 50;
			spell.costProperty = UnitProperties.Mana;
			spell.targetType = TargetType.Self;			
			spell.soundPack.hit = SoundResources.magicHit7;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellProtectionBlue.bitmapData);
			spell.specialEffect = typesRepository.effectTypes.ShieldPurple;
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 100).value;
			spell.sfxDuration = effect.duration;
			game.spellManager.addSpellType(spell);	
			
			elementalProtectionLvl1 = spell;
		}
		
		private function summonTotemLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffectSummon = new SpellEffectSummon();
			effect.unitTypeId = typesRepository.unitTypes.Totem.id;
			effect.summonLifeTime = new GameTime(0, 55).value;
			effect.summonEffectId = typesRepository.effectTypes.GroundFirePurple.id;

			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.Summon;
			spell.name = "SummonTotemLvl1";
			spell.locName = "Summon Totem";
			spell.description = "Summons Totem at selected place that will attack nearby enemies for {summonLifeTime0} sec.";	
			spell.castType = SpellCastType.Place;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 100;
			spell.range = 6;
			spell.cooldown = new GameTime(0, 15).value;
			spell.targetType = TargetType.Place;			
			spell.soundPack.hit = SoundResources.magicHit9;			
			spell.icon = new BitmapAsset(BitmapResources.icoTotem.bitmapData);
			game.spellManager.addSpellType(spell);	
			
			summonTotemLvl1 = spell;
		}		

		private function summonTotemLvl2Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffectSummon = new SpellEffectSummon();
			effect.unitTypeId = typesRepository.unitTypes.TotemLvl2.id;
			effect.summonLifeTime = new GameTime(0, 60).value;
			effect.summonEffectId = typesRepository.effectTypes.GroundFirePurple.id;

			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.Summon;
			spell.name = "SummonTotemLvl2";
			spell.locName = "Summon Totem (2)";
			spell.description = "Summons Totem at selected place that will attack nearby enemies for {summonLifeTime0} sec.";	
			spell.castType = SpellCastType.Place;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 110;
			spell.range = 6;
			spell.cooldown = new GameTime(0, 10).value;
			spell.targetType = TargetType.Place;			
			spell.soundPack.hit = SoundResources.magicHit9;			
			spell.icon = new BitmapAsset(BitmapResources.icoTotem.bitmapData);
			game.spellManager.addSpellType(spell);	
			
			summonTotemLvl2 = spell;
		}
		
		private function arcaneBlastLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.minChange = -70;
			effect.maxChange = -80;
			effect.propertyId = UnitProperties.Health;
			effect.critChance = 3;

			var effect1:SpellEffect = new SpellEffect();
			effect1.minChange = -30;
			effect1.maxChange = -40;
			effect1.propertyId = UnitProperties.Mana;
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1] );
			spell.aiHint = AiHintType.Attack;
			spell.range = 8;
			spell.name = "ArcaneBlastLvl1";
			spell.locName = "Arcane Blast";
			spell.description = "Blasts target for {minChange0} to {maxChange0} Magic damage and burns {minChange1} to {maxChange1} of target's mana";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 55;
			spell.targetType = TargetType.Enemy;
			spell.soundPack.attack = SoundResources.magicShoot5;							
			spell.soundPack.hit = SoundResources.magicHit5;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellArcaneBlast.bitmapData);
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.GroundFire;
			spell.projectileSpeed = 3;
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 8).value;
			spell.projectileModel = Game.instance().spriteRepository.getByName("ProjectileArcaneBallGlow");
			spell.affectBuildings = false;
			spell.projectileTrajectory = ProjectileTrajectory.Sine;
			game.spellManager.addSpellType(spell);	
			
			arcaneBlastLvl1 = spell;
		}

		private function arcaneBlastLvl2Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.minChange = -100;
			effect.maxChange = -110;
			effect.propertyId = UnitProperties.Health;
			effect.critChance = 4;

			var effect1:SpellEffect = new SpellEffect();
			effect1.minChange = -30;
			effect1.maxChange = -40;
			effect1.propertyId = UnitProperties.Mana;
			
			var effect2:SpellEffectSummon = new SpellEffectSummon();
			effect2.unitTypeId = typesRepository.unitTypes.AncientProtector.id;
			effect2.summonLifeTime = new GameTime(0, 12).value;
			effect2.summonEffectId = typesRepository.effectTypes.GroundFirePurple.id;
			effect2.applyChance = 10;
			
			var effect3:SpellEffectCastSpell = new SpellEffectCastSpell();
			effect3.spellTypeId = arcaneBlastLvl1.id;	
			effect3.castFromTargetPosition = false;					
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1, effect2, effect3] );
			spell.aiHint = AiHintType.Attack;
			spell.range = 8;
			spell.name = "ArcaneBlastLvl2";
			spell.locName = "Arcane Blast (2)";
			spell.description = "Blasts 2 targets for {minChange0} to {maxChange0} Magic damage and burns {minChange1} to {maxChange1} of target's mana. Has a {applyChance2}% chance to spawn an arcane spirit.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 65;
			spell.targetType = TargetType.Enemy;
			spell.soundPack.attack = SoundResources.magicShoot5;							
			spell.soundPack.hit = SoundResources.magicHit5;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellArcaneBlast.bitmapData);
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.GroundFire;
			spell.projectileSpeed = 3;
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 8).value;
			spell.projectileModel = Game.instance().spriteRepository.getByName("ProjectileArcaneBallGlow");
			spell.affectBuildings = false;
			spell.projectileTrajectory = ProjectileTrajectory.Sine;			
			game.spellManager.addSpellType(spell);	
			
			arcaneBlastLvl2 = spell;
		}

		private function arcaneBlastLvl3Init(game:Game, typesRepository:TypesRepository):void
		{		
			var effectFork:SpellEffect = new SpellEffect();
			effectFork.minChange = -40;
			effectFork.maxChange = -80;
			effectFork.propertyId = UnitProperties.Health;
			effectFork.critChance = 3;

			var effectFork1:SpellEffect = new SpellEffect();
			effectFork1.minChange = -5;
			effectFork1.maxChange = -10;
			effectFork1.propertyId = UnitProperties.Mana;
			
			var spell1:SpellType = new SpellType();
			spell1.addEffects( [effectFork, effectFork1] );
			spell1.range = 6;
			spell1.name = "ArcaneBlastFork";
			spell1.locName = "Arcane Blast";
			spell1.description = "Blasts target for {minChange0} to {maxChange0} Magic damage and burns {minChange1} to {maxChange1} of target's mana";	
			spell1.castType = SpellCastType.Unit;
			spell1.autocastType = SpellAutocastType.NONE;	
			spell1.targetType = TargetType.Enemy;
			spell1.soundPack.attack = SoundResources.magicShoot5;							
			spell1.soundPack.hit = SoundResources.magicHit5;			
			spell1.spellEffectSpecialEffect = typesRepository.effectTypes.GroundFire;
			spell1.projectileSpeed = 3;
			spell1.snapToUnit = true;
			spell1.projectileModel = Game.instance().spriteRepository.getByName("ProjectileArcaneBallGlow");
			spell1.affectBuildings = false;
			spell1.projectileTrajectory = ProjectileTrajectory.Sine;
			game.spellManager.addSpellType(spell1);							
				
			var effect:SpellEffect = new SpellEffect();
			effect.minChange = -160;
			effect.maxChange = -170;
			effect.propertyId = UnitProperties.Health;
			effect.critChance = 5;

			var effect1:SpellEffect = new SpellEffect();
			effect1.minChange = -35;
			effect1.maxChange = -40;
			effect1.propertyId = UnitProperties.Mana;
			
			var effect2:SpellEffectSummon = new SpellEffectSummon();
			effect2.unitTypeId = typesRepository.unitTypes.AncientProtector.id;
			effect2.summonLifeTime = new GameTime(0, 16).value;
			effect2.summonEffectId = typesRepository.effectTypes.GroundFirePurple.id;
			effect2.applyChance = 15;	
			
			var effect3:SpellEffectCastSpell = new SpellEffectCastSpell();
			effect3.spellTypeId = arcaneBlastLvl1.id;	
			effect3.castFromTargetPosition = false;		

			var effect4:SpellEffectCastSpell = new SpellEffectCastSpell();
			effect4.spellTypeId = spell1.id;				
			effect4.castFromTargetPosition = false;	
			
			var effect5:SpellEffectCastSpell = new SpellEffectCastSpell();
			effect5.spellTypeId = spell1.id;	
			effect5.castFromTargetPosition = false;	
									
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1, effect2, effect3, effect4, effect5] );
			spell.aiHint = AiHintType.Attack;
			spell.range = 10;
			spell.name = "ArcaneBlastLvl2";
			spell.locName = "Arcane Blast (3)";
			spell.description = "Blasts 4 targets for {minChange0} to {maxChange0} Magic damage and burns {minChange1} to {maxChange1} of target's mana. Has a {applyChance2}% chance to spawn an arcane spirit.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 110;
			spell.targetType = TargetType.Enemy;
			spell.soundPack.attack = SoundResources.magicShoot5;							
			spell.soundPack.hit = SoundResources.magicHit5;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellArcaneBlast.bitmapData);
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.GroundFire;
			spell.projectileSpeed = 2;
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 8.6).value;
			spell.projectileModel = Game.instance().spriteRepository.getByName("ProjectileArcaneBallGlow");
			spell.affectBuildings = false;
			spell.projectileTrajectory = ProjectileTrajectory.Sine;			
			game.spellManager.addSpellType(spell);	
			
			arcaneBlastLvl3 = spell;
		}
				
		private function silenceLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.minChange = Spell.MAX_CAST_DELAY;
			effect.propertyId = UnitProperties.CastDelay;
			effect.opType = SpellEffectOperationType.Set;
			effect.duration = new GameTime(0, 16).value;
			effect.affectedByMagicResistance = false;
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.Debuff;
			spell.range = 6;
			spell.name = "SilenceLvl1";
			spell.locName = "Silence";
			spell.description = "Silences the targets in selected area, preventing them from casting spells for {effDuration0} sec.";	
			spell.castType = SpellCastType.Place;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 90;
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.dispell;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellImplosion.bitmapData);
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Mouth1;
			spell.effectSfxDuration = effect.duration;
			spell.radius = 3;
			spell.cooldown = new GameTime(0, 30).value;
			spell.affectBuildings = false;
			game.spellManager.addSpellType(spell);	
			
			silenceLvl1 = spell;
		}

		private function silenceNeutralInit(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.minChange = Spell.MAX_CAST_DELAY;
			effect.propertyId = UnitProperties.CastDelay;
			effect.opType = SpellEffectOperationType.Set;
			effect.duration = new GameTime(0, 10).value;
			effect.affectedByMagicResistance = false;
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.Debuff;
			spell.range = 6;
			spell.name = "SilenceLvlNeutral";
			spell.locName = "Silence";
			spell.description = "Silences the targets in selected area, preventing them from casting spells for {effDuration0} sec.";	
			spell.castType = SpellCastType.Place;
			spell.autocastType = SpellAutocastType.AUTOCAST;	
			spell.cost = 90;
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.dispell;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellImplosion.bitmapData);
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Mouth1;
			spell.effectSfxDuration = effect.duration;
			spell.radius = 3;
			spell.cooldown = new GameTime(0, 35).value;
			spell.affectBuildings = false;
			game.spellManager.addSpellType(spell);	
			
			silenceNeutral = spell;
		}
		
		private function brillianceAuraLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.opType = SpellEffectOperationType.Add;
			effect.minChange = -10;						
			effect.propertyId = UnitProperties.ManaRegenRate;
			effect.coeficientPropertyId = UnitProperties.ManaRegenRate;
			effect.duration = Util.secToFrames(5);
			effect.period = 1;
			effect.stackable = false;
			effect.affectedByMagicResistance = false;
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.Passive;
			spell.name = "BrillianceAuraLvl1";
			spell.locName = "Brilliance Aura";
			spell.description = "Increases mana regeneration rate for all nearby friendly units by {minChange0}%. Only one aura can be active at a time.";	
			spell.castType = SpellCastType.Aura;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.targetType = TargetType.Ally;					
			spell.icon = new BitmapAsset(BitmapResources.icoSpellArcaneAura.bitmapData);
			spell.specialEffect = typesRepository.effectTypes.AuraBlue;
			spell.radius = 3;
			spell.snapToUnit = true;
			spell.duration = effect.duration;
			spell.affectBuildings = false;
			game.spellManager.addSpellType(spell);	
			
			brillianceAuraLvl1 = spell;
		}
		
		private function mirrorImageLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffectMirrorImage = new SpellEffectMirrorImage();
			effect.summonLifeTime = new GameTime(0, 10).value;
			effect.summonEffectId = typesRepository.effectTypes.GroundFirePurple.id;
			effect.duration = new GameTime(0, 60).value;
			effect.period = new GameTime(0, 10).value;
			effect.summonCount = 2;

			var effect1:SpellEffect = new SpellEffect();
			effect1.minChange = ArmorType.DIVINE;
			effect1.propertyId = UnitProperties.ArmorType;
			effect1.opType = SpellEffectOperationType.Set;
			effect1.duration = new GameTime(0, 1).value;
			effect1.affectedByMagicResistance = false;
						
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1] );
			spell.aiHint = AiHintType.Summon;
			spell.name = "MirrorImageLvl1";
			spell.locName = "Mirror Image";
			spell.description = "Creates 2 copies of the caster nearby, which distract the mage's enemies. Copy deals 30% of mage's damage. Lasts {effDuration0} sec.";	
			spell.castType = SpellCastType.Self;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 175;
			spell.targetType = TargetType.Self;			
			spell.soundPack.hit = SoundResources.dispell;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellMirrorImage.bitmapData);
			spell.cooldown = new GameTime(0, 110).value;
			game.spellManager.addSpellType(spell);	
			
			mirrorImageLvl1 = spell;
		}		

		private function banishLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffectUnsummon = new SpellEffectUnsummon();
			effect.minChange = -80000;
			effect.propertyId = UnitProperties.Health;
			effect.affectedByMagicResistance = false;

			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.None;
			spell.name = "BanishLvl1";
			spell.locName = "Banish";
			spell.description = "Instantly banishes any summoned creature to the plane where it came from.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 50;
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.magicHit8;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellBanish.bitmapData);
			spell.range = 6;
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.BigPurpleFire;
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 20).value;
			game.spellManager.addSpellType(spell);	
			
			banishLvl1 = spell;
		}

		private function banishItemInit(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffectUnsummon = new SpellEffectUnsummon();
			effect.minChange = -80000;
			effect.propertyId = UnitProperties.Health;
			effect.affectedByMagicResistance = false;

			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.None;
			spell.name = "BanishItem";
			spell.locName = "Banish (Item)";
			spell.description = "Instantly banishes any summoned creature to the plane where it came from.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 0;
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.magicHit8;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellBanish.bitmapData);
			spell.range = 6;
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.BigPurpleFire;
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 1).value;
			game.spellManager.addSpellType(spell);	
			
			banishItem = spell;
		}
				
		private function blinkLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffectTeleport = new SpellEffectTeleport();

			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.ProtectionCritical;
			spell.name = "BlinkLvl1";
			spell.locName = "Blink";
			spell.description = "Teleports the caster to a nearby location.";	
			spell.castType = SpellCastType.Place;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 100;
			spell.targetType = TargetType.Place;			
			spell.soundPack.hit = SoundResources.magicHit7;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellBlink.bitmapData);
			spell.range = 12;
			spell.specialEffect = typesRepository.effectTypes.Teleport;
			spell.cooldown = new GameTime(0, 10).value;
			game.spellManager.addSpellType(spell);	
			
			blinkLvl1 = spell;
		}
		
		private function teleportOtherLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffectTeleportOther = new SpellEffectTeleportOther();

			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.Attack;
			spell.name = "TeleportOtherLvl1";
			spell.locName = "Summon";
			spell.description = "Teleports a target to the caster.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 100;
			spell.targetType = TargetType.All;			
			spell.soundPack.hit = SoundResources.magicHit7;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellBlink.bitmapData);
			spell.range = 9;
			spell.snapToUnit = true;
			spell.specialEffect = typesRepository.effectTypes.Teleport;
			spell.cooldown = new GameTime(0, 45).value;
			game.spellManager.addSpellType(spell);	
			
			teleportOtherLvl1 = spell;
		}
		
		private function townPortalInit(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffectTownPortal = new SpellEffectTownPortal();

			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.ProtectionCritical;
			spell.name = "TownPortal";
			spell.locName = "Town Portal";
			spell.description = "Teleports you to an allied building or a point nearby an allied building.";	
			spell.castType = SpellCastType.Self;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 75;
			spell.targetType = TargetType.Self;			
			spell.soundPack.hit = SoundResources.magicHit7;			
			spell.icon = new BitmapAsset(BitmapResources.icoItemScrollTownPortal.bitmapData);
			spell.range = 12;
			spell.snapToUnit = true;
			spell.specialEffect = typesRepository.effectTypes.Teleport;
			spell.cooldown = 1;
			game.spellManager.addSpellType(spell);	
			
			townPortal = spell;
		}					
		
		private function shieldBashLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:AbilityEffect = new AbilityEffect();
			effect.propertyId = UnitProperties.Health;
			effect.ownerPropertyIdMin = UnitProperties.AttackDmgMin;
			effect.ownerPropertyIdMax = UnitProperties.AttackDmgMax;
			effect.coefficient = -0.60;		

			var effect1:SpellEffect = new SpellEffect();
			effect1.minChange = Constants.FALSE;
			effect1.opType = SpellEffectOperationType.Set;
			effect1.propertyId = UnitProperties.CanMove;
			effect1.duration = new GameTime(0, 6).value;
			
			var effect2:SpellEffect = new SpellEffect();
			effect2.minChange = 0;
			effect2.opType = SpellEffectOperationType.Set;
			effect2.propertyId = UnitProperties.AttackRange;
			effect2.duration = new GameTime(0, 6).value;
			
			var effect3:SpellEffect = new SpellEffect();
			effect3.minChange = Spell.MAX_CAST_DELAY;
			effect3.propertyId = UnitProperties.CastDelay;
			effect3.opType = SpellEffectOperationType.Set;
			effect3.duration = new GameTime(0, 6).value;			

			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1, effect2, effect3] );
			spell.aiHint = AiHintType.Attack;
			spell.name = "ShieldBashLvl1";
			spell.locName = "Bash";
			spell.description = "Deals {coeff0}% of caster main attack damage and stuns the target for {effDuration1} sec. This ability is not affected by target's magic resistance.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.stoneHit1;			
			spell.icon = new BitmapAsset(BitmapResources.icoShieldBash.bitmapData);
			spell.range = 1;
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Blood;
			spell.specialEffect = typesRepository.effectTypes.Stun;
			spell.sfxDuration = effect1.duration;
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 15).value;
			spell.affectBuildings = false;
			game.spellManager.addSpellType(spell);	
			
			shieldBashLvl1 = spell;
		}	

		private function itemStunLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect1:SpellEffect = new SpellEffect();
			effect1.minChange = Constants.FALSE;
			effect1.opType = SpellEffectOperationType.Set;
			effect1.propertyId = UnitProperties.CanMove;
			effect1.duration = new GameTime(0, 1.5).value;
			effect1.applyChance = 15;
			
			var effect2:SpellEffect = new SpellEffect();
			effect2.minChange = 0;
			effect2.opType = SpellEffectOperationType.Set;
			effect2.propertyId = UnitProperties.AttackRange;
			effect2.duration = new GameTime(0, 1.5).value;
			effect2.applyChance = 15;
						
			var effect3:SpellEffect = new SpellEffect();
			effect3.minChange = Spell.MAX_CAST_DELAY;
			effect3.propertyId = UnitProperties.CastDelay;
			effect3.opType = SpellEffectOperationType.Set;
			effect3.duration = new GameTime(0, 1.5).value;			
			effect3.applyChance = 15;
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect1, effect2, effect3] );
			spell.aiHint = AiHintType.Attack;
			spell.name = "ItemStunLvl1";
			spell.locName = "ItemStun";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.targetType = TargetType.Enemy;					
			spell.icon = new BitmapAsset(BitmapResources.icoShieldBash.bitmapData);
			spell.range = 1;
			spell.specialEffect = typesRepository.effectTypes.Stun;
			spell.sfxDuration = effect1.duration;
			spell.snapToUnit = true;
			spell.affectBuildings = false;
			game.spellManager.addSpellType(spell);	
			
			itemStunLvl1 = spell;
		}
		
		private function heroicStrikeLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:AbilityEffect = new AbilityEffect();
			effect.propertyId = UnitProperties.Health;
			effect.ownerPropertyIdMin = UnitProperties.AttackDmgMin;
			effect.ownerPropertyIdMax = UnitProperties.AttackDmgMax;
			effect.coefficient = -1.45;					

			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.Attack;
			spell.name = "HeroicStrikeLvl1";
			spell.locName = "Heroic Strike";
			spell.description = "An attack that instantly deals {coeff0}% of Hero's main attack damage. Can be set to autocast. This ability is not affected by target's magic resistance.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.AUTOCAST;	
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.hitClub2;			
			spell.icon = new BitmapAsset(BitmapResources.icoSwordRed.bitmapData);
			spell.range = 1;
			spell.specialEffect = typesRepository.effectTypes.Sword;
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Blood;
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 9).value;
			game.spellManager.addSpellType(spell);	
			
			heroicStrikeLvl1 = spell;
		}

		private function heroicStrikeLvl2Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:AbilityEffect = new AbilityEffect();
			effect.propertyId = UnitProperties.Health;
			effect.ownerPropertyIdMin = UnitProperties.AttackDmgMin;
			effect.ownerPropertyIdMax = UnitProperties.AttackDmgMax;
			effect.coefficient = -1.55;					

			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.Attack;
			spell.name = "HeroicStrikeLvl2";
			spell.locName = "Heroic Strike (2)";
			spell.description = "An attack that instantly deals {coeff0}% of Hero's main attack damage. Can be set to autocast. This ability is not affected by target's magic resistance.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.AUTOCAST;	
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.hitClub2;			
			spell.icon = new BitmapAsset(BitmapResources.icoSwordRed.bitmapData);
			spell.range = 1;
			spell.specialEffect = typesRepository.effectTypes.Sword;
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Blood;
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 9).value;
			game.spellManager.addSpellType(spell);	
			
			heroicStrikeLvl2 = spell;
		}
				
		private function thunderClapLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.minChange = -80;
			effect.maxChange = -80;
			effect.propertyId = UnitProperties.Health;	
			
			var effect1:SpellEffect = new SpellEffect();
			effect1.minChange = 50;
			effect1.propertyId = UnitProperties.MoveSpeed;
			effect1.coeficientPropertyId = UnitProperties.MoveSpeed;
			effect1.duration = new GameTime(0, 5.5).value;						
			effect1.affectedByMagicResistance = false;

			var effect2:SpellEffect = new SpellEffect();
			effect2.minChange = effect1.minChange;
			effect2.propertyId = UnitProperties.AttackDelay;
			effect2.coeficientPropertyId = UnitProperties.AttackDelay;
			effect2.duration = effect1.duration;						
			effect2.affectedByMagicResistance = false;
						
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1, effect2 ] );
			spell.aiHint = AiHintType.Attack;
			spell.name = "ThunderClapLvl1";
			spell.locName = "Thunder Clap";
			spell.description = "Deals {minChange0} Physical damage to all enemies around the caster, reducing targets move and attack speed by {minChange1}%.";	
			spell.castType = SpellCastType.Self;
			spell.autocastType = SpellAutocastType.AUTOCAST;	
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.canonHit1;			
			spell.icon = new BitmapAsset(BitmapResources.icoThunderClap.bitmapData);
			spell.radius = 2;
			spell.specialEffect = typesRepository.effectTypes.Quake;
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Stun;
			spell.effectSfxDuration = effect1.duration;
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 14).value;
			spell.quakeDuration = Util.secToFrames(1);
			spell.cost = 100;
			game.spellManager.addSpellType(spell);	
			
			thunderClapLvl1 = spell;
		}	

		private function thunderClapLvl2Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.minChange = -120;
			effect.maxChange = -120;
			effect.propertyId = UnitProperties.Health;	
			
			var effect1:SpellEffect = new SpellEffect();
			effect1.minChange = 70;
			effect1.propertyId = UnitProperties.MoveSpeed;
			effect1.coeficientPropertyId = UnitProperties.MoveSpeed;
			effect1.duration = new GameTime(0, 5.5).value;						
			effect1.affectedByMagicResistance = false;

			var effect2:SpellEffect = new SpellEffect();
			effect2.minChange = effect1.minChange;
			effect2.propertyId = UnitProperties.AttackDelay;
			effect2.coeficientPropertyId = UnitProperties.AttackDelay;
			effect2.duration = effect1.duration;						
			effect2.affectedByMagicResistance = false;
						
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1] );
			spell.aiHint = AiHintType.Attack;
			spell.name = "ThunderClapLvl2";
			spell.locName = "Thunder Clap (2)";
			spell.description = "Deals {minChange0} Physical damage to all enemies around the caster, reducing targets move and attack speed by {minChange1}%.";	
			spell.castType = SpellCastType.Self;
			spell.autocastType = SpellAutocastType.AUTOCAST;	
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.canonHit1;			
			spell.icon = new BitmapAsset(BitmapResources.icoThunderClap.bitmapData);
			spell.radius = 2;
			spell.specialEffect = typesRepository.effectTypes.Quake;
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Stun;
			spell.effectSfxDuration = effect1.duration;
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 14).value;
			spell.quakeDuration = Util.secToFrames(1);
			spell.cost = 100;
			game.spellManager.addSpellType(spell);	
			
			thunderClapLvl2 = spell;
		}
				
		private function cleaveLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:AbilityEffect = new AbilityEffect();
			effect.propertyId = UnitProperties.Health;
			effect.ownerPropertyIdMin = UnitProperties.AttackDmgMin;
			effect.ownerPropertyIdMax = UnitProperties.AttackDmgMax;
			effect.coefficient = -1.6;		
							
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.Attack;
			spell.name = "CleaveLvl1";
			spell.locName = "Cleave";
			spell.description = "Inflicts {coeff0}% of weapon damage to an enemy and its nearest allies, affecting up to 3 targets in front. This ability is not affected by target's magic resistance.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.AUTOCAST;	
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.hitWet1;			
			spell.icon = new BitmapAsset(BitmapResources.icoHalbertGreen.bitmapData);
			spell.radius = 2;
			spell.range = 1;
			spell.cone = true;
			spell.specialEffect = typesRepository.effectTypes.Blood;
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Sword;
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 15).value;
			game.spellManager.addSpellType(spell);	
			
			cleaveLvl1 = spell;
		}			

		private function cleaveLvl2Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:AbilityEffect = new AbilityEffect();
			effect.propertyId = UnitProperties.Health;
			effect.ownerPropertyIdMin = UnitProperties.AttackDmgMin;
			effect.ownerPropertyIdMax = UnitProperties.AttackDmgMax;
			effect.coefficient = -2.0;		
							
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.Attack;
			spell.name = "CleaveLvl2";
			spell.locName = "Cleave (2)";
			spell.description = "Inflicts {coeff0}% of weapon damage to an enemy and its nearest allies, affecting up to 3 targets in front. This ability is not affected by target's magic resistance.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.AUTOCAST;	
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.hitWet1;			
			spell.icon = new BitmapAsset(BitmapResources.icoHalbertGreen.bitmapData);
			spell.radius = 2;
			spell.range = 1;
			spell.cone = true;
			spell.specialEffect = typesRepository.effectTypes.Blood;
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Sword;
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 15.5).value;
			game.spellManager.addSpellType(spell);	
			
			cleaveLvl2 = spell;
		}
		
		private function defensiveStance1LvlInit(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.propertyId = UnitProperties.Armor;
			effect.minChange = 20;
			effect.opType = SpellEffectOperationType.Add;
			effect.duration = new GameTime(0, 20).value;
			effect.affectedByMagicResistance = false;
			effect.stackable = false;
			
			var effect1:SpellEffect = new SpellEffect();
			effect1.propertyId = UnitProperties.ArmorType;
			effect1.minChange = ArmorType.FORTIFIED;
			effect1.opType = SpellEffectOperationType.Set;
			effect1.duration = new GameTime(0, 20).value;
			effect1.affectedByMagicResistance = false;
			effect1.stackable = false;			

			var effect2:SpellEffect = new SpellEffect();
			effect2.propertyId = UnitProperties.MoveSpeed;
			effect2.minChange = 50;
			effect2.coeficientPropertyId =  UnitProperties.MoveSpeed;
			effect2.duration = new GameTime(0, 20).value;
			effect2.affectedByMagicResistance = false;
			effect2.stackable = false;
									
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1, effect2] );
			spell.aiHint = AiHintType.Protection;
			spell.name = "DefensiveStanceLvl1";
			spell.locName = "Defensive Stance";
			spell.description = "Increases caster armor by {minChange0} but reduces movement speed by {minChange1}% for {effDuration0} sec.";	
			spell.castType = SpellCastType.Self;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 50;
			spell.costProperty = UnitProperties.Mana;
			spell.targetType = TargetType.Self;			
			spell.soundPack.hit = SoundResources.magicHit5;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellShieldWall.bitmapData);
			spell.specialEffect = typesRepository.effectTypes.DefensiveStance;
			spell.snapToUnit = true;
			spell.sfxDuration = effect.duration;
			spell.cooldown = new GameTime(0, 60).value;
			game.spellManager.addSpellType(spell);	
			
			defensiveStanceLvl1 = spell;
		}	
		
		private function combatAuraLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.opType = SpellEffectOperationType.Add;
			effect.minChange = 10;						
			effect.propertyId = UnitProperties.AttackDmgMin;
			effect.coeficientPropertyId = UnitProperties.AttackDmgMin;
			effect.duration = Util.secToFrames(5);
			effect.period = 1;
			effect.affectedByMagicResistance = false;
			effect.stackable = false;
			
			var effect1:SpellEffect = new SpellEffect();
			effect1.opType = SpellEffectOperationType.Add;
			effect1.minChange = 10;						
			effect1.propertyId = UnitProperties.AttackDmgMax;
			effect1.coeficientPropertyId = UnitProperties.AttackDmgMax;
			effect1.duration = Util.secToFrames(5);
			effect1.period = 1;
			effect1.affectedByMagicResistance = false;
			effect1.stackable = false;		
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1] );
			spell.aiHint = AiHintType.Passive;
			spell.name = "CombatAuraLvl1";
			spell.locName = "Combat Aura";
			spell.description = "Increases attack damage for all nearby friendly units by {minChange0}%. Only one aura can be active at a time.";	
			spell.castType = SpellCastType.Aura;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.targetType = TargetType.Ally;					
			spell.icon = new BitmapAsset(BitmapResources.icoSpellCombatAura.bitmapData);
			spell.specialEffect = typesRepository.effectTypes.AuraRed;
			spell.radius = 4;
			spell.snapToUnit = true;
			spell.duration = effect.duration;
			spell.affectBuildings = false;
			game.spellManager.addSpellType(spell);	
			
			combatAuraLvl1 = spell;
		}

		private function combatAuraLvl2Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.opType = SpellEffectOperationType.Add;
			effect.minChange = 18;						
			effect.propertyId = UnitProperties.AttackDmgMin;
			effect.coeficientPropertyId = UnitProperties.AttackDmgMin;
			effect.duration = Util.secToFrames(5);
			effect.period = 1;
			effect.affectedByMagicResistance = false;
			effect.stackable = false;
			
			var effect1:SpellEffect = new SpellEffect();
			effect1.opType = SpellEffectOperationType.Add;
			effect1.minChange = 18;						
			effect1.propertyId = UnitProperties.AttackDmgMax;
			effect1.coeficientPropertyId = UnitProperties.AttackDmgMax;
			effect1.duration = Util.secToFrames(5);
			effect1.period = 1;
			effect1.affectedByMagicResistance = false;
			effect1.stackable = false;		
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1] );
			spell.aiHint = AiHintType.Passive;
			spell.name = "CombatAuraLvl2";
			spell.locName = "Combat Aura (2)";
			spell.description = "Increases attack damage for all nearby friendly units by {minChange0}%. Only one aura can be active at a time.";	
			spell.castType = SpellCastType.Aura;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.targetType = TargetType.Ally;					
			spell.icon = new BitmapAsset(BitmapResources.icoSpellCombatAura.bitmapData);
			spell.specialEffect = typesRepository.effectTypes.AuraRed;
			spell.radius = 4;
			spell.snapToUnit = true;
			spell.duration = effect.duration;
			spell.affectBuildings = false;
			game.spellManager.addSpellType(spell);	
			
			combatAuraLvl2 = spell;
		}
				
		private function chargeLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.propertyId = UnitProperties.MoveSpeed;
			effect.coeficientPropertyId = UnitProperties.MoveSpeed; 
			effect.minChange = -40;
			effect.opType = SpellEffectOperationType.Set;
			effect.duration = new GameTime(0, 15).value;
			effect.affectedByMagicResistance = false;
			effect.stackable = false;
						
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.SpeedBuff;
			spell.name = "ChargeLvl1";
			spell.locName = "Charge";
			spell.description = "Increases movement speed by {minChange0} for {effDuration0} sec.";	
			spell.castType = SpellCastType.Self;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.costProperty = UnitProperties.Mana;
			spell.targetType = TargetType.Self;			
			spell.soundPack.hit = SoundResources.magicHit7;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellCharge.bitmapData);
			spell.specialEffect = typesRepository.effectTypes.Haste;
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 60).value;
			game.spellManager.addSpellType(spell);	
			
			chargeLvl1 = spell;
		}		

		private function dashLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.propertyId = UnitProperties.MoveSpeed;
			effect.coeficientPropertyId = UnitProperties.MoveSpeed; 
			effect.minChange = -40;
			effect.opType = SpellEffectOperationType.Set;
			effect.duration = new GameTime(0, 10).value;
			effect.affectedByMagicResistance = false;
			effect.stackable = false;
						
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.SpeedBuff;
			spell.name = "DashLvl1";
			spell.locName = "Dash";
			spell.description = "Increases movement speed by {minChange0} for {effDuration0} sec.";	
			spell.castType = SpellCastType.Self;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.costProperty = UnitProperties.Mana;
			spell.targetType = TargetType.Self;			
			spell.soundPack.hit = SoundResources.magicHit7;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellCharge.bitmapData);
			spell.specialEffect = typesRepository.effectTypes.Haste;
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 55).value;
			game.spellManager.addSpellType(spell);	
			
			dashLvl1 = spell;
		}
		
		private function healLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.opType = SpellEffectOperationType.Add;
			effect.minChange = 100;	
			effect.maxChange = 120;					
			effect.propertyId = UnitProperties.Health;
			effect.affectedByMagicResistance = false;
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.Heal;
			spell.name = "HealLvl1";
			spell.locName = "Heal";
			spell.description = "Heals the caster for {minChange0} to {maxChange0} points of health.";	
			spell.castType = SpellCastType.Self;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.targetType = TargetType.Self;					
			spell.icon = new BitmapAsset(BitmapResources.icoSpellHeal.bitmapData);
			spell.specialEffect = typesRepository.effectTypes.Heal;
			spell.snapToUnit = true;
			spell.cost = 90;
			spell.cooldown = new GameTime(0, 12).value;
			spell.affectBuildings = false;
			spell.soundPack.hit = SoundResources.heal;
			game.spellManager.addSpellType(spell);	
			
			healLvl1 = spell;
		}

		private function healLvl2Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.opType = SpellEffectOperationType.Add;
			effect.minChange = 160;	
			effect.maxChange = 180;					
			effect.propertyId = UnitProperties.Health;
			effect.affectedByMagicResistance = false;
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.Heal;
			spell.name = "HealLvl2";
			spell.locName = "Heal (2)";
			spell.description = "Heals the caster for {minChange0} to {maxChange0} points of health.";	
			spell.castType = SpellCastType.Self;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.targetType = TargetType.Self;					
			spell.icon = new BitmapAsset(BitmapResources.icoSpellHeal.bitmapData);
			spell.specialEffect = typesRepository.effectTypes.Heal;
			spell.snapToUnit = true;
			spell.cost = 100;
			spell.cooldown = new GameTime(0, 14).value;
			spell.affectBuildings = false;
			spell.soundPack.hit = SoundResources.heal;
			game.spellManager.addSpellType(spell);	
			
			healLvl2 = spell;
		}
				
		private function devoutionAuraLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.opType = SpellEffectOperationType.Add;
			effect.minChange = 2;						
			effect.propertyId = UnitProperties.Armor;
			effect.duration = Util.secToFrames(5);
			effect.period = 1;
			effect.affectedByMagicResistance = false;
			effect.stackable = false;	
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.Passive;
			spell.name = "DevoutionAuraLvl1";
			spell.locName = "Devoution Aura";
			spell.description = "Increases armor for all nearby friendly units by {minChange0}. Only one aura can be active at a time.";	
			spell.castType = SpellCastType.Aura;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.targetType = TargetType.Ally;					
			spell.icon = new BitmapAsset(BitmapResources.icoSpellAuraDevoution.bitmapData);
			spell.specialEffect = typesRepository.effectTypes.Aura1;
			spell.radius = 3;
			spell.snapToUnit = true;
			spell.duration = effect.duration;
			spell.affectBuildings = false;
			game.spellManager.addSpellType(spell);	
			
			devoutionAuraLvl1 = spell;
		}	
	
		private function devoutionAuraLvl2Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.opType = SpellEffectOperationType.Add;
			effect.minChange = 3;						
			effect.propertyId = UnitProperties.Armor;
			effect.duration = Util.secToFrames(5);
			effect.period = 1;
			effect.affectedByMagicResistance = false;
			effect.stackable = false;	
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.Passive;
			spell.name = "DevoutionAuraLvl2";
			spell.locName = "Devoution Aura (2)";
			spell.description = "Increases armor for all nearby friendly units by {minChange0}. Only one aura can be active at a time.";	
			spell.castType = SpellCastType.Aura;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.targetType = TargetType.Ally;					
			spell.icon = new BitmapAsset(BitmapResources.icoSpellAuraDevoution.bitmapData);
			spell.specialEffect = typesRepository.effectTypes.Aura1;
			spell.radius = 4;
			spell.snapToUnit = true;
			spell.duration = effect.duration;
			spell.affectBuildings = false;
			game.spellManager.addSpellType(spell);	
			
			devoutionAuraLvl2 = spell;
		}	

		private function devoutionAuraLvl3Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.opType = SpellEffectOperationType.Add;
			effect.minChange = 5;						
			effect.propertyId = UnitProperties.Armor;
			effect.duration = Util.secToFrames(5);
			effect.period = 1;
			effect.affectedByMagicResistance = false;
			effect.stackable = false;	
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.Passive;
			spell.name = "DevoutionAuraLvl3";
			spell.locName = "Devoution Aura (3)";
			spell.description = "Increases armor for all nearby friendly units by {minChange0}. Only one aura can be active at a time.";	
			spell.castType = SpellCastType.Aura;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.targetType = TargetType.Ally;					
			spell.icon = new BitmapAsset(BitmapResources.icoSpellAuraDevoution.bitmapData);
			spell.specialEffect = typesRepository.effectTypes.Aura1;
			spell.radius = 4;
			spell.snapToUnit = true;
			spell.duration = effect.duration;
			spell.affectBuildings = false;
			game.spellManager.addSpellType(spell);	
			
			devoutionAuraLvl3 = spell;
		}
					
		private function holyShockLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.minChange = -100;
			effect.maxChange = -120;
			effect.propertyId = UnitProperties.Health;	
			
			var effect1:SpellEffect = new SpellEffect();
			effect1.minChange = -100;
			effect1.maxChange = -120;
			effect1.propertyId = UnitProperties.Health;
			effect1.coeficientPropertyId = UnitProperties.IsMechanical;				
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1] );
			spell.aiHint = AiHintType.Attack;
			spell.name = "HolyShockLvl1";
			spell.locName = "Holy Shock";
			spell.description = "Inflicts {minChange0} to {maxChange0} of Magical damage to all enemies around the caster. Damage to undead is doubled.";	
			spell.castType = SpellCastType.Self;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.magicHit2;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellHolyLight.bitmapData);
			spell.radius = 2;
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.BigBlueFire;
			spell.snapToUnit = true;
			spell.cost = 95;
			spell.cooldown = new GameTime(0, 25).value;
			spell.affectBuildings = false;
			game.spellManager.addSpellType(spell);	
			
			holyShockLvl1 = spell;
		}			

		private function holyShockLvl2Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.minChange = -130;
			effect.maxChange = -150;
			effect.propertyId = UnitProperties.Health;	
			
			var effect1:SpellEffect = new SpellEffect();
			effect1.minChange = -130;
			effect1.maxChange = -150;
			effect1.propertyId = UnitProperties.Health;
			effect1.coeficientPropertyId = UnitProperties.IsMechanical;			

			var effect2:SpellEffect = new SpellEffect();
			effect2.minChange = 0;
			effect2.propertyId = UnitProperties.HealthRegen;
			effect2.duration = new GameTime(0, 10).value;	
						
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1] );
			spell.aiHint = AiHintType.Attack;
			spell.name = "HolyShockLvl2";
			spell.locName = "Holy Shock (2)";
			spell.description = "Inflicts {minChange0} to {maxChange0} of Magical damage to all enemies around the caster and prevents health regeneration for {effDuration2} sec. Damage to undead is doubled.";	
			spell.castType = SpellCastType.Self;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.magicHit2;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellHolyLight.bitmapData);
			spell.radius = 2;
			spell.cost = 100;
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.BigBlueFire;
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 25).value;
			spell.affectBuildings = false;
			game.spellManager.addSpellType(spell);	
			
			holyShockLvl2 = spell;
		}
		
		private function devineShieldLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.propertyId = UnitProperties.ArmorType;
			effect.minChange = ArmorType.DIVINE;
			effect.opType = SpellEffectOperationType.Set;
			effect.duration = new GameTime(0, 15).value;
			effect.affectedByMagicResistance = false;
			effect.stackable = false;
			
			var effect1:SpellEffect = new SpellEffect();
			effect1.propertyId = UnitProperties.MagicRes;
			effect1.minChange = 100;
			effect1.opType = SpellEffectOperationType.Set;
			effect1.duration = new GameTime(0, 15).value;
			effect1.affectedByMagicResistance = false;
			effect1.stackable = false;			
						
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1] );
			spell.aiHint = AiHintType.Protection;
			spell.name = "DivineShieldLvl1";
			spell.locName = "Divine Shield";
			spell.description = "Protects you from all damage and spells for {effDuration0} sec.";	
			spell.castType = SpellCastType.Self;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 50;
			spell.costProperty = UnitProperties.Mana;
			spell.targetType = TargetType.Self;			
			spell.soundPack.hit = SoundResources.dispell;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellDivineShield.bitmapData);
			spell.specialEffect = typesRepository.effectTypes.Shield;
			spell.snapToUnit = true;
			spell.sfxDuration = effect.duration;
			spell.cooldown = new GameTime(0, 60).value;
			game.spellManager.addSpellType(spell);	
			
			devineShield1Lvl1 = spell;
		}

		private function devineShieldLvl2Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.propertyId = UnitProperties.ArmorType;
			effect.minChange = ArmorType.DIVINE;
			effect.opType = SpellEffectOperationType.Set;
			effect.duration = new GameTime(0, 20).value;
			effect.affectedByMagicResistance = false;
			effect.stackable = false;
			
			var effect1:SpellEffect = new SpellEffect();
			effect1.propertyId = UnitProperties.MagicRes;
			effect1.minChange = 100;
			effect1.opType = SpellEffectOperationType.Set;
			effect1.duration = new GameTime(0, 20).value;
			effect1.affectedByMagicResistance = false;
			effect1.stackable = false;			
						
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1] );
			spell.aiHint = AiHintType.Protection;
			spell.name = "DivineShieldLvl2";
			spell.locName = "Divine Shield (2)";
			spell.description = "Protects you from all damage and spells for {effDuration0} sec.";	
			spell.castType = SpellCastType.Self;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 50;
			spell.costProperty = UnitProperties.Mana;
			spell.targetType = TargetType.Self;			
			spell.soundPack.hit = SoundResources.dispell;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellDivineShield.bitmapData);
			spell.specialEffect = typesRepository.effectTypes.Shield;
			spell.snapToUnit = true;
			spell.sfxDuration = effect.duration;
			spell.cooldown = new GameTime(0, 60).value;
			game.spellManager.addSpellType(spell);	
			
			devineShieldLvl2 = spell;
		}
				
		private function blessLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.opType = SpellEffectOperationType.Add;
			effect.minChange = 5;						
			effect.propertyId = UnitProperties.AttackDmgMin;
			effect.duration = Util.secToFrames(35);
			effect.affectedByMagicResistance = false;
			effect.stackable = false;	
			
			var effect1:SpellEffect = new SpellEffect();
			effect1.opType = SpellEffectOperationType.Add;
			effect1.minChange = 5;						
			effect1.propertyId = UnitProperties.AttackDmgMax;
			effect1.duration = Util.secToFrames(35);
			effect1.affectedByMagicResistance = false;
			effect1.stackable = false;				
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1] );
			spell.aiHint = AiHintType.Buff;
			spell.name = "BlessLvl1";
			spell.locName = "Bless";
			spell.description = "Increases attack damage of all allies in selected area by {minChange0}.";	
			spell.castType = SpellCastType.Place;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.targetType = TargetType.Ally;					
			spell.icon = new BitmapAsset(BitmapResources.icoSpellBless.bitmapData);
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Bless;
			spell.radius = 4;
			spell.range = 6;
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 45).value;
			spell.cost = 75;
			spell.affectBuildings = false;
			spell.soundPack.hit = SoundResources.spellEffect1;				
			game.spellManager.addSpellType(spell);	
			
			blessLvl1 = spell;
		}		
		
		private function cleanseLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffectDispell = new SpellEffectDispell();
						
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.ProtectionMagic;
			spell.name = "CleanseLvl1";
			spell.locName = "Cleanse";
			spell.description = "Cleanses the caster, removing all negative effects.";	
			spell.castType = SpellCastType.Self;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.costProperty = UnitProperties.Mana;
			spell.targetType = TargetType.Self;			
			spell.soundPack.hit = SoundResources.waterHit1;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellCleanse.bitmapData);
			spell.specialEffect = typesRepository.effectTypes.Cleanse;
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 100).value;
			spell.cost = 10;
			spell.soundPack.hit = SoundResources.dispell;			
			game.spellManager.addSpellType(spell);	
			
			cleanseLvl1 = spell;
		}	
		
		private function holyBoltLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.minChange = -100;
			effect.maxChange = -120;
			effect.propertyId = UnitProperties.Health;
			effect.critChance = 3;

			var effect1:SpellEffect = new SpellEffect();
			effect1.minChange = 0;
			effect1.propertyId = UnitProperties.CanMove;
			effect1.applyChance = 25;
			effect1.duration = new GameTime(0, 5).value;
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1] );
			spell.aiHint = AiHintType.Attack;
			spell.range = 9;
			spell.name = "HolyBoltLvl1";
			spell.locName = "Holy Bolt";
			spell.description = "Hurls a bolt of light magic at an enemy, inflicting {minChange0} to {maxChange0} Magic damage. Has a {applyChance1}% chance to root the target for {effDuration1} sec.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 50;
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.magicShoot7;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellHolyBolt.bitmapData);
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Sparks2;
			spell.projectileSpeed = 3;
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 10).value;
			spell.affectBuildings = false;
			spell.projectileModel = Game.instance().spriteRepository.getByName("ProjectileHolyBolt");
			game.spellManager.addSpellType(spell);	
			
			holyBoltLvl1 = spell;
		}		

		private function holyBoltLvl2Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.minChange = -150;
			effect.maxChange = -190;
			effect.propertyId = UnitProperties.Health;
			effect.critChance = 3;

			var effect1:SpellEffect = new SpellEffect();
			effect1.minChange = 0;
			effect1.propertyId = UnitProperties.CanMove;
			effect1.applyChance = 45;
			effect1.duration = new GameTime(0, 5).value;
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1] );
			spell.aiHint = AiHintType.Attack;
			spell.range = 9;
			spell.name = "HolyBoltLvl2";
			spell.locName = "Holy Bolt (2)";
			spell.description = "Hurls a bolt of light magic at an enemy, inflicting {minChange0} to {maxChange0} Magic damage. Has a {applyChance1}% chance to root the target for {effDuration1} sec.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 100;
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.magicShoot7;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellHolyBolt.bitmapData);
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Sparks2;
			spell.projectileSpeed = 3;
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 11).value;
			spell.affectBuildings = false;
			spell.projectileModel = Game.instance().spriteRepository.getByName("ProjectileHolyBolt");
			game.spellManager.addSpellType(spell);	
			
			holyBoltLvl2 = spell;
		}
		
		private function manaBurnLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.minChange = 10;
			effect.coeficientPropertyId = UnitProperties.MaxMana;
			effect.propertyId = UnitProperties.Mana;

			var effect1:SpellEffect = new SpellEffect();
			effect1.minChange = 30;
			effect1.propertyId = UnitProperties.ManaRegen;
			effect1.coeficientPropertyId = UnitProperties.ManaRegen;
			effect1.duration = new GameTime(0, 8).value;
			
			var effect2:SpellEffect = new SpellEffect();
			effect2.minChange = 10;
			effect2.maxChange = 15;
			effect2.propertyId = UnitProperties.Health;	
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1, effect2] );
			spell.aiHint = AiHintType.DrainMana;
			spell.range = 8;
			spell.name = "ManaBurnLvl1";
			spell.locName = "Mana Burn";
			spell.description = "Destroy {minChange0}% of the target's mana, and inflicts {minChange2} to {maxChange2} Magic damage. Reduces mana regeneratation of the target to 30% for 8 sec.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 50;
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.magicHit6;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellDrainMana.bitmapData);
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.GroundFire;
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 45).value;
			game.spellManager.addSpellType(spell);	
			
			manaBurnLvl1 = spell;
		}
		
		private function irradiateLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.minChange = 1;
			effect.opType = SpellEffectOperationType.Set;
			effect.propertyId = UnitProperties.AttackRange;
			effect.duration = new GameTime(0, 6).value;
			effect.affectedByMagicResistance = false;
						
			var effect1:SpellEffect = new SpellEffect();
			effect1.minChange = -30;
			effect1.coeficientPropertyId = UnitProperties.SightRange;
			effect1.opType = SpellEffectOperationType.Set;
			effect1.propertyId = UnitProperties.SightRange;
			effect1.duration = new GameTime(0, 10).value;
			effect1.affectedByMagicResistance = false;

			var effect2:SpellEffect = new SpellEffect();
			effect2.minChange = -3;
			effect2.propertyId = UnitProperties.AttackDmgMin;
			effect2.duration = new GameTime(0, 10).value;
			effect2.affectedByMagicResistance = false;

			var effect3:SpellEffect = new SpellEffect();
			effect3.minChange = -3;
			effect3.propertyId = UnitProperties.AttackDmgMax;
			effect3.duration = new GameTime(0, 10).value;
			effect3.affectedByMagicResistance = false;
									
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1, effect2, effect3] );
			spell.aiHint = AiHintType.Debuff;
			spell.range = 9;
			spell.radius = 3;
			spell.name = "IrradiateLvl1";
			spell.locName = "Irradiate";
			spell.description = "Flash of searing light blinds all enemies in selected area for {effDuration1} sec, reducing enemies sight range by {minChange1}% and attack by {minChange2}. Will force targets with range/spell attack to come closer to the caster.\r\nThis spell can not be resisted.";	
			spell.castType = SpellCastType.Place;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 50;
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.magicHit7;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellIrradiate.bitmapData);
			spell.specialEffect = typesRepository.effectTypes.Fog1;
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Eye;
			spell.effectSfxDuration = effect1.duration;
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 60).value;
			spell.affectBuildings = false;
			game.spellManager.addSpellType(spell);	
			
			irradiateLvl1 = spell;
		}	
		
		private function burningSwordLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect2:SpellEffect = new SpellEffect();
			effect2.minChange = -10
			effect2.propertyId = UnitProperties.Health;
			effect2.stackable = false;
			effect2.applyChance = 30;
			
			var fireBurn:SpellType = new SpellType();
			fireBurn.addEffects( [effect2] );
			fireBurn.name = "BurningSwordFireBurn";	
			fireBurn.castType = SpellCastType.Unit;
			fireBurn.autocastType = SpellAutocastType.NONE;	
			fireBurn.targetType = TargetType.Enemy;			
			fireBurn.soundPack.hit = SoundResources.magicHit6;			
			fireBurn.icon = new BitmapAsset(BitmapResources.icoWisp.bitmapData);
			fireBurn.spellEffectSpecialEffect = typesRepository.effectTypes.Sparks2Red;
			fireBurn.specialEffect = typesRepository.effectTypes.Sparks3Red;
			fireBurn.snapToUnit = true;
			game.spellManager.addSpellType(fireBurn);				
			
			var effect:SpellEffect = new SpellEffect();
			effect.minChange = 3;
			effect.propertyId = UnitProperties.AttackDmgMin;
			effect.duration = new GameTime(0, 25).value;
			effect.affectedByMagicResistance = false;			
			effect.stackable = false;

			var effect1:SpellEffect = new SpellEffect();
			effect1.minChange = 3;
			effect1.propertyId = UnitProperties.AttackDmgMax;
			effect1.duration = effect.duration;
			effect1.affectedByMagicResistance = false;			
			effect1.stackable = false;
			
			var effect3:SpellEffect = new SpellEffect();
			effect3.minChange = fireBurn.id;
			effect3.propertyId = UnitProperties.AttackSpell;
			effect3.affectedByMagicResistance = false;			
			effect3.duration = effect.duration;		
						
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1, effect3] );
			spell.aiHint = AiHintType.Attack;
			spell.name = "BurningSwordLvl1";
			spell.locName = "Burning Sword";
			spell.description = "Lights caster's weapon with fire. Each melee attack will do {minChange0} additional Physical damage. Also there is a 30% chance to make 10 points of Fire damage on each hit. Lasts {effDuration0} sec.";	
			spell.castType = SpellCastType.Self;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 50;
			spell.targetType = TargetType.Self;			
			spell.soundPack.hit = SoundResources.magicHit2;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellBurningSword.bitmapData);
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.RedSparks;
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 60).value;
			game.spellManager.addSpellType(spell);	
			
			burningSwordLvl1 = spell;
		}	

		private function burningSwordLvl2Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect2:SpellEffect = new SpellEffect();
			effect2.minChange = -15
			effect2.propertyId = UnitProperties.Health;
			effect2.stackable = false;
			effect2.applyChance = 45;
			
			var fireBurn:SpellType = new SpellType();
			fireBurn.addEffects( [effect2] );
			fireBurn.name = "BurningSwordFireBurn2";	
			fireBurn.castType = SpellCastType.Unit;
			fireBurn.autocastType = SpellAutocastType.NONE;	
			fireBurn.targetType = TargetType.Enemy;			
			fireBurn.soundPack.hit = SoundResources.magicHit6;			
			fireBurn.icon = new BitmapAsset(BitmapResources.icoWisp.bitmapData);
			fireBurn.spellEffectSpecialEffect = typesRepository.effectTypes.Sparks2Red;
			fireBurn.specialEffect = typesRepository.effectTypes.Sparks3Red;
			fireBurn.snapToUnit = true;
			game.spellManager.addSpellType(fireBurn);				
			
			var effect:SpellEffect = new SpellEffect();
			effect.minChange = 4;
			effect.propertyId = UnitProperties.AttackDmgMin;
			effect.duration = new GameTime(0, 35).value;
			effect.affectedByMagicResistance = false;			
			effect.stackable = false;

			var effect1:SpellEffect = new SpellEffect();
			effect1.minChange = 4;
			effect1.propertyId = UnitProperties.AttackDmgMax;
			effect1.duration = effect.duration;
			effect1.affectedByMagicResistance = false;
			effect1.stackable = false;
			
			var effect3:SpellEffect = new SpellEffect();
			effect3.minChange = fireBurn.id;
			effect3.propertyId = UnitProperties.AttackSpell;
			effect3.duration = effect.duration;	
			effect3.affectedByMagicResistance = false;	
						
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1, effect3] );
			spell.aiHint = AiHintType.Attack;
			spell.name = "BurningSwordLvl2";
			spell.locName = "Burning Sword (2)";
			spell.description = "Lights caster's weapon with fire. Each melee attack will do {minChange0} additional Physical damage. Also there is a 45% chance to make 15 points of Fire damage on each hit. Lasts {effDuration0} sec.";	
			spell.castType = SpellCastType.Self;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 50;
			spell.targetType = TargetType.Self;			
			spell.soundPack.hit = SoundResources.magicHit2;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellBurningSword.bitmapData);
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.RedSparks;
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 60).value;
			game.spellManager.addSpellType(spell);	
			
			burningSwordLvl2 = spell;
		}
				
		private function burningShieldLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.propertyId = UnitProperties.DamageRetention;
			effect.minChange = 15;
			effect.opType = SpellEffectOperationType.Add;
			effect.duration = new GameTime(0, 25).value;
			effect.affectedByMagicResistance = false;
			effect.stackable = false;
			
			var effect1:SpellEffect = new SpellEffect();
			effect1.propertyId = UnitProperties.MagicRes;
			effect1.minChange = 40;
			effect1.opType = SpellEffectOperationType.Add;
			effect1.duration = new GameTime(0, 25).value;
			effect1.affectedByMagicResistance = false;
			effect1.stackable = false;			
						
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1] );
			spell.aiHint = AiHintType.Protection;
			spell.name = "BurningShieldLvl1";
			spell.locName = "Burning Shield";
			spell.description = "Causes {minChange0} Fire damage when hit. Increases magic resistance by {minChange1}%. Lasts {effDuration0} sec.";	
			spell.castType = SpellCastType.Self;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 50;
			spell.costProperty = UnitProperties.Mana;
			spell.targetType = TargetType.Self;			
			spell.soundPack.hit = SoundResources.magicHit2;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellBurningShield.bitmapData);
			spell.specialEffect = typesRepository.effectTypes.ShieldRed;
			spell.snapToUnit = true;
			spell.sfxDuration = effect.duration;
			spell.cooldown = new GameTime(0, 60).value;
			game.spellManager.addSpellType(spell);	
			
			burningShield1Lvl1 = spell;
		}	

		private function burningShieldLvl2Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.propertyId = UnitProperties.DamageRetention;
			effect.minChange = 25;
			effect.opType = SpellEffectOperationType.Add;
			effect.duration = new GameTime(0, 30).value;
			effect.affectedByMagicResistance = false;
			effect.stackable = false;
			
			var effect1:SpellEffect = new SpellEffect();
			effect1.propertyId = UnitProperties.MagicRes;
			effect1.minChange = 40;
			effect1.opType = SpellEffectOperationType.Add;
			effect1.duration = new GameTime(0, 30).value;
			effect1.affectedByMagicResistance = false;
			effect1.stackable = false;			
						
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1] );
			spell.aiHint = AiHintType.Protection;
			spell.name = "BurningShieldLvl2";
			spell.locName = "Burning Shield (2)";
			spell.description = "Causes {minChange0} Fire damage when hit. Increases magic resistance by {minChange1}%. Lasts {effDuration0} sec.";	
			spell.castType = SpellCastType.Self;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 50;
			spell.costProperty = UnitProperties.Mana;
			spell.targetType = TargetType.Self;			
			spell.soundPack.hit = SoundResources.magicHit2;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellBurningShield.bitmapData);
			spell.specialEffect = typesRepository.effectTypes.ShieldRed;
			spell.snapToUnit = true;
			spell.sfxDuration = effect.duration;
			spell.cooldown = new GameTime(0, 60).value;
			game.spellManager.addSpellType(spell);	
			
			burningShield1Lvl2 = spell;
		}
				
		private function smiteLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.minChange = -15;
			effect.maxChange = -16;
			effect.propertyId = UnitProperties.Health;
			effect.critChance = 1;
			
			var effect1:SpellEffect = new SpellEffect();
			effect1.minChange = -1;
			effect1.propertyId = UnitProperties.Health;	
			effect1.coeficientPropertyId = UnitProperties.Mana;			

			var effect2:SpellEffect = new SpellEffect();
			effect2.minChange = Constants.FALSE;
			effect2.opType = SpellEffectOperationType.Set;
			effect2.propertyId = UnitProperties.CanMove;
			effect2.duration = new GameTime(0, 2.5).value;
			effect2.stackable = false;
			effect2.affectedByMagicResistance = false;
						
			var effect3:SpellEffect = new SpellEffect();
			effect3.minChange = 0;
			effect3.opType = SpellEffectOperationType.Set;
			effect3.propertyId = UnitProperties.AttackRange;
			effect3.duration = new GameTime(0, 2.5).value;
			effect3.stackable = false;
			effect3.affectedByMagicResistance = false;
									
			var effect4:SpellEffect = new SpellEffect();
			effect4.minChange = Spell.MAX_CAST_DELAY;
			effect4.propertyId = UnitProperties.CastDelay;
			effect4.opType = SpellEffectOperationType.Set;
			effect4.duration = new GameTime(0, 2.5).value;			
			effect4.stackable = false;
			effect3.affectedByMagicResistance = false;
									
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1, effect2, effect3, effect4] );
			spell.aiHint = AiHintType.Attack;
			spell.range = 4;
			spell.name = "SmiteLvl1";
			spell.locName = "Smite";
			spell.description = "Inflicts 60 to 75 Magic damage plus damage equal to 5% of target's mana and stuns the target for {effDuration2} sec.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 100;
			spell.cooldown = new GameTime(0, 8).value;
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.magicHit3;	
			spell.soundPack.attack = SoundResources.magicShoot3;						
			spell.icon = new BitmapAsset(BitmapResources.icoSpellSmite.bitmapData);
			spell.specialEffect = typesRepository.effectTypes.Sparks2;
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Stun;
			spell.effectSfxDuration = effect2.duration/2;
			spell.projectileSpeed = 2;
			spell.projectileModel = Game.instance().spriteRepository.getByName("ProjectileLightning1");
			spell.affectBuildings = false;
			spell.snapToUnit = true;
			spell.rainDelay = 1;
			spell.duration = 5;
			spell.visualType = SpellVisualType.Rain;
			game.spellManager.addSpellType(spell);	
			
			smiteLvl1 = spell;
		}					

		private function smiteLvl2Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.minChange = -24;
			effect.maxChange = -30;
			effect.propertyId = UnitProperties.Health;
			effect.critChance = 1;
			
			var effect1:SpellEffect = new SpellEffect();
			effect1.minChange = -1;
			effect1.propertyId = UnitProperties.Health;	
			effect1.coeficientPropertyId = UnitProperties.Mana;			

			var effect2:SpellEffect = new SpellEffect();
			effect2.minChange = Constants.FALSE;
			effect2.opType = SpellEffectOperationType.Set;
			effect2.propertyId = UnitProperties.CanMove;
			effect2.duration = new GameTime(0, 3).value;
			effect2.stackable = false;
			effect2.affectedByMagicResistance = false;
						
			var effect3:SpellEffect = new SpellEffect();
			effect3.minChange = 0;
			effect3.opType = SpellEffectOperationType.Set;
			effect3.propertyId = UnitProperties.AttackRange;
			effect3.duration = new GameTime(0, 3).value;
			effect3.stackable = false;
			effect3.affectedByMagicResistance = false;
									
			var effect4:SpellEffect = new SpellEffect();
			effect4.minChange = Spell.MAX_CAST_DELAY;
			effect4.propertyId = UnitProperties.CastDelay;
			effect4.opType = SpellEffectOperationType.Set;
			effect4.duration = new GameTime(0, 3).value;			
			effect4.stackable = false;
			effect3.affectedByMagicResistance = false;
									
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1, effect2, effect3, effect4] );
			spell.aiHint = AiHintType.Attack;
			spell.range = 4;
			spell.name = "SmiteLvl2";
			spell.locName = "Smite (2)";
			spell.description = "Inflicts 120 to 150 Magic damage plus damage equal to 5% of target's mana and stuns the target for {effDuration2} sec.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 100;
			spell.cooldown = new GameTime(0, 10).value;
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.magicHit3;	
			spell.soundPack.attack = SoundResources.magicShoot3;						
			spell.icon = new BitmapAsset(BitmapResources.icoSpellSmite.bitmapData);
			spell.specialEffect = typesRepository.effectTypes.Sparks2;
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Stun;
			spell.effectSfxDuration = effect2.duration/2;
			spell.projectileSpeed = 2;
			spell.projectileModel = Game.instance().spriteRepository.getByName("ProjectileLightning1");
			spell.affectBuildings = false;
			spell.snapToUnit = true;
			spell.rainDelay = 1;
			spell.duration = 5;
			spell.visualType = SpellVisualType.Rain;
			game.spellManager.addSpellType(spell);	
			
			smiteLvl2 = spell;
		}

		private function smiteLvl3Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.minChange = -30;
			effect.maxChange = -42;
			effect.propertyId = UnitProperties.Health;
			effect.critChance = 1;
			
			var effect1:SpellEffect = new SpellEffect();
			effect1.minChange = -1;
			effect1.propertyId = UnitProperties.Health;	
			effect1.coeficientPropertyId = UnitProperties.Mana;			

			var effect2:SpellEffect = new SpellEffect();
			effect2.minChange = Constants.FALSE;
			effect2.opType = SpellEffectOperationType.Set;
			effect2.propertyId = UnitProperties.CanMove;
			effect2.duration = new GameTime(0, 3.5).value;
			effect2.stackable = false;
			effect2.affectedByMagicResistance = false;
						
			var effect3:SpellEffect = new SpellEffect();
			effect3.minChange = 0;
			effect3.opType = SpellEffectOperationType.Set;
			effect3.propertyId = UnitProperties.AttackRange;
			effect3.duration = new GameTime(0, 3.5).value;
			effect3.stackable = false;
			effect3.affectedByMagicResistance = false;
									
			var effect4:SpellEffect = new SpellEffect();
			effect4.minChange = Spell.MAX_CAST_DELAY;
			effect4.propertyId = UnitProperties.CastDelay;
			effect4.opType = SpellEffectOperationType.Set;
			effect4.duration = new GameTime(0, 3.5).value;			
			effect4.stackable = false;
			effect3.affectedByMagicResistance = false;
									
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1, effect2, effect3, effect4] );
			spell.aiHint = AiHintType.Attack;
			spell.range = 4;
			spell.name = "SmiteLvl3";
			spell.locName = "Smite (3)";
			spell.description = "Inflicts 150 to 210 Magic damage plus damage equal to 5% of target's mana and stuns the target for {effDuration2} sec.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 100;
			spell.cooldown = new GameTime(0, 10).value;
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.magicHit3;	
			spell.soundPack.attack = SoundResources.magicShoot3;						
			spell.icon = new BitmapAsset(BitmapResources.icoSpellSmite.bitmapData);
			spell.specialEffect = typesRepository.effectTypes.Sparks2;
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Stun;
			spell.effectSfxDuration = effect2.duration/2;
			spell.projectileSpeed = 2;
			spell.projectileModel = Game.instance().spriteRepository.getByName("ProjectileLightning1");
			spell.affectBuildings = false;
			spell.snapToUnit = true;
			spell.rainDelay = 1;
			spell.duration = 5;
			spell.visualType = SpellVisualType.Rain;
			game.spellManager.addSpellType(spell);	
			
			smiteLvl3 = spell;
		}
						
		private function sacrificeLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.minChange = -100;
			effect.propertyId = UnitProperties.Health;	
			effect.affectedByMagicResistance = false;				
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.None;
			spell.name = "SacrificeLvl1";
			spell.locName = "Sacrifice";
			spell.description = "At cost of {cost} health caster inflicts {minChange0} Magic damage to all enemies around. Damage can not be resisted and pierce even through Divine Shield.";	
			spell.castType = SpellCastType.Self;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.magicHit5;			
			spell.icon = new BitmapAsset(BitmapResources.icoArmorBlue.bitmapData);
			spell.radius = 3;
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.GroundFire;
			spell.specialEffect = typesRepository.effectTypes.AuraRed;
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 15).value;
			spell.cost = 100;
			spell.costProperty = UnitProperties.Health;
			game.spellManager.addSpellType(spell);	
			
			sacrificeLvl1 = spell;
		}
		
		private function lifeStealLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffectDrain = new SpellEffectDrain();
			effect.minChange = -5;
			effect.maxChange = -10;
			effect.propertyId = UnitProperties.Health;
			effect.opType = SpellEffectOperationType.Add;
			effect.stackable = false;

			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.DrainHealth;
			spell.range = 20;
			spell.name = "LifeStealLvl1";
			spell.locName = "SpLifeSteal";
			spell.description = "SpLifeStealDesc";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.targetType = TargetType.Enemy;					
			spell.icon = new BitmapAsset(BitmapResources.icoSpellHolyLight.bitmapData);
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Acid;
			spell.snapToUnit = true;
			spell.affectBuildings = false;
			game.spellManager.addSpellType(spell);	
			
			lifeStealLvl1 = spell;
		}	
		
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
		
		private function weaponThrowLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:AbilityEffect = new AbilityEffect();
			effect.propertyId = UnitProperties.Health;
			effect.ownerPropertyIdMin = UnitProperties.AttackDmgMin;
			effect.ownerPropertyIdMax = UnitProperties.AttackDmgMax;
			effect.coefficient = -1.2;		

			var effect1:SpellEffect = new SpellEffect();
			effect1.minChange = -20;
			effect1.propertyId = UnitProperties.Health;
			effect1.critChance = 1;
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1] );
			spell.aiHint = AiHintType.Attack;
			spell.range = 7;
			spell.name = "WeaponThrowLvl1";
			spell.locName = "Weapon Throw";
			spell.description = "Hurl a weapon at an enemy for {coeff0}% weapon damage plus {minChange1} Magic Damage.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 40;
			spell.cooldown = new GameTime(0, 15).value;
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.attack = SoundResources.bladeShoot1;	
			spell.soundPack.hit = SoundResources.hitWet2;					
			spell.icon = new BitmapAsset(BitmapResources.icoItemWarAxe.bitmapData);
			spell.specialEffect = typesRepository.effectTypes.Blood;
			spell.projectileSpeed = 3;
			spell.snapToUnit = true;
			spell.projectileModel = Game.instance().spriteRepository.getByName("ProjectileBarbarAxe");
			game.spellManager.addSpellType(spell);	
			
			weaponThrowLvl1 = spell;
		}										

		private function bloodThirstLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:AbilityEffect = new AbilityEffect();
			effect.propertyId = UnitProperties.Health;
			effect.ownerPropertyIdMin = UnitProperties.AttackDmgMin;
			effect.ownerPropertyIdMax = UnitProperties.AttackDmgMax;
			effect.coefficient = -1.2;					

			var effect1:SpellEffectDrain = new SpellEffectDrain();
			effect1.minChange = -30;
			effect1.propertyId = UnitProperties.Health;
			effect1.opType = SpellEffectOperationType.Add;
			effect1.stackable = false;
			effect1.critChance = 1;
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1] );
			spell.aiHint = AiHintType.Attack;
			spell.name = "BloodThirstLvl1";
			spell.locName = "Blood Thirst";
			spell.description = "Instantly attack the target causing 120% of weapon damage + {minChange1}. In addition, successful attack will restore {minChange1} points of health.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.AUTOCAST;	
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.magicHit4;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellBloodThirst.bitmapData);
			spell.range = 1;
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Blood;
			spell.specialEffect = typesRepository.effectTypes.Sparks3Red;
			spell.snapToUnit = true;
			spell.affectBuildings = false;
			spell.cooldown = new GameTime(0, 10).value;
			game.spellManager.addSpellType(spell);	
			
			bloodThirstLvl1 = spell;
		}

		private function bloodThirstLvl2Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:AbilityEffect = new AbilityEffect();
			effect.propertyId = UnitProperties.Health;
			effect.ownerPropertyIdMin = UnitProperties.AttackDmgMin;
			effect.ownerPropertyIdMax = UnitProperties.AttackDmgMax;
			effect.coefficient = -1.3;					

			var effect1:SpellEffectDrain = new SpellEffectDrain();
			effect1.minChange = -40;
			effect1.propertyId = UnitProperties.Health;
			effect1.opType = SpellEffectOperationType.Add;
			effect1.stackable = false;
			effect1.critChance = 2;
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1] );
			spell.aiHint = AiHintType.Attack;
			spell.name = "BloodThirstLvl2";
			spell.locName = "Blood Thirst (2)";
			spell.description = "Instantly attack the target causing 130% of weapon damage + {minChange1}. In addition, successful attack will restore {minChange1} points of health.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.AUTOCAST;	
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.magicHit4;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellBloodThirst.bitmapData);
			spell.range = 1;
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Blood;
			spell.specialEffect = typesRepository.effectTypes.Sparks3Red;
			spell.snapToUnit = true;
			spell.affectBuildings = false;
			spell.cooldown = new GameTime(0, 10).value;
			game.spellManager.addSpellType(spell);	
			
			bloodThirstLvl2 = spell;
		}
				
		private function enragedSwingLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.minChange = 1;
			effect.propertyId = UnitProperties.AttackDamageRange;
			effect.opType = SpellEffectOperationType.Set;
			effect.applyChance = 60;
			effect.stackable = false;
			effect.duration = new GameTime(0, 20).value;
			effect.period = 1;
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.Attack;
			spell.name = "EnragedSwingLvl1";
			spell.locName = "Enraged Swings";
			spell.description = "For {effDuration0} sec each melee attack has a {applyChance0}% chance to affect all targets around the caster.";	
			spell.castType = SpellCastType.Self;
			spell.autocastType = SpellAutocastType.AUTOCAST;	
			spell.targetType = TargetType.Self;			
			spell.soundPack.hit = SoundResources.magicHit7;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellEnragedSwing.bitmapData);
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.RedSparks;
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 60).value;
			game.spellManager.addSpellType(spell);	
			
			enragedSwingLvl1 = spell;
		}		

		private function warCryLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.opType = SpellEffectOperationType.Add;
			effect.minChange = 15;						
			effect.propertyId = UnitProperties.AttackDmgMin;
			effect.coeficientPropertyId = UnitProperties.AttackDmgMax;			
			effect.duration = Util.secToFrames(10);
			effect.affectedByMagicResistance = false;
			effect.stackable = false;	
			
			var effect1:SpellEffect = new SpellEffect();
			effect1.opType = SpellEffectOperationType.Add;
			effect1.minChange = 15;						
			effect1.propertyId = UnitProperties.AttackDmgMax;
			effect1.coeficientPropertyId = UnitProperties.AttackDmgMax;
			effect1.duration = Util.secToFrames(10);
			effect1.affectedByMagicResistance = false;
			effect1.stackable = false;				
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1] );
			spell.aiHint = AiHintType.Buff;
			spell.name = "WarCryLvl1";
			spell.locName = "War Cry";
			spell.description = "Increases attack damage for all nearby friendly units by {minChange0}% for {effDuration0} sec.";	
			spell.castType = SpellCastType.Self;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.targetType = TargetType.Ally;					
			spell.icon = new BitmapAsset(BitmapResources.icoSpellWarCry.bitmapData);
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.WarCry;
			spell.radius = 5;
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 30).value;
			spell.cost = 50;
			spell.affectBuildings = false;
			spell.soundPack.hit = SoundResources.spellEffect1;				
			game.spellManager.addSpellType(spell);	
			
			warCryLvl1 = spell;
		}

		private function warCryLvl2Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.opType = SpellEffectOperationType.Add;
			effect.minChange = 18;						
			effect.propertyId = UnitProperties.AttackDmgMin;
			effect.coeficientPropertyId = UnitProperties.AttackDmgMax;			
			effect.duration = Util.secToFrames(15);
			effect.affectedByMagicResistance = false;
			effect.stackable = false;	
			
			var effect1:SpellEffect = new SpellEffect();
			effect1.opType = SpellEffectOperationType.Add;
			effect1.minChange = 18;						
			effect1.propertyId = UnitProperties.AttackDmgMax;
			effect1.coeficientPropertyId = UnitProperties.AttackDmgMax;
			effect1.duration = Util.secToFrames(15);
			effect1.affectedByMagicResistance = false;
			effect1.stackable = false;				
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1] );
			spell.aiHint = AiHintType.Buff;
			spell.name = "WarCryLvl2";
			spell.locName = "War Cry (2)";
			spell.description = "Increases attack damage for all nearby friendly units by {minChange0}% for {effDuration0} sec.";	
			spell.castType = SpellCastType.Self;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.targetType = TargetType.Ally;					
			spell.icon = new BitmapAsset(BitmapResources.icoSpellWarCry.bitmapData);
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.WarCry;
			spell.radius = 5;
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 30).value;
			spell.cost = 50;
			spell.affectBuildings = false;
			spell.soundPack.hit = SoundResources.spellEffect1;				
			game.spellManager.addSpellType(spell);	
			
			warCryLvl2 = spell;
		}
		
		private function deathWishLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.opType = SpellEffectOperationType.Add;
			effect.minChange = 40;						
			effect.propertyId = UnitProperties.AttackDmgMin;
			effect.coeficientPropertyId = UnitProperties.AttackDmgMin;			
			effect.duration = Util.secToFrames(30);
			effect.affectedByMagicResistance = false;
			effect.stackable = false;	
			
			var effect1:SpellEffect = new SpellEffect();
			effect1.opType = SpellEffectOperationType.Add;
			effect1.minChange = 40;						
			effect1.propertyId = UnitProperties.AttackDmgMax;
			effect1.coeficientPropertyId = UnitProperties.AttackDmgMax;
			effect1.duration = Util.secToFrames(30);
			effect1.affectedByMagicResistance = false;
			effect1.stackable = false;				

			var effect2:SpellEffect = new SpellEffect();
			effect2.opType = SpellEffectOperationType.Add;
			effect2.minChange = -40;						
			effect2.propertyId = UnitProperties.Armor;
			effect2.coeficientPropertyId = UnitProperties.Armor;
			effect2.duration = Util.secToFrames(30);
			effect2.affectedByMagicResistance = false;
			effect2.stackable = false;
						
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1, effect2] );
			spell.aiHint = AiHintType.Attack;
			spell.name = "DeathWishLvl1";
			spell.locName = "Death Wish";
			spell.description = "When activated you become Enraged, increasing your physical damage by {minChange0}% but reducing armor by {minChange2}%. Lasts {effDuration0} sec.";	
			spell.castType = SpellCastType.Self;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.targetType = TargetType.Self;					
			spell.icon = new BitmapAsset(BitmapResources.icoSpellDeathWish.bitmapData);
			spell.specialEffect = typesRepository.effectTypes.Skull;
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.RedSparks;
			spell.sfxDuration = effect2.duration;
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 60).value;
			spell.cost = 50;
			spell.soundPack.hit = SoundResources.magicHit7;			
			game.spellManager.addSpellType(spell);	
			
			deathWishLvl1 = spell;
		}

		private function berserkLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.opType = SpellEffectOperationType.Add;
			effect.minChange = -50;						
			effect.propertyId = UnitProperties.AttackDelay;
			effect.coeficientPropertyId = UnitProperties.AttackDelay;			
			effect.duration = Util.secToFrames(15);
			effect.affectedByMagicResistance = false;
			effect.stackable = false;	

			var effect1:SpellEffect = new SpellEffect();
			effect1.opType = SpellEffectOperationType.Add;
			effect1.minChange = -50;						
			effect1.propertyId = UnitProperties.AttackSpeed;
			effect1.coeficientPropertyId = UnitProperties.AttackSpeed;			
			effect1.duration = Util.secToFrames(15);
			effect1.affectedByMagicResistance = false;
			effect1.stackable = false;
			
			var effect2:SpellEffect = new SpellEffect();
			effect2.opType = SpellEffectOperationType.Add;
			effect2.minChange = 10;						
			effect2.propertyId = UnitProperties.AttackDelay;
			effect2.coeficientPropertyId = UnitProperties.AttackDelay;			
			effect2.duration = Util.secToFrames(25);
			effect2.affectedByMagicResistance = false;
			effect2.stackable = false;
			
			var effect3:SpellEffectColorTransform = new SpellEffectColorTransform();
			effect3.r = 100;
			effect3.b = -30;
			effect3.duration = effect1.duration;
			effect3.period = new GameTime(0, 1).value;		
									
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1, effect2, effect3] );
			spell.aiHint = AiHintType.Attack;
			spell.name = "BerserkLvl1";
			spell.locName = "Berserk";
			spell.description = "Increases attack speed by {minChange0}% for {effDuration0} sec. After that caster becomes fatigued, reducing attack speed by {minChange2}% for 10 sec.";	
			spell.castType = SpellCastType.Self;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.targetType = TargetType.Self;					
			spell.icon = new BitmapAsset(BitmapResources.icoSpellBeserk.bitmapData);
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Aura1;
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 60).value;
			spell.cost = 50;
			spell.soundPack.hit = SoundResources.magicHit7;				
			game.spellManager.addSpellType(spell);	
			
			berserkLvl1 = spell;
		}

		private function berserkLvl2Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.opType = SpellEffectOperationType.Add;
			effect.minChange = -50;						
			effect.propertyId = UnitProperties.AttackDelay;
			effect.coeficientPropertyId = UnitProperties.AttackDelay;			
			effect.duration = Util.secToFrames(20);
			effect.affectedByMagicResistance = false;
			effect.stackable = false;	

			var effect1:SpellEffect = new SpellEffect();
			effect1.opType = SpellEffectOperationType.Add;
			effect1.minChange = -50;						
			effect1.propertyId = UnitProperties.AttackSpeed;
			effect1.coeficientPropertyId = UnitProperties.AttackSpeed;			
			effect1.duration = Util.secToFrames(20);
			effect1.affectedByMagicResistance = false;
			effect1.stackable = false;
			
			var effect2:SpellEffect = new SpellEffect();
			effect2.opType = SpellEffectOperationType.Add;
			effect2.minChange = 10;						
			effect2.propertyId = UnitProperties.AttackDelay;
			effect2.coeficientPropertyId = UnitProperties.AttackDelay;			
			effect2.duration = Util.secToFrames(25);
			effect2.affectedByMagicResistance = false;
			effect2.stackable = false;
			
			var effect3:SpellEffectColorTransform = new SpellEffectColorTransform();
			effect3.r = 100;
			effect3.b = -30;
			effect3.duration = effect1.duration;
			effect3.period = new GameTime(0, 1).value;		

			var effect4:SpellEffect = new SpellEffect();
			effect4.opType = SpellEffectOperationType.Add;
			effect4.minChange = 3;						
			effect4.propertyId = UnitProperties.AttackDmgMin;			
			effect4.duration = Util.secToFrames(20);
			effect4.affectedByMagicResistance = false;
			effect4.stackable = false;

			var effect5:SpellEffect = new SpellEffect();
			effect5.opType = SpellEffectOperationType.Add;
			effect5.minChange = 3;						
			effect5.propertyId = UnitProperties.AttackDmgMax;			
			effect5.duration = Util.secToFrames(20);
			effect5.affectedByMagicResistance = false;
			effect5.stackable = false;
															
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1, effect2, effect3, effect4, effect5] );
			spell.aiHint = AiHintType.Attack;
			spell.name = "BerserkLvl2";
			spell.locName = "Berserk (2)";
			spell.description = "Increases attack speeds by {minChange0}% and attack damage by {minChange4} for {effDuration0} sec. After that caster becomes fatigued, reducing attack speed by {minChange2}% for 5 sec.";	
			spell.castType = SpellCastType.Self;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.targetType = TargetType.Self;					
			spell.icon = new BitmapAsset(BitmapResources.icoSpellBeserk.bitmapData);
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Aura1;
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 60).value;
			spell.cost = 50;
			spell.soundPack.hit = SoundResources.magicHit7;				
			game.spellManager.addSpellType(spell);	
			
			berserkLvl2 = spell;
		}
		
		private function iceArrowLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.minChange = -80;
			effect.maxChange = -100;
			effect.dmgSubtype = SpellDamageSubtype.Frost;			
			effect.propertyId = UnitProperties.Health;
			effect.critChance = 2;

			var effect1:SpellEffect = new SpellEffect();
			effect1.minChange = 50;
			effect1.propertyId = UnitProperties.MoveSpeed;
			effect1.dmgSubtype = SpellDamageSubtype.Frost;
			effect1.coeficientPropertyId = UnitProperties.MoveSpeed;
			effect1.duration = new GameTime(0, 6).value; 
			
			var effect2:SpellEffectColorTransform = new SpellEffectColorTransform();
			effect2.duration = effect1.duration;
			effect2.period =  new GameTime(0, 1).value;
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1, effect2] );
			spell.aiHint = AiHintType.Attack;
			spell.range = 10;
			spell.name = "IceArrowLvl1";
			spell.locName = "Ice Arrow";
			spell.description = "Launches a bolt of frost at the enemy, causing {minChange0} to {maxChange0} Frost damage and slowing movement speed by {minChange1}% for {effDuration1} sec.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 70;
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.magicHit1;			
			spell.soundPack.attack = SoundResources.magicShoot1;					
			spell.icon = new BitmapAsset(BitmapResources.icoSpellIceArrow.bitmapData);
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Sparks3;
			spell.projectileSpeed = 3;
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 8).value;
			spell.projectileModel = Game.instance().spriteRepository.getByName("ProjectileIceShard1");
			spell.affectBuildings = false;
			game.spellManager.addSpellType(spell);	
			
			iceArrowLvl1 = spell;
		}

		private function iceArrowLvl2Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.minChange = -140;
			effect.maxChange = -140;
			effect.dmgSubtype = SpellDamageSubtype.Frost;			
			effect.propertyId = UnitProperties.Health;
			effect.critChance = 2;

			var effect1:SpellEffect = new SpellEffect();
			effect1.minChange = 60;
			effect1.propertyId = UnitProperties.MoveSpeed;
			effect1.dmgSubtype = SpellDamageSubtype.Frost;
			effect1.coeficientPropertyId = UnitProperties.MoveSpeed;
			effect1.duration = new GameTime(0, 6).value; 
			
			var effect2:SpellEffectColorTransform = new SpellEffectColorTransform();
			effect2.duration = effect1.duration;
			effect2.period =  new GameTime(0, 1).value;
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1, effect2] );
			spell.aiHint = AiHintType.Attack;
			spell.range = 10;
			spell.name = "IceArrowLvl2";
			spell.locName = "Ice Arrow (2)";
			spell.description = "Launches a bolt of frost at the enemy, causing {minChange0} Frost damage and slowing movement speed by {minChange1}% for {effDuration1} sec.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 75;
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.magicHit1;			
			spell.soundPack.attack = SoundResources.magicShoot1;					
			spell.icon = new BitmapAsset(BitmapResources.icoSpellIceArrow.bitmapData);
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Sparks3;
			spell.projectileSpeed = 3;
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 8).value;
			spell.projectileModel = Game.instance().spriteRepository.getByName("ProjectileIceShard1");
			spell.affectBuildings = false;
			game.spellManager.addSpellType(spell);	
			
			iceArrowLvl2 = spell;
		}
		
		private function iceBlockLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.propertyId = UnitProperties.ArmorType;
			effect.minChange = ArmorType.DIVINE;
			effect.opType = SpellEffectOperationType.Set;
			effect.duration = new GameTime(0, 12).value;
			effect.affectedByMagicResistance = false;
			effect.stackable = false;
			
			var effect1:SpellEffect = new SpellEffect();
			effect1.propertyId = UnitProperties.MagicRes;
			effect1.minChange = 100;
			effect1.opType = SpellEffectOperationType.Set;
			effect1.duration = new GameTime(0, 12).value;
			effect1.affectedByMagicResistance = false;
			effect1.stackable = false;			

			var effect2:SpellEffect = new SpellEffect();
			effect2.propertyId = UnitProperties.CanMove;
			effect2.minChange = 0;
			effect2.opType = SpellEffectOperationType.Set;
			effect2.duration = new GameTime(0, 12).value;
			effect2.affectedByMagicResistance = false;
			effect2.stackable = false;

			var effect3:SpellEffect = new SpellEffect();
			effect3.propertyId = UnitProperties.AttackRange;
			effect3.minChange = 0;
			effect3.opType = SpellEffectOperationType.Set;
			effect3.duration = new GameTime(0, 10).value;
			effect3.affectedByMagicResistance = false;
			effect3.stackable = false;

			var effect4:SpellEffect = new SpellEffect();
			effect4.propertyId = UnitProperties.CastDelay;
			effect4.minChange = Spell.MAX_CAST_DELAY;
			effect4.opType = SpellEffectOperationType.Set;
			effect4.duration = new GameTime(0, 10).value;
			effect4.affectedByMagicResistance = false;
			effect4.stackable = false;
															
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1, effect2, effect3, effect4] );
			spell.aiHint = AiHintType.ProtectionCritical;
			spell.name = "IceBlockLvl1";
			spell.locName = "Ice Block";
			spell.description = "You become encased in a block of ice, protecting you from all physical attacks and spells for {effDuration0} sec, but during that time you cannot attack, move or cast spells.";	
			spell.castType = SpellCastType.Self;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 80;
			spell.costProperty = UnitProperties.Mana;
			spell.targetType = TargetType.Self;			
			spell.soundPack.hit = SoundResources.magicHit1;		
			spell.icon = new BitmapAsset(BitmapResources.icoSpellIceBlock.bitmapData);
			spell.specialEffect = typesRepository.effectTypes.Ice3;
			spell.snapToUnit = true;
			spell.sfxDuration = effect.duration;
			spell.cooldown = new GameTime(0, 60).value;
			game.spellManager.addSpellType(spell);	
			
			iceBlockLvl1 = spell;
		}

		private function iceStormLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.minChange = -4;
			effect.propertyId = UnitProperties.Health;
			effect.dmgSubtype = SpellDamageSubtype.Frost;			

			var effect1:SpellEffect = new SpellEffect();
			effect1.minChange = 60;
			effect1.propertyId = UnitProperties.MoveSpeed;
			effect1.coeficientPropertyId = UnitProperties.MoveSpeed;
			effect1.dmgSubtype = SpellDamageSubtype.Frost;
			effect1.duration = new GameTime(0, 1).value;
			effect1.stackable = false; 
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1] );
			spell.aiHint = AiHintType.Attack;
			spell.range = 7;
			spell.name = "IceStormLvl1";
			spell.locName = "Blizzard";
			spell.description = "Ice shards pelt the target area doing 400 Frost damage over {duration} sec and slowing affected target movement speed by {minChange1}%.";	
			spell.castType = SpellCastType.Place;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 175;
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.freeze;	
			spell.soundPack.hitRepeat = 4;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellIceShards.bitmapData);
			spell.specialEffect = typesRepository.effectTypes.Ice2;
			spell.projectileSpeed = 5;
			spell.projectileModel = Game.instance().spriteRepository.getByName("ProjectileIceShard1");
			spell.radius = 3;
			spell.cooldown = new GameTime(0, 100).value;
			spell.visualType = SpellVisualType.Rain;
			spell.duration = Util.secToFrames(5);
			spell.rainDelay = Util.secToFrames(0.05);
			game.spellManager.addSpellType(spell);	
			
			iceStormLvl1 = spell;
		}

		private function iceShieldLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.propertyId = UnitProperties.DamageRetention;
			effect.minChange = 10;
			effect.opType = SpellEffectOperationType.Add;
			effect.duration = new GameTime(0, 25).value;
			effect.affectedByMagicResistance = false;
			effect.stackable = false;
			
			var effect1:SpellEffect = new SpellEffect();
			effect1.propertyId = UnitProperties.Armor;
			effect1.minChange = 5;
			effect1.opType = SpellEffectOperationType.Add;
			effect1.duration = new GameTime(0, 25).value;
			effect1.affectedByMagicResistance = false;
			effect1.stackable = false;			
						
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1] );
			spell.aiHint = AiHintType.Protection;
			spell.name = "IceShieldLvl1";
			spell.locName = "Shield of Ice";
			spell.description = "Causes {minChange0} Ice damage when hit, increases your armor by {minChange1} for {effDuration0} sec.";	
			spell.castType = SpellCastType.Self;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 100;
			spell.costProperty = UnitProperties.Mana;
			spell.targetType = TargetType.Self;			
			spell.soundPack.hit = SoundResources.magicHit1;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellProtectIce.bitmapData);
			spell.specialEffect = typesRepository.effectTypes.ShieldBlue;
			spell.snapToUnit = true;
			spell.sfxDuration = effect.duration;
			spell.cooldown = new GameTime(0, 50).value;
			game.spellManager.addSpellType(spell);	
			
			iceShieldLvl1 = spell;
		}
		
		private function iceShieldLvl2Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.propertyId = UnitProperties.DamageRetention;
			effect.minChange = 15;
			effect.opType = SpellEffectOperationType.Add;
			effect.duration = new GameTime(0, 25).value;
			effect.affectedByMagicResistance = false;
			effect.stackable = false;
			
			var effect1:SpellEffect = new SpellEffect();
			effect1.propertyId = UnitProperties.Armor;
			effect1.minChange = 8;
			effect1.opType = SpellEffectOperationType.Add;
			effect1.duration = new GameTime(0, 25).value;
			effect1.affectedByMagicResistance = false;
			effect1.stackable = false;			
						
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1] );
			spell.aiHint = AiHintType.Protection;
			spell.name = "IceShieldLvl2";
			spell.locName = "Shield of Ice (2)";
			spell.description = "Causes {minChange0} Ice damage when hit, increases your armor by {minChange1} for {effDuration0} sec.";	
			spell.castType = SpellCastType.Self;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 100;
			spell.costProperty = UnitProperties.Mana;
			spell.targetType = TargetType.Self;			
			spell.soundPack.hit = SoundResources.magicHit1;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellProtectIce.bitmapData);
			spell.specialEffect = typesRepository.effectTypes.ShieldBlue;
			spell.snapToUnit = true;
			spell.sfxDuration = effect.duration;
			spell.cooldown = new GameTime(0, 50).value;
			game.spellManager.addSpellType(spell);	
			
			iceShieldLvl2 = spell;
		}		

		private function deathBlowLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffectInstantKill = new SpellEffectInstantKill();				
			effect.resitDamageCoeff = 4;

			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.Attack;
			spell.name = "DeathBlowLvl1";
			spell.locName = "Death Blow";
			spell.description = "Instantly kills a target. Heroes and buildings suffer 4x weapon damage instead.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.magicShoot4;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellDeathBlow.bitmapData);
			spell.range = 1;
			spell.cost = 90;
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Blood;
			spell.specialEffect = typesRepository.effectTypes.Sparks2Red;			
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 120).value;
			spell.quakeDuration = Util.secToFrames(1);
			game.spellManager.addSpellType(spell);	
			
			deathBlowLvl1 = spell;
		}
				
		private function summonWaterElementalLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffectSummon = new SpellEffectSummon();
			effect.unitTypeId = typesRepository.unitTypes.IceElemental.id;
			effect.summonLifeTime = new GameTime(0, 60).value;
			effect.summonEffectId = typesRepository.effectTypes.WaterJet.id;
			effect.summonMaxCount = 1;

			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.Summon;
			spell.name = "SummonWaterElementalLvl1";
			spell.locName = "Summon Water Elemental";
			spell.description = "Summon a Water Elemental to fight for the caster for {summonLifeTime0} sec.";	
			spell.castType = SpellCastType.Place;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 100;
			spell.targetType = TargetType.Place;			
			spell.soundPack.hit = SoundResources.waterHit1;	
			spell.range = 6;		
			spell.cooldown = new GameTime(0, 45).value;
			spell.icon = new BitmapAsset(BitmapResources.icoIceGolem.bitmapData);
			game.spellManager.addSpellType(spell);	
			
			summonWaterElementalLvl1 = spell;
		}

		private function scorchLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.minChange = -70;
			effect.maxChange = -90;
			effect.dmgSubtype = SpellDamageSubtype.Fire;			
			effect.propertyId = UnitProperties.Health;
			effect.critChance = 25;	
			effect.critOnSameDamage = true;
						
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.Attack;
			spell.range = 8;
			spell.name = "ScorchLvl1";
			spell.locName = "Scorch";
			spell.description = "Fires a jet of flame, burning target for {minChange0} to {maxChange0} points of damage. This spell has a very high critical strike chance. If target is under immolate effect - spell will consume it and crit with 100% chance.\r\nMay remove freezing effects from the target.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 65;
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.magicHit6;	
			spell.cooldown = new GameTime(0, 4).value;		
			spell.icon = new BitmapAsset(BitmapResources.icoSpellFireExplosion.bitmapData);
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.FireExplosion2;
			spell.snapToUnit = true;
			game.spellManager.addSpellType(spell);	
			
			scorchLvl1 = spell;
		}

		private function scorchLvl2Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.minChange = -90;
			effect.maxChange = -110;
			effect.dmgSubtype = SpellDamageSubtype.Fire;			
			effect.propertyId = UnitProperties.Health;	
			effect.critChance = 27;	
			effect.critOnSameDamage = true;
						
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.Attack;
			spell.range = 8;
			spell.name = "ScorchLvl2";
			spell.locName = "Scorch (2)";
			spell.description = "Fires a jet of flame, burning target for {minChange0} to {maxChange0} points of damage. Critical strike chance is increased by 2%. If target is under immolate effect - spell will consume it and crit with 100% chance.\r\nMay remove freezing effects from the target.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 65;
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.magicHit6;	
			spell.cooldown = new GameTime(0, 4).value;		
			spell.icon = new BitmapAsset(BitmapResources.icoSpellFireExplosion.bitmapData);
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.FireExplosion2;
			spell.snapToUnit = true;
			game.spellManager.addSpellType(spell);	
			
			scorchLvl2 = spell;
		}
		
		private function scorchLvl3Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.minChange = -110;
			effect.maxChange = -140;
			effect.dmgSubtype = SpellDamageSubtype.Fire;			
			effect.propertyId = UnitProperties.Health;	
			effect.critChance = 30;	
			effect.critOnSameDamage = true;
						
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.Attack;
			spell.range = 8;
			spell.name = "ScorchLvl3";
			spell.locName = "Scorch (3)";
			spell.description = "Fires a jet of flame, burning target for {minChange0} to {maxChange0} points of damage. Critical strike chance is increased by 2%. If target is under immolate effect - spell will consume it and crit with 100% chance.\r\nMay remove freezing effects from the target.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 75;
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.magicHit6;	
			spell.cooldown = new GameTime(0, 4).value;		
			spell.icon = new BitmapAsset(BitmapResources.icoSpellFireExplosion.bitmapData);
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.FireExplosion2;
			spell.specialEffect = typesRepository.effectTypes.Sparks3Red;
			spell.snapToUnit = true;
			game.spellManager.addSpellType(spell);	
			
			scorchLvl3 = spell;
		}		
		
		private function fireStormLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.minChange = -5;
			effect.maxChange = -6;			
			effect.dmgSubtype = SpellDamageSubtype.Fire;			
			effect.propertyId = UnitProperties.Health;
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.Attack;
			spell.range = 8;
			spell.name = "FireStormLvl1";
			spell.locName = "Fire Storm";
			spell.description = "Calls down a molten rain, burning all enemies in a selected area for 550 Fire damage for {duration} sec. May remove freezing effects.";	
			spell.castType = SpellCastType.Place;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 175;
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.fireStorm;	
			spell.soundPack.hitRepeat = 3;		
			spell.icon = new BitmapAsset(BitmapResources.icoSpellFireStorm.bitmapData);
			spell.specialEffect = typesRepository.effectTypes.FireExplosion1;
			spell.projectileSpeed = 5;
			spell.projectileModel = Game.instance().spriteRepository.getByName("ProjectileFireball1");
			spell.radius = 3;
			spell.cooldown = new GameTime(0, 110).value;
			spell.visualType = SpellVisualType.Rain;
			spell.duration = Util.secToFrames(5);
			spell.rainDelay = Util.secToFrames(0.05);
			game.spellManager.addSpellType(spell);	
			
			fireStormLvl1 = spell;
		}

		private function polymorphLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffectChangeModel = new SpellEffectChangeModel();
			effect.modelName = "UnitSheep";
			effect.duration = new GameTime(0, 20).value;
			effect.period = effect.duration;
			effect.stackable = false;
			
			// prohibit attacks
			var effect1:SpellEffect = new SpellEffect();
			effect1.propertyId = UnitProperties.AttackRange;
			effect1.duration = new GameTime(0, 20).value;
			effect1.stackable = false;
			effect1.minChange = 0;
			effect1.opType = SpellEffectOperationType.Set;	

			// prohibit cast
			var effect2:SpellEffect = new SpellEffect();
			effect2.propertyId = UnitProperties.CastDelay;
			effect2.duration = new GameTime(0, 20).value;
			effect2.stackable = false;
			effect2.minChange = Spell.MAX_CAST_DELAY;
			effect2.opType = SpellEffectOperationType.Set;	
			effect2.stackable = false;

			var effect3:SpellEffect = new SpellEffect();
			effect3.propertyId = UnitProperties.HealthRegenRate;
			effect3.coeficientPropertyId = UnitProperties.HealthRegenRate;			
			effect3.duration = new GameTime(0, 20).value;
			effect3.stackable = false;
			effect3.minChange = 130;
			effect3.opType = SpellEffectOperationType.Set;	
			effect3.stackable = false;

			var effect4:SpellEffect = new SpellEffect();
			effect4.propertyId = UnitProperties.MoveSpeed;
			effect4.coeficientPropertyId = UnitProperties.MoveSpeed;
			effect4.duration = new GameTime(0, 20).value;
			effect4.stackable = false;
			effect4.minChange = 50;
			effect4.opType = SpellEffectOperationType.Add;
															
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1, effect2, effect3, effect4] );
			spell.aiHint = AiHintType.Ultimate;
			spell.name = "PolymorphLvl1";
			spell.locName = "Polymorph";
			spell.description = "Transforms the enemy into a sheep, forcing it to wander around for up to {effDuration0} sec. While wandering, the sheep cannot attack or cast spells but will regenerate health faster.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 50;
			spell.range = 7;
			spell.costProperty = UnitProperties.Mana;
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.spellEffect2;	
			spell.cooldown = new GameTime(0, 120).value;		
			spell.icon = new BitmapAsset(BitmapResources.icoSpellPolymorph.bitmapData);
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Sparks2;
			spell.snapToUnit = true;
			spell.affectBuildings = false;
			game.spellManager.addSpellType(spell);	
			
			polymorphLvl1 = spell;
		}

		private function avatarOfWarLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffectChangeModel = new SpellEffectChangeModel();
			effect.modelName = "UnitAvatarOfWar";
			effect.duration = new GameTime(0, 35).value;
			effect.period = effect.duration;
			effect.stackable = false;
			
			// set armor
			var effect1:SpellEffect = new SpellEffect();
			effect1.propertyId = UnitProperties.Armor;
			effect1.duration = effect.duration;
			effect1.stackable = false;
			effect1.minChange = 4;	
			effect1.affectedByMagicResistance = false;

			var effect2:SpellEffect = new SpellEffect();
			effect2.propertyId = UnitProperties.AttackDmgMin;
			effect2.duration = effect.duration;
			effect2.stackable = false;
			effect2.minChange = 20;	
			effect2.affectedByMagicResistance = false;
					
			var effect3:SpellEffect = new SpellEffect();
			effect3.propertyId = UnitProperties.AttackDmgMax;
			effect3.duration = effect.duration;
			effect3.stackable = false;
			effect3.minChange = effect2.minChange;	
			effect3.affectedByMagicResistance = false;						

			var effect4:SpellEffect = new SpellEffect();
			effect4.propertyId = UnitProperties.MaxHealth;
			effect4.duration = effect.duration;
			effect4.stackable = false;
			effect4.minChange = 400;	
			effect4.affectedByMagicResistance = false;

			var effect5:SpellEffect = new SpellEffect();
			effect5.propertyId = UnitProperties.Health;
			effect5.duration = 1;
			effect5.stackable = false;
			effect5.minChange = effect4.minChange;	
			effect5.affectedByMagicResistance = false;

			var effect6:SpellEffect = new SpellEffect();
			effect6.propertyId = UnitProperties.MagicRes;
			effect6.opType = SpellEffectOperationType.Set;
			effect6.duration = effect.duration;
			effect6.stackable = false;
			effect6.minChange = 70;	
			effect6.affectedByMagicResistance = false;
																		
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1, effect2, effect3, effect4, effect5, effect6] );
			spell.aiHint = AiHintType.Ultimate;
			spell.name = "AvatarOfWarLvl1";
			spell.locName = "Avatar Of War";
			spell.description = "Transforms the caster into Avatar Of War, increasing armor by {minChange1}, damage by {minChange2}, health by {minChange4} and setting magic resistance to {minChange6}.";	
			spell.castType = SpellCastType.Self;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 50;
			spell.costProperty = UnitProperties.Mana;
			spell.targetType = TargetType.Self;			
			spell.soundPack.hit = SoundResources.canonShoot1;	
			spell.cooldown = new GameTime(0, 120).value;		
			spell.icon = new BitmapAsset(BitmapResources.icoShadow.bitmapData);
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Sparks3;
			game.spellManager.addSpellType(spell);	
			
			avatarOfWarLvl1 = spell;
		}

		private function imprisonLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.propertyId = UnitProperties.CanMove;
			effect.duration = new GameTime(0, 25).value;
			effect.stackable = false;
			effect.minChange = 0;
			effect.opType = SpellEffectOperationType.Set;	
			effect.affectedByMagicResistance = false;		
			
			// prohibit attacks
			var effect1:SpellEffect = new SpellEffect();
			effect1.propertyId = UnitProperties.AttackRange;
			effect1.duration = new GameTime(0, 25).value;
			effect1.stackable = false;
			effect1.minChange = 0;
			effect1.opType = SpellEffectOperationType.Set;	
			effect1.affectedByMagicResistance = false;
			
			// prohibit cast
			var effect2:SpellEffect = new SpellEffect();
			effect2.propertyId = UnitProperties.CastDelay;
			effect2.duration = new GameTime(0, 25).value;
			effect2.stackable = false;
			effect2.minChange = Spell.MAX_CAST_DELAY;
			effect2.opType = SpellEffectOperationType.Set;	
			effect2.stackable = false;
			effect2.affectedByMagicResistance = false;
															
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1, effect2] );
			spell.aiHint = AiHintType.Attack;
			spell.name = "ImprisonLvl1";
			spell.locName = "Imprison";
			spell.description = "An impenetrable wall surrounds the target for {effDuration0} sec, preventing it from attacking, moving or casting spells. While imprisoned target is completely invulnerable. This spell can not be resisted.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 50;
			spell.range = 4;
			spell.costProperty = UnitProperties.Mana;
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.dispell;	
			spell.cooldown = new GameTime(0, 120).value;		
			spell.icon = new BitmapAsset(BitmapResources.icoSpellBanish.bitmapData);
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Leafs1;
			spell.effectSfxDuration = effect.duration;
			spell.snapToUnit = true;
			spell.affectBuildings = false;
			game.spellManager.addSpellType(spell);	
			
			imprisonLvl1 = spell;
		}
		
		private function deathCallLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffectInstantKill = new SpellEffectInstantKill();
			effect.applyChance = 25;
			effect.affectNonOrganic = false;
			effect.resitDamageCoeff = 1.2;					
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.Ultimate;
			spell.name = "DeathCallLvl1";
			spell.locName = "Death Call";
			spell.description = "All enemies around the caster are killed instantly with {applyChance0}% chance. Heroes suffers normal caster damage instead. Can be resisted, in which case target suffers 120% of caster main attack damage. Building, undead and mechanical targets are not affected.";	
			spell.castType = SpellCastType.Self;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.spellEffectIncantation;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellDeathWish.bitmapData);
			spell.radius = 3;
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.GroundFire;
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 120).value;
			spell.cost = 175;
			spell.costProperty = UnitProperties.Mana;
			spell.affectBuildings = false;
			spell.quakeDuration = Util.secToFrames(0.8);
			game.spellManager.addSpellType(spell);	
			
			deathCallLvl1 = spell;
		}

		private function healingLightLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.opType = SpellEffectOperationType.Add;
			effect.minChange = 120;						
			effect.propertyId = UnitProperties.Health;
			effect.affectedByMagicResistance = false;
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.Heal;
			spell.name = "HealingLightLvl1";
			spell.locName = "Healing Light";
			spell.description = "Wave of healing light heals all ally targets around caster. Lasts for {duration} sec.";	
			spell.castType = SpellCastType.Self;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.targetType = TargetType.Ally;					
			spell.icon = new BitmapAsset(BitmapResources.icoSpellImplosion.bitmapData);
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Heal;
			spell.snapToUnit = true;
			spell.cost = 150;
			spell.radius = 3;
			spell.cooldown = new GameTime(0, 150).value;
			spell.duration = Util.secToFrames(10);
			spell.affectBuildings = false;
			spell.soundPack.hit = SoundResources.heal;
			spell.period = Util.secToFrames(0.3);
			game.spellManager.addSpellType(spell);	
			
			healingLightLvl1 = spell;
		}

		private function discordLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.opType = SpellEffectOperationType.Add;
			effect.minChange = -15;						
			effect.propertyId = UnitProperties.MagicRes;
			effect.affectedByMagicResistance = false;
			effect.duration = new GameTime(0, 10).value;
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.Heal;
			spell.name = "DiscordLvl1";
			spell.locName = "Discord";
			spell.description = "Applies a debuff on all enemy units in selected area, causing them to have reduced magic resistance for {effDuration0} sec.";	
			spell.castType = SpellCastType.Self;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.targetType = TargetType.Self;					
			spell.icon = new BitmapAsset(BitmapResources.icoItemDiscord.bitmapData);
			spell.specialEffect = typesRepository.effectTypes.Cleanse;
			spell.snapToUnit = true;
			spell.cost = 65;
			spell.cooldown = new GameTime(0, 40).value;
			spell.affectBuildings = false;
			spell.soundPack.hit = SoundResources.heal;
			game.spellManager.addSpellType(spell);	
			
			discordLvl1 = spell;
		}
				
		private function rejuvenateLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.opType = SpellEffectOperationType.Add;
			effect.minChange = 15;						
			effect.propertyId = UnitProperties.Health;
			effect.affectedByMagicResistance = false;
			effect.duration = new GameTime(0, 10).value;
			effect.period = new GameTime(0, 1).value;
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.Heal;
			spell.name = "RejuvenateLvl1";
			spell.locName = "Rejuvenate";
			spell.description = "Restores 150 HP over 10 seconds. Can only be cast on self.";	
			spell.castType = SpellCastType.Self;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.targetType = TargetType.Self;					
			spell.icon = new BitmapAsset(BitmapResources.icoItemAmulet3.bitmapData);
			spell.specialEffect = typesRepository.effectTypes.Heal;
			spell.snapToUnit = true;
			spell.cost = 50;
			spell.cooldown = new GameTime(0, 65).value;
			spell.affectBuildings = false;
			spell.soundPack.hit = SoundResources.heal;
			game.spellManager.addSpellType(spell);	
			
			rejuvenateLvl1 = spell;
		}
		
		private function lightningStrikeInit(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.minChange = -20;
			effect.maxChange = -22;
			effect.propertyId = UnitProperties.Health;
			effect.critChance = 1;
			
			var effect1:SpellEffect = new SpellEffect();
			effect1.minChange = -1;
			effect1.propertyId = UnitProperties.Health;	
			effect1.coeficientPropertyId = UnitProperties.Mana;			

			var effect2:SpellEffect = new SpellEffect();
			effect2.minChange = Constants.FALSE;
			effect2.opType = SpellEffectOperationType.Set;
			effect2.propertyId = UnitProperties.CanMove;
			effect2.duration = new GameTime(0, 3).value;
			effect2.stackable = false;
			effect2.affectedByMagicResistance = false;
						
			var effect3:SpellEffect = new SpellEffect();
			effect3.minChange = 0;
			effect3.opType = SpellEffectOperationType.Set;
			effect3.propertyId = UnitProperties.AttackRange;
			effect3.duration = new GameTime(0, 3).value;
			effect3.stackable = false;
			effect3.affectedByMagicResistance = false;
									
			var effect4:SpellEffect = new SpellEffect();
			effect4.minChange = Spell.MAX_CAST_DELAY;
			effect4.propertyId = UnitProperties.CastDelay;
			effect4.opType = SpellEffectOperationType.Set;
			effect4.duration = new GameTime(0, 3).value;			
			effect4.stackable = false;
			effect3.affectedByMagicResistance = false;
									
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1, effect2, effect3, effect4] );
			spell.aiHint = AiHintType.Attack;
			spell.range = 6;
			spell.name = "LightningStrikeLvl1";
			spell.locName = "Lightning Strike";
			spell.description = "Inflicts 100 to 110 Magic damage and stuns the target for {effDuration2} sec.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 100;
			spell.cooldown = new GameTime(0, 30).value;
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.thunder;	
			spell.soundPack.attack = SoundResources.magicShoot3;						
			spell.icon = new BitmapAsset(BitmapResources.icoItemAxe2.bitmapData);
			spell.specialEffect = typesRepository.effectTypes.Sparks2;
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Stun;
			spell.effectSfxDuration = effect2.duration/2;
			spell.specialGeneratedEffect = typesRepository.effectTypes.GeneratedLightningFork;
			spell.sfxDuration = Util.secToFrames(0.2);
			spell.affectBuildings = false;
			spell.snapToUnit = true;
			spell.rainDelay = 1;
			spell.duration = 5;
			spell.visualType = SpellVisualType.Rain;
			game.spellManager.addSpellType(spell);	
			
			lightningStrike = spell;
		}		

		private function lightningStormLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.minChange = -2;
			effect.maxChange = -2;						
			effect.propertyId = UnitProperties.Health;
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.Attack;
			spell.range = 8;
			spell.name = "ThunderStormLvl1";
			spell.locName = "Thunderstorm";
			spell.description = "Calls down a thunder storm, burning all enemies in a selected area for 200 Magic damage for {duration} sec.";	
			spell.castType = SpellCastType.Place;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 150;
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.magicShoot3;	
			spell.soundPack.hitRepeat = 5;		
			spell.icon = new BitmapAsset(BitmapResources.icoItemAmuletThunder.bitmapData);
			spell.specialEffect = typesRepository.effectTypes.Fog1;
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Sparks3;			
			spell.projectileSpeed = 3;
			spell.projectileModel = Game.instance().spriteRepository.getByName("ProjectileLightning1");
			spell.radius = 4;
			spell.cooldown = new GameTime(0, 110).value;
			spell.visualType = SpellVisualType.Rain;
			spell.duration = Util.secToFrames(5);
			spell.rainDelay = Util.secToFrames(0.05);
			game.spellManager.addSpellType(spell);	
			
			lightningStormLvl1 = spell;
		}
		
		private function webLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect1:SpellEffect = new SpellEffect();
			effect1.minChange = Constants.FALSE;
			effect1.opType = SpellEffectOperationType.Set;
			effect1.propertyId = UnitProperties.CanMove;
			effect1.duration = new GameTime(0, 6).value;
			effect1.affectedByMagicResistance = false;
			
			var effect2:SpellEffect = new SpellEffect();
			effect2.minChange = 0;
			effect2.opType = SpellEffectOperationType.Set;
			effect2.propertyId = UnitProperties.AttackRange;
			effect2.duration = new GameTime(0, 1).value;
			
			var effect3:SpellEffect = new SpellEffect();
			effect3.minChange = Spell.MAX_CAST_DELAY;
			effect3.propertyId = UnitProperties.CastDelay;
			effect3.opType = SpellEffectOperationType.Set;
			effect3.duration = new GameTime(0, 1).value;	
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect3, effect1, effect2] );
			spell.aiHint = AiHintType.Attack;
			spell.range = 9;
			spell.name = "Web";
			spell.locName = "Web";
			spell.description = "Launches a web at the enemy rooting target for {effDuration0} sec.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 75;
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.hitWeb;			
			spell.soundPack.attack = SoundResources.bladeShoot1;					
			spell.icon = new BitmapAsset(BitmapResources.icoItemSpiderTotem.bitmapData);
			spell.specialEffect = typesRepository.effectTypes.Web;
			spell.sfxDuration = effect1.duration;
			spell.projectileSpeed = 2;
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 30).value;
			spell.projectileModel = Game.instance().spriteRepository.getByName("ProjectileWeb");
			spell.affectBuildings = false;
			game.spellManager.addSpellType(spell);	
			
			webLvl1 = spell;
		}	

		private function trapLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect1:SpellEffect = new SpellEffect();
			effect1.minChange = Constants.FALSE;
			effect1.opType = SpellEffectOperationType.Set;
			effect1.propertyId = UnitProperties.CanMove;
			effect1.duration = new GameTime(0, 8).value;
			effect1.affectedByMagicResistance = false;
			
			var effect2:SpellEffect = new SpellEffect();
			effect2.minChange = 0;
			effect2.opType = SpellEffectOperationType.Set;
			effect2.propertyId = UnitProperties.AttackRange;
			effect2.duration = new GameTime(0, 1.5).value;
			
			var effect3:SpellEffect = new SpellEffect();
			effect3.minChange = Spell.MAX_CAST_DELAY;
			effect3.propertyId = UnitProperties.CastDelay;
			effect3.opType = SpellEffectOperationType.Set;
			effect3.duration = new GameTime(0, 1.5).value;	
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect1, effect2, effect3] );
			spell.aiHint = AiHintType.Attack;
			spell.range = 9;
			spell.name = "TrapLvl1";
			spell.locName = "Trap";
			spell.description = "Launches a web at the enemy trapping target for {effDuration0} sec.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 75;
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.hitWeb;			
			spell.soundPack.attack = SoundResources.bladeShoot1;					
			spell.icon = new BitmapAsset(BitmapResources.icoSpellTrap.bitmapData);
			spell.specialEffect = typesRepository.effectTypes.Web;
			spell.sfxDuration = effect1.duration;
			spell.projectileSpeed = 2;
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 30).value;
			spell.projectileModel = Game.instance().spriteRepository.getByName("ProjectileWeb");
			spell.affectBuildings = false;
			game.spellManager.addSpellType(spell);	
			
			trapLvl1 = spell;
		}
				
		private function fireRayLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.minChange = -55;
			effect.maxChange = -65;
			effect.dmgSubtype = SpellDamageSubtype.Fire;			
			effect.propertyId = UnitProperties.Health;
			effect.critChance = 8;	
			effect.critOnSameDamage = true;
						
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.Attack;
			spell.range = 4;
			spell.name = "FireRayLvl1";
			spell.locName = "Fire Ray";
			spell.description = "Fires a jet of flame, burning target for {minChange0} to {maxChange0} points of damage. If target is under immolate effect - spell will consume it and crit with 100% chance.\r\nMay remove freezing effects from the target.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.AUTOCAST;	
			spell.cost = 65;
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.magicHit7;	
			spell.cooldown = new GameTime(0, 4).value;		
			spell.icon = new BitmapAsset(BitmapResources.icoSpellFireExplosion.bitmapData);
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Sparks2Red;
			spell.specialGeneratedEffect = typesRepository.effectTypes.GeneratedRayRed;
			spell.sfxDuration = Util.secToFrames(0.3);
			spell.snapToUnit = true;
			game.spellManager.addSpellType(spell);	
			
			fireRayLvl1 = spell;
		}			

		private function titanShellInit(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.propertyId = UnitProperties.Armor;
			effect.minChange = 35;
			effect.opType = SpellEffectOperationType.Set;
			effect.duration = new GameTime(0, 22).value;
			effect.affectedByMagicResistance = false;
			effect.stackable = false;
			
			var effect1:SpellEffect = new SpellEffect();
			effect1.propertyId = UnitProperties.MagicRes;
			effect1.minChange = 100;
			effect1.opType = SpellEffectOperationType.Set;
			effect1.duration = new GameTime(0, 22).value;
			effect1.affectedByMagicResistance = false;
			effect1.stackable = false;			

			var effect2:SpellEffect = new SpellEffect();
			effect2.propertyId = UnitProperties.DamageRetention;
			effect2.minChange = 30;
			effect2.opType = SpellEffectOperationType.Add;
			effect2.duration = new GameTime(0, 22).value;
			effect2.affectedByMagicResistance = false;
			effect2.stackable = false;	
									
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1, effect2] );
			spell.aiHint = AiHintType.Protection;
			spell.name = "TitanShellLvl1";
			spell.locName = "Titan's Shell";
			spell.description = "Protects you from damage and spells for {effDuration0} sec. Anyone that hits the caster will suffer 30 Magic damage.";	
			spell.castType = SpellCastType.Self;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 50;
			spell.costProperty = UnitProperties.Mana;
			spell.targetType = TargetType.Self;			
			spell.soundPack.hit = SoundResources.dispell;			
			spell.icon = new BitmapAsset(BitmapResources.icoItemTitanShield.bitmapData);
			spell.specialEffect = typesRepository.effectTypes.Shield;
			spell.snapToUnit = true;
			spell.sfxDuration = effect.duration;
			spell.cooldown = new GameTime(0, 120).value;
			game.spellManager.addSpellType(spell);	
			
			titanShell = spell;
		}

		private function hideLvl1Init(game:Game, typesRepository:TypesRepository):void
		{			
			var effect1:SpellEffectInvisibility = new SpellEffectInvisibility();
			effect1.duration = new GameTime(0, 20).value;
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect1] );
			spell.aiHint = AiHintType.Attack;
			spell.range = 9;
			spell.name = "HideLvl1";
			spell.locName = "Stealth";
			spell.description = "Conceals you in the shadows, allowing you to stalk enemies without being seen. Any attack made when in stealth will get additional 30% damage bonus. Lasts {effDuration0} sec. Attacking, casting spells or taking any damage will reveal you.";	
			spell.castType = SpellCastType.Self;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 90;
			spell.targetType = TargetType.Self;			
			spell.soundPack.hit = SoundResources.magicHit7;								
			spell.icon = new BitmapAsset(BitmapResources.icoShadow.bitmapData);
			spell.specialEffect = typesRepository.effectTypes.LeafsDark;
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 30).value;
			game.spellManager.addSpellType(spell);	
			
			hideLvl1 = spell;
		}

		private function hideLvl2Init(game:Game, typesRepository:TypesRepository):void
		{			
			var effect1:SpellEffectInvisibility = new SpellEffectInvisibility();
			effect1.duration = new GameTime(0, 22).value;
			effect1.period = new GameTime(0, 10).value;
			effect1.constant = true;

			var effect2:SpellEffect = new SpellEffect();
			effect2.opType = SpellEffectOperationType.Add;
			effect2.minChange = -30;						
			effect2.propertyId = UnitProperties.AttackSpeed;
			effect2.coeficientPropertyId = UnitProperties.AttackSpeed;			
			effect2.duration = Util.secToFrames(12);
			effect2.affectedByMagicResistance = false;
			effect2.stackable = false;
			
			var effect3:SpellEffect = new SpellEffect();
			effect3.opType = SpellEffectOperationType.Add;
			effect3.minChange = -30;						
			effect3.propertyId = UnitProperties.AttackDelay;
			effect3.coeficientPropertyId = UnitProperties.AttackDelay;			
			effect3.duration = Util.secToFrames(12);
			effect3.affectedByMagicResistance = false;
			effect3.stackable = false;
						
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect1, effect2, effect3] );
			spell.aiHint = AiHintType.Attack;
			spell.range = 9;
			spell.name = "HideLvl2";
			spell.locName = "Improved Stealth";
			spell.description = "Conceals you in the shadows, allowing you to stalk enemies without being seen. Any attack made when in stealth will get additional 30% damage bonus. Lasts {effDuration0} sec. Attacking, casting spells or taking any damage will reveal you.\r\nUnlike simple stealth after beeing revealed you will be stealthed again after some period if you are not attacking. Additionaly attack speed is increased by 30% for first 12 sec.";	
			spell.castType = SpellCastType.Self;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 90;
			spell.targetType = TargetType.Self;			
			spell.soundPack.hit = SoundResources.magicHit7;								
			spell.icon = new BitmapAsset(BitmapResources.icoShadow.bitmapData);
			spell.specialEffect = typesRepository.effectTypes.LeafsDark;
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 30).value;
			game.spellManager.addSpellType(spell);	
			
			hideLvl2 = spell;
		}
		
		private function fanOfKnivesLvl1Init(game:Game, typesRepository:TypesRepository):void
		{		
			var effectFork:AbilityEffect = new AbilityEffect();
			effectFork.coefficient = -1;
			effectFork.ownerPropertyIdMin = UnitProperties.AttackDmgMin;
			effectFork.ownerPropertyIdMax = UnitProperties.AttackDmgMax;			
			effectFork.propertyId = UnitProperties.Health;
			
			var spell1:SpellType = new SpellType();
			spell1.addEffects( [effectFork] );
			spell1.range = 6;
			spell1.name = "FanOfKnivesFork";
			spell1.description = "";	
			spell1.castType = SpellCastType.Unit;
			spell1.autocastType = SpellAutocastType.NONE;	
			spell1.targetType = TargetType.Enemy;
			spell1.soundPack.attack = SoundResources.bladeShoot1;							
			spell1.soundPack.hit = SoundResources.bladeShoot1;			
			spell1.spellEffectSpecialEffect = typesRepository.effectTypes.Blood;
			spell1.projectileSpeed = 2;
			spell1.snapToUnit = true;
			spell1.projectileModel = Game.instance().spriteRepository.getByName("ProjectileKnife");
			spell1.affectBuildings = false;
			game.spellManager.addSpellType(spell1);							
			
			var effect1:SpellEffectCastSpell = new SpellEffectCastSpell();
			effect1.spellTypeId = spell1.id;	
			effect1.castFromTargetPosition = false;	
			effect1.castTimes = 3;
									
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect1] );
			spell.aiHint = AiHintType.Attack;
			spell.range = 8;
			spell.name = "FanOfKnivesLvl1";
			spell.locName = "Fan Of Knives";
			spell.description = "Release a spray of throwing knives at 3 targets within range, causing 100% of weapon damage.";	
			spell.castType = SpellCastType.Self;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.targetType = TargetType.Self;
			spell.soundPack.attack = SoundResources.bladeShoot1;							
			spell.soundPack.hit = SoundResources.bladeShoot1;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellFanOfDaggers.bitmapData);
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 14).value;
			spell.affectBuildings = false;		
			game.spellManager.addSpellType(spell);	
			
			fanOfKnivesLvl1 = spell;
		}

		private function fanOfKnivesLvl2Init(game:Game, typesRepository:TypesRepository):void
		{		
			var effectFork:AbilityEffect = new AbilityEffect();
			effectFork.coefficient = -1.25;
			effectFork.ownerPropertyIdMin = UnitProperties.AttackDmgMin;
			effectFork.ownerPropertyIdMax = UnitProperties.AttackDmgMax;			
			effectFork.propertyId = UnitProperties.Health;
			
			var spell1:SpellType = new SpellType();
			spell1.addEffects( [effectFork] );
			spell1.range = 6;
			spell1.name = "FanOfKnivesFork2";
			spell1.description = "";	
			spell1.castType = SpellCastType.Unit;
			spell1.autocastType = SpellAutocastType.NONE;	
			spell1.targetType = TargetType.Enemy;
			spell1.soundPack.attack = SoundResources.bladeShoot1;							
			spell1.soundPack.hit = SoundResources.bladeShoot1;			
			spell1.spellEffectSpecialEffect = typesRepository.effectTypes.Blood;
			spell1.projectileSpeed = 2;
			spell1.snapToUnit = true;
			spell1.projectileModel = Game.instance().spriteRepository.getByName("ProjectileKnife");
			spell1.affectBuildings = false;
			game.spellManager.addSpellType(spell1);							
			
			var effect1:SpellEffectCastSpell = new SpellEffectCastSpell();
			effect1.spellTypeId = spell1.id;	
			effect1.castFromTargetPosition = false;	
			effect1.castTimes = 4;
									
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect1] );
			spell.aiHint = AiHintType.Attack;
			spell.range = 8;
			spell.name = "FanOfKnivesLvl2";
			spell.locName = "Fan Of Knives (2)";
			spell.description = "Release a spray of throwing knives at 4 targets within range, causing 125% of weapon damage.";	
			spell.castType = SpellCastType.Self;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.targetType = TargetType.Self;
			spell.soundPack.attack = SoundResources.bladeShoot1;							
			spell.soundPack.hit = SoundResources.bladeShoot1;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellFanOfDaggers.bitmapData);
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 14).value;
			spell.affectBuildings = false;		
			game.spellManager.addSpellType(spell);	
			
			fanOfKnivesLvl2 = spell;
		}	

		private function fanOfKnivesLvl3Init(game:Game, typesRepository:TypesRepository):void
		{		
			var effectFork:AbilityEffect = new AbilityEffect();
			effectFork.coefficient = -1.4;
			effectFork.ownerPropertyIdMin = UnitProperties.AttackDmgMin;
			effectFork.ownerPropertyIdMax = UnitProperties.AttackDmgMax;			
			effectFork.propertyId = UnitProperties.Health;
			
			var spell1:SpellType = new SpellType();
			spell1.addEffects( [effectFork] );
			spell1.range = 7;
			spell1.name = "FanOfKnivesFork3";
			spell1.description = "";	
			spell1.castType = SpellCastType.Unit;
			spell1.autocastType = SpellAutocastType.NONE;	
			spell1.targetType = TargetType.Enemy;
			spell1.soundPack.attack = SoundResources.bladeShoot1;							
			spell1.soundPack.hit = SoundResources.bladeShoot1;			
			spell1.spellEffectSpecialEffect = typesRepository.effectTypes.Blood;
			spell1.projectileSpeed = 2;
			spell1.snapToUnit = true;
			spell1.projectileModel = Game.instance().spriteRepository.getByName("ProjectileKnife");
			spell1.affectBuildings = false;
			game.spellManager.addSpellType(spell1);							
			
			var effect1:SpellEffectCastSpell = new SpellEffectCastSpell();
			effect1.spellTypeId = spell1.id;	
			effect1.castFromTargetPosition = false;	
			effect1.castTimes = 5;
									
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect1] );
			spell.aiHint = AiHintType.Attack;
			spell.range = 8;
			spell.name = "FanOfKnivesLvl2";
			spell.locName = "Fan Of Knives (3)";
			spell.description = "Release a spray of throwing knives at 5 targets within range, causing 140% of weapon damage.";	
			spell.castType = SpellCastType.Self;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.targetType = TargetType.Self;
			spell.soundPack.attack = SoundResources.bladeShoot1;							
			spell.soundPack.hit = SoundResources.bladeShoot1;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellFanOfDaggers.bitmapData);
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 14).value;
			spell.affectBuildings = false;		
			game.spellManager.addSpellType(spell);	
			
			fanOfKnivesLvl3 = spell;
		}

		private function fanOfKnivesLvl4Init(game:Game, typesRepository:TypesRepository):void
		{		
			var effectFork:AbilityEffect = new AbilityEffect();
			effectFork.coefficient = -1.5;
			effectFork.ownerPropertyIdMin = UnitProperties.AttackDmgMin;
			effectFork.ownerPropertyIdMax = UnitProperties.AttackDmgMax;			
			effectFork.propertyId = UnitProperties.Health;
			
			var effectFork1:SpellEffect = new SpellEffect();
			effectFork1.minChange = -8;			
			effectFork1.propertyId = UnitProperties.Health;
			effectFork1.duration = new GameTime(0, 5).value;
			effectFork1.period = new GameTime(0, 1).value;
						
			var spell1:SpellType = new SpellType();
			spell1.addEffects( [effectFork, effectFork1] );
			spell1.range = 7;
			spell1.name = "FanOfKnivesFork4";
			spell1.description = "";	
			spell1.castType = SpellCastType.Unit;
			spell1.autocastType = SpellAutocastType.NONE;	
			spell1.targetType = TargetType.Enemy;
			spell1.soundPack.attack = SoundResources.bladeShoot1;							
			spell1.soundPack.hit = SoundResources.bladeShoot1;			
			spell1.spellEffectSpecialEffect = typesRepository.effectTypes.Acid;
			spell1.projectileSpeed = 2;
			spell1.snapToUnit = true;
			spell1.projectileModel = Game.instance().spriteRepository.getByName("ProjectileKnife");
			spell1.affectBuildings = false;
			game.spellManager.addSpellType(spell1);							
			
			var effect1:SpellEffectCastSpell = new SpellEffectCastSpell();
			effect1.spellTypeId = spell1.id;	
			effect1.castFromTargetPosition = false;	
			effect1.castTimes = 6;
									
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect1] );
			spell.aiHint = AiHintType.Attack;
			spell.range = 8;
			spell.name = "FanOfKnivesLvl2";
			spell.locName = "Fan Of Knives (4)";
			spell.description = "Release a spray of throwing knives at 6 targets within range, causing 150% of weapon damage and additionaly 40 poison damage over 5 sec.";	
			spell.castType = SpellCastType.Self;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.targetType = TargetType.Self;
			spell.soundPack.attack = SoundResources.bladeShoot1;							
			spell.soundPack.hit = SoundResources.bladeShoot1;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellFanOfDaggers.bitmapData);
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 14).value;
			spell.affectBuildings = false;		
			game.spellManager.addSpellType(spell);	
			
			fanOfKnivesLvl4 = spell;
		}
		
		private function sapLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:AbilityEffect = new AbilityEffect();
			effect.propertyId = UnitProperties.Health;
			effect.ownerPropertyIdMin = UnitProperties.AttackDmgMin;
			effect.ownerPropertyIdMax = UnitProperties.AttackDmgMax;
			effect.coefficient = -0.60;		

			var effect1:SpellEffect = new SpellEffect();
			effect1.minChange = Constants.FALSE;
			effect1.opType = SpellEffectOperationType.Set;
			effect1.propertyId = UnitProperties.CanMove;
			effect1.duration = new GameTime(0, 6).value;
			
			var effect2:SpellEffect = new SpellEffect();
			effect2.minChange = 0;
			effect2.opType = SpellEffectOperationType.Set;
			effect2.propertyId = UnitProperties.AttackRange;
			effect2.duration = new GameTime(0, 6).value;
			
			var effect3:SpellEffect = new SpellEffect();
			effect3.minChange = Spell.MAX_CAST_DELAY;
			effect3.propertyId = UnitProperties.CastDelay;
			effect3.opType = SpellEffectOperationType.Set;
			effect3.duration = new GameTime(0, 6).value;			

			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1, effect2, effect3] );
			spell.aiHint = AiHintType.Attack;
			spell.name = "SapLvl1";
			spell.locName = "Sap";
			spell.description = "Deals {coeff0}% of caster main attack damage and stuns the target for {effDuration1} sec. This ability is not affected by target's magic resistance.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.hitWet1;			
			spell.icon = new BitmapAsset(BitmapResources.icoShieldBash.bitmapData);
			spell.range = 1;
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Blood;
			spell.specialEffect = typesRepository.effectTypes.Stun;
			spell.sfxDuration = effect1.duration;
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 15).value;
			spell.affectBuildings = false;
			game.spellManager.addSpellType(spell);	
			
			sapLvl1 = spell;
		}

		private function sapLvl2Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:AbilityEffect = new AbilityEffect();
			effect.propertyId = UnitProperties.Health;
			effect.ownerPropertyIdMin = UnitProperties.AttackDmgMin;
			effect.ownerPropertyIdMax = UnitProperties.AttackDmgMax;
			effect.coefficient = -0.80;		

			var effect1:SpellEffect = new SpellEffect();
			effect1.minChange = Constants.FALSE;
			effect1.opType = SpellEffectOperationType.Set;
			effect1.propertyId = UnitProperties.CanMove;
			effect1.duration = new GameTime(0, 8).value;
			
			var effect2:SpellEffect = new SpellEffect();
			effect2.minChange = 0;
			effect2.opType = SpellEffectOperationType.Set;
			effect2.propertyId = UnitProperties.AttackRange;
			effect2.duration = new GameTime(0, 8).value;
			
			var effect3:SpellEffect = new SpellEffect();
			effect3.minChange = Spell.MAX_CAST_DELAY;
			effect3.propertyId = UnitProperties.CastDelay;
			effect3.opType = SpellEffectOperationType.Set;
			effect3.duration = new GameTime(0, 8).value;			

			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1, effect2, effect3] );
			spell.aiHint = AiHintType.Attack;
			spell.name = "SapLvl2";
			spell.locName = "Sap (2)";
			spell.description = "Deals {coeff0}% of caster main attack damage and stuns the target for {effDuration1} sec. This ability is not affected by target's magic resistance.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.spit1;			
			spell.icon = new BitmapAsset(BitmapResources.icoShieldBash.bitmapData);
			spell.range = 1;
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Blood;
			spell.specialEffect = typesRepository.effectTypes.Stun;
			spell.sfxDuration = effect1.duration;
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 15).value;
			spell.affectBuildings = false;
			game.spellManager.addSpellType(spell);	
			
			sapLvl2 = spell;
		}

		private function poisonDaggerLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.minChange = -20;			
			effect.propertyId = UnitProperties.Health;
			effect.critChance = 2;
			effect.duration = new GameTime(0, 5).value;
			effect.period = new GameTime(0, 1).value;
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.Attack;
			spell.range = 8;
			spell.name = "PoisonDaggerLvl1";
			spell.locName = "Poison Dagger";
			spell.description = "Throw a dagger at the enemy, causing 100 Poison damage over 5 sec.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 70;
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.swish1;			
			spell.soundPack.attack = SoundResources.hitWet2;					
			spell.icon = new BitmapAsset(BitmapResources.icoSpellPoisonDagger.bitmapData);
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Acid;
			spell.projectileSpeed = 3;
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 10).value;
			spell.projectileModel = Game.instance().spriteRepository.getByName("ProjectileKnife");
			spell.affectBuildings = false;
			game.spellManager.addSpellType(spell);	
			
			poisonDaggerLvl1 = spell;
		}

		private function poisonDaggerLvl2Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.minChange = -32;			
			effect.propertyId = UnitProperties.Health;
			effect.critChance = 2;
			effect.duration = new GameTime(0, 5).value;
			effect.period = new GameTime(0, 1).value;

			var effect1:SpellEffect = new SpellEffect();
			effect1.minChange = 50;
			effect1.propertyId = UnitProperties.MoveSpeed;
			effect1.dmgSubtype = SpellDamageSubtype.Frost;
			effect1.coeficientPropertyId = UnitProperties.MoveSpeed;
			effect1.duration = new GameTime(0, 6).value; 
			
			var effect2:SpellEffectColorTransform = new SpellEffectColorTransform();
			effect2.r = -30;
			effect2.g = 50;
			effect2.b = -30;
			effect2.duration = effect1.duration;
			effect2.period = new GameTime(0, 1).value;
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1, effect2] );
			spell.aiHint = AiHintType.Attack;
			spell.range = 10;
			spell.name = "PoisonDaggerLvl2";
			spell.locName = "Poison Dagger (2)";
			spell.description = "Throw a dagger at the enemy, causing 160 Poison damage over 5 sec and slowing movement speed by {minChange1}% for {effDuration1} sec.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 80;
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.swish1;				
			spell.soundPack.attack = SoundResources.hitWet2;					
			spell.icon = new BitmapAsset(BitmapResources.icoSpellPoisonDagger.bitmapData);
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Acid;
			spell.projectileSpeed = 3;
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 11).value;
			spell.projectileModel = Game.instance().spriteRepository.getByName("ProjectileKnife");
			spell.affectBuildings = false;
			game.spellManager.addSpellType(spell);	
			
			poisonDaggerLvl2 = spell;
		}

		private function poisonDaggerLvl3Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffect = new SpellEffect();
			effect.minChange = -52;			
			effect.propertyId = UnitProperties.Health;
			effect.critChance = 2;
			effect.duration = new GameTime(0, 5).value;
			effect.period = new GameTime(0, 1).value;

			var effect1:SpellEffect = new SpellEffect();
			effect1.minChange = 50;
			effect1.propertyId = UnitProperties.MoveSpeed;
			effect1.dmgSubtype = SpellDamageSubtype.Frost;
			effect1.coeficientPropertyId = UnitProperties.MoveSpeed;
			effect1.duration = new GameTime(0, 6).value; 
			
			var effect2:SpellEffectColorTransform = new SpellEffectColorTransform();
			effect2.r = -30;
			effect2.g = 50;
			effect2.b = -30;
			effect2.duration = effect1.duration;
			effect2.period = new GameTime(0, 1).value;
			
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1, effect2] );
			spell.aiHint = AiHintType.Attack;
			spell.range = 10;
			spell.name = "PoisonDaggerLvl3";
			spell.locName = "Poison Dagger (3)";
			spell.description = "Throw a dagger at the enemy, causing 260 Poison damage over 5 sec and slowing movement speed by {minChange1}% for {effDuration1} sec.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 90;
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.swish1;				
			spell.soundPack.attack = SoundResources.hitWet2;					
			spell.icon = new BitmapAsset(BitmapResources.icoSpellPoisonDagger.bitmapData);
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Acid;
			spell.projectileSpeed = 3;
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 12).value;
			spell.projectileModel = Game.instance().spriteRepository.getByName("ProjectileKnife");
			spell.affectBuildings = false;
			game.spellManager.addSpellType(spell);	
			
			poisonDaggerLvl3 = spell;
		}

		private function stabLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:AbilityEffect = new AbilityEffect();
			effect.propertyId = UnitProperties.Health;
			effect.ownerPropertyIdMin = UnitProperties.AttackDmgMin;
			effect.ownerPropertyIdMax = UnitProperties.AttackDmgMax;
			effect.coefficient = -5;					

			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.Attack;
			spell.name = "StabLvl1";
			spell.locName = "Stab";
			spell.description = "An attack that instantly deals {coeff0}% of Hero's main attack damage. Can be used only in stealth. This ability is not affected by target's magic resistance.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.AUTOCAST;	
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.hitClub2;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellEnragedSwing.bitmapData);
			spell.range = 1;
			spell.specialEffect = typesRepository.effectTypes.Skull;
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.Blood;
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 20).value;
			spell.affectBuildings = false;
			spell.canCastOnlyIfNotVisible = true;
			game.spellManager.addSpellType(spell);	
			
			stabLvl1 = spell;
		}

		private function kickLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:AbilityEffect = new AbilityEffect();
			effect.propertyId = UnitProperties.Health;
			effect.ownerPropertyIdMin = UnitProperties.AttackDmgMin;
			effect.ownerPropertyIdMax = UnitProperties.AttackDmgMax;
			effect.coefficient = -1.4;
			effect.critOnStunned = true;	

			var effect1:SpellEffect = new SpellEffect();
			effect1.minChange = Spell.MAX_CAST_DELAY;
			effect1.propertyId = UnitProperties.CastDelay;
			effect1.opType = SpellEffectOperationType.Set;
			effect1.duration = new GameTime(0, 2).value;
			effect1.affectedByMagicResistance = false;							

			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1] );
			spell.aiHint = AiHintType.Attack;
			spell.name = "KickLvl1";
			spell.locName = "Kick";
			spell.description = "An attack that instantly deals {coeff0}% of Hero's main attack damage and interrupts spell casting for {effDuration1} sec. Will crit on incapacitated\stunned targets with 100% chance. This ability is not affected by target's magic resistance.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.AUTOCAST;	
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.hitClub1;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellKick.bitmapData);
			spell.range = 1;
			spell.specialEffect = typesRepository.effectTypes.BlackSparks;
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.BloodLight;
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 16).value;
			spell.affectBuildings = false;
			game.spellManager.addSpellType(spell);	
			
			kickLvl1 = spell;
		}

		private function kickLvl2Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:AbilityEffect = new AbilityEffect();
			effect.propertyId = UnitProperties.Health;
			effect.ownerPropertyIdMin = UnitProperties.AttackDmgMin;
			effect.ownerPropertyIdMax = UnitProperties.AttackDmgMax;
			effect.coefficient = -1.5;
			effect.critOnStunned = true;	

			var effect1:SpellEffect = new SpellEffect();
			effect1.minChange = Spell.MAX_CAST_DELAY;
			effect1.propertyId = UnitProperties.CastDelay;
			effect1.opType = SpellEffectOperationType.Set;
			effect1.duration = new GameTime(0, 3).value;
			effect1.affectedByMagicResistance = false;							

			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1] );
			spell.aiHint = AiHintType.Attack;
			spell.name = "KickLvl2";
			spell.locName = "Kick (2)";
			spell.description = "An attack that instantly deals {coeff0}% of Hero's main attack damage and interrupts spell casting for {effDuration1} sec. Will crit on incapacitated targets with 100% chance. This ability is not affected by target's magic resistance.";	
			spell.castType = SpellCastType.Unit;
			spell.autocastType = SpellAutocastType.AUTOCAST;	
			spell.targetType = TargetType.Enemy;			
			spell.soundPack.hit = SoundResources.hitClub1;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellKick.bitmapData);
			spell.range = 1;
			spell.specialEffect = typesRepository.effectTypes.BlackSparks;
			spell.spellEffectSpecialEffect = typesRepository.effectTypes.BloodLight;
			spell.snapToUnit = true;
			spell.cooldown = new GameTime(0, 16).value;
			spell.affectBuildings = false;
			game.spellManager.addSpellType(spell);	
			
			kickLvl2 = spell;
		}

		private function summonAncientProtectorLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffectSummon = new SpellEffectSummon();
			effect.unitTypeId = typesRepository.unitTypes.Worker.id;
			effect.summonLifeTime = new GameTime(0, 60).value;
			effect.summonEffectId = typesRepository.effectTypes.GroundFirePurple.id;

			var spell:SpellType = new SpellType();
			spell.addEffects( [effect] );
			spell.aiHint = AiHintType.Summon;
			spell.name = "SummonAncientProtectorLvl1";
			spell.locName = "Summon Ancient Protector";
			spell.description = "Summons a Ancient Protector that can repair structures for {summonLifeTime0} sec.";	
			spell.castType = SpellCastType.Place;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 80;
			spell.targetType = TargetType.Place;			
			spell.soundPack.hit = SoundResources.magicShoot5;	
			spell.range = 6;		
			spell.cooldown = new GameTime(0, 3).value;
			spell.icon = new BitmapAsset(BitmapResources.icoSkeleton.bitmapData);
			game.spellManager.addSpellType(spell);	
			
			summonAncientProtectorLvl1 = spell;
		}

		private function shadowLvl1Init(game:Game, typesRepository:TypesRepository):void
		{
			var effect:SpellEffectMirrorImage = new SpellEffectMirrorImage();
			effect.summonLifeTime = new GameTime(0, 50).value;
			effect.summonEffectId = typesRepository.effectTypes.GroundFirePurple.id;
			effect.summonCount = 1;

			var effect1:SpellEffect = new SpellEffect();
			effect1.minChange = ArmorType.DIVINE;
			effect1.propertyId = UnitProperties.ArmorType;
			effect1.opType = SpellEffectOperationType.Set;
			effect1.duration = new GameTime(0, 1).value;
			effect1.affectedByMagicResistance = false;
						
			var spell:SpellType = new SpellType();
			spell.addEffects( [effect, effect1] );
			spell.aiHint = AiHintType.Summon;
			spell.name = "ShadowLvl1";
			spell.locName = "Shadow";
			spell.description = "Creates a shadow copy of the caster nearby, which distract the rogue's enemies. Copy deals 30% of mage's damage. Lasts {effDuration0} sec.";	
			spell.castType = SpellCastType.Self;
			spell.autocastType = SpellAutocastType.NONE;	
			spell.cost = 125;
			spell.targetType = TargetType.Self;			
			spell.soundPack.hit = SoundResources.dispell;			
			spell.icon = new BitmapAsset(BitmapResources.icoSpellMirrorImage.bitmapData);
			spell.cooldown = new GameTime(0, 110).value;
			game.spellManager.addSpellType(spell);	
			
			shadowLvl1 = spell;
		}	
																																																																																																																	
		public function init(game:Game, typesRepository:TypesRepository):void
		{
			summonSkeletonLvl1Init(game, typesRepository);
			summonSkeletonLvl2Init(game, typesRepository);
			summonSkeletonLvl3Init(game, typesRepository);

			lifeTapLvl1Init(game, typesRepository);
			
			drainLifeLvl1Init(game, typesRepository);
			drainManaLvl1Init(game, typesRepository);

			curseOfWeaknessLvl1Init(game, typesRepository);
						
			shadowFormLvl1Init(game, typesRepository);
						
			fireballLvl1Init(game, typesRepository);
			iceShackleLvl1Init(game, typesRepository);
			iceCometLvl1Init(game, typesRepository);
			earthQuakeLvl1Init(game, typesRepository);
			chainLightningLvl1Init(game, typesRepository);
			
			preparateLvl1Init(game, typesRepository);
			elementalProtectionLvl1Init(game, typesRepository);
			summonTotemLvl1Init(game, typesRepository);

			arcaneBlastLvl1Init(game, typesRepository);
			silenceLvl1Init(game, typesRepository);
			brillianceAuraLvl1Init(game, typesRepository);
			mirrorImageLvl1Init(game, typesRepository);
			banishLvl1Init(game, typesRepository);
			blinkLvl1Init(game, typesRepository);
			
			shieldBashLvl1Init(game, typesRepository);
			heroicStrikeLvl1Init(game, typesRepository);
			thunderClapLvl1Init(game, typesRepository);
			cleaveLvl1Init(game, typesRepository);
			
			defensiveStance1LvlInit(game, typesRepository);			
			combatAuraLvl1Init(game, typesRepository);
			chargeLvl1Init(game, typesRepository);
			
			healLvl1Init(game, typesRepository);
			devoutionAuraLvl1Init(game, typesRepository);
			devoutionAuraLvl2Init(game, typesRepository);
			devoutionAuraLvl3Init(game, typesRepository);						
			holyShockLvl1Init(game, typesRepository);
			devineShieldLvl1Init(game, typesRepository);
			cleanseLvl1Init(game, typesRepository);
			blessLvl1Init(game, typesRepository);
			holyBoltLvl1Init(game, typesRepository);
			
			manaBurnLvl1Init(game, typesRepository);
			irradiateLvl1Init(game, typesRepository);
			burningSwordLvl1Init(game, typesRepository);
			burningShieldLvl1Init(game, typesRepository);
			smiteLvl1Init(game, typesRepository);
			sacrificeLvl1Init(game, typesRepository);
			
			weaponThrowLvl1Init(game, typesRepository);
			bloodThirstLvl1Init(game, typesRepository);
			enragedSwingLvl1Init(game, typesRepository);
			warCryLvl1Init(game, typesRepository);
			deathWishLvl1Init(game, typesRepository);
			berserkLvl1Init(game, typesRepository);
			
			lifeStealLvl1Init(game, typesRepository);
			poolRegenerationAuraLvl1Init(game, typesRepository);
			
			iceArrowLvl1Init(game, typesRepository);
			iceBlockLvl1Init(game, typesRepository);
			iceStormLvl1Init(game, typesRepository);
			iceShieldLvl1Init(game, typesRepository);
			
			scorchLvl1Init(game, typesRepository);
			fireStormLvl1Init(game, typesRepository);
			
			polymorphLvl1Init(game, typesRepository);
			
			summonWaterElementalLvl1Init(game, typesRepository);
			drainLifeLvl2Init(game, typesRepository);
			
			avatarOfWarLvl1Init(game, typesRepository);
			imprisonLvl1Init(game, typesRepository);
			deathBlowLvl1Init(game, typesRepository);
			
			deathCallLvl1Init(game, typesRepository);
			healingLightLvl1Init(game, typesRepository);
			scorchLvl2Init(game, typesRepository);
			fireballLvl2Init(game, typesRepository);
			summonTotemLvl2Init(game, typesRepository);
			arcaneBlastLvl2Init(game, typesRepository);
			
			burningSwordLvl2Init(game, typesRepository);
			arcaneBlastLvl3Init(game, typesRepository);
			earthQuakeLvl2Init(game, typesRepository);
			burningShieldLvl2Init(game, typesRepository);
			smiteLvl2Init(game, typesRepository);
			thunderClapLvl2Init(game, typesRepository);
			heroicStrikeLvl2Init(game, typesRepository);
			chainLightningLvl2Init(game, typesRepository);
			
			iceShackleLvl2Init(game, typesRepository);
			iceShackleLvl3Init(game, typesRepository);
			iceArrowLvl2Init(game, typesRepository);
			iceShieldLvl2Init(game, typesRepository);
				
			holyBoltLvl2Init(game, typesRepository);	
			warCryLvl2Init(game, typesRepository);	
			iceCometLvl2Init(game, typesRepository);
			scorchLvl3Init(game, typesRepository);	
			drainLifeLvl3Init(game, typesRepository);	
			combatAuraLvl2Init(game, typesRepository);	
			cleaveLvl2Init(game, typesRepository);		
			berserkLvl2Init(game, typesRepository);		
			bloodThirstLvl2Init(game, typesRepository);		
			smiteLvl3Init(game, typesRepository);
			healLvl2Init(game, typesRepository);
			devineShieldLvl2Init(game, typesRepository);	
			holyShockLvl2Init(game, typesRepository);
			silenceNeutralInit(game, typesRepository);
			drainManaLvl2Init(game, typesRepository);
			earthQuakeLvl3Init(game, typesRepository);
			
			itemStunLvl1Init(game, typesRepository);
			etherFormLvl1Init(game, typesRepository);	
			rejuvenateLvl1Init(game, typesRepository);
			discordLvl1Init(game, typesRepository);	
			
			lightningStrikeInit(game, typesRepository);
			teleportOtherLvl1Init(game, typesRepository);
			lightningStormLvl1Init(game, typesRepository);	
			webLvl1Init(game, typesRepository);	
			fireRayLvl1Init(game, typesRepository);
			runeLvl1Init(game, typesRepository);
			timeStopLongInit(game, typesRepository);
			timeStopLvl1Init(game, typesRepository);
			titanShellInit(game, typesRepository);
			townPortalInit(game, typesRepository);
			
			dashLvl1Init(game, typesRepository);
			trapLvl1Init(game, typesRepository);
			hideLvl1Init(game, typesRepository);
			fanOfKnivesLvl1Init(game, typesRepository);
			fanOfKnivesLvl2Init(game, typesRepository);
			fanOfKnivesLvl3Init(game, typesRepository);	
			fanOfKnivesLvl4Init(game, typesRepository);
			sapLvl1Init(game, typesRepository);			
			sapLvl2Init(game, typesRepository);	
			poisonDaggerLvl1Init(game, typesRepository);			
			poisonDaggerLvl2Init(game, typesRepository);			
			poisonDaggerLvl3Init(game, typesRepository);
			
			stabLvl1Init(game, typesRepository);	
			kickLvl1Init(game, typesRepository);
			kickLvl2Init(game, typesRepository);
			summonAncientProtectorLvl1Init(game, typesRepository);
			banishItemInit(game, typesRepository);
			hideLvl2Init(game, typesRepository);
			shadowLvl1Init(game, typesRepository);
		}
	}
}