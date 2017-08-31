package arena
{
	import engine.ai.ItemAiHintType;
	import engine.core.GameTime;
	import engine.game.Game;
	import engine.heros.HeroProperties;
	import engine.items.InventoryItem;
	import engine.items.InventoryItemEffect;
	import engine.items.InventoryItemEffectAddSpell;
	import engine.items.InventoryItemEffectChangeHeroAttribute;
	import engine.items.InventoryItemEffectGold;
	import engine.items.InventoryItemEffectPermament;
	import engine.items.InventoryItemType;
	import engine.spells.SpellEffectCastSpell;
	import engine.units.UnitProperties;
	import engine.util.BitmapTransformer;
	
	import mx.core.BitmapAsset;
	
	import resources.BitmapResources;
	
	public final class InventoryItemsRepository
	{
		private var game:Game;
		private var _typesRepository:TypesRepository;
		
		internal var potionOfGreaterHealing:InventoryItem;
		internal var potionOfGreaterMana:InventoryItem;
		internal var ringOfRegeneration:InventoryItem;
		internal var staffOfBrilliance:InventoryItem;
		internal var inkvisitorArmor:InventoryItem;
		internal var robeOfIntelligece:InventoryItem;
		internal var helmOfHonor:InventoryItem;
		internal var hoodOfCunning:InventoryItem;
		internal var amuletOfMana:InventoryItem;
		internal var talismanOfVitality:InventoryItem;
		internal var robeOfMagi:InventoryItem;
		internal var mirrorShield:InventoryItem;
		internal var battleShield:InventoryItem;
		internal var arcaneTome:InventoryItem;
		internal var scepterOfApprentice:InventoryItem;
		internal var woodenShield:InventoryItem;
		internal var warAxe:InventoryItem;
		internal var steelSword:InventoryItem;		
		internal var arcaniteSword:InventoryItem;
		internal var avenger:InventoryItem;
		internal var staffOfAchmage:InventoryItem;
		internal var ringOfProtection:InventoryItem;
		internal var tomeOfStrength:InventoryItem;
		internal var tomeOfAgility:InventoryItem;
		internal var tomeOfIntellect:InventoryItem;
		internal var scrollOfSpeed:InventoryItem;
		internal var ringOfDefense:InventoryItem;
		internal var dawnStar:InventoryItem;
		internal var soulReaver:InventoryItem;
		internal var crownOfKings:InventoryItem;
		internal var replenishmentPotion:InventoryItem;
		internal var ringOfSuperiority:InventoryItem;
		internal var potionOfHealing:InventoryItem;
		internal var staffOfApprentice:InventoryItem;
		internal var potionOfDivinity:InventoryItem;
		internal var ringOfTheRam:InventoryItem;
		internal var leatherArmor:InventoryItem;
		internal var daggerOfAgility:InventoryItem;
		internal var rustedChainArmor:InventoryItem;
		internal var woodmanAxe:InventoryItem;
		internal var scepterOfSpellcasting:InventoryItem;
		internal var shieldOfTheGuardian:InventoryItem;
		internal var meat:InventoryItem;
		internal var crownOfUndead:InventoryItem;
		internal var runeOfHealth:InventoryItem;
		internal var crusader:InventoryItem;
		internal var grimuar:InventoryItem;
		internal var archmageTome:InventoryItem;
		internal var executor:InventoryItem;
		internal var ringOfIce:InventoryItem;
		internal var etherSword:InventoryItem;
		internal var talismanOfTranquility:InventoryItem;
		internal var scepterOfDiscord:InventoryItem;
		internal var coin:InventoryItem;
		internal var mjolnir:InventoryItem;
		internal var arcaniteArmor:InventoryItem;
		internal var runeOfMana:InventoryItem;
		internal var summoner:InventoryItem;
		internal var breastPlate:InventoryItem;
		internal var robeOfArchmage:InventoryItem;
		internal var thunder:InventoryItem;
		internal var ringOfStars:InventoryItem;
		internal var bronseShield:InventoryItem;
		internal var spiderTotem:InventoryItem;
		internal var time:InventoryItem;
		internal var titansShell:InventoryItem;
		internal var scrollOfTownPortal:InventoryItem;
		internal var scrollOfAncientProtector:InventoryItem;
		internal var shadowFang:InventoryItem;
																			
		public function init(game:Game, typesRepository:TypesRepository):void
		{
			this.game = game;
			this._typesRepository = typesRepository;

			potionOfGreaterHealingInit(game, typesRepository);
			potionOfGreaterManaInit(game, typesRepository);
			ringOfRegenerationInit(game, typesRepository);
			staffOfBrillianceInit(game, typesRepository);
			inkvisitorArmorInit(game, typesRepository);
			robeOfIntelligenceInit(game, typesRepository);
			helmOfHonorInit(game, typesRepository);
			hoodOfCunningInit(game, typesRepository);
			amuletOfManaInit(game, typesRepository);
			talismanOfVitalityInit(game, typesRepository);
			robeOfMagiInit(game, typesRepository);
			mirrorShieldInit(game, typesRepository);
			battleShieldInit(game, typesRepository);
			arcaneTomeInit(game, typesRepository);
			scepterOfApprenticeInit(game, typesRepository);
			warAxeInit(game, typesRepository);
			steelSwordInit(game, typesRepository);
			arcaniteSwordInit(game, typesRepository);	
			avengerInit(game, typesRepository);	
			staffOfAchmageInit(game, typesRepository);	
			ringOfProtectionInit(game, typesRepository);
			tomeOfStrengthInit(game, typesRepository);
			tomeOfAgilityInit(game, typesRepository);
			tomeOfIntellectInit(game, typesRepository);	
			scrollOfSpeedInit(game, typesRepository);
			ringOfDefenseInit(game, typesRepository);
			dawnStarInit(game, typesRepository);	
			soulReaverInit(game, typesRepository);	
			crownOfKingsInit(game, typesRepository);	
			replenishmentPotionInit(game, typesRepository);	
			ringOfSuperiorityInit(game, typesRepository);	
			potionOfHealingInit(game, typesRepository);	
			staffOfApprenticeInit(game, typesRepository);
			potionOfDivinityInit(game, typesRepository);
			ringOfTheRamInit(game, typesRepository);
			leatherArmorInit(game, typesRepository);
			daggerOfAgilityInit(game, typesRepository);
			rustedChainArmorInit(game, typesRepository);
			woodmanAxeInit(game, typesRepository);
			woodenShieldInit(game, typesRepository);
			scepterOfSpellcastingInit(game, typesRepository);
			shieldOfTheGuardianInit(game, typesRepository);
			meatInit(game, typesRepository);
			crownOfUndeadInit(game, typesRepository);
			runeOfHealthInit(game, typesRepository);
			
			grimuarInit(game, typesRepository);
			crusaderInit(game, typesRepository);
			archmageTomeInit(game, typesRepository);
			executorInit(game, typesRepository);
			ringOfIceInit(game, typesRepository);
			etherSwordInit(game, typesRepository);
			talismanOfTranquilityInit(game, typesRepository);
			scepterOfDiscordInit(game, typesRepository);
			coinInit(game, typesRepository);
			mjolnirInit(game, typesRepository);
			arcaniteArmorInit(game, typesRepository);
			runeOfManaInit(game, typesRepository);
			summonerInit(game, typesRepository);
			breastPlateInit(game, typesRepository);
			robeOfArchmageInit(game, typesRepository);
			thunderInit(game, typesRepository);
			ringOfStarsInit(game, typesRepository);
			bronseShieldInit(game, typesRepository);
			spiderTotemInit(game, typesRepository);
			runeInit(game, typesRepository);
			timeInit(game, typesRepository);
			titansShellInit(game, typesRepository);
			scrollOfTownPortalInit(game, typesRepository);
			scrollOfAncientProtectorInit(game, typesRepository);
			shadowFangInit(game, typesRepository);
		}

		private function woodmanAxeInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffect = new InventoryItemEffect();
			eff.change = 2;
			eff.propertyId = UnitProperties.AttackDmgMin;		

			var eff1:InventoryItemEffect = new InventoryItemEffect();
			eff1.change = 2;
			eff1.propertyId = UnitProperties.AttackDmgMax;	
												
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemAxe1.bitmapData);
			item.name = "Woodman Axe";
			item.description = "Increases the attack damage of the Hero by {0} when equipped.";
			item.type = InventoryItemType.HAND;
			item.aiHint = ItemAiHintType.EquipableStrength;
			item.goldCost = 75;
			item.effects.push(eff);
			item.effects.push(eff1);
												
			woodmanAxe = item;
			game.inventoryItemManager.addItemType(item);			
		}

		private function rustedChainArmorInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffect = new InventoryItemEffect();
			eff.change = 1;
			eff.propertyId = UnitProperties.Armor;
						
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemChainArmor.bitmapData);
			item.name = "Rusted Chain Armor";
			item.description = "Enhances the Hero's armor by {0}.";
			item.type = InventoryItemType.ARMOR;
			item.aiHint = ItemAiHintType.EquipableStrength;
			item.goldCost = 75;
			item.effects.push(eff);
			
			rustedChainArmor = item;
			game.inventoryItemManager.addItemType(item);		
		}
						
		private function daggerOfAgilityInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffectChangeHeroAttribute = new InventoryItemEffectChangeHeroAttribute();
			eff.change = 2;
			eff.propertyId = HeroProperties.Agility;		

												
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemDagger1.bitmapData);
			item.name = "Dagger of Agility";
			item.description = "Increases the Agility of the Hero by {0} when equipped.";
			item.type = InventoryItemType.HAND;
			item.aiHint = ItemAiHintType.EquipableAgility;
			item.goldCost = 50;
			item.effects.push(eff);
												
			daggerOfAgility = item;
			game.inventoryItemManager.addItemType(item);		
		}
		
		private function potionOfGreaterHealingInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffect = new InventoryItemEffect();
			eff.change = 500;
			eff.propertyId = UnitProperties.Health;
						
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemPotionGreaterHealing.bitmapData);
			item.name = "Potion of Greater Healing";
			item.description = "Heals {0} hit points when used.";
			item.type = InventoryItemType.USABLE;
			item.goldCost = 400;
			item.cooldown = new GameTime(0, 25).value;
			item.aiHint = ItemAiHintType.RestoreHealth;
			item.effects.push(eff);
			
			potionOfGreaterHealing = item;
			game.inventoryItemManager.addItemType(item);		
		}

		private function potionOfHealingInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffect = new InventoryItemEffect();
			eff.change = 200;
			eff.propertyId = UnitProperties.Health;
						
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemPotionHealing.bitmapData);
			item.name = "Potion of Healing";
			item.description = "Heals {0} hit points when used.";
			item.type = InventoryItemType.USABLE;
			item.goldCost = 150;
			item.cooldown = new GameTime(0, 20).value;
			item.aiHint = ItemAiHintType.RestoreHealth;
			item.effects.push(eff);
			
			potionOfHealing = item;
			game.inventoryItemManager.addItemType(item);		
		}

		private function runeOfHealthInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffect = new InventoryItemEffect();
			eff.change = 100;
			eff.propertyId = UnitProperties.Health;
						
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemPotionHealing.bitmapData);
			item.name = "Health Rune";
			item.description = "Heals {0} hit points when used.";
			item.type = InventoryItemType.USABLE_IMMEDIATE;
			item.goldCost = 0;
			item.cooldown = 0;
			item.aiHint = ItemAiHintType.RestoreHealth;
			item.model = game.spriteRepository.getByName("EffectHealthRune");
			item.effects.push(eff);
			item.dropChance = 8;
			
			runeOfHealth = item;
			game.inventoryItemManager.addItemType(item);		
		}
		
		private function runeOfManaInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffect = new InventoryItemEffect();
			eff.change = 100;
			eff.propertyId = UnitProperties.Mana;
						
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemPotionHealing.bitmapData);
			item.name = "Mana Rune";
			item.type = InventoryItemType.USABLE_IMMEDIATE;
			item.goldCost = 0;
			item.cooldown = 0;
			item.aiHint = ItemAiHintType.RestoreMana;
			item.model = game.spriteRepository.getByName("EffectManaRune");
			item.effects.push(eff);
			item.dropChance = 10;
			
			runeOfMana = item;
			game.inventoryItemManager.addItemType(item);		
		}		

		private function coinInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffectGold = new InventoryItemEffectGold();
			eff.change = 50;
						
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemPotionHealing.bitmapData);
			item.name = "+50g";
			item.description = "";
			item.type = InventoryItemType.USABLE_IMMEDIATE;
			item.goldCost = 0;
			item.cooldown = 0;
			item.aiHint = ItemAiHintType.None;
			item.model = game.spriteRepository.getByName("EffectCoin");
			item.effects.push(eff);
			item.dropChance = 14;
			
			coin = item;
			game.inventoryItemManager.addItemType(item);		
		}
								
		private function potionOfGreaterManaInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffect = new InventoryItemEffect();
			eff.change = 250;
			eff.propertyId = UnitProperties.Mana;
						
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemPotionMana.bitmapData);
			item.name = "Potion of Greater Mana";
			item.description = "Restores {0} mana when used.";
			item.type = InventoryItemType.USABLE;
			item.goldCost = 400;
			item.cooldown = new GameTime(0, 20).value;
			item.aiHint = ItemAiHintType.RestoreMana;
			item.effects.push(eff);
			
			potionOfGreaterMana = item;
			game.inventoryItemManager.addItemType(item);		
		}

		private function replenishmentPotionInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffect = new InventoryItemEffect();
			eff.change = 250;
			eff.propertyId = UnitProperties.Health;
			
			var eff1:InventoryItemEffect = new InventoryItemEffect();
			eff1.change = 100;
			eff1.propertyId = UnitProperties.Mana;
									
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemPotionRestoration.bitmapData);
			item.name = "Replenishment Potion";
			item.description = "Restores {0} health and {1} mana when used.";
			item.type = InventoryItemType.USABLE;
			item.goldCost = 450;
			item.cooldown = new GameTime(0, 25).value;
			item.aiHint = ItemAiHintType.RestoreHealth;
			item.effects.push(eff);
			item.effects.push(eff1);
						
			replenishmentPotion = item;
			game.inventoryItemManager.addItemType(item);		
		}
				
		private function ringOfRegenerationInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffect = new InventoryItemEffect();
			eff.change = 2;
			eff.propertyId = UnitProperties.HealthRegen;
						
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemRingOfRegeneration.bitmapData);
			item.name = "Ring of Regeneration";
			item.description = "Increases the life regeneration rate of the Hero by {0} hit point per second when worn.";
			item.type = InventoryItemType.RING;
			item.goldCost = 220;
			item.aiHint = ItemAiHintType.EquipableManaRegen;
			item.effects.push(eff);
			
			ringOfRegeneration = item;
			game.inventoryItemManager.addItemType(item);		
		}

		private function ringOfSuperiorityInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffectChangeHeroAttribute = new InventoryItemEffectChangeHeroAttribute();
			eff.change = 1;
			eff.propertyId = HeroProperties.Stength;

			var eff1:InventoryItemEffectChangeHeroAttribute = new InventoryItemEffectChangeHeroAttribute();
			eff1.change = 1;
			eff1.propertyId = HeroProperties.Intellect;
			
			var eff2:InventoryItemEffectChangeHeroAttribute = new InventoryItemEffectChangeHeroAttribute();
			eff2.change = 1;
			eff2.propertyId = HeroProperties.Agility;
												
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemRingOfSuperiority.bitmapData);
			item.name = "Ring of Superiority";
			item.description = "Increases the Strength, Agility and Intelligence of the Hero by {0} when worn.";
			item.type = InventoryItemType.RING;
			item.aiHint = ItemAiHintType.EquipableRaiseStats;
			item.goldCost = 125;
			item.effects.push(eff);
			item.effects.push(eff1);
			item.effects.push(eff2);
									
			ringOfSuperiority = item;
			game.inventoryItemManager.addItemType(item);		
		}

		private function ringOfStarsInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffectChangeHeroAttribute = new InventoryItemEffectChangeHeroAttribute();
			eff.change = 5;
			eff.propertyId = HeroProperties.Stength;

			var eff1:InventoryItemEffectChangeHeroAttribute = new InventoryItemEffectChangeHeroAttribute();
			eff1.change = 5;
			eff1.propertyId = HeroProperties.Intellect;

			var eff2:InventoryItemEffect = new InventoryItemEffect();
			eff2.change = 4;
			eff2.propertyId = UnitProperties.Armor;	
			
			var eff3:InventoryItemEffect = new InventoryItemEffect();
			eff3.change = 1;
			eff3.propertyId = UnitProperties.HealthRegen;			
												
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoRingStars.bitmapData);
			item.name = "Ring of Stars";
			item.description = "Increases the Strength and Intelligence of the Hero by {0} when worn.\r\nArmor + {2}.\r\nLife regeneration rate +{3} per tick.";
			item.type = InventoryItemType.RING;
			item.aiHint = ItemAiHintType.EquipableRaiseStats;
			item.goldCost = 2800;
			item.effects.push(eff);
			item.effects.push(eff1);
			item.effects.push(eff2);
			item.effects.push(eff3);
												
			ringOfStars = item;
			game.inventoryItemManager.addItemType(item);		
		}

		private function ringOfIceInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffect = new InventoryItemEffect();
			eff.change = 4;
			eff.propertyId = UnitProperties.Armor;

			var eff1:InventoryItemEffect = new InventoryItemEffect();
			eff1.change = 15;
			eff1.propertyId = UnitProperties.MagicRes;

			var eff2:InventoryItemEffectChangeHeroAttribute = new InventoryItemEffectChangeHeroAttribute();
			eff2.change = 16;
			eff2.propertyId = HeroProperties.Intellect;
															
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapTransformer.recolorBitmap(BitmapResources.icoItemRingOfSuperiority.bitmapData, 0.9, 1, 2.3));
			item.name = "Ice Ring";
			item.description = "Magic resistance +{1}. Armor +{0}. Intellect + {2}.";
			item.type = InventoryItemType.RING;
			item.aiHint = ItemAiHintType.None;
			item.goldCost = 3000;
			item.effects.push(eff);
			item.effects.push(eff1);
			item.effects.push(eff2);			
			item.requiredSpecialization = _typesRepository.skillTreeRepository.ice;
									
			ringOfIce = item;
			game.inventoryItemManager.addItemType(item);		
		}
						
		private function staffOfBrillianceInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffect = new InventoryItemEffect();
			eff.change = 50;
			eff.coeficientPropertyId = UnitProperties.ManaRegen;
			eff.propertyId = UnitProperties.ManaRegen;
						
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoStaffOfBrilliance.bitmapData);
			item.name = "Staff of Brilliance";
			item.description = "Increases the mana regeneration rate of the Hero by {0}% when worn.";
			item.type = InventoryItemType.HAND;
			item.aiHint = ItemAiHintType.EquipableManaRegen;
			item.goldCost = 800;
			item.effects.push(eff);
			
			staffOfBrilliance = item;
			game.inventoryItemManager.addItemType(item);		
		}

		private function staffOfApprenticeInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffect = new InventoryItemEffect();
			eff.change = 15;
			eff.coeficientPropertyId = UnitProperties.ManaRegen;
			eff.propertyId = UnitProperties.ManaRegen;
						
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoStaffOfApprentice.bitmapData);
			item.name = "Staff of Apprentice";
			item.description = "Increases the mana regeneration rate of the Hero by {0}% when worn.";
			item.type = InventoryItemType.HAND;
			item.aiHint = ItemAiHintType.EquipableManaRegen;
			item.goldCost = 150;
			item.effects.push(eff);
			
			staffOfApprentice = item;
			game.inventoryItemManager.addItemType(item);		
		}
				
		private function arcaniteArmorInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffect = new InventoryItemEffect();
			eff.change = 7;
			eff.propertyId = UnitProperties.Armor;

			var eff1:InventoryItemEffectChangeHeroAttribute = new InventoryItemEffectChangeHeroAttribute();
			eff1.change = 4;
			eff1.propertyId = HeroProperties.Stength;
									
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemArcaniteArmor.bitmapData);
			item.name = "Arcanite Armor";
			item.description = "Enhances the Hero's armor by {0} and Strength by {1}.";
			item.type = InventoryItemType.ARMOR;
			item.aiHint = ItemAiHintType.EquipableStrength;
			item.goldCost = 3500;
			item.effects.push(eff);
			item.effects.push(eff1);
						
			arcaniteArmor = item;
			game.inventoryItemManager.addItemType(item);		
		}

		private function inkvisitorArmorInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffect = new InventoryItemEffect();
			eff.change = 8;
			eff.propertyId = UnitProperties.Armor;

			var eff1:InventoryItemEffect = new InventoryItemEffect();
			eff1.change = 15;
			eff1.propertyId = UnitProperties.MagicRes;
									
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemIncvisitorArmor.bitmapData);
			item.name = "Inkvisitor Armor";
			item.description = "Enhances the Hero's armor by {0} and magic resistance by {1}.";
			item.type = InventoryItemType.ARMOR;
			item.aiHint = ItemAiHintType.EquipableStrength;
			item.goldCost = 4000;
			item.effects.push(eff);
			item.effects.push(eff1);
			item.requiredSpecialization = _typesRepository.skillTreeRepository.retribution;
						
			inkvisitorArmor = item;
			game.inventoryItemManager.addItemType(item);		
		}
				
		private function leatherArmorInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffect = new InventoryItemEffect();
			eff.change = 3;
			eff.propertyId = UnitProperties.Armor;
						
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemLeatherArmor.bitmapData);
			item.name = "Leather Armor";
			item.description = "Enhances the Hero's armor by {0}.";
			item.type = InventoryItemType.ARMOR;
			item.aiHint = ItemAiHintType.EquipableStrength;
			item.goldCost = 300;
			item.effects.push(eff);
			
			leatherArmor = item;
			game.inventoryItemManager.addItemType(item);		
		}			

		private function breastPlateInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffect = new InventoryItemEffect();
			eff.change = 5;
			eff.propertyId = UnitProperties.Armor;
						
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemBreastPlate.bitmapData);
			item.name = "Breast Plate";
			item.description = "Enhances the Hero's armor by {0}.";
			item.type = InventoryItemType.ARMOR;
			item.aiHint = ItemAiHintType.EquipableStrength;
			item.goldCost = 800;
			item.effects.push(eff);
			
			breastPlate = item;
			game.inventoryItemManager.addItemType(item);		
		}
				
		private function robeOfIntelligenceInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffectChangeHeroAttribute = new InventoryItemEffectChangeHeroAttribute();
			eff.change = 4;
			eff.propertyId = HeroProperties.Intellect;
						
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemRobe1.bitmapData);
			item.name = "Robe of Intelligence";
			item.description = "Increases the Intelligence of the Hero by {0} when worn.";
			item.type = InventoryItemType.ARMOR;
			item.aiHint = ItemAiHintType.EquipableInt;
			item.goldCost = 100;
			item.effects.push(eff);
			
			robeOfIntelligece = item;
			game.inventoryItemManager.addItemType(item);		
		}
		
		private function helmOfHonorInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffectChangeHeroAttribute = new InventoryItemEffectChangeHeroAttribute();
			eff.change = 4;
			eff.propertyId = HeroProperties.Stength;

			var eff1:InventoryItemEffectChangeHeroAttribute = new InventoryItemEffectChangeHeroAttribute();
			eff1.change = 4;
			eff1.propertyId = HeroProperties.Agility;
									
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemHelm1.bitmapData);
			item.name = "Helm Of Honor";
			item.description = "Increases the Strength and Agility of the Hero by {0} when worn.";
			item.type = InventoryItemType.HEAD;
			item.aiHint = ItemAiHintType.EquipableStrength;
			item.goldCost = 550;
			item.effects.push(eff);
			item.effects.push(eff1);
						
			helmOfHonor = item;
			game.inventoryItemManager.addItemType(item);		
		}
		
		private function hoodOfCunningInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffectChangeHeroAttribute = new InventoryItemEffectChangeHeroAttribute();
			eff.change = 4;
			eff.propertyId = HeroProperties.Intellect;

			var eff1:InventoryItemEffectChangeHeroAttribute = new InventoryItemEffectChangeHeroAttribute();
			eff1.change = 4;
			eff1.propertyId = HeroProperties.Agility;
									
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemHood.bitmapData);
			item.name = "Hood Of Cunning";
			item.description = "Increases the Agility and Intelligence of the Hero by {0} when worn.";
			item.type = InventoryItemType.HEAD;
			item.aiHint = ItemAiHintType.EquipableInt;
			item.goldCost = 550;
			item.effects.push(eff);
			item.effects.push(eff1);
						
			hoodOfCunning = item;
			game.inventoryItemManager.addItemType(item);		
		}

		private function crownOfKingsInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffectChangeHeroAttribute = new InventoryItemEffectChangeHeroAttribute();
			eff.change = 6;
			eff.propertyId = HeroProperties.Intellect;

			var eff1:InventoryItemEffectChangeHeroAttribute = new InventoryItemEffectChangeHeroAttribute();
			eff1.change = 6;
			eff1.propertyId = HeroProperties.Agility;

			var eff2:InventoryItemEffectChangeHeroAttribute = new InventoryItemEffectChangeHeroAttribute();
			eff2.change = 6;
			eff2.propertyId = HeroProperties.Stength;
												
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemHelm2.bitmapData);
			item.name = "Crown Of Kings";
			item.description = "Increases the Strength, Intelligence, and Agility of the Hero by {0} when worn.";
			item.type = InventoryItemType.HEAD;
			item.aiHint = ItemAiHintType.EquipableRaiseStats;
			item.goldCost = 1750;
			item.effects.push(eff);
			item.effects.push(eff1);
			item.effects.push(eff2);
									
			crownOfKings = item;
			game.inventoryItemManager.addItemType(item);		
		}

		private function crownOfUndeadInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffectChangeHeroAttribute = new InventoryItemEffectChangeHeroAttribute();
			eff.change = 8;
			eff.propertyId = HeroProperties.Intellect;

			var eff1:InventoryItemEffectChangeHeroAttribute = new InventoryItemEffectChangeHeroAttribute();
			eff1.change = 8;
			eff1.propertyId = HeroProperties.Agility;

			var eff2:InventoryItemEffectChangeHeroAttribute = new InventoryItemEffectChangeHeroAttribute();
			eff2.change = 8;
			eff2.propertyId = HeroProperties.Stength;
												
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapTransformer.recolorBitmap(BitmapResources.icoItemHelm2.bitmapData, 1.4, 1.4, 0.9));
			item.name = "Crown Of Undead";
			item.description = "Increases the Strength, Intelligence, and Agility of the Hero by {0} when worn.";
			item.type = InventoryItemType.HEAD;
			item.aiHint = ItemAiHintType.EquipableRaiseStats;
			item.goldCost = 1800;
			item.effects.push(eff);
			item.effects.push(eff1);
			item.effects.push(eff2);
									
			crownOfUndead = item;		
		}
				
		private function amuletOfManaInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffect = new InventoryItemEffect();
			eff.change = 250;
			eff.propertyId = UnitProperties.MaxMana;
									
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemAmuletOfMana.bitmapData);
			item.name = "Amulet of Mana";
			item.description = "Increases the mana capacity of the Hero by {0} when worn.";
			item.type = InventoryItemType.AMULET;
			item.aiHint = ItemAiHintType.EquipableInt;
			item.goldCost = 500;
			item.effects.push(eff);
						
			amuletOfMana = item;
			game.inventoryItemManager.addItemType(item);		
		}
		
		private function talismanOfVitalityInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffect = new InventoryItemEffect();
			eff.change = 300;
			eff.propertyId = UnitProperties.MaxHealth;
									
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemAmuletOfHealth.bitmapData);
			item.name = "Talisman of Vitality";
			item.description = "Increases the health capacity of the Hero by {0} when worn.";
			item.type = InventoryItemType.AMULET;
			item.aiHint = ItemAiHintType.EquipableGeneric;
			item.goldCost = 550;
			item.effects.push(eff);
						
			talismanOfVitality = item;
			game.inventoryItemManager.addItemType(item);		
		}

		private function thunderInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffect = new InventoryItemEffect();
			eff.change = 200;
			eff.propertyId = UnitProperties.MaxHealth;

			var eff1:InventoryItemEffect = new InventoryItemEffect();
			eff1.change = 150;
			eff1.propertyId = UnitProperties.MaxMana;

			var eff2:InventoryItemEffect = new InventoryItemEffect();
			eff2.change = 3;
			eff2.propertyId = UnitProperties.DamageRetention;			

			var eff3:InventoryItemEffectAddSpell = new InventoryItemEffectAddSpell();
			eff3.spellType = _typesRepository.spellTypes.lightningStormLvl1;			
												
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemAmuletThunder.bitmapData);
			item.name = "Thunder";
			item.description = "Increases the health capacity of the Hero by {0} and mana by {1} when worn.\r\nCauses {2} Lightning damage when hit.\r\nThunderstorm (Spell).";
			item.type = InventoryItemType.AMULET;
			item.aiHint = ItemAiHintType.EquipableGeneric;
			item.goldCost = 3500;
			item.effects.push(eff);
			item.effects.push(eff1);
			item.effects.push(eff2);			
			item.effects.push(eff3);
												
			thunder = item;
			game.inventoryItemManager.addItemType(item);		
		}
		
		private function talismanOfTranquilityInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffect = new InventoryItemEffect();
			eff.change = 250;
			eff.propertyId = UnitProperties.MaxHealth;

			var eff1:InventoryItemEffectAddSpell = new InventoryItemEffectAddSpell();
			eff1.spellType = _typesRepository.spellTypes.rejuvenateLvl1;
												
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemAmulet3.bitmapData);
			item.name = "Talisman of Tranquility";
			item.description = "Increases the health capacity of the Hero by {0} when worn.\r\nRejuvenate (Spell).";
			item.type = InventoryItemType.AMULET;
			item.aiHint = ItemAiHintType.EquipableGeneric;
			item.goldCost = 1250;
			item.effects.push(eff);
			item.effects.push(eff1);
									
			talismanOfTranquility = item;
			game.inventoryItemManager.addItemType(item);		
		}

		private function runeInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffectChangeHeroAttribute = new InventoryItemEffectChangeHeroAttribute();
			eff.change = 20;
			eff.propertyId = HeroProperties.Intellect;

			var eff1:InventoryItemEffectAddSpell = new InventoryItemEffectAddSpell();
			eff1.spellType = _typesRepository.spellTypes.runeLvl1;
			
			var eff2:InventoryItemEffectChangeHeroAttribute = new InventoryItemEffectChangeHeroAttribute();
			eff2.change = 20;
			eff2.propertyId = HeroProperties.Stength;			

			var eff3:InventoryItemEffectChangeHeroAttribute = new InventoryItemEffectChangeHeroAttribute();
			eff3.change = 10;
			eff3.propertyId = HeroProperties.Agility;
															
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemRuneAmulet.bitmapData);
			item.name = "Rune (Artefact)";
			item.description = "Intellect + {0}.\r\nStrength + {2}.\r\nAgility + {3}.\r\nRune (Spell).";
			item.type = InventoryItemType.AMULET;
			item.aiHint = ItemAiHintType.EquipableGeneric;
			item.goldCost = 12500;
			item.effects.push(eff);
			item.effects.push(eff1);
			item.effects.push(eff2);
			item.effects.push(eff3);
															
			talismanOfTranquility = item;
			game.inventoryItemManager.addItemType(item);		
		}

		private function timeInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffectChangeHeroAttribute = new InventoryItemEffectChangeHeroAttribute();
			eff.change = 40;
			eff.propertyId = HeroProperties.Intellect;

			var eff1:InventoryItemEffectAddSpell = new InventoryItemEffectAddSpell();
			eff1.spellType = _typesRepository.spellTypes.timeStop;

			var eff2:InventoryItemEffect = new InventoryItemEffect();
			eff2.change = 2;
			eff2.propertyId = UnitProperties.Armor;
																		
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemTimeDagger.bitmapData);
			item.name = "Time (Artefact)";
			item.description = "Intellect +{0}.\r\nArmor +{2}.\r\nTime Stop (Spell).";
			item.type = InventoryItemType.OFF_HAND;
			item.aiHint = ItemAiHintType.EquipableGeneric;
			item.goldCost = 15000;
			item.effects.push(eff);
			item.effects.push(eff1);
			item.effects.push(eff2);
															
			time = item;
			game.inventoryItemManager.addItemType(item);		
		}

		private function titansShellInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffectChangeHeroAttribute = new InventoryItemEffectChangeHeroAttribute();
			eff.change = 30;
			eff.propertyId = HeroProperties.Stength;

			var eff1:InventoryItemEffectAddSpell = new InventoryItemEffectAddSpell();
			eff1.spellType = _typesRepository.spellTypes.titanShell;

			var eff2:InventoryItemEffect = new InventoryItemEffect();
			eff2.change = 6;
			eff2.propertyId = UnitProperties.Armor;
																		
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemTitanShield.bitmapData);
			item.name = "Titan's Shell (Artefact)";
			item.description = "Strength +{0}.\r\nArmor +{2}.\r\nTitan's Shell (Spell).";
			item.type = InventoryItemType.OFF_HAND;
			item.aiHint = ItemAiHintType.EquipableGeneric;
			item.goldCost = 16000;
			item.effects.push(eff);
			item.effects.push(eff1);
			item.effects.push(eff2);
															
			titansShell = item;
			game.inventoryItemManager.addItemType(item);		
		}
										
		private function robeOfMagiInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffectChangeHeroAttribute = new InventoryItemEffectChangeHeroAttribute();
			eff.change = 8;
			eff.propertyId = HeroProperties.Intellect;
									
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemRobeOfMagi.bitmapData);
			item.name = "Robe of Magi";
			item.description = "Increases the Intelligence of the Hero by {0} when worn.";
			item.type = InventoryItemType.ARMOR;
			item.aiHint = ItemAiHintType.EquipableInt;
			item.goldCost = 500;
			item.effects.push(eff);
						
			robeOfMagi = item;
			game.inventoryItemManager.addItemType(item);		
		}

		private function robeOfArchmageInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffectChangeHeroAttribute = new InventoryItemEffectChangeHeroAttribute();
			eff.change = 10;
			eff.propertyId = HeroProperties.Intellect;

			var eff1:InventoryItemEffect = new InventoryItemEffect();
			eff1.change = 5;
			eff1.propertyId = UnitProperties.Armor;

			var eff2:InventoryItemEffect = new InventoryItemEffect();
			eff2.change = 10;
			eff2.propertyId = UnitProperties.SpellBonus;

			var eff3:InventoryItemEffect = new InventoryItemEffect();
			eff3.change = 10;
			eff3.propertyId = UnitProperties.MagicRes;
																		
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapTransformer.recolorBitmap(BitmapResources.icoItemRobeOfMagi.bitmapData, 1, 1.8, 1));
			item.name = "Archmage's Robes";
			item.description = "Increases the Intelligence of the Hero by {0} when worn.\r\nArmor +{1}.\r\nSpell Damage Bonus +{2}%.\r\nMagic Resistance +{3}.";
			item.type = InventoryItemType.ARMOR;
			item.aiHint = ItemAiHintType.None;
			item.goldCost = 4000;
			item.effects.push(eff);
			item.effects.push(eff1);
			item.effects.push(eff2);
			item.effects.push(eff3);
															
			robeOfArchmage = item;
			game.inventoryItemManager.addItemType(item);		
		}
				
		private function mirrorShieldInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffect = new InventoryItemEffect();
			eff.change = 20;
			eff.propertyId = UnitProperties.MagicRes;
									
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoSpellShieldWall.bitmapData);
			item.name = "Mirror Shield";
			item.description = "Reduces Magic damage dealt to the Hero by {0}%.";
			item.type = InventoryItemType.OFF_HAND;
			item.goldCost = 850;
			item.effects.push(eff);
						
			mirrorShield = item;
			game.inventoryItemManager.addItemType(item);		
		}

		private function bronseShieldInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffect = new InventoryItemEffect();
			eff.change = 3;
			eff.propertyId = UnitProperties.Armor;

			var eff1:InventoryItemEffectChangeHeroAttribute = new InventoryItemEffectChangeHeroAttribute();
			eff1.change = 2;
			eff1.propertyId = HeroProperties.Stength;
												
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemShieldBronze.bitmapData);
			item.name = "Bronze Shield";
			item.description = "Increases the Hero's armor by {0} and Strength by {1} when worn.";
			item.type = InventoryItemType.OFF_HAND;
			item.aiHint = ItemAiHintType.EquipableStrength;				
			item.goldCost = 800;
			item.effects.push(eff);
			item.effects.push(eff1);
									
			bronseShield = item;
			game.inventoryItemManager.addItemType(item);		
		}
				
		private function battleShieldInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffect = new InventoryItemEffect();
			eff.change = 5;
			eff.propertyId = UnitProperties.Armor;
									
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemSteelShield.bitmapData);
			item.name = "Battle Shield";
			item.description = "Increases the Hero's armor by {0} when worn.";
			item.type = InventoryItemType.OFF_HAND;
			item.aiHint = ItemAiHintType.EquipableStrength;				
			item.goldCost = 2200;
			item.effects.push(eff);
						
			battleShield = item;
			game.inventoryItemManager.addItemType(item);		
		}

		private function shieldOfTheGuardianInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffect = new InventoryItemEffect();
			eff.change = 6;
			eff.propertyId = UnitProperties.Armor;

			var eff1:InventoryItemEffect = new InventoryItemEffect();
			eff1.change = 10;
			eff1.propertyId = UnitProperties.MagicRes;
												
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapTransformer.recolorBitmap(BitmapResources.icoItemSteelShield.bitmapData, 3, 3, 1));
			item.name = "Shield of The Guardian";
			item.description = "Increases the Hero's armor by {0} and magic resistance by {1} when worn.";
			item.type = InventoryItemType.OFF_HAND;
			item.aiHint = ItemAiHintType.EquipableStrength;			
			item.goldCost = 3500;
			item.effects.push(eff);
			item.effects.push(eff1);
									
			shieldOfTheGuardian = item;
			game.inventoryItemManager.addItemType(item);		
		}

		private function archmageTomeInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffect = new InventoryItemEffect();
			eff.change = 300;
			eff.propertyId = UnitProperties.MaxMana;
			
			var eff1:InventoryItemEffect = new InventoryItemEffect();
			eff1.change = 10;
			eff1.propertyId = UnitProperties.SpellBonus;			
									
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemArcaneTome.bitmapData);
			item.name = "Archmage's Tome";
			item.description = "Increases the Hero's mana by {0} while equipped. Increases damage from spells by {1}%.";
			item.type = InventoryItemType.OFF_HAND;
			item.goldCost = 4200;
			item.aiHint = ItemAiHintType.EquipableInt;
			item.effects.push(eff);
			item.effects.push(eff1);
									
			archmageTome = item;
			game.inventoryItemManager.addItemType(item);		
		}
						
		private function arcaneTomeInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffect = new InventoryItemEffect();
			eff.change = 360;
			eff.propertyId = UnitProperties.MaxMana;
			
			var eff1:InventoryItemEffect = new InventoryItemEffect();
			eff1.change = 14;
			eff1.propertyId = UnitProperties.SpellBonus;			
									
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapTransformer.recolorBitmap(BitmapResources.icoItemArcaneTome.bitmapData, 1, 1, 1.7));
			item.name = "Arcane Tome";
			item.description = "Increases the Hero's mana by {0} while equipped. Increases damage from spells by {1}%.";
			item.type = InventoryItemType.OFF_HAND;
			item.goldCost = 4400;
			item.aiHint = ItemAiHintType.None
			item.effects.push(eff);
			item.effects.push(eff1);
			item.requiredSpecialization = _typesRepository.skillTreeRepository.arcane;
									
			arcaneTome = item;
			game.inventoryItemManager.addItemType(item);		
		}	

		private function scepterOfDiscordInit(game:Game, typesRepository:TypesRepository):void
		{	
			var eff:InventoryItemEffectAddSpell = new InventoryItemEffectAddSpell();
			eff.spellType = _typesRepository.spellTypes.discordLvl1;
											
			var eff1:InventoryItemEffect = new InventoryItemEffect();
			eff1.change = 14;
			eff1.propertyId = UnitProperties.SpellBonus;	

			var eff2:InventoryItemEffect = new InventoryItemEffect();
			eff2.change = 100;
			eff2.propertyId = UnitProperties.MaxMana;
															
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemDiscord.bitmapData);
			item.name = "Scepter Of Discord";
			item.description = "Increases damage from spells by {1}%.\r\nTotal mana + {2}.\r\nDiscord (Spell).";
			item.type = InventoryItemType.OFF_HAND;
			item.goldCost = 4400;
			item.aiHint = ItemAiHintType.None
			item.effects.push(eff);
			item.effects.push(eff1);
			item.effects.push(eff2);
						
			item.requiredSpecialization = _typesRepository.skillTreeRepository.elemental;
									
			scepterOfDiscord = item;
			game.inventoryItemManager.addItemType(item);		
		}

		private function spiderTotemInit(game:Game, typesRepository:TypesRepository):void
		{	
			var eff:InventoryItemEffectAddSpell = new InventoryItemEffectAddSpell();
			eff.spellType = _typesRepository.spellTypes.webLvl1;
											
			var eff1:InventoryItemEffectChangeHeroAttribute = new InventoryItemEffectChangeHeroAttribute();
			eff1.change = 12;
			eff1.propertyId = HeroProperties.Agility;	
															
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemSpiderTotem.bitmapData);
			item.name = "Spider Totem";
			item.description = "Increases Agility by {1}.\r\nWeb (Spell).";
			item.type = InventoryItemType.OFF_HAND;
			item.goldCost = 2600;
			item.aiHint = ItemAiHintType.None
			item.effects.push(eff);
			item.effects.push(eff1);
									
			spiderTotem = item;
			game.inventoryItemManager.addItemType(item);		
		}
				
		private function grimuarInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffect = new InventoryItemEffect();
			eff.change = 360;
			eff.propertyId = UnitProperties.MaxMana;			

			var eff1:InventoryItemEffect = new InventoryItemEffect();
			eff1.change = 120;
			eff1.propertyId = UnitProperties.MaxHealth;
												
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapTransformer.recolorBitmap(BitmapResources.icoItemArcaneTome.bitmapData, 0.9, 1.5, 0.9));
			item.name = "Grimuar";
			item.description = "Increases the Hero's mana by {0} while equipped. Increases total health by {1}.";
			item.type = InventoryItemType.OFF_HAND;
			item.goldCost = 4400;
			item.aiHint = ItemAiHintType.None
			item.effects.push(eff);
			item.effects.push(eff1);
			item.requiredSpecialization = _typesRepository.skillTreeRepository.necromancy;
									
			grimuar = item;
			game.inventoryItemManager.addItemType(item);		
		}
				
		private function scepterOfApprenticeInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffectChangeHeroAttribute = new InventoryItemEffectChangeHeroAttribute();
			eff.change = 2;
			eff.propertyId = HeroProperties.Intellect;		
									
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoWandBlue.bitmapData);
			item.name = "Scepter Of Apprentice";
			item.description = "Increases the Hero's Intellect by {0} while equipped.";
			item.type = InventoryItemType.OFF_HAND;
			item.aiHint = ItemAiHintType.EquipableInt;
			item.goldCost = 50;
			item.effects.push(eff);
									
			scepterOfApprentice = item;
			game.inventoryItemManager.addItemType(item);		
		}

		private function scepterOfSpellcastingInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffectChangeHeroAttribute = new InventoryItemEffectChangeHeroAttribute();
			eff.change = 10;
			eff.propertyId = HeroProperties.Intellect;		

			var eff1:InventoryItemEffect = new InventoryItemEffect();
			eff1.change = 3;
			eff1.propertyId = UnitProperties.AttackDmgMin;		

			var eff2:InventoryItemEffect = new InventoryItemEffect();
			eff2.change = 3;
			eff2.propertyId = UnitProperties.AttackDmgMax;
												
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoWandFire.bitmapData);
			item.name = "Scepter Of Spellcasting";
			item.description = "Increases the Hero's Intellect by {0} and attack by {1} while equipped.";
			item.type = InventoryItemType.OFF_HAND;
			item.aiHint = ItemAiHintType.EquipableInt;
			item.goldCost = 1200;
			item.effects.push(eff);
			item.effects.push(eff1);
			item.effects.push(eff2);						
									
			scepterOfSpellcasting = item;
			game.inventoryItemManager.addItemType(item);		
		}
				
		private function woodenShieldInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffect = new InventoryItemEffect();
			eff.change = 1;
			eff.propertyId = UnitProperties.Armor;		
									
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemWoodenShield.bitmapData);
			item.name = "Wooden Shield";
			item.description = "Increases the Hero's Armor by {0} while equipped.";
			item.type = InventoryItemType.OFF_HAND;
			item.aiHint = ItemAiHintType.EquipableStrength;
			item.goldCost = 70;
			item.effects.push(eff);
									
			woodenShield = item;
			game.inventoryItemManager.addItemType(item);		
		}
		
		private function ringOfProtectionInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffect = new InventoryItemEffect();
			eff.change = 2;
			eff.propertyId = UnitProperties.Armor;		
									
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemRingOfProtection.bitmapData);
			item.name = "Ring of Protection";
			item.description = "Increases the Hero's Armor by {0} while equipped.";
			item.type = InventoryItemType.RING;
			item.aiHint = ItemAiHintType.EquipableGeneric;
			item.goldCost = 150;
			item.effects.push(eff);
									
			ringOfProtection = item;
			game.inventoryItemManager.addItemType(item);		
		}			

		private function ringOfTheRamInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffect = new InventoryItemEffect();
			eff.change = 3;
			eff.propertyId = UnitProperties.AttackDmgMin;
			
			var eff1:InventoryItemEffect = new InventoryItemEffect();
			eff1.change = 3;
			eff1.propertyId = UnitProperties.AttackDmgMax;						
									
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemRingOfTheRam.bitmapData);
			item.name = "Ring of the Ram";
			item.description = "Increases the attack damage of the Hero by {0} when equipped.";
			item.type = InventoryItemType.RING;
			item.aiHint = ItemAiHintType.EquipableGeneric;
			item.goldCost = 350;
			item.effects.push(eff);
									
			ringOfTheRam = item;
			game.inventoryItemManager.addItemType(item);		
		}
		
		private function ringOfDefenseInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffect = new InventoryItemEffect();
			eff.change = 4;
			eff.propertyId = UnitProperties.Armor;		
									
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemRingOfDefense.bitmapData);
			item.name = "Ring of Defense";
			item.description = "Increases the Hero's Armor by {0} while equipped.";
			item.type = InventoryItemType.RING;
			item.aiHint = ItemAiHintType.EquipableStrength;
			item.goldCost = 550;
			item.effects.push(eff);
									
			ringOfDefense = item;
			game.inventoryItemManager.addItemType(item);		
		}
				
		private function warAxeInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffect = new InventoryItemEffect();
			eff.change = 5;
			eff.propertyId = UnitProperties.AttackDmgMin;		

			var eff1:InventoryItemEffect = new InventoryItemEffect();
			eff1.change = 5;
			eff1.propertyId = UnitProperties.AttackDmgMax;	
												
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemWarAxe.bitmapData);
			item.name = "War Axe";
			item.description = "Increases the attack damage of the Hero by {0} when equipped.";
			item.type = InventoryItemType.HAND;
			item.aiHint = ItemAiHintType.EquipableStrength;
			item.goldCost = 600;
			item.effects.push(eff);
			item.effects.push(eff1);
												
			warAxe = item;
			game.inventoryItemManager.addItemType(item);		
		}	
		
		private function executorInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffect = new InventoryItemEffect();
			eff.change = 14;
			eff.propertyId = UnitProperties.AttackDmgMin;		

			var eff1:InventoryItemEffect = new InventoryItemEffect();
			eff1.change = 14;
			eff1.propertyId = UnitProperties.AttackDmgMax;	

			var eff2:InventoryItemEffect = new InventoryItemEffect();
			eff2.change = -12;
			eff2.coeficientPropertyId = UnitProperties.AttackDelay;
			eff2.propertyId = UnitProperties.AttackDelay;	
															
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapTransformer.recolorBitmap(BitmapResources.icoItemWarAxe.bitmapData, 1.6, 1, 1));
			item.name = "Executor";
			item.description = "Increases the attack damage of the Hero by {0} when equipped. Increases attack speed by 12%.";
			item.type = InventoryItemType.HAND;
			item.aiHint = ItemAiHintType.None;
			item.goldCost = 4500;
			item.effects.push(eff);
			item.effects.push(eff1);
			item.effects.push(eff2);
			item.requiredSpecialization = _typesRepository.skillTreeRepository.rage;
															
			executor = item;
			game.inventoryItemManager.addItemType(item);		
		}			

		private function mjolnirInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffect = new InventoryItemEffect();
			eff.change = 14;
			eff.propertyId = UnitProperties.AttackDmgMin;		

			var eff1:InventoryItemEffect = new InventoryItemEffect();
			eff1.change = 14;
			eff1.propertyId = UnitProperties.AttackDmgMax;	

			var eff2:InventoryItemEffectAddSpell = new InventoryItemEffectAddSpell();
			eff2.spellType = typesRepository.spellTypes.lightningStrike;	
															
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemAxe2.bitmapData);
			item.name = "Mjölnir";
			item.description = "Increases the attack damage of the Hero by {0} when equipped.\r\n.Lightning Strike (Spell).";
			item.type = InventoryItemType.HAND;
			item.aiHint = ItemAiHintType.None;
			item.goldCost = 4500;
			item.effects.push(eff);
			item.effects.push(eff1);
			item.effects.push(eff2);
			item.requiredSpecialization = _typesRepository.skillTreeRepository.combat;
															
			mjolnir = item;
			game.inventoryItemManager.addItemType(item);		
		}
		
		private function steelSwordInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffect = new InventoryItemEffect();
			eff.change = 3;
			eff.propertyId = UnitProperties.AttackDmgMin;		

			var eff1:InventoryItemEffect = new InventoryItemEffect();
			eff1.change = 3;
			eff1.propertyId = UnitProperties.AttackDmgMax;	
												
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemSteelSword.bitmapData);
			item.name = "Steel Sword";
			item.description = "Increases the attack damage of the Hero by {0} when equipped.";
			item.type = InventoryItemType.HAND;
			item.aiHint = ItemAiHintType.EquipableStrength;
			item.goldCost = 300;
			item.effects.push(eff);
			item.effects.push(eff1);
												
			steelSword = item;
			game.inventoryItemManager.addItemType(item);		
		}

		private function arcaniteSwordInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffect = new InventoryItemEffect();
			eff.change = 8;
			eff.propertyId = UnitProperties.AttackDmgMin;		

			var eff1:InventoryItemEffect = new InventoryItemEffect();
			eff1.change = 8;
			eff1.propertyId = UnitProperties.AttackDmgMax;	
												
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemAracniteSword.bitmapData);
			item.name = "Arcanite Sword";
			item.description = "Increases the attack damage of the Hero by {0} when equipped.";
			item.type = InventoryItemType.HAND;
			item.aiHint = ItemAiHintType.EquipableStrength;
			item.goldCost = 1200;
			item.effects.push(eff);
			item.effects.push(eff1);
												
			arcaniteSword = item;
			game.inventoryItemManager.addItemType(item);		
		}

		private function etherSwordInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffect = new InventoryItemEffect();
			eff.change = 6;
			eff.propertyId = UnitProperties.AttackDmgMin;		

			var eff1:InventoryItemEffect = new InventoryItemEffect();
			eff1.change = 6;
			eff1.propertyId = UnitProperties.AttackDmgMax;	
			
			var eff2:InventoryItemEffectChangeHeroAttribute = new InventoryItemEffectChangeHeroAttribute();
			eff2.change = 10;
			eff2.propertyId = HeroProperties.Intellect;

			var eff3:InventoryItemEffectAddSpell = new InventoryItemEffectAddSpell();
			eff3.spellType = _typesRepository.spellTypes.etherFormLvl1;
																		
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemEtherSword.bitmapData);
			item.name = "Ether Sword";
			item.description = "Increases the attack damage of the Hero by {0} when equipped.\r\nIntellect +{2}.\r\nEther Form (Spell).";
			item.type = InventoryItemType.HAND;
			item.aiHint = ItemAiHintType.EquipableInt;
			item.goldCost = 2500;
			item.effects.push(eff);
			item.effects.push(eff1);
			item.effects.push(eff2);
			item.effects.push(eff3);
																		
			etherSword = item;
			game.inventoryItemManager.addItemType(item);		
		}
		
		private function avengerInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffect = new InventoryItemEffect();
			eff.change = 14;
			eff.propertyId = UnitProperties.AttackDmgMin;		

			var eff1:InventoryItemEffect = new InventoryItemEffect();
			eff1.change = 14;
			eff1.propertyId = UnitProperties.AttackDmgMax;	
			
			var eff2:InventoryItemEffect = new InventoryItemEffect();
			eff2.change = 100;
			eff2.propertyId = UnitProperties.MaxHealth;			
												
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemGreatSword.bitmapData);
			item.name = "Avenger";
			item.description = "Increases the attack damage of the Hero by {0} when equipped. Also increases the health capacity of the Hero by {2}.";
			item.type = InventoryItemType.HAND;
			item.aiHint = ItemAiHintType.EquipableStrength;
			item.goldCost = 4600;
			item.effects.push(eff);
			item.effects.push(eff1);
			item.effects.push(eff2);
															
			avenger = item;
			game.inventoryItemManager.addItemType(item);		
		}

		private function crusaderInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffect = new InventoryItemEffect();
			eff.change = 15;
			eff.propertyId = UnitProperties.AttackDmgMin;		

			var eff1:InventoryItemEffect = new InventoryItemEffect();
			eff1.change = 15;
			eff1.propertyId = UnitProperties.AttackDmgMax;	
			
			var eff2:InventoryItemEffect = new InventoryItemEffect();
			eff2.change = _typesRepository.spellTypes.itemStunLvl1.id;
			eff2.propertyId = UnitProperties.AttackSpell;
												
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapTransformer.recolorBitmap(BitmapResources.icoItemGreatSword.bitmapData, 1.8, 1.8, 0.8));
			item.name = "Crusader";
			item.description = "Increases the attack damage of the Hero by {0} when equipped. Every attack has a 15% chance to stun the target for 1.5 sec.";
			item.type = InventoryItemType.HAND;
			item.aiHint = ItemAiHintType.None;
			item.goldCost = 4800;
			item.effects.push(eff);
			item.effects.push(eff1);
			item.effects.push(eff2);
			item.requiredSpecialization = _typesRepository.skillTreeRepository.holy;
															
			crusader = item;
			game.inventoryItemManager.addItemType(item);		
		}
				
		private function staffOfAchmageInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffect = new InventoryItemEffect();
			eff.change = 10;
			eff.propertyId = UnitProperties.AttackDmgMin;		

			var eff1:InventoryItemEffect = new InventoryItemEffect();
			eff1.change = 10;
			eff1.propertyId = UnitProperties.AttackDmgMax;	
			
			var eff2:InventoryItemEffect = new InventoryItemEffect();
			eff2.change = 15;
			eff2.propertyId = UnitProperties.SpellBonus;	
			
			var eff3:InventoryItemEffect = new InventoryItemEffect();
			eff3.change = 50;
			eff3.coeficientPropertyId = UnitProperties.ManaRegen;
			eff3.propertyId = UnitProperties.ManaRegen;					
												
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemGreatStaff.bitmapData);
			item.name = "The Archmage's Staff";
			item.description = "Increases the attack damage of the Hero by {0} when equipped. Also increases the spell damage of the Hero by {2}% and Mana regeneration by {3}%.";
			item.type = InventoryItemType.HAND;
			item.goldCost = 4600;
			item.aiHint = ItemAiHintType.EquipableInt;
			item.effects.push(eff);
			item.effects.push(eff1);
			item.effects.push(eff2);
			item.effects.push(eff3);
																		
			staffOfAchmage = item;
			game.inventoryItemManager.addItemType(item);		
		}

		private function summonerInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffect = new InventoryItemEffect();
			eff.change = 10;
			eff.propertyId = UnitProperties.AttackDmgMin;		

			var eff1:InventoryItemEffect = new InventoryItemEffect();
			eff1.change = 10;
			eff1.propertyId = UnitProperties.AttackDmgMax;	
			
			var eff2:InventoryItemEffectAddSpell = new InventoryItemEffectAddSpell();
			eff2.spellType = _typesRepository.spellTypes.teleportOtherLvl1;	
			
			var eff3:InventoryItemEffect = new InventoryItemEffect();
			eff3.change = 50;
			eff3.coeficientPropertyId = UnitProperties.ManaRegen;
			eff3.propertyId = UnitProperties.ManaRegen;					
												
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapTransformer.recolorBitmap(BitmapResources.icoItemGreatStaff.bitmapData, 1, 0.8, 1.8));
			item.name = "Summoner (Staff)";
			item.description = "Increases the attack damage of the Hero by {0} when equipped and Mana regeneration by {3}%.\r\nSummon (Spell).";
			item.type = InventoryItemType.HAND;
			item.goldCost = 4800;
			item.aiHint = ItemAiHintType.EquipableInt;
			item.effects.push(eff);
			item.effects.push(eff1);
			item.effects.push(eff2);			
			item.effects.push(eff3);
																		
			summoner = item;
			game.inventoryItemManager.addItemType(item);		
		}
				
		private function tomeOfStrengthInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffectPermament = new InventoryItemEffectPermament();
			eff.change = 1;
			eff.propertyId = HeroProperties.Stength;		
									
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemTomeOfStrength.bitmapData);
			item.name = "Tome of Strength";
			item.description = "Permanently increases the Strength of the Hero by {0} when used.";
			item.type = InventoryItemType.USABLE;
			item.aiHint = ItemAiHintType.PowerUpStrength;
			item.goldCost = 300;
			item.effects.push(eff);
									
			tomeOfStrength = item;
			game.inventoryItemManager.addItemType(item);		
		}
		
		private function tomeOfAgilityInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffectPermament = new InventoryItemEffectPermament();
			eff.change = 1;
			eff.propertyId = HeroProperties.Agility;		
									
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemTomeOfAgility.bitmapData);
			item.name = "Tome of Agility";
			item.description = "Permanently increases the Agility of the Hero by {0} when used.";
			item.type = InventoryItemType.USABLE;
			item.aiHint = ItemAiHintType.PowerUpAgility;
			item.goldCost = 300;
			item.effects.push(eff);
									
			tomeOfAgility = item;
			game.inventoryItemManager.addItemType(item);		
		}
	
		private function tomeOfIntellectInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffectPermament = new InventoryItemEffectPermament();
			eff.change = 1;
			eff.propertyId = HeroProperties.Intellect;		
									
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemTomeOfIntellect.bitmapData);
			item.name = "Tome of Intellect";
			item.description = "Permanently increases the Intellect of the Hero by {0} when used.";
			item.type = InventoryItemType.USABLE;
			item.aiHint = ItemAiHintType.PowerUpIntellect;
			item.goldCost = 300;
			item.effects.push(eff);
									
			tomeOfIntellect = item;
			game.inventoryItemManager.addItemType(item);		
		}
		
		private function scrollOfSpeedInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:SpellEffectCastSpell = new SpellEffectCastSpell();
			eff.spellTypeId = typesRepository.spellTypes.chargeLvl1.id;
			eff.nextTargetIsRandom = false;
									
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemScrollOfSpeed.bitmapData);
			item.name = "Scroll of Speed";
			item.description = "Increase Hero's speed by 40% for 15 sec when used.";
			item.type = InventoryItemType.USABLE;
			item.aiHint = ItemAiHintType.None;
			item.goldCost = 200;
			item.cooldown = new GameTime(0, 60).value;
			item.effects.push(eff);
									
			scrollOfSpeed = item;
			game.inventoryItemManager.addItemType(item);		
		}	

		private function scrollOfTownPortalInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:SpellEffectCastSpell = new SpellEffectCastSpell();
			eff.spellTypeId = typesRepository.spellTypes.townPortal.id;
			eff.nextTargetIsRandom = false;
									
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemScrollTownPortal.bitmapData);
			item.name = "Scroll of Town Portal";
			item.description = "Teleports you to an allied building or a point nearby an allied building.";
			item.type = InventoryItemType.USABLE;
			item.aiHint = ItemAiHintType.None;
			item.goldCost = 160;
			item.cooldown = new GameTime(0, 80).value;
			item.effects.push(eff);
									
			scrollOfTownPortal = item;
			game.inventoryItemManager.addItemType(item);		
		}
		
		private function scrollOfAncientProtectorInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:SpellEffectCastSpell = new SpellEffectCastSpell();
			eff.spellTypeId = typesRepository.spellTypes.summonAncientProtectorLvl1.id;
			eff.nextTargetIsRandom = false;
									
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapTransformer.recolorBitmap(BitmapResources.icoItemScrollOfSpeed.bitmapData, 80, 80, 0, 1, true));
			item.name = "Scroll of Ancient Protector";
			item.description = "Summons a Ancient Protector that can repair structures. Lasts 60 sec.";
			item.type = InventoryItemType.USABLE;
			item.aiHint = ItemAiHintType.None;
			item.goldCost = 1000;
			item.cooldown = new GameTime(0, 60).value;
			item.effects.push(eff);
									
			scrollOfAncientProtector = item;
			game.inventoryItemManager.addItemType(item);		
		}			
		
		private function potionOfDivinityInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:SpellEffectCastSpell = new SpellEffectCastSpell();
			eff.spellTypeId = typesRepository.spellTypes.devineShield1Lvl1.id;
			eff.nextTargetIsRandom = false;
									
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemPotionOfDivinity.bitmapData);
			item.name = "Potion of Divinity";
			item.description = "Turns the Hero invulnerable for 15 seconds.";
			item.type = InventoryItemType.USABLE;
			item.goldCost = 600;
			item.cooldown = new GameTime(0, 0, 2).value;
			item.aiHint = ItemAiHintType.None;
			item.effects.push(eff);
									
			potionOfDivinity = item;
			game.inventoryItemManager.addItemType(item);		
		}
				
		private function dawnStarInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffect = new InventoryItemEffect();
			eff.change = 12;
			eff.propertyId = UnitProperties.AttackDmgMin;		

			var eff1:InventoryItemEffect = new InventoryItemEffect();
			eff1.change = 12;
			eff1.propertyId = UnitProperties.AttackDmgMax;	
			
			var eff2:InventoryItemEffect = new InventoryItemEffect();
			eff2.change = typesRepository.spellTypes.banishItem.id;
			eff2.propertyId = UnitProperties.AttackSpell;						
												
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemDawnStarSword.bitmapData);
			item.name = "Dawn Star";
			item.description = "Increases the attack damage of the Hero by {0} when equipped. Any summoned creature hit will be instantly killed.";
			item.type = InventoryItemType.HAND;
			item.aiHint = ItemAiHintType.None;
			item.goldCost = 4200;
			item.effects.push(eff);
			item.effects.push(eff1);
			item.effects.push(eff2);
			item.requiredSpecialization = _typesRepository.skillTreeRepository.retribution;
															
			dawnStar = item;
			game.inventoryItemManager.addItemType(item);		
		}
		
		private function soulReaverInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffect = new InventoryItemEffect();
			eff.change = typesRepository.spellTypes.lifeStealLvl1.id;
			eff.propertyId = UnitProperties.AttackSpell;						
												
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemSoulReaver.bitmapData);
			item.name = "Soul Reaver";
			item.description = "On each attack 5 to 10 points of health is transferred from target to the Hero.";
			item.type = InventoryItemType.HAND;
			item.goldCost = 5000;
			item.aiHint = ItemAiHintType.EquipableStrength;
			item.effects.push(eff);
															
			soulReaver = item;
			game.inventoryItemManager.addItemType(item);		
		}
		
		private function shadowFangInit(game:Game, typesRepository:TypesRepository):void
		{
			var eff:InventoryItemEffectChangeHeroAttribute = new InventoryItemEffectChangeHeroAttribute();
			eff.change = 16;
			eff.propertyId = HeroProperties.Agility;

			var eff1:InventoryItemEffect = new InventoryItemEffect();
			eff1.change = 8;
			eff1.propertyId = UnitProperties.AttackDmgMin;

			var eff2:InventoryItemEffect = new InventoryItemEffect();
			eff2.change = 8;
			eff2.propertyId = UnitProperties.AttackDmgMax;			

			var eff3:InventoryItemEffectAddSpell = new InventoryItemEffectAddSpell();
			eff3.spellType = _typesRepository.spellTypes.shadowLvl1;			
												
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoItemShadowFang.bitmapData);
			item.name = "Shadow Fang";
			item.description = "Increases the Agility of the Hero by {0} and damage by {1} when worn.\r\nShadow (Spell).";
			item.type = InventoryItemType.HAND;
			item.aiHint = ItemAiHintType.EquipableAgility;
			item.requiredSpecialization = _typesRepository.skillTreeRepository.shadow;			
			item.goldCost = 4800;
			item.effects.push(eff);
			item.effects.push(eff1);
			item.effects.push(eff2);			
			item.effects.push(eff3);
												
			shadowFang = item;
			game.inventoryItemManager.addItemType(item);		
		}		
		
		private function meatInit(game:Game, typesRepository:TypesRepository):void
		{
			var item:InventoryItem = new InventoryItem();
 			item.icon = new BitmapAsset(BitmapResources.icoDogMeat.bitmapData);
			item.name = "Dog Meat";
			item.description = "Meat to feed the dog.";
			item.type = InventoryItemType.NONE;
			item.goldCost = 50;
			item.aiHint = ItemAiHintType.None;
															
			meat = item;
			game.inventoryItemManager.addItemType(item);		
		}																																																						
	}
}