package alderun
{
	import engine.animation.AnimatedSprite;
	import engine.animation.UnitSprite;
	import engine.game.Game;
	
	public final class CustomModelsRepository
	{
		public function init(game:Game, typesRepository:TypesRepository):void
		{
			var unitSprite:UnitSprite = game.spriteRepository.getByName("UnitGiantSpider") as UnitSprite;
			game.spriteRepository.addRecoloredUnitSprite("UnitPhaseSpider", unitSprite, 0.2, 1, 0.4, 0.7);

			unitSprite = game.spriteRepository.getByName("UnitFireGolem") as UnitSprite;
			game.spriteRepository.addRecoloredUnitSprite("UnitIceGolem", unitSprite, 0.3, 0.8, 3, 0.8);

			unitSprite = game.spriteRepository.getByName("UnitBarbar") as UnitSprite;
			game.spriteRepository.addRecoloredUnitSprite("UnitAvatarOfWar", unitSprite, 1, 0.2, 0.2, 0.5);

			unitSprite = game.spriteRepository.getByName("UnitLich") as UnitSprite;
			game.spriteRepository.addRecoloredUnitSprite("UnitShadowForm", unitSprite, 0.3, 0.3, 0.3, 0.5);

			unitSprite = game.spriteRepository.getByName("UnitTotem") as UnitSprite;
			game.spriteRepository.addRecoloredUnitSprite("UnitTotemLvl2", unitSprite, 1, 0.9, 2, 1);
			
			unitSprite = game.spriteRepository.getByName("UnitSkeletonSword") as UnitSprite;
			game.spriteRepository.addRecoloredUnitSprite("UnitSkeletonKing", unitSprite, 0.5, 0.1, 0.5, 1);				
																											
			var sprite:AnimatedSprite = game.spriteRepository.getByName("ProjectileWaterBall");
			game.spriteRepository.addRecoloredSprite("ProjectileFireArrow", sprite, 210, -25, -140, 0.9, true);
			
			var sprite:AnimatedSprite = game.spriteRepository.getByName("ProjectileAxe");
			game.spriteRepository.addGlowSprite("ProjectileBarbarAxe", sprite, 0xF7D60D, 0.4, 8);

			var sprite:AnimatedSprite = game.spriteRepository.getByName("ProjectileLightBall");
			sprite = game.spriteRepository.addRecoloredSprite("ProjectileArcaneBall", sprite, 0.5, 0.5, 1, 0.9);
			game.spriteRepository.addGlowSprite("ProjectileArcaneBallGlow", sprite.clone(), 0x942894, 0.3, 4);
									
			var sprite:AnimatedSprite = game.spriteRepository.getByName("ProjectileWaterBall");
			game.spriteRepository.addRecoloredSprite("ProjectileAstralArrow", sprite, 0.5, 2.8, 0.5, 0.9);
						
			sprite = game.spriteRepository.getByName("EffectFireExplosion2");
			game.spriteRepository.addBlackAndWhiteSprite("EffectConstructionDemolition", sprite);

			sprite = game.spriteRepository.getByName("EffectGroundFire");
			game.spriteRepository.addRecoloredSprite("EffectGroundFirePurple", sprite, 100, 0, 0, 0.9, true);

			sprite = game.spriteRepository.getByName("EffectLeafs");
			game.spriteRepository.addRecoloredSprite("EffectLeafsDark", sprite, 0.3, 0.3, 0.2, 0.5);

			sprite = game.spriteRepository.getByName("EffectAura1");
			game.spriteRepository.addRecoloredSprite("EffectAuraBlue", sprite, 0, -45, 190, 1, true);

			sprite = game.spriteRepository.getByName("EffectAura1");
			game.spriteRepository.addRecoloredSprite("EffectAuraRed", sprite, 130, -40, 0, 1, true);
						
			sprite = game.spriteRepository.getByName("EffectBigFire");
			game.spriteRepository.addRecoloredSprite("EffectBigFireBlue", sprite, -130, 0, 200, 0.9, true);

			sprite = game.spriteRepository.getByName("EffectBigFire");
			game.spriteRepository.addRecoloredSprite("EffectBigFirePurple", sprite, 0, 0, 200, 0.9, true);

			sprite = game.spriteRepository.getByName("EffectShield");
			game.spriteRepository.addRecoloredSprite("EffectShieldPurple", sprite, 130, 0, 0, 1, true);

			sprite = game.spriteRepository.getByName("EffectShield");
			game.spriteRepository.addRecoloredSprite("EffectShieldRed", sprite, 210, 0, -100, 1, true);

			sprite = game.spriteRepository.getByName("EffectShield");
			game.spriteRepository.addGlowSprite("EffectShieldBlue", sprite, 0x2828FF, 0.6, 4);

			sprite = game.spriteRepository.getByName("EffectHeal");
			game.spriteRepository.addRecoloredSprite("EffectCleanse", sprite, 0, -120, 200, 1, true);

			sprite = game.spriteRepository.getByName("EffectHeal");
			game.spriteRepository.addRecoloredSprite("EffectRedSparks", sprite, 200, -120, 0, 1, true);

			sprite = game.spriteRepository.getByName("EffectSparks2");
			game.spriteRepository.addRecoloredSprite("EffectSparks2Red", sprite, 200, 0, -120, 1, true);
	
			sprite = game.spriteRepository.getByName("EffectSparks3");
			game.spriteRepository.addRecoloredSprite("EffectSparks3Red", sprite, 200, 0, -120, 1, true);
			
			sprite = game.spriteRepository.getByName("EffectSparks3");
			game.spriteRepository.addRecoloredSprite("EffectSparks3Green", sprite, 0, 200, -120, 1, true);			

			sprite = game.spriteRepository.getByName("EffectBlood");
			game.spriteRepository.addRecoloredSprite("EffectBloodLight", sprite, 0.9, 1, 1, 0.5);
																																										
			sprite = game.spriteRepository.getByName("ObjectLandVar1");
			game.spriteRepository.addFlippedSprite("ObjectLandVar3", sprite);
			
			sprite = game.spriteRepository.getByName("ObjectLandVar2");
			game.spriteRepository.addFlippedSprite("ObjectLandVar4", sprite);
			
			sprite = game.spriteRepository.getByName("ObjectLandVar1");
			game.spriteRepository.addRecoloredSprite("ObjectLandVar1Green", sprite, 0.7, 1.7, 0.7, 0.9);		
			
			sprite = game.spriteRepository.getByName("ObjectLandVar2");
			game.spriteRepository.addRecoloredSprite("ObjectLandVar2Green", sprite, 0.7, 1.7, 0.7, 0.9);
			
			sprite = game.spriteRepository.getByName("ObjectBanner1");
			game.spriteRepository.addRecoloredSprite("ObjectBannerBlue", sprite, 0.4, 1, 2.2);
			
			sprite = game.spriteRepository.getByName("EffectStoneExplosion1");
			game.spriteRepository.addRecoloredSprite("EffectStoneExplosion2", sprite, 0.3, 1, 1, 1);																								
		}
	}
}