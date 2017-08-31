package arena
{
	import engine.ai.AiHintType;
	import engine.game.Game;
	import engine.heros.Skill;
	import engine.heros.SkillBranch;
	import engine.heros.SkillTree;
	import engine.units.UnitProperties;
	import engine.units.UnitType;
	
	import mx.core.BitmapAsset;
	
	import resources.BitmapResources;
	
	public final class SkillTreeRepository
	{
		public var holy:SkillBranch = new SkillBranch();
		public var retribution:SkillBranch = new SkillBranch();
		public var arcane:SkillBranch = new SkillBranch();
		public var necromancy:SkillBranch = new SkillBranch();
		public var rage:SkillBranch = new SkillBranch();
		public var ice:SkillBranch = new SkillBranch();
		public var elemental:SkillBranch = new SkillBranch();
		public var combat:SkillBranch = new SkillBranch();				
		public var shadow:SkillBranch = new SkillBranch();
				
		public function init(game:Game, typesRepository:TypesRepository):void
		{
			holyBranchInit(game, typesRepository.unitTypes.HeroPaladin, typesRepository);
			retributionBranchInit(game, typesRepository.unitTypes.HeroPaladin, typesRepository);

			combatBranchInit(game, typesRepository.unitTypes.HeroBarbar, typesRepository);
			rageBranchInit(game, typesRepository.unitTypes.HeroBarbar, typesRepository);
									
			fireBranchInit(game, typesRepository.unitTypes.HeroMage, typesRepository);
			iceBranchInit(game, typesRepository.unitTypes.HeroMage, typesRepository);			
			arcaneBranchInit(game, typesRepository.unitTypes.HeroMage, typesRepository);

			necromancyBranchInit(game, typesRepository.unitTypes.HeroLich, typesRepository);
			fireBranchInit(game, typesRepository.unitTypes.HeroLich, typesRepository);		
			
			shadowBranchInit(game, typesRepository.unitTypes.HeroRogue, typesRepository);							
		}

		private function shadowBranchInit(game:Game, heroType:UnitType, typesRepository:TypesRepository):void
		{
			var skillTree:SkillTree = game.skillTree.getTreeForHero(heroType);
			shadow.name = "Shadows";
			
			var sap1:Skill = new Skill();
			sap1.name = "Sap";
			sap1.addSpells([typesRepository.spellTypes.sapLvl1]);

			var sap2:Skill = new Skill();
			sap2.addSpells([typesRepository.spellTypes.sapLvl2]);
			
			sap1.addSkillLevels([sap2]);			
			shadow.add(sap1);

			var trap1:Skill = new Skill();
			trap1.name = "Trap";
			trap1.addSpells([typesRepository.spellTypes.trapLvl1]);
			trap1.dependsOnSkill = sap1;
			shadow.add(trap1, sap1);

			var fanOfKnifes1:Skill = new Skill();
			fanOfKnifes1.name = "Fan Of Knives";
			fanOfKnifes1.dependsOnSkill = sap1;
			fanOfKnifes1.addSpells([typesRepository.spellTypes.fanOfKnivesLvl1]);
			
			var fanOfKnifes2:Skill = new Skill();
			fanOfKnifes2.addSpells([typesRepository.spellTypes.fanOfKnivesLvl2]);

			var fanOfKnifes3:Skill = new Skill();
			fanOfKnifes3.addSpells([typesRepository.spellTypes.fanOfKnivesLvl3]);

			var fanOfKnifes4:Skill = new Skill();
			fanOfKnifes4.addSpells([typesRepository.spellTypes.fanOfKnivesLvl4]);
									
			fanOfKnifes1.addSkillLevels([fanOfKnifes2, fanOfKnifes3, fanOfKnifes4]);			
			shadow.add(fanOfKnifes1, sap1);
						
			var stealth1:Skill = new Skill();
			stealth1.name = "Stealth";
			stealth1.addSpells([typesRepository.spellTypes.hideLvl1]);
			
			var stealth2:Skill = new Skill();
			stealth2.addSpells([typesRepository.spellTypes.hideLvl2]);

			stealth1.addSkillLevels([stealth2]);							
			shadow.add(stealth1, sap1);

			var combatSpecialization1:Skill = new Skill();
			combatSpecialization1.icon = new BitmapAsset(BitmapResources.icoCombatSpecialization.bitmapData);
			combatSpecialization1.name = "Assassin Specialization";
			combatSpecialization1.changeProperties[UnitProperties.AttackDmgMin] = 5;
			combatSpecialization1.changeProperties[UnitProperties.AttackDmgMax] = 5;
			combatSpecialization1.changeProperties[UnitProperties.SpellBonus] = 10;			
			combatSpecialization1.description = "Increases attack damage of the Hero by 5 and damage from poison by 10%.";
			combatSpecialization1.aiHint = AiHintType.Passive;
			combatSpecialization1.dependsOnSkill = stealth1;
			
			var combatSpecialization2:Skill = new Skill();
			combatSpecialization2.changeProperties[UnitProperties.AttackDmgMin] = 6;
			combatSpecialization2.changeProperties[UnitProperties.AttackDmgMax] = 6;
			combatSpecialization2.description = "Increases attack damage of the Hero by 6.";			
			combatSpecialization1.addSkillLevels([combatSpecialization2]);
			shadow.add(combatSpecialization1, stealth1);	
												
			var dash1:Skill = new Skill();
			dash1.name = "Dash";
			dash1.addSpells([typesRepository.spellTypes.dashLvl1]);
			dash1.dependsOnLevel = 4;
			shadow.add(dash1, trap1);
			
			var poisonDagger1:Skill = new Skill();
			poisonDagger1.name = "Poison Dagger";
			poisonDagger1.dependsOnSkill = fanOfKnifes1;
			poisonDagger1.addSpells([typesRepository.spellTypes.poisonDaggerLvl1]);			

			var poisonDagger2:Skill = new Skill();
			poisonDagger2.addSpells([typesRepository.spellTypes.poisonDaggerLvl2]);
			
			var poisonDagger3:Skill = new Skill();
			poisonDagger3.addSpells([typesRepository.spellTypes.poisonDaggerLvl3]);
						
			poisonDagger1.addSkillLevels([poisonDagger2, poisonDagger3]);			
			shadow.add(poisonDagger1, fanOfKnifes1);

			var blink1:Skill = new Skill();
			blink1.name = "Blink";
			blink1.addSpells([typesRepository.spellTypes.blinkLvl1]);
			blink1.dependsOnSkill = dash1;
			shadow.add(blink1, dash1);

			var kick1:Skill = new Skill();
			kick1.name = "Kick";
			kick1.dependsOnSkill = poisonDagger1;
			kick1.addSpells([typesRepository.spellTypes.kickLvl1]);
			
			var kick2:Skill = new Skill();
			kick2.addSpells([typesRepository.spellTypes.kickLvl2]);
						
			kick1.addSkillLevels([kick2]);
						
			shadow.add(kick1, poisonDagger1);
						
			var stab1:Skill = new Skill();
			stab1.name = "Stab";
			stab1.dependsOnSkill = kick1;
			stab1.dependsOnLevel = 6;
			stab1.addSpells([typesRepository.spellTypes.stabLvl1]);
			shadow.add(stab1, kick1);				
																																	
			skillTree.skillsBranches.push(shadow);							
		}
		
		private function retributionBranchInit(game:Game, heroType:UnitType, typesRepository:TypesRepository):void
		{
			var skillTree:SkillTree = game.skillTree.getTreeForHero(heroType);
			retribution.name = "Retribution";

			var burningSword1:Skill = new Skill();
			burningSword1.name = "Burning Sword";
			burningSword1.addSpells([typesRepository.spellTypes.burningSwordLvl1]);
			
			var burningSword2:Skill = new Skill();
			burningSword2.addSpells([typesRepository.spellTypes.burningSwordLvl2]);		
			burningSword1.addSkillLevels([burningSword2]);
				
			retribution.add(burningSword1);
			
			var manaBurn1:Skill = new Skill();
			manaBurn1.name = "Mana Burn";
			manaBurn1.addSpells([typesRepository.spellTypes.manaBurnLvl1]);
			manaBurn1.dependsOnLevel = 2;
			retribution.add(manaBurn1, burningSword1);

			var irradiate1:Skill = new Skill();
			irradiate1.name = "Irradiate";
			irradiate1.addSpells([typesRepository.spellTypes.irradiateLvl1]);
			irradiate1.dependsOnSkill = burningSword1;
			retribution.add(irradiate1, burningSword1);	

			var spellResistance1:Skill = new Skill();
			spellResistance1.icon = new BitmapAsset(BitmapResources.icoSpellProtectionBlue.bitmapData);
			spellResistance1.name = "Magic Resistance";
			spellResistance1.changeProperties[UnitProperties.MagicRes] = 10;
			spellResistance1.aiHint = AiHintType.Passive;
			spellResistance1.description = "Increases the spell resistance of the Hero by {0}%.";
			spellResistance1.dependsOnLevel = 2;
			
			var spellResistance2:Skill = new Skill();
			spellResistance2.changeProperties[UnitProperties.MagicRes] = 10;
			spellResistance2.changeProperties[UnitProperties.DamageRetention] = 1;	
			spellResistance2.name = "Magic Retention";
			spellResistance1.description = "Increases the spell resistance of the Hero by {0}%. Causes {1} Magic damage when hit.";			
			spellResistance1.addSkillLevels([spellResistance2]);			
			retribution.add(spellResistance1, burningSword1);

			var smite1:Skill = new Skill();
			smite1.name = "Smite";
			smite1.addSpells([typesRepository.spellTypes.smiteLvl1]);
			smite1.dependsOnSkill = irradiate1;
			
			var smite2:Skill = new Skill();
			smite2.addSpells([typesRepository.spellTypes.smiteLvl2]);

			var smite3:Skill = new Skill();
			smite3.addSpells([typesRepository.spellTypes.smiteLvl3]);
						
			smite1.addSkillLevels([	smite2, smite3 ]);		
			retribution.add(smite1, manaBurn1);
																	
			var burningShield:Skill = new Skill();
			burningShield.name = "Burning Shield";
			burningShield.addSpells([typesRepository.spellTypes.burningShield1Lvl1]);
			burningShield.dependsOnSkill = spellResistance1;
			
			var burningShield2:Skill = new Skill();
			burningShield2.addSpells([typesRepository.spellTypes.burningShield1Lvl2]);
			burningShield.addSkillLevels([burningShield2]);			
			retribution.add(burningShield, manaBurn1);
	
			var sacrifice1:Skill = new Skill();
			sacrifice1.name = "Sacrifice";
			sacrifice1.addSpells([typesRepository.spellTypes.sacrificeLvl1]);
			sacrifice1.dependsOnLevel = 4;
			sacrifice1.dependsOnSkill = smite1;
			retribution.add(sacrifice1, smite1);
						
			var imprison1:Skill = new Skill();
			imprison1.name = "Imprison";
			imprison1.addSpells([typesRepository.spellTypes.imprisonLvl1]);
			imprison1.dependsOnLevel = 8;
			imprison1.dependsOnSkill = sacrifice1;
			retribution.add(imprison1, sacrifice1);
															
			skillTree.skillsBranches.push(retribution);			
		}
		
		private function holyBranchInit(game:Game, heroType:UnitType, typesRepository:TypesRepository):void
		{
			var skillTree:SkillTree = game.skillTree.getTreeForHero(heroType);
			holy.name = "Holy";
			
			var heal1:Skill = new Skill();
			heal1.name = "Heal";
			heal1.addSpells([typesRepository.spellTypes.healLvl1]);
			
			var heal2:Skill = new Skill();
			heal2.addSpells([typesRepository.spellTypes.healLvl2]);
			
			heal1.addSkillLevels([heal2]);					
			holy.add(heal1);	

			var holyBolt1:Skill = new Skill();
			holyBolt1.name = "Holy Bolt";
			holyBolt1.addSpells([typesRepository.spellTypes.holyBoltLvl1]);
			holyBolt1.dependsOnLevel = 2;
			
			var holyBolt2:Skill = new Skill();
			holyBolt2.addSpells([typesRepository.spellTypes.holyBoltLvl2]);
			holyBolt1.addSkillLevels([holyBolt2]);
						
			holy.add(holyBolt1, heal1);
									
			var cleanse1:Skill = new Skill();
			cleanse1.name = "Cleanse";
			cleanse1.addSpells([typesRepository.spellTypes.cleanseLvl1]);
			cleanse1.dependsOnSkill = heal1;
			holy.add(cleanse1, heal1);
			
			var devoutionAura1:Skill = new Skill();
			devoutionAura1.name = "Devoution Aura";
			devoutionAura1.addSpells([typesRepository.spellTypes.devoutionAuraLvl1]);
			devoutionAura1.dependsOnLevel = 2;
			holy.add(devoutionAura1, heal1);			

			var devoutionAura2:Skill = new Skill();
			devoutionAura2.addSpells([typesRepository.spellTypes.devoutionAuraLvl2]);

			var devoutionAura3:Skill = new Skill();
			devoutionAura3.addSpells([typesRepository.spellTypes.devoutionAuraLvl3]);
			devoutionAura1.addSkillLevels([devoutionAura2, devoutionAura3]);	
			
			var devineShield1:Skill = new Skill();
			devineShield1.name = "Devine Shield";
			devineShield1.addSpells([typesRepository.spellTypes.devineShield1Lvl1]);
			devineShield1.dependsOnSkill = holyBolt1;
			
			var devineShield2:Skill = new Skill();
			devineShield2.addSpells([typesRepository.spellTypes.devineShieldLvl2]);
			
			devineShield1.addSkillLevels([devineShield2]);			
			holy.add(devineShield1, holyBolt1);					
			
			var heavensGift:Skill = new Skill();
			heavensGift.icon = new BitmapAsset(BitmapResources.icoSpellHeavensGift.bitmapData);
			heavensGift.name = "Heavens Gift";
			heavensGift.changeProperties[UnitProperties.ManaRegen] = 1;
			heavensGift.changeProperties[UnitProperties.HealthRegen] = 1;
			heavensGift.description = "Increases health and mana regeneration by {0} per tick.";
			heavensGift.aiHint = AiHintType.Passive;
			heavensGift.dependsOnLevel = 4;
			
			var heavensGift2:Skill = new Skill();
			heavensGift2.changeProperties[UnitProperties.ManaRegen] = 1;
			heavensGift2.changeProperties[UnitProperties.HealthRegen] = 1;	
			
			heavensGift.addSkillLevels([heavensGift2])		
			holy.add(heavensGift, holyBolt1);										

			var bless1:Skill = new Skill();
			bless1.name = "Bless";
			bless1.addSpells([typesRepository.spellTypes.blessLvl1]);
			bless1.dependsOnSkill = cleanse1;
			holy.add(bless1, holyBolt1);
			
			var holyShock:Skill = new Skill();
			holyShock.name = "Holy Shock";
			holyShock.dependsOnLevel = 5;
			holyShock.addSpells([typesRepository.spellTypes.holyShockLvl1]);
			holyShock.dependsOnSkill = devineShield1;
			
			var holyShock2:Skill = new Skill();
			holyShock2.addSpells([typesRepository.spellTypes.holyShockLvl2]);
			
			holyShock.addSkillLevels([holyShock2]);			
			holy.add(holyShock, bless1);
				
			var healingLight:Skill = new Skill();
			healingLight.name = "Healing Light";
			healingLight.addSpells([typesRepository.spellTypes.healingLightLvl1]);
			healingLight.dependsOnLevel = 7;
			healingLight.dependsOnSkill = holyShock;
			holy.add(healingLight, holyShock);
												
			skillTree.skillsBranches.push(holy);				
		}

		private function rageBranchInit(game:Game, heroType:UnitType, typesRepository:TypesRepository):void
		{
			var skillTree:SkillTree = game.skillTree.getTreeForHero(heroType);
			rage.name = "Rage";	

			var berserk1:Skill = new Skill();
			berserk1.name = "Berserk";
			berserk1.addSpells([typesRepository.spellTypes.berserkLvl1]);
			
			var berserk2:Skill = new Skill();
			berserk2.addSpells([typesRepository.spellTypes.berserkLvl2]);
				
			berserk1.addSkillLevels([berserk2]);			
			rage.add(berserk1);
			
			var charge1:Skill = new Skill();
			charge1.name = "Charge";
			charge1.dependsOnLevel = 2;
			charge1.addSpells([typesRepository.spellTypes.chargeLvl1]);
			rage.add(charge1, berserk1);

			var enragedSwing1:Skill = new Skill();
			enragedSwing1.name = "Enraged Swings";
			enragedSwing1.addSpells([typesRepository.spellTypes.enragedSwingLvl1]);
			enragedSwing1.dependsOnSkill = berserk1;
			rage.add(enragedSwing1, berserk1);
			
			var vitality1:Skill = new Skill();
			vitality1.icon = new BitmapAsset(BitmapResources.icoSpellVitality.bitmapData);
			vitality1.name = "Vitality";
			vitality1.changeProperties[UnitProperties.MaxHealth] = 100;
			vitality1.description = "Increases total health of the Hero by {0}.";
			vitality1.dependsOnLevel = 2;
			vitality1.aiHint = AiHintType.Passive;

			var vitality2:Skill = new Skill();
			vitality2.changeProperties[UnitProperties.MaxHealth] = 100;
			var vitality3:Skill = new Skill();
			vitality3.changeProperties[UnitProperties.MaxHealth] = 100;
			vitality1.addSkillLevels([vitality2, vitality3]);
							
			rage.add(vitality1, berserk1);
						
			var warCry1:Skill = new Skill();
			warCry1.name = "War Cry";
			warCry1.addSpells([typesRepository.spellTypes.warCryLvl1]);
			warCry1.dependsOnLevel = 4;
			
			var warCry2:Skill = new Skill();
			warCry2.addSpells([typesRepository.spellTypes.warCryLvl2]);	
			
			warCry1.addSkillLevels([warCry2]);		
			rage.add(warCry1, enragedSwing1);

			var bloodThirst1:Skill = new Skill();
			bloodThirst1.name = "Blood Thirst";
			bloodThirst1.addSpells([typesRepository.spellTypes.bloodThirstLvl1]);
			bloodThirst1.dependsOnSkill = enragedSwing1;
			
			var bloodThirst2:Skill = new Skill();
			bloodThirst2.addSpells([typesRepository.spellTypes.bloodThirstLvl2]);
			bloodThirst1.addSkillLevels([bloodThirst2]);
						
			rage.add(bloodThirst1, enragedSwing1);	

			var deathWish1:Skill = new Skill();
			deathWish1.name = "Death Wish";
			deathWish1.addSpells([typesRepository.spellTypes.deathWishLvl1]);
			deathWish1.dependsOnSkill = bloodThirst1;
			rage.add(deathWish1, warCry1);
			
			var deathBlow1:Skill = new Skill();
			deathBlow1.name = "Death Blow";
			deathBlow1.addSpells([typesRepository.spellTypes.deathBlowLvl1]);
			deathBlow1.dependsOnLevel = 8;
			deathBlow1.dependsOnSkill = deathWish1;
			rage.add(deathBlow1, deathWish1);
																											
			skillTree.skillsBranches.push(rage);		
		}
				
		private function combatBranchInit(game:Game, heroType:UnitType, typesRepository:TypesRepository):void
		{
			var skillTree:SkillTree = game.skillTree.getTreeForHero(heroType);
			combat.name = "Combat";

			var heroicStrike1:Skill = new Skill();
			heroicStrike1.name = "Heroic Strike";
			heroicStrike1.addSpells([typesRepository.spellTypes.heroicStrikeLvl1]);
			
			var heroicStrike2:Skill = new Skill();
			heroicStrike2.addSpells([typesRepository.spellTypes.heroicStrikeLvl2]);
			heroicStrike1.addSkillLevels([heroicStrike2]);	
						
			combat.add(heroicStrike1);	
						
			var shieldBash1:Skill = new Skill();
			shieldBash1.name = "Bash";
			shieldBash1.dependsOnSkill = heroicStrike1;
			shieldBash1.addSpells([typesRepository.spellTypes.shieldBashLvl1]);
			combat.add(shieldBash1, heroicStrike1);			

			var combatAura1:Skill = new Skill();
			combatAura1.name = "Combat Aura";
			combatAura1.addSpells([typesRepository.spellTypes.combatAuraLvl1]);
			combatAura1.dependsOnLevel = 2;
			combat.add(combatAura1, heroicStrike1);			

			var cleave1:Skill = new Skill();
			cleave1.name = "Cleave";
			cleave1.addSpells([typesRepository.spellTypes.cleaveLvl1]);
			cleave1.dependsOnSkill = shieldBash1;
			
			var cleave2:Skill = new Skill();
			cleave2.addSpells([typesRepository.spellTypes.cleaveLvl2]);	
			cleave1.addSkillLevels([cleave2]);
					
			combat.add(cleave1, shieldBash1);	

			var weaponThrow1:Skill = new Skill();	
			weaponThrow1.name= "Weapon Throw";
			weaponThrow1.addSpells([typesRepository.spellTypes.weaponThrowLvl1]);
			weaponThrow1.dependsOnSkill = cleave1;
			combat.add(weaponThrow1, cleave1);
			
			var combatSpecialization1:Skill = new Skill();
			combatSpecialization1.icon = new BitmapAsset(BitmapResources.icoCombatSpecialization.bitmapData);
			combatSpecialization1.name = "Combat Specialization";
			combatSpecialization1.changeProperties[UnitProperties.AttackDmgMin] = 6;
			combatSpecialization1.changeProperties[UnitProperties.AttackDmgMax] = 6;
			combatSpecialization1.description = "Increases attack damage of the Hero by {0}.";
			combatSpecialization1.aiHint = AiHintType.Passive;
			combatSpecialization1.dependsOnSkill = combatAura1;
			
			var combatSpecialization2:Skill = new Skill();
			combatSpecialization2.changeProperties[UnitProperties.AttackDmgMin] = 6;
			combatSpecialization2.changeProperties[UnitProperties.AttackDmgMax] = 6;
			combatSpecialization1.addSkillLevels([combatSpecialization2]);
			combat.add(combatSpecialization1, shieldBash1);	

			var thunderClap1:Skill = new Skill();
			thunderClap1.name = "Thunder Clap";
			thunderClap1.addSpells([typesRepository.spellTypes.thunderClapLvl1]);
			thunderClap1.dependsOnSkill = cleave1;
			
			var thunderClap2:Skill = new Skill();
			thunderClap2.addSpells([typesRepository.spellTypes.thunderClapLvl2]);			
			thunderClap1.addSkillLevels([thunderClap1]);
			
			combat.add(thunderClap1, cleave1);
			
			var defensiveStance1:Skill = new Skill();
			defensiveStance1.name = "Defensive Stance";
			defensiveStance1.addSpells([typesRepository.spellTypes.defensiveStanceLvl1]);
			defensiveStance1.dependsOnSkill = combatSpecialization1;
			combat.add(defensiveStance1, cleave1);	
								
			var avatarOfWar1:Skill = new Skill();
			avatarOfWar1.name = "Avatar of War";
			avatarOfWar1.addSpells([typesRepository.spellTypes.avatarOfWarLvl1]);
			avatarOfWar1.dependsOnSkill = thunderClap1;
			avatarOfWar1.dependsOnLevel = 8;
			combat.add(avatarOfWar1, thunderClap1);				
															
			skillTree.skillsBranches.push(combat);	
		}

		private function arcaneBranchInit(game:Game, heroType:UnitType, typesRepository:TypesRepository):void
		{
			var skillTree:SkillTree = game.skillTree.getTreeForHero(heroType);
			arcane.name = "Arcane";

			var arcaneBlast1:Skill = new Skill();
			arcaneBlast1.name = "Arcane Blast";
			arcaneBlast1.addSpells([typesRepository.spellTypes.arcaneBlastLvl1]);
			
			var arcaneBlast2:Skill = new Skill();
			arcaneBlast2.addSpells([typesRepository.spellTypes.arcaneBlastLvl2]);
			
			var arcaneBlast3:Skill = new Skill();
			arcaneBlast3.addSpells([typesRepository.spellTypes.arcaneBlastLvl3]);
						
			arcaneBlast1.addSkillLevels([arcaneBlast2, arcaneBlast3]);		
			arcane.add(arcaneBlast1);

			var silence1:Skill = new Skill();
			silence1.name = "Silence";
			silence1.dependsOnLevel = 2;
			silence1.addSpells([typesRepository.spellTypes.silenceLvl1]);
			arcane.add(silence1, arcaneBlast1);
						
			var arcaneMastery1:Skill = new Skill();
			arcaneMastery1.icon = new BitmapAsset(BitmapResources.icoWandBlue.bitmapData);
			arcaneMastery1.name = "Arcane Mastery";
			arcaneMastery1.changeProperties[UnitProperties.ManaRegen] = 2;
			arcaneMastery1.description = "Increases mana regeneration of the Hero by {0} per tick.";
			arcaneMastery1.aiHint = AiHintType.Passive;
			arcaneMastery1.dependsOnSkill = arcaneBlast1;
			
			var arcaneMastery2:Skill = new Skill();
			arcaneMastery2.changeProperties[UnitProperties.ManaRegen] = 3;
			arcaneMastery1.addSkillLevels([arcaneMastery2]);
			arcane.add(arcaneMastery1, arcaneBlast1);

			var brillianceAura1:Skill = new Skill();
			brillianceAura1.name = "Brilliance Aura";
			brillianceAura1.addSpells([typesRepository.spellTypes.brillianceAuraLvl1]);
			brillianceAura1.dependsOnSkill = arcaneMastery1;
			arcane.add(brillianceAura1, arcaneBlast1);

			var earthQuake1:Skill = new Skill();
			earthQuake1.name = "Earth Quake";
			earthQuake1.addSpells([typesRepository.spellTypes.earthQuakeLvl1]);
			earthQuake1.dependsOnLevel = 4;

			var earthQuake2:Skill = new Skill();
			earthQuake2.addSpells([typesRepository.spellTypes.earthQuakeLvl2]);	
			
			var earthQuake3:Skill = new Skill();
			earthQuake3.addSpells([typesRepository.spellTypes.earthQuakeLvl3]);	
								
			earthQuake1.addSkillLevels([earthQuake2, earthQuake3]);
			arcane.add(earthQuake1, arcaneMastery1);
			
			var mirrorImage1:Skill = new Skill();
			mirrorImage1.name = "Mirror Image";
			mirrorImage1.addSpells([typesRepository.spellTypes.mirrorImageLvl1]);
			mirrorImage1.dependsOnSkill = arcaneMastery1;
			arcane.add(mirrorImage1, arcaneMastery1);

			var banish1:Skill = new Skill();
			banish1.name = "Banish";
			banish1.addSpells([typesRepository.spellTypes.banishLvl1]);
			banish1.dependsOnLevel = 6;
			arcane.add(banish1, mirrorImage1);
			
			var blink1:Skill = new Skill();
			blink1.name = "Blink";
			blink1.addSpells([typesRepository.spellTypes.blinkLvl1]);
			blink1.dependsOnSkill = mirrorImage1;
			arcane.add(blink1, mirrorImage1);			

			var polymorph1:Skill = new Skill();
			polymorph1.name = "Polymorph";
			polymorph1.addSpells([typesRepository.spellTypes.polymorphLvl1]);
			polymorph1.dependsOnLevel = 8;
			polymorph1.dependsOnSkill = blink1;
			arcane.add(polymorph1, blink1);
																					
			skillTree.skillsBranches.push(arcane);		
		}	
		
		private function fireBranchInit(game:Game, heroType:UnitType, typesRepository:TypesRepository):void
		{
			var skillTree:SkillTree = game.skillTree.getTreeForHero(heroType);
			elemental.name = "Fire";	

			var scorch1:Skill = new Skill();
			scorch1.name = "Scorch";
			scorch1.addSpells([typesRepository.spellTypes.scorchLvl1]);
			elemental.add(scorch1);

			var scorch2:Skill = new Skill();
			scorch2.addSpells([typesRepository.spellTypes.scorchLvl2]);
			
			var scorch3:Skill = new Skill();
			scorch3.addSpells([typesRepository.spellTypes.scorchLvl3]);
						
			scorch1.addSkillLevels([scorch2, scorch3]);
									
			var fireball1:Skill = new Skill();
			fireball1.name = "Fireball";
			fireball1.addSpells([typesRepository.spellTypes.fireballLvl1]);
			fireball1.dependsOnSkill = scorch1;
			elemental.add(fireball1, scorch1);	
				
			var fireball2:Skill = new Skill();
			fireball2.addSpells([typesRepository.spellTypes.fireballLvl2]);
			fireball1.addSkillLevels([fireball2]);
						
			var spellMastery1:Skill = new Skill();
			spellMastery1.icon = new BitmapAsset(BitmapResources.icoWandFire.bitmapData);
			spellMastery1.name = "Spell Mastery";
			spellMastery1.changeProperties[UnitProperties.SpellBonus] = 10;
			spellMastery1.description = "Increases damage from spells by {0}.";
			spellMastery1.aiHint = AiHintType.Passive;
			spellMastery1.dependsOnLevel = 2;
			
			var spellMastery2:Skill = new Skill();
			spellMastery2.changeProperties[UnitProperties.SpellBonus] = 10;				
			spellMastery1.addSkillLevels([spellMastery2]);		
			elemental.add(spellMastery1, scorch1);	

			var summonTotem1:Skill = new Skill();
			summonTotem1.name = "Summon Totem";
			summonTotem1.addSpells([typesRepository.spellTypes.summonTotemLvl1]);
			summonTotem1.dependsOnSkill = fireball1;
			
			var summonTotem2:Skill = new Skill();
			summonTotem2.addSpells([typesRepository.spellTypes.summonTotemLvl2]);	
			summonTotem1.addSkillLevels([summonTotem2]);	
			elemental.add(summonTotem1, fireball1);
			
			var chainLightning1:Skill = new Skill();
			chainLightning1.name = "Chain Lightning";
			chainLightning1.addSpells([typesRepository.spellTypes.chainLightningLvl1]);
			chainLightning1.dependsOnLevel = 3;
			
			var chainLightning2:Skill = new Skill();
			chainLightning2.addSpells([typesRepository.spellTypes.chainLightningLvl2]);	
						
			chainLightning1.addSkillLevels( [chainLightning2] );		
			elemental.add(chainLightning1, fireball1);				

			var elementalProtection1:Skill = new Skill();
			elementalProtection1.name = "Elemental Protection";
			elementalProtection1.addSpells([typesRepository.spellTypes.elementalProtectionLvl1]);
			elementalProtection1.dependsOnSkill = summonTotem1;
			elemental.add(elementalProtection1, summonTotem1);
			
			var preparate1:Skill = new Skill();
			preparate1.name = "Preparate";
			preparate1.addSpells([typesRepository.spellTypes.preparateLvl1]);
			preparate1.dependsOnSkill = chainLightning1;	
			preparate1.dependsOnLevel = 6;		
			elemental.add(preparate1, summonTotem1);

			var fireStorm1:Skill = new Skill();
			fireStorm1.name = "Fire Storm";
			fireStorm1.addSpells([typesRepository.spellTypes.fireStormLvl1]);
			fireStorm1.dependsOnSkill = elementalProtection1;
			fireStorm1.dependsOnLevel = 8;
			elemental.add(fireStorm1, elementalProtection1);
																						
			skillTree.skillsBranches.push(elemental);		
		}		

		private function iceBranchInit(game:Game, heroType:UnitType, typesRepository:TypesRepository):void
		{
			var skillTree:SkillTree = game.skillTree.getTreeForHero(heroType);
			ice.name = "Ice";	

			var iceArrow1:Skill = new Skill();
			iceArrow1.name = "Ice Arrow";
			iceArrow1.addSpells([typesRepository.spellTypes.iceArrowLvl1]);

			var iceArrow2:Skill = new Skill();
			iceArrow2.addSpells([typesRepository.spellTypes.iceArrowLvl2]);			
			
			iceArrow1.addSkillLevels([iceArrow2]);
			ice.add(iceArrow1);			

			var iceBorn1:Skill = new Skill();
			iceBorn1.icon = new BitmapAsset(BitmapResources.icoArmorBlue.bitmapData);
			iceBorn1.name = "Ice Born";
			iceBorn1.changeProperties[UnitProperties.MagicRes] = 8;
			iceBorn1.changeProperties[UnitProperties.ManaRegen] = 1;
			iceBorn1.description = "Increases mana regeneration of the Hero by {1} per tick and magic resistance by {0}.";		
			iceBorn1.aiHint = AiHintType.Passive;
			
			var iceBorn2:Skill = new Skill();
			iceBorn2.changeProperties[UnitProperties.MagicRes] = 10;
			iceBorn2.changeProperties[UnitProperties.ManaRegen] = 1;
			iceBorn1.addSkillLevels([iceBorn2]);	
			ice.add(iceBorn1, iceArrow1);
			
			var iceShackle1:Skill = new Skill();
			iceShackle1.name = "Ice Shackle";
			iceShackle1.addSpells([typesRepository.spellTypes.iceShackleLvl1]);
			iceShackle1.dependsOnSkill = iceArrow1;
			
			var iceShackle2:Skill = new Skill();
			iceShackle2.addSpells([typesRepository.spellTypes.iceShackleLvl2]);

			var iceShackle3:Skill = new Skill();
			iceShackle3.addSpells([typesRepository.spellTypes.iceShackleLvl3]);
							
			iceShackle1.addSkillLevels( [iceShackle2, iceShackle3] );			
			ice.add(iceShackle1, iceArrow1);		
						
			var iceShield1:Skill = new Skill();
			iceShield1.name = "Shield of Ice";
			iceShield1.addSpells([typesRepository.spellTypes.iceShieldLvl1]);
			iceShackle1.dependsOnSkill = iceArrow1;
			
			var iceShield2:Skill = new Skill();
			iceShield2.addSpells([typesRepository.spellTypes.iceShieldLvl2]);
			iceShield1.addSkillLevels([iceShield2]);
						
			ice.add(iceShield1, iceArrow1);	
					
			var iceComet1:Skill = new Skill();
			iceComet1.name = "Frost Comet";
			iceComet1.addSpells([typesRepository.spellTypes.iceCometLvl1]);
			iceComet1.dependsOnSkill = iceShackle1;
			iceComet1.dependsOnLevel = 4;
			
			var iceComet2:Skill = new Skill();
			iceComet2.addSpells([typesRepository.spellTypes.iceCometLvl2]);	
			iceComet1.addSkillLevels([iceComet2]);
					
			ice.add(iceComet1, iceShackle1);
			
			
			var iceBlock:Skill = new Skill();
			iceBlock.name = "Ice Block";
			iceBlock.addSpells([typesRepository.spellTypes.iceBlockLvl1]);
			iceBlock.dependsOnSkill = iceShield1;
			ice.add(iceBlock, iceShackle1);		

			var summonWaterElemental:Skill = new Skill();
			summonWaterElemental.name = "Summon Water Elemental";
			summonWaterElemental.addSpells([typesRepository.spellTypes.summonWaterElementalLvl1]);
			summonWaterElemental.dependsOnSkill = iceComet1;
			summonWaterElemental.dependsOnLevel = 6;
			ice.add(summonWaterElemental, iceComet1);
			
			var iceStorm:Skill = new Skill();
			iceStorm.name = "Blizzard";
			iceStorm.addSpells([typesRepository.spellTypes.iceStormLvl1]);
			iceStorm.dependsOnLevel = 8;
			iceStorm.dependsOnSkill = summonWaterElemental;
			ice.add(iceStorm, summonWaterElemental);
																																								
			skillTree.skillsBranches.push(ice);		
		}
				
		private function necromancyBranchInit(game:Game, heroType:UnitType, typesRepository:TypesRepository):void
		{
			var skillTree:SkillTree = game.skillTree.getTreeForHero(heroType);
			necromancy.name = "Necromancy";
			
			var summonSkeleton1:Skill = new Skill();
			summonSkeleton1.name = "Summon Skeleton";
			summonSkeleton1.addSpells([typesRepository.spellTypes.summonSkeletonLvl1]);
			necromancy.add(summonSkeleton1);

			var summonSkeleton2:Skill = new Skill();
			summonSkeleton2.addSpells([typesRepository.spellTypes.summonSkeletonLvl2]);			
			var summonSkeleton3:Skill = new Skill();
			summonSkeleton3.addSpells([typesRepository.spellTypes.summonSkeletonLvl3]);
			summonSkeleton1.addSkillLevels([summonSkeleton2, summonSkeleton3]);
			
			var drainLife1:Skill = new Skill();
			drainLife1.name = "Drain Life";
			drainLife1.addSpells([typesRepository.spellTypes.drainLifeLvl1]);
			drainLife1.dependsOnLevel = 2;
			necromancy.add(drainLife1, summonSkeleton1);
			
			var drainLife2:Skill = new Skill();
			drainLife2.addSpells([typesRepository.spellTypes.drainLifeLvl2]);

			var drainLife3:Skill = new Skill();
			drainLife3.addSpells([typesRepository.spellTypes.drainLifeLvl3]);
									
			drainLife1.addSkillLevels([drainLife2, drainLife3]);

			var summonMastery:Skill = new Skill();
			summonMastery.icon = new BitmapAsset(BitmapResources.icoSkeletonSword.bitmapData);
			summonMastery.name = "Summon Mastery";
			summonMastery.changeProperties[UnitProperties.Health] = 150;
			summonMastery.changeProperties[UnitProperties.MaxHealth] = 150;
			summonMastery.description = "Increases summons total health by {0}.";
			summonMastery.applyToSummon = true;
			summonMastery.aiHint = AiHintType.Passive;
			summonMastery.dependsOnSkill = summonSkeleton1;
			
			var summonMastery2:Skill = new Skill();
			summonMastery2.changeProperties[UnitProperties.Health] = 225;
			summonMastery2.changeProperties[UnitProperties.MaxHealth] = 225;
			summonMastery2.changeProperties[UnitProperties.Armor] = 1;
			summonMastery2.description = "Increases summons total health by {0} and armor by {2}.";
			summonMastery2.applyToSummon = true;			
			summonMastery.addSkillLevels([summonMastery2]);
			necromancy.add(summonMastery, summonSkeleton1);	
			
			var drainMana1:Skill = new Skill();
			drainMana1.name = "Drain Mana";
			drainMana1.dependsOnSkill = drainLife1;
			drainMana1.addSpells([typesRepository.spellTypes.drainManaLvl1]);
			
			var drainMana2:Skill = new Skill();
			drainMana2.addSpells([typesRepository.spellTypes.drainManaLvl2]);
			drainMana1.addSkillLevels([drainMana2]);
			necromancy.add(drainMana1, drainLife1);			
						
			var undeadResilience1:Skill = new Skill();
			undeadResilience1.icon = new BitmapAsset(BitmapResources.icoSpellDemonicThing.bitmapData);
			undeadResilience1.name = "Undead Resilience";
			undeadResilience1.changeProperties[UnitProperties.MaxHealth] = 70;
			undeadResilience1.changeProperties[UnitProperties.MagicRes] = 5;
			undeadResilience1.description = "Increases total health of the hero by {0} and magic resistance by {1}.";
			undeadResilience1.aiHint = AiHintType.Passive;
			undeadResilience1.dependsOnSkill = summonMastery;
			
			var undeadResilience2:Skill = new Skill();
			undeadResilience2.changeProperties[UnitProperties.MaxHealth] = 80;
			undeadResilience2.changeProperties[UnitProperties.MagicRes] = 5;
			undeadResilience1.addSkillLevels([undeadResilience2]);			
			necromancy.add(undeadResilience1, drainLife1);

			var lifeTap1:Skill = new Skill();
			lifeTap1.name = "Life Tap";
			lifeTap1.addSpells([typesRepository.spellTypes.lifeTapLvl1]);
			lifeTap1.dependsOnSkill = drainMana1;
			necromancy.add(lifeTap1, undeadResilience1);
												
			var curseOfWeakness1:Skill = new Skill();
			curseOfWeakness1.name = "Curse of Weakness";
			curseOfWeakness1.addSpells([typesRepository.spellTypes.curseOfWeaknessLvl1]);
			curseOfWeakness1.dependsOnLevel = 6;
			necromancy.add(curseOfWeakness1, undeadResilience1);
						
			var shadowForm1:Skill = new Skill();
			shadowForm1.name = "Shadow Form";
			shadowForm1.addSpells([typesRepository.spellTypes.shadowFormLvl1]);
			shadowForm1.dependsOnSkill = undeadResilience1;
			necromancy.add(shadowForm1, undeadResilience1);
									
			var deathCall1:Skill = new Skill();
			deathCall1.name = "Death Call";
			deathCall1.dependsOnLevel = 8;
			deathCall1.dependsOnSkill = shadowForm1;
			deathCall1.addSpells([typesRepository.spellTypes.deathCallLvl1]);
			necromancy.add(deathCall1, shadowForm1);
															
			skillTree.skillsBranches.push(necromancy);			
		}
	}
}