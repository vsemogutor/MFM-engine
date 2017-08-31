package common
{
	import engine.game.Game;
	import engine.specialEffects.SpecialEffectLayers;
	import engine.specialEffects.SpecialEffectType;
	import engine.specialEffects.SpecialEffects;
	import engine.specialEffects.generated.lightning.Ray;
	import engine.specialEffects.generated.lightning.LightningFadeType;
	import engine.util.Util;
	
	public class EffectTypesRepository
	{
		public var Acid:SpecialEffectType;
		public var Aura1:SpecialEffectType;
		public var Blood:SpecialEffectType;
		public var BloodLight:SpecialEffectType;		
		public var FireExplosion1:SpecialEffectType;
		public var FireExplosion2:SpecialEffectType;
		public var Fog1:SpecialEffectType;
		public var GroundFire:SpecialEffectType;
		public var GroundFirePurple:SpecialEffectType;		
		public var Heal:SpecialEffectType;
		public var Ice1:SpecialEffectType;
		public var Ice2:SpecialEffectType;
		public var Quake:SpecialEffectType;
		public var Shield:SpecialEffectType;
		public var Sparks2:SpecialEffectType;
		public var Sparks2Red:SpecialEffectType;		
		public var Sparks3:SpecialEffectType;
		public var Sparks3Red:SpecialEffectType;		
		public var StoneExplosion1:SpecialEffectType;
		public var StoneExplosion2:SpecialEffectType;		
		public var UnitDeath:SpecialEffectType;
		public var WaterJet:SpecialEffectType;
		public var Web:SpecialEffectType;
		public var LevelUp:SpecialEffectType;
		public var ItemUsed:SpecialEffectType;
		public var BuildingDemolition:SpecialEffectType;
		public var SmallFire:SpecialEffectType;		
		public var BigFire:SpecialEffectType;
		public var Ice3:SpecialEffectType;
		public var Leafs1:SpecialEffectType;
		public var LeafsDark:SpecialEffectType;
		public var Mouth1:SpecialEffectType;
		public var Time1:SpecialEffectType;
		public var BigBlueFire:SpecialEffectType;
		public var BigPurpleFire:SpecialEffectType;
		public var Teleport:SpecialEffectType;
		public var Bless:SpecialEffectType;
		public var Haste:SpecialEffectType;
		public var WarCry:SpecialEffectType;
		public var AuraBlue:SpecialEffectType;
		public var AuraRed:SpecialEffectType;
		public var DefensiveStance:SpecialEffectType;
		public var Sword:SpecialEffectType;
		public var ShieldPurple:SpecialEffectType;
		public var ShieldRed:SpecialEffectType;		
		public var ShieldBlue:SpecialEffectType;
		public var Cleanse:SpecialEffectType;
		public var Eye:SpecialEffectType;
		public var RedSparks:SpecialEffectType;
		public var Skull:SpecialEffectType;
		public var Stun:SpecialEffectType;
		public var SummonMark:SpecialEffectType;
		public var SparksRedSnap:SpecialEffectType;
		public var SparksGreenSnap:SpecialEffectType;
		public var SparksBlueSnap:SpecialEffectType;
		public var BlackSparks:SpecialEffectType;
				
		public var GeneratedRayBlue:Ray;
		public var GeneratedRayGreen:Ray;
		public var GeneratedRayRed:Ray;
		public var GeneratedLightning:Ray;
		public var GeneratedLightningFork:Ray;
		public var GeneratedLightningForkFree:Ray;
																								
		public function init():void {
			var game:Game = Game.instance();

			Acid = new SpecialEffectType();
			Acid.name = "EffectAcid";
			Acid.model = game.spriteRepository.getByName("EffectAcid");
			game.effectManager.addEffectType(Acid);

			Aura1 = new SpecialEffectType();
			Aura1.name = "EffectAura1";
			Aura1.model = game.spriteRepository.getByName("EffectAura1");
			Aura1.snapToObject = true;
			Aura1.layer = SpecialEffectLayers.BeforeUnits;
			Aura1.z = 5;
			game.effectManager.addEffectType(Aura1);

			AuraBlue = new SpecialEffectType();
			AuraBlue.name = "EffectAuraBlue";
			AuraBlue.model = game.spriteRepository.getByName("EffectAuraBlue");
			AuraBlue.snapToObject = true;
			AuraBlue.layer = SpecialEffectLayers.BeforeUnits;
			AuraBlue.z = 5;
			game.effectManager.addEffectType(AuraBlue);
			
			AuraRed = new SpecialEffectType();
			AuraRed.name = "EffectAuraRed";
			AuraRed.model = game.spriteRepository.getByName("EffectAuraRed");
			AuraRed.snapToObject = true;
			AuraRed.layer = SpecialEffectLayers.BeforeUnits;
			AuraRed.z = 5;
			game.effectManager.addEffectType(AuraRed);
						
			Blood = new SpecialEffectType();
			Blood.name = "EffectBlood";
			Blood.model = game.spriteRepository.getByName("EffectBlood");
			game.effectManager.addEffectType(Blood);

			BloodLight = new SpecialEffectType();
			BloodLight.name = "EffectBloodLight";
			BloodLight.model = game.spriteRepository.getByName("EffectBloodLight");
			game.effectManager.addEffectType(BloodLight);
			
			FireExplosion1 = new SpecialEffectType();
			FireExplosion1.name = "EffectFireExplosion1";
			FireExplosion1.model = game.spriteRepository.getByName("EffectFireExplosion1");
			game.effectManager.addEffectType(FireExplosion1);

			FireExplosion2 = new SpecialEffectType();
			FireExplosion2.name = "EffectFireExplosion2";
			FireExplosion2.model = game.spriteRepository.getByName("EffectFireExplosion2");
			game.effectManager.addEffectType(FireExplosion2);

			Fog1 = new SpecialEffectType();
			Fog1.name = "EffectFog1";
			Fog1.model = game.spriteRepository.getByName("EffectFog1");
			Fog1.animCycleDuration = 14;
			Fog1.duration = 14;			
			game.effectManager.addEffectType(Fog1);
			
			GroundFire = new SpecialEffectType();
			GroundFire.name = "EffectGroundFire";
			GroundFire.model = game.spriteRepository.getByName("EffectGroundFire");
			game.effectManager.addEffectType(GroundFire);

			GroundFirePurple = new SpecialEffectType();
			GroundFirePurple.name = "EffectGroundFirePurple";
			GroundFirePurple.model = game.spriteRepository.getByName("EffectGroundFirePurple");
			game.effectManager.addEffectType(GroundFirePurple);
			
			Heal = new SpecialEffectType();
			Heal.name = "EffectHeal";
			Heal.model = game.spriteRepository.getByName("EffectHeal");
			game.effectManager.addEffectType(Heal);

			Cleanse = new SpecialEffectType();
			Cleanse.name = "EffectCleanse";
			Cleanse.model = game.spriteRepository.getByName("EffectCleanse");
			game.effectManager.addEffectType(Cleanse);

			RedSparks = new SpecialEffectType();
			RedSparks.name = "EffectRedSparks";
			RedSparks.model = game.spriteRepository.getByName("EffectRedSparks");
			game.effectManager.addEffectType(RedSparks);

			BlackSparks = new SpecialEffectType();
			BlackSparks.name = "EffectBlackSparks";
			BlackSparks.model = game.spriteRepository.getByName("EffectBlackSparks");
			game.effectManager.addEffectType(BlackSparks);
									
			Ice1 = new SpecialEffectType();
			Ice1.name = "EffectIce1";
			Ice1.model = game.spriteRepository.getByName("EffectIce1");
			game.effectManager.addEffectType(Ice1);

			Ice2 = new SpecialEffectType();
			Ice2.name = "EffectIce2";
			Ice2.model = game.spriteRepository.getByName("EffectIce2");
			game.effectManager.addEffectType(Ice2);

			Ice3 = new SpecialEffectType();
			Ice3.name = "EffectIce3";
			Ice3.model = game.spriteRepository.getByName("EffectIce3");
			game.effectManager.addEffectType(Ice3);
			
			Quake = new SpecialEffectType();
			Quake.name = "EffectQuake";
			Quake.model = game.spriteRepository.getByName("EffectQuake");
			game.effectManager.addEffectType(Quake);

			Shield = new SpecialEffectType();
			Shield.name = "EffectShield";
			Shield.model = game.spriteRepository.getByName("EffectShield");
			Shield.snapToObject = true;
			Shield.z = 9;
			game.effectManager.addEffectType(Shield);

			ShieldPurple = new SpecialEffectType();
			ShieldPurple.name = "EffectShieldPurple";
			ShieldPurple.model = game.spriteRepository.getByName("EffectShieldPurple");
			ShieldPurple.snapToObject = true;
			ShieldPurple.z = 9;
			game.effectManager.addEffectType(ShieldPurple);
			
			ShieldRed = new SpecialEffectType();
			ShieldRed.name = "EffectShieldRed";
			ShieldRed.model = game.spriteRepository.getByName("EffectShieldRed");
			ShieldRed.snapToObject = true;
			ShieldRed.z = 9;
			game.effectManager.addEffectType(ShieldRed);
			
			ShieldBlue = new SpecialEffectType();
			ShieldBlue.name = "EffectShieldBlue";
			ShieldBlue.model = game.spriteRepository.getByName("EffectShieldBlue");
			ShieldBlue.snapToObject = true;
			ShieldBlue.z = 9;
			game.effectManager.addEffectType(ShieldRed);
									
			Sparks2 = new SpecialEffectType();
			Sparks2.name = "EffectSparks2";
			Sparks2.model = game.spriteRepository.getByName("EffectSparks2");
			game.effectManager.addEffectType(Sparks2);

			StoneExplosion1 = new SpecialEffectType();
			StoneExplosion1.name = "EffectStoneExplosion1";
			StoneExplosion1.model = game.spriteRepository.getByName("EffectStoneExplosion1");
			game.effectManager.addEffectType(StoneExplosion1);

			StoneExplosion2 = new SpecialEffectType();
			StoneExplosion2.name = "EffectStoneExplosion2";
			StoneExplosion2.model = game.spriteRepository.getByName("EffectStoneExplosion2");
			game.effectManager.addEffectType(StoneExplosion2);
			
			UnitDeath = new SpecialEffectType();
			UnitDeath.name = "EffectUnitDeath";
			UnitDeath.model = game.spriteRepository.getByName("EffectUnitDeath");
			game.effectManager.addEffectType(UnitDeath, SpecialEffects.Death);
			
			LevelUp = new SpecialEffectType();
			LevelUp.name = "EffectLevelUp";
			LevelUp.model = game.spriteRepository.getByName("EffectLevelUp");
			LevelUp.snapToObject = true;
			game.effectManager.addEffectType(LevelUp, SpecialEffects.LevelUp);

			ItemUsed = new SpecialEffectType();
			ItemUsed.name = "EffectItemUsed";
			ItemUsed.model = game.spriteRepository.getByName("EffectCleanse");
			ItemUsed.snapToObject = true;
			game.effectManager.addEffectType(ItemUsed, SpecialEffects.ItemUsed);	
			
			BuildingDemolition = new SpecialEffectType();
			BuildingDemolition.name = "EffectBuildingDemolition";
			BuildingDemolition.model = game.spriteRepository.getByName("EffectConstructionDemolition");
			game.effectManager.addEffectType(BuildingDemolition, SpecialEffects.BuildingDemolition);								

			WaterJet = new SpecialEffectType();
			WaterJet.name = "EffectWaterJet";
			WaterJet.model = game.spriteRepository.getByName("EffectWaterJet");
			game.effectManager.addEffectType(WaterJet);

			Web = new SpecialEffectType();
			Web.name = "EffectWeb";
			Web.model = game.spriteRepository.getByName("EffectWeb");
			Web.snapToObject = true;
			Web.z = 8;
			game.effectManager.addEffectType(Web);

			Sparks2Red = new SpecialEffectType();
			Sparks2Red.name = "EffectSparks2Red";
			Sparks2Red.model = game.spriteRepository.getByName("EffectSparks2Red");
			game.effectManager.addEffectType(Sparks2Red);

			Sparks3Red = new SpecialEffectType();
			Sparks3Red.name = "EffectSparks3Red";
			Sparks3Red.model = game.spriteRepository.getByName("EffectSparks3Red");
			game.effectManager.addEffectType(Sparks3Red);
			
			Sparks3 = new SpecialEffectType();
			Sparks3.name = "EffectSparks3";
			Sparks3.model = game.spriteRepository.getByName("EffectSparks3");
			game.effectManager.addEffectType(Sparks3);
			
			SparksRedSnap = new SpecialEffectType();
			SparksRedSnap.name = "EffectSparks3RedSnap";
			SparksRedSnap.model = game.spriteRepository.getByName("EffectSparks3Red");
			SparksRedSnap.snapToObject = true;
			game.effectManager.addEffectType(SparksRedSnap);			

			SparksBlueSnap = new SpecialEffectType();
			SparksBlueSnap.name = "EffectSparks3BlueSnap";
			SparksBlueSnap.model = game.spriteRepository.getByName("EffectSparks3");
			SparksBlueSnap.snapToObject = true;
			game.effectManager.addEffectType(SparksBlueSnap);

			SparksGreenSnap = new SpecialEffectType();
			SparksGreenSnap.name = "EffectSparks3GreenSnap";
			SparksGreenSnap.model = game.spriteRepository.getByName("EffectSparks3Green");
			SparksGreenSnap.snapToObject = true;
			game.effectManager.addEffectType(SparksGreenSnap);
									
			SmallFire = new SpecialEffectType();
			SmallFire.name = "EffectSmallFire";
			SmallFire.model = game.spriteRepository.getByName("EffectSmallFire");
			game.effectManager.addEffectType(SmallFire, SpecialEffects.BuildingSmallFire);
			
			BigFire = new SpecialEffectType();
			BigFire.name = "EffectBigFire";
			BigFire.model = game.spriteRepository.getByName("EffectBigFire");
			game.effectManager.addEffectType(BigFire, SpecialEffects.BuildingBigFire);

			SummonMark = new SpecialEffectType();
			SummonMark.name = "EffectSummonMark";
			SummonMark.model = game.spriteRepository.getByName("EffectSummon");
			SummonMark.snapToObject = true;
			SummonMark.z = -28;
			game.effectManager.addEffectType(SummonMark, SpecialEffects.SummonMark);
			
			BigBlueFire = new SpecialEffectType();
			BigBlueFire.name = "EffectBigFireBlue";
			BigBlueFire.model = game.spriteRepository.getByName("EffectBigFireBlue");
			game.effectManager.addEffectType(BigBlueFire);

			BigPurpleFire = new SpecialEffectType();
			BigPurpleFire.name = "EffectBigFirePurple";
			BigPurpleFire.model = game.spriteRepository.getByName("EffectBigFirePurple");
			game.effectManager.addEffectType(BigPurpleFire);
									
			Leafs1 = new SpecialEffectType();
			Leafs1.name = "EffectLeafs1";
			Leafs1.snapToObject = true;
			Leafs1.model = game.spriteRepository.getByName("EffectLeafs");
			game.effectManager.addEffectType(Leafs1);

			LeafsDark = new SpecialEffectType();
			LeafsDark.name = "EffectLeafsDark";
			LeafsDark.snapToObject = true;
			LeafsDark.model = game.spriteRepository.getByName("EffectLeafsDark");
			LeafsDark.animCycleDuration = Util.secToFrames(1);
			game.effectManager.addEffectType(LeafsDark);

			Teleport = new SpecialEffectType();
			Teleport.name = "EffectTeleport";
			Teleport.model = game.spriteRepository.getByName("EffectTeleport");
			Teleport.z = -12;
			Teleport.animCycleDuration = Util.secToFrames(0.65);
			game.effectManager.addEffectType(Teleport);
									
			Mouth1 = new SpecialEffectType();
			Mouth1.name = "EffectMouth";
			Mouth1.model = game.spriteRepository.getByName("EffectMouth");
			Mouth1.z = -24;
			Mouth1.snapToObject = true;
			game.effectManager.addEffectType(Mouth1);
			
			Time1 = new SpecialEffectType();
			Time1.name = "EffectTime";
			Time1.model = game.spriteRepository.getByName("EffectTime");
			Time1.z = -28;
			Time1.animCycleDuration = Util.secToFrames(0.7);
			Time1.snapToObject = true;
			game.effectManager.addEffectType(Time1);	
			
			Bless = new SpecialEffectType();
			Bless.name = "EffectBless";
			Bless.model = game.spriteRepository.getByName("EffectBless");
			Bless.z = -28;
			Bless.animCycleDuration = Util.secToFrames(0.6);
			Bless.snapToObject = true;
			game.effectManager.addEffectType(Bless);
			
			Haste = new SpecialEffectType();
			Haste.name = "EffectHaste";
			Haste.model = game.spriteRepository.getByName("EffectHaste");
			Haste.z = -28;
			Haste.animCycleDuration = Util.secToFrames(0.6);
			Haste.snapToObject = true;
			game.effectManager.addEffectType(Haste);
			
			WarCry = new SpecialEffectType();
			WarCry.name = "EffectWarCry";
			WarCry.model = game.spriteRepository.getByName("EffectWarCry");
			WarCry.z = -28;
			WarCry.animCycleDuration = Util.secToFrames(0.9);
			WarCry.snapToObject = true;
			game.effectManager.addEffectType(WarCry);	
			
			DefensiveStance = new SpecialEffectType();
			DefensiveStance.name = "EffectDefensiveStance";
			DefensiveStance.model = game.spriteRepository.getByName("EffectDefensiveStance");
			DefensiveStance.z = -28;
			DefensiveStance.animCycleDuration = Util.secToFrames(0.9);
			DefensiveStance.snapToObject = true;
			game.effectManager.addEffectType(DefensiveStance);
			
			Sword = new SpecialEffectType();
			Sword.name = "EffectSword";
			Sword.model = game.spriteRepository.getByName("EffectSword");
			Sword.z = -32;
			Sword.snapToObject = true;
			game.effectManager.addEffectType(Sword);	
			
			Eye = new SpecialEffectType();
			Eye.name = "EffectEye";
			Eye.model = game.spriteRepository.getByName("EffectEye");
			Eye.z = -28;
			Eye.animCycleDuration = Util.secToFrames(0.9);
			Eye.snapToObject = true;
			game.effectManager.addEffectType(Eye);
			
			Skull = new SpecialEffectType();
			Skull.name = "EffectSkull";
			Skull.model = game.spriteRepository.getByName("EffectSkull");
			Skull.z = -28;
			Skull.animCycleDuration = Util.secToFrames(0.9);
			Skull.snapToObject = true;
			game.effectManager.addEffectType(Skull);
			
			Stun = new SpecialEffectType();
			Stun.name = "EffectStun";
			Stun.model = game.spriteRepository.getByName("EffectStun");
			Stun.z = -28;
			Stun.animCycleDuration = Util.secToFrames(0.9);
			Stun.snapToObject = true;
			game.effectManager.addEffectType(Stun);	
			
			GeneratedRayBlue = new Ray(0x1952FF, 3, 22);
			GeneratedRayBlue.snapToStartObject = true;
			GeneratedRayBlue.snapToEndObject = true;			
			GeneratedRayBlue.name = "GeneratedRayBlue";
			GeneratedRayBlue.steps = 30;
			GeneratedRayBlue.smoothPercentage = 0;
			GeneratedRayBlue.wavelength = 0;
			GeneratedRayBlue.amplitude = 0.4;
			GeneratedRayBlue.speed = 0.8;
			GeneratedRayBlue.childrenProbability = 0;	
			
			GeneratedRayGreen = new Ray(0x09D10C, 2, 22);
			GeneratedRayGreen.snapToStartObject = true;
			GeneratedRayGreen.snapToEndObject = true;			
			GeneratedRayGreen.name = "GeneratedRayGreen";
			GeneratedRayGreen.steps = 30;
			GeneratedRayGreen.smoothPercentage = 0;
			GeneratedRayGreen.wavelength = 0;
			GeneratedRayGreen.amplitude = 0.04;
			GeneratedRayGreen.speed = 0.8;
			GeneratedRayGreen.childrenProbability = 0;
			
			GeneratedRayRed = new Ray(0xD1090C, 2, 22);
			GeneratedRayRed.snapToStartObject = true;
			GeneratedRayRed.snapToEndObject = true;			
			GeneratedRayRed.name = "GeneratedRayRed";
			GeneratedRayRed.steps = 6;
			GeneratedRayRed.smoothPercentage = 0;
			GeneratedRayRed.wavelength = 0;
			GeneratedRayRed.amplitude = 0.04;
			GeneratedRayRed.speed = 0.8;
			GeneratedRayRed.childrenProbability = 0;					
			
			GeneratedLightning = new Ray(0x94D3F4, 2, 22);
			GeneratedLightning.snapToStartObject = true;
			GeneratedLightning.snapToEndObject = true;			
			GeneratedLightning.name = "GeneratedLightning";
			GeneratedLightning.steps = 48;
			GeneratedLightning.smoothPercentage = 0;
			GeneratedLightning.wavelength = 0.34;
			GeneratedLightning.amplitude = 0.4;
			GeneratedLightning.speed = 0.8;
			GeneratedLightning.childrenProbability = 1;	
			GeneratedLightning.childrenLifeSpanMin = Util.secToFrames(1);
			GeneratedLightning.childrenLifeSpanMax = Util.secToFrames(3);
			
			GeneratedLightningFork = new Ray(0x94D3F4, 2, 22);
			GeneratedLightningFork.snapToStartObject = false;
			GeneratedLightningFork.snapToEndObject = true;			
			GeneratedLightningFork.name = "GeneratedLightningFork";
			GeneratedLightningFork.steps = 48;
			GeneratedLightningFork.smoothPercentage = 0;
			GeneratedLightningFork.wavelength = 0.34;
			GeneratedLightningFork.amplitude = 0.4;
			GeneratedLightningFork.speed = 0.8;
			GeneratedLightningFork.childrenProbability = 1;	
			GeneratedLightningFork.childrenLifeSpanMin = Util.secToFrames(0.1);
			GeneratedLightningFork.childrenLifeSpanMax = Util.secToFrames(0.2);
			GeneratedLightningFork.childrenDetachedEnd = true;
			
			GeneratedLightningForkFree = new Ray(0x94D3FB, 1, 22);
			GeneratedLightningForkFree.snapToStartObject = false;
			GeneratedLightningForkFree.snapToEndObject = false;			
			GeneratedLightningForkFree.name = "GeneratedLightningFree";
			GeneratedLightningForkFree.steps = 48;
			GeneratedLightningForkFree.smoothPercentage = 0;
			GeneratedLightningForkFree.wavelength = 0.34;
			GeneratedLightningForkFree.amplitude = 0.5;
			GeneratedLightningForkFree.speed = 0.8;
			GeneratedLightningForkFree.childrenProbability = 1;	
			GeneratedLightningForkFree.childrenLifeSpanMin = Util.secToFrames(0.1);
			GeneratedLightningForkFree.childrenLifeSpanMax = Util.secToFrames(0.2);
			GeneratedLightningForkFree.childrenDetachedEnd = false;																																																
		}
	}
}