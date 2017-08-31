package arena
{
	import __AS3__.vec.Vector;
	
	import computers.utils.Utils;
	
	import engine.area.Area;
	import engine.computers.ArmorAndDamage;
	import engine.core.GameTime;
	import engine.core.events.GameEvent;
	import engine.core.events.GameEvents;
	import engine.core.isometric.IsoTile;
	import engine.dashboard.Dashboard;
	import engine.fraction.FractionControllerType;
	import engine.fraction.PredefinedFractions;
	import engine.fraction.ResourceType;
	import engine.game.GameManager;
	import engine.game.GameResultType;
	import engine.game.PlayerSlot;
	import engine.game.PlayerTeam;
	import engine.heros.Hero;
	import engine.localization.Localization;
	import engine.mission.Mission;
	import engine.mission.MissionType;
	import engine.quests.QuestDescription;
	import engine.quests.QuestDescriptionToken;
	import engine.shapes.UIShape;
	import engine.shapes.UIShapeManager;
	import engine.sound.SoundManager;
	import engine.structures.Structure;
	import engine.text.Text;
	import engine.text.TextPosition;
	import engine.tileset.Tileset;
	import engine.timer.Timer;
	import engine.trigger.Trigger;
	import engine.units.ArmorType;
	import engine.units.DamageType;
	import engine.units.Unit;
	import engine.units.UnitProperties;
	import engine.units.UnitType;
	import engine.units.groups.UnitGroup;
	import engine.util.DialogResult;
	import engine.util.TileUtil;
	import engine.util.Util;
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	import mx.core.ByteArrayAsset;
	
	import resources.BitmapResources;
	import resources.MusicResources;
	import resources.SoundResources;
	
	public class Arena extends Mission
	{
		[Embed(source="localization/LocalizationRU.xml", mimeType="application/octet-stream")]
		private static const _localizationClass:Class;
		private static var _localization:Localization;
				
		[Embed(source="xml/arena.xml", mimeType="application/octet-stream")] 
		private const _mapXmlClass:Class; 
		private static var _mapXml:XML;
		
		private var _typesRepository:TypesRepository = new TypesRepository();
		
		private var _goodPlaceArea:Area;
		private var _goodRetreatArea:Area;		
		private var _badPlaceArea:Area;		
		private var _playerHero:Hero;

		private var _lightArea:Area;
		private var _darkArea:Area;
		
		private var _tutorialArea:Area;
				
		private var _lightCastle:Unit; 		
		private var _darkCastle:Unit;
		 
		private var _heroTypes:Object;
		private var _enemyHeroes:Array = [];
		private var _allyHeroes:Array = [];		
		
		private var _undeadKing:Unit;
		private var _dog:Unit;		
		private var _dashboard:Dashboard;
		
		private var _kills:int;
		private var _deaths:int;
		private var _heroKillsWithoutDeath:int = 0;		
		
		private var _isDay:Boolean = true;								
								
		public override function get mapXml():XML 
		{
			if (!_mapXml)
			{
				var ba:ByteArrayAsset = ByteArrayAsset( new _mapXmlClass() );
         		_mapXml = new XML( ba.readUTFBytes(ba.length) );
			}
			
			return _mapXml;
		}

		public override function get localization():Localization 
		{
			if (!_localization)
			{
				var ba:ByteArrayAsset = ByteArrayAsset( new _localizationClass() );
         		_localization = new Localization(new XML( ba.readUTFBytes(ba.length) ));
			}
			
			return _localization;
		}
				
		public override function get tilesetBitmap():BitmapData {
			return BitmapResources.tilesetSummer1.bitmapData;
		}
		
		public function Arena()
		{
			super();
			
			_typesRepository.loc = localization;
			
			_name = localization.get("MissionName");
			_type = MissionType.RPG;
			_description = localization.get("MissionDescription");
			_tilesetName = localization.get("TilesetName");

			_playerTeams.push(new PlayerTeam());
			_playerTeams.push(new PlayerTeam());
						
			playerTeams[0].addSlots(4);
			playerTeams[1].addSlots(5);				
		}
		
		public override function beforeWorldInit():void
		{
			_tileset = new Tileset();
			tileset.addTileType("Grass[Buildable,Passable]", true, true, 0, 0, true);
			tileset.addTileType("Dirt[Passable,Buildable]", true, true, 0, 1, true);
			tileset.addTileType("Stone[Passable,NonBuildable]", true, false, 0, 2, false, false, tileset.tileTypes[1]);
			tileset.addTileType("Water[NonBuildable,NonPassable]", false, false, 0, 5, false, true);
			tileset.addCliffType("Cliff[NonBuildable,NonPassable]", 0, 6);	
			
			_undeadKing = null;
			_dog = null;
			_enemyHeroes = [];
			_allyHeroes = [];
			_kills = 0;
			_deaths = 0;
			_isDay = true;								
		}
		
		public override function defineFractions():void 
		{
			_typesRepository.fractions.init(game, _typesRepository);
		}
		
		public override function defineObjectTypes():void 
		{
			_typesRepository.objectsRepository.init();
		}		
		
		public override function defineUnitTypes():void
		{
			_typesRepository.unitTypes.init(game, _typesRepository);
		}
		
		public override function defineVisualEffectsTypes():void
		{
			_typesRepository.customModelsRepository.init(game, _typesRepository);
			_typesRepository.effectTypes.init();
		}
		
		public override function defineSpellTypes():void
		{
			_typesRepository.spellTypes.init(game, _typesRepository);
		}
		
		public override function defineUnitSpells():void
		{
			_typesRepository.unitTypes.initUnitSpells(game, _typesRepository);			
		}
		
		public override function defineInventoryItems():void
		{
			_typesRepository.inventoryItems.init(game, _typesRepository);
		}
		
		public override function defineSkillTree():void
		{
			_typesRepository.skillTreeRepository.init(game, _typesRepository);			
		}
				
		public override function afterWorldInit():void
		{
			_goodPlaceArea = game.areaManager.getByName("GoodPlace");
			_goodRetreatArea = game.areaManager.getByName("GoodHeroRetreat");
			_badPlaceArea = game.areaManager.getByName("BadPlace");
			_lightArea = game.areaManager.getByName("LightArea");
			_darkArea = game.areaManager.getByName("DarkArea");
			_tutorialArea = game.areaManager.getByName("TutorialArea");
					
			_lightCastle = game.unitManager.getUnitByName("LightAncient");	
			_darkCastle = game.unitManager.getUnitByName("DarkAncient");	
			
			_heroTypes = {
				"mage": _typesRepository.unitTypes.HeroMage,
				"paladin": _typesRepository.unitTypes.HeroPaladin,
				"lich": _typesRepository.unitTypes.HeroLich,
				"barbar": _typesRepository.unitTypes.HeroBarbar,
				"rogue": _typesRepository.unitTypes.HeroRogue
			};						
			
			_playerHero = game.unitManager.createUnitFromType(_heroTypes[stateBag.hero], _typesRepository.fractions.player) as Hero;			
			game.unitManager.placeUnitOnWorld(_playerHero, _goodPlaceArea.centerTile, true);
			game.sceneManager.cameraCenterOnUnit(_playerHero);	
			game.selectionManager.selectUnit(_playerHero);	
			_playerHero.displaySelection.setActive(0x1831E7, Util.secToFrames(3));
			if (_stateBag.startLevel > 1) _playerHero.levelUp(_stateBag.startLevel - 1);
			
			_dog = game.unitManager.createUnitFromType(_typesRepository.unitTypes.Dog, _typesRepository.fractions.lightForces);			
			game.unitManager.placeUnitOnWorld(_dog, _goodPlaceArea.randomTile, true);
			_dog.wander();
			

			var potions:Array = [ _typesRepository.inventoryItems.potionOfGreaterMana, _typesRepository.inventoryItems.potionOfHealing];
			var stockItems:Array = game.inventoryItemManager.getItemsByCost(1, 1000).concat(potions);
			var rareItems:Array = game.inventoryItemManager.getItemsByCost(1000);
			var items:Array = stockItems.concat(rareItems);									
			
			game.unitManager.getUnitByName("MerchantLight").addStockItems(stockItems);
			game.unitManager.getUnitByName("MerchantRareLight").addStockItems(rareItems);
			game.unitManager.getUnitByName("MerchantDark").addStockItems(items);
			game.unitManager.getUnitByName("MerchantMiddle").addStockItems(stockItems);
									
			game.eventManager.addEventListener(GameEvents.UNIT_DEATH, onUnitDeath);		
		}
		
		private function enableCheats():void
		{
			GameManager.instance().showDialog("Do you want to use sponsor cheat and start at level 10?", "",
				function(result:int):void {
					if (result == DialogResult.YES)
					{
						_playerHero.levelUp(10 - _playerHero.level);
					}
				});
		}
		
		private function showTutorial():Boolean
		{
			if (!GameManager.instance().options.showTutorial) return false;
			GameManager.instance().options.showTutorial = false;

			GameManager.instance().showDialog("Do you want a tutorial?", "Taking a tutorial is strongly advised.",
				function(result:int):void {
					if (result == DialogResult.YES)
					{
						game.unitManager.moveUnit(_playerHero, _tutorialArea.centerTile);
						game.sceneManager.cameraCenterOnUnit(_playerHero);
						game.sceneManager.cameraSnapTo(_playerHero);
						
						Trigger.afterPeriod(new GameTime(0, 1), function():void {
							showTutor("The purpose of the game is to defend your Castle and try to destroy the opponents Castle. The castles are located deep in both bases, which are located at the top right and bottom left corners of the map.",
							function():void {
								showTutor("You can control only your Hero and as such using your Hero right is the key to victory. I will show you how to do that.",
								function():void {
									var arrow:UIShape = UIShapeManager.showArrow(new Point(240, 80), new Point(40, 40));
									showTutor("You can select the Hero at any time by clicking on this icon. It also indicates the amount of health and mana the Hero has available.",
									function():void {
										UIShapeManager.hideShape(arrow);
										arrow = UIShapeManager.showArrow(new Point(250, 298), new Point(500, 550));
										_playerHero.addItem(_typesRepository.inventoryItems.woodenShield);
										showTutor("Hero can equip items like sword or shield which give bonuses to Hero stats.\r\nClick on inventory button and equip shield by dragging it to the Hero.",
										function():void {
											UIShapeManager.hideShape(arrow);
											showTutor("Great. By killing enemy Heroes and creeps your Hero will get experience and new levels. Gaining a level will increase Hero attributes like Strength, Agility and Intellect.",
											function():void {
												arrow = UIShapeManager.showArrow(new Point(250, 298), new Point(500, 589));
												showTutor("On each new level your Hero will receive 1 skill point that can be spent to learn or upgrade a skill. You start the game with 1 available skill point.\r\nClick on skills button and use it to learn a skill.",
												function():void {
												showTutor("Hotkeys for skills are [1-9] keys on the keyboard.", 
													function():void {
														UIShapeManager.hideShape(arrow);
														showTutor("Now try to defeat a skeleton using hero primary attack and the skill you have learned. Note that hero will automatically attack enemies that are near.", function():void {
														
															Trigger.afterPeriod(new GameTime(0, 1), function():void {
																var skeleton:Unit = game.unitManager.createUnitFromType(_typesRepository.unitTypes.Skeleton, game.fractionManager.getFractionById(PredefinedFractions.PassiveAgressive));
																game.unitManager.placeUnitOnWorld(skeleton, _tutorialArea.topLeft, true);
																
																game.eventManager.addEventListener(GameEvents.UNIT_DEATH, function(evt:GameEvent):void {
																	if (evt.properties.unit == skeleton)
																	{
																		arrow = UIShapeManager.showArrow(new Point(280, 80), new Point(610, 15));
																		showTutor("Good. Killing enemies also yields gold. You can see the amount of gold you have here.", function():void {
																			UIShapeManager.hideShape(arrow);
																			game.unitManager.moveUnit(_playerHero, _goodPlaceArea.centerTile);
																			game.sceneManager.cameraCenterOnUnit(_playerHero);
																			game.sceneManager.cameraFreeze();
																			
																			Trigger.afterPeriod(new GameTime(0, 2), function():void {
																				_playerHero.removeItem(_typesRepository.inventoryItems.woodenShield);
																				arrow = UIShapeManager.showArrow(new Point(150, 298), new Point(30, 350));
																				var arrow1:UIShape = UIShapeManager.showArrow(new Point(250, 298), new Point(280, 450));
																				showTutor("There are two merchants at your base. One sells common items and another sells rare items. You have some amount of gold initially so you can spend it here.", function():void {
																					UIShapeManager.hideShape(arrow);
																					UIShapeManager.hideShape(arrow1);
																					game.sceneManager.cameraFree();									
																					game.sceneManager.cameraMove(_lightCastle.tile.xindex - 4, _lightCastle.tile.yindex - 4, true);
																					_lightCastle.displaySelection.setActive(0x00FF00, Util.secToFrames(3));
																					showTutor("This is your Castle, you must protect it at all cost.", function():void {
																						_darkCastle.displaySelection.setActive(0xFF0000, Util.secToFrames(3));
																						game.sceneManager.cameraMove(_darkCastle.tile.xindex - 4, _darkCastle.tile.yindex - 4, true);
																						showTutor("This is enemy Castle, the goal of the game is to destroy it.\r\nIt is heavily guarded so you will need to level up your hero first. Destroy it and you will see a dancing squirrels.", function():void {
																							game.sceneManager.cameraFree();
																							game.sceneManager.cameraCenterOnUnit(_playerHero);
																								
																							showTutor("You can snap/unsnap camera to Hero by pressing 'Space'. When camera is snapped You can also move Hero by clicking on the minimap.", function():void {
																								showTutor("Now you are ready. Good luck!", function():void {
																								});
																							});
																						});
																					});
																				});
																			});
																		});
																	}
																});
															});
														});
													});
												});
											});
										});
									});
								});
							});
						});
					}
				});
				
				return true;
		}
		
		private function showTutor(text:String, callback:Function=null):void
		{
			GameManager.instance().showUnitDialog("Tutor", text, null, callback);		
		}

		public override function beforeStart():void
		{		
			showTutorial();
				
			Trigger.afterPeriod(new GameTime(0, 1), function():void {
				GameManager.instance().showWarning("SquirrelFM's Aeon Defense version 1.1", 10, true, 0xFFFFFF);	
			});
						
			Trigger.afterPeriod(new GameTime(0, 6), function():void {
				GameManager.instance().showWarning("Game will start in 30 sec. Prepare yourself.", 16, true, 0xFF0000);	
			});
			
			Trigger.afterPeriod(new GameTime(0, 10), function():void {
				GameManager.instance().showWarning("Please refer to Help and Rules if something is not clear.", 10, true, 0x19D345);	
			});	

			Trigger.afterPeriod(new GameTime(0, 20), function():void {
				GameManager.instance().showWarning("Inspired by w3 Three Corridors and DOTA.", 9, true, 0xFFFFFF);	
			});	

						
			Trigger.afterPeriod(new GameTime(0, 25), function():void {
				GameManager.instance().showWarning("5...", 0.9, true);	
			});
			
			Trigger.afterPeriod(new GameTime(0, 26), function():void {
				GameManager.instance().showWarning("4...", 0.9, true);	
			});
			
			Trigger.afterPeriod(new GameTime(0, 27), function():void {
				GameManager.instance().showWarning("3...", 0.9, true);	
			});

			Trigger.afterPeriod(new GameTime(0, 28), function():void {
				GameManager.instance().showWarning("2...", 0.9, true);	
			});
			
			Trigger.afterPeriod(new GameTime(0, 29), function():void {
				GameManager.instance().showWarning("1...", 0.9, true);	
			});
									
			Trigger.afterPeriod(new GameTime(0, 30), function():void {
				GameManager.instance().showWarning("Game started...", 5, true);	
				SoundManager.instance().playSound(SoundResources.gong);
			});	
			
			
			Trigger.add("WinCondition", 
				function():Boolean {
					return !_darkCastle.isActive;
				},
				function():void {
					SoundManager.instance().playSound(SoundResources.gong);	
					game.stop(GameResultType.VICTORY, true);
				},
				new GameTime(0, 5)
			);
			
			Trigger.add("LooseCondition", 
				function():Boolean {
					return !_lightCastle.isActive;
				},
				function():void {
					SoundManager.instance().playSound(SoundResources.gong);	
					game.stop(GameResultType.DEFEAT, true);
				},
				new GameTime(0, 5)
			);			
			
			_dashboard = game.dashboardManager.addDashboard("dashboard", "");
			_dashboard.value = "Kills/Deaths:    " + _kills + "/" + _deaths;								
			
			SoundManager.instance().playMusicPlayList([MusicResources.track1, MusicResources.track2]);
			SoundManager.instance().setAmbientList([
				{ area:_lightArea, sound:SoundResources.ambientCricket },
				{ area:_lightArea, sound:SoundResources.ambientBirds1 },
				{ area:_lightArea, sound:SoundResources.ambientBirds2 },
				{ area:_darkArea, sound:SoundResources.ambientOwl1 },
				{ area:_darkArea, sound:SoundResources.ambientOwl2 },
				{ area:_darkArea, sound:SoundResources.ambientWind } ]);			
			SoundManager.instance().setAmbientLoopAreaList([ 
				{area:_lightArea, sound:SoundResources.ambientCricketLong}, 
				{area:_darkArea, sound:SoundResources.ambientWindLong} ]);		
		}		
		
		public override function addTriggers():void
		{
 			var waves:Waves = new Waves();
			waves.init(game, _typesRepository);
			
			Trigger.afterPeriod(new GameTime(0, 32), function():void {
				
				for (var i:int = 0; i < playerTeams[0].slots.length; ++i)
				{
					if (playerTeams[0].slots[i].controllerType == FractionControllerType.Computer)
					{
						var allyHero:Hero = game.unitManager.createUnitFromType(getHeroTypeFromSlot(playerTeams[0].slots[i]), game.fractionManager.getFractionByName("LightPlayer" + (i+1))) as Hero;
						game.unitManager.placeUnitOnWorld(allyHero, _goodPlaceArea.centerTile, true);
						game.effectManager.addEffectByType(_typesRepository.effectTypes.Teleport, allyHero.physicalCenter);
						if (_stateBag.startLevel > 1) allyHero.levelUp(_stateBag.startLevel - 1);
						_allyHeroes.push(allyHero);
					}					
				}

				for (var i:int = 0; i < playerTeams[1].slots.length; ++i)
				{
					if (playerTeams[1].slots[i].controllerType == FractionControllerType.Computer)
					{
						var enemyHero:Hero = game.unitManager.createUnitFromType(getHeroTypeFromSlot(playerTeams[1].slots[i]), game.fractionManager.getFractionByName("DarkPlayer" + (i+1))) as Hero;
						game.unitManager.placeUnitOnWorld(enemyHero, _badPlaceArea.centerTile, true);	
						game.effectManager.addEffectByType(_typesRepository.effectTypes.Teleport, enemyHero.physicalCenter);
						if (_stateBag.startLevel > 1) enemyHero.levelUp(_stateBag.startLevel - 1);
						_enemyHeroes.push(enemyHero);
					}					
				}				
			
			}); 
			
			Trigger.afterPeriodRepeat(new GameTime(0,0,10), new GameTime(0,0,10), Trigger.INFINITE,
				function(state:Object):Boolean {
					return _darkCastle.isActive && _lightCastle.isActive && (!_undeadKing || !_undeadKing.isActive);
				},function():void {
					spawnUndeadKing();
				});
				
			Trigger.afterPeriodRepeat(new GameTime(0,0,12), new GameTime(0,0,12), Trigger.INFINITE,
				function(state:Object):Boolean {
					return _darkCastle.isActive && _lightCastle.isActive && _playerHero.level >= 4;
				},function():void {
					startDuel();
				});

			Trigger.afterPeriodRepeat(new GameTime(0,0,24), new GameTime(0,0,24), Trigger.INFINITE,
				function(state:Object):Boolean {
					return _darkCastle.isActive && _lightCastle.isActive;
				},function():void {
					startLightningStorm();
				});
								
			Trigger.afterPeriodRepeat(new GameTime(0,10), new GameTime(0,1.6), Trigger.INFINITE,
				function(state:Object):Boolean {
					return _dog.isActive && TileUtil.getTileDist(_dog.tile, _playerHero.tile) < 3;
				},function():void {
					if (_playerHero.hasItem(_typesRepository.inventoryItems.meat))
					{
						_dog.changeProp(UnitProperties.Health, 300, _dog.properties[UnitProperties.MaxHealth]);
						SoundManager.instance().playSoundOnUnit(_dog, SoundResources.ambientDogBark);
						game.effectManager.addEffectByType(_typesRepository.effectTypes.Heal, _dog.center, 0, _dog);
						_playerHero.removeItem(_typesRepository.inventoryItems.meat);
					}
					else if (Utils.rand(0, 6) == 2)
					{
						SoundManager.instance().playSoundOnUnit(_dog, SoundResources.ambientDogBark);
					}
				});	
				
			Trigger.afterPeriodRepeat(new GameTime(0,3,0), new GameTime(0,3,0), 8,
				function(state:Object):Boolean {
					return _lightCastle.isActive && Utils.rand(0,1) == 0;
				},function():void {
					var endPos:Point = _lightCastle.physicalCenter;
					endPos.offset(Utils.rand(-150,150), Utils.rand(-200,200));
					
					var startPos:Point = endPos.clone();
					var rand:int = Utils.rand(5,30);
					startPos.offset(-160 - rand, -160 - rand);
					
					var duration:int =  Utils.rand(5,18);
					game.effectManager.addGeneratedEffect(_typesRepository.effectTypes.GeneratedLightningForkFree, startPos, endPos, duration);
					game.effectManager.addEffectByType(_typesRepository.effectTypes.Sparks2, endPos, duration); 
					SoundManager.instance().playSoundOnUnit(_lightCastle, SoundResources.thunder);
				});	
				
			Trigger.afterPeriodRepeat(new GameTime(0,0,6), new GameTime(0,0,6), Trigger.INFINITE, 
				function(state:Object):Boolean {
					return true;
				},function():void {
					SoundManager.instance().playSound(SoundResources.ambientOwl1);
					if (_isDay) game.sceneManager.applyTransform(0.5, 0.5, 0.5, new GameTime(0, 4));
					else game.sceneManager.applyTransform(1, 1, 1, new GameTime(0, 3));
					_isDay = !_isDay;	
				});		 																			 				
		}
		
		private function spawnUndeadKing():void
		{
			var text:Text = new Text();
			text.relativeX = TextPosition.CENTER;
			text.relativeY = TextPosition.CENTER;
			text.text = "Undead King has been spawned!";
			text.color = 0xFF0000;
			text.time = Util.secToFrames(4);
			text.size = 17;
			game.textManager.addText("UndeadKingWarning", text);
			
			var area:Area = game.areaManager.getByName("NeutralMiddle");
			var unit:Unit = game.unitManager.createUnitFromType(_typesRepository.unitTypes.UndeadKing, _typesRepository.fractions.undeadKing);					
			_undeadKing = unit;
			game.unitManager.placeUnitOnWorld(unit, area.centerTile, true);
			game.effectManager.addEffectByType(_typesRepository.effectTypes.Skull, unit.physicalCenter, int.MAX_VALUE, unit);
						
			var units:Vector.<Unit> = game.unitManager.createUnitsFromType(4,
				_typesRepository.unitTypes.UndeadMinion, _typesRepository.fractions.undeadKing);			
			game.unitManager.placeUnitsOnWorld(units, area.centerTile, true);
			game.effectManager.addEffectByType(_typesRepository.effectTypes.Teleport, unit.position);
			
			var unitGroup:UnitGroup = new UnitGroup();
			unitGroup.addUnits(units);
			game.groupManager.watch(unitGroup, true);	
						
			SoundManager.instance().playSound(SoundResources.gong);			
			game.sceneManager.cameraShake(5, Util.secToFrames(1.5));
			
			Trigger.addRepeat(function(state:Object, t:Timer):void {
				if (!unit.isActive) t.remove();
				else 
				{
					unit.attackMove(area.centerTile);
					unitGroup.orderAttackMove(area.centerTile);
				}
			}, new GameTime(0, 6));						
		}

		private function startDuel():void
		{
			if (UnitGroup.fromArea(_tutorialArea).length > 0) return;
			
			var rand:int = Utils.rand(1, _enemyHeroes.length);
			if (rand <= 0) return;
			
			var text:Text = new Text();
			text.relativeX = TextPosition.CENTER;
			text.relativeY = TextPosition.CENTER;
			text.color = 0xFF0000;
			text.time = Util.secToFrames(4);
			text.size = 15;
				
			var movedEnemyUnits:Array = [];
			var movedAllyUnits:Array = [];
			
			if (_enemyHeroes.length > 0 && rand == 1 || _enemyHeroes.length >= rand && _allyHeroes.length >= rand - 1)
			{
				GameManager.instance().showDialog("You have been summoned to the duel! Accept?", "", 
				function(result:int):void
				{
					if (result == DialogResult.NO) return;
													
					if (_enemyHeroes.length > 0 && rand == 1)
					{
						game.sceneManager.cameraShake(3, Util.secToFrames(1));
						SoundManager.instance().playSound(SoundResources.gong);
						text.text = "You have been summoned to the duel!";
						game.textManager.addText("DuelWarning", text);
						game.sceneManager.cameraSnapTo(_playerHero);
						
						var enemyHero:Hero = _enemyHeroes[Utils.rand(0, _enemyHeroes.length-1)];
						movedEnemyUnits.push(enemyHero);
						movedAllyUnits.push(_playerHero);
					
						_playerHero.setProp(UnitProperties.Health, _playerHero.properties[UnitProperties.MaxHealth]);
						_playerHero.setProp(UnitProperties.Mana, _playerHero.properties[UnitProperties.MaxMana]);				
						enemyHero.setProp(UnitProperties.Health, enemyHero.properties[UnitProperties.MaxHealth]);
						enemyHero.setProp(UnitProperties.Mana, enemyHero.properties[UnitProperties.MaxMana]);
						enemyHero.ai.suspendRetreat = true;
						game.unitManager.moveUnit(_playerHero, _tutorialArea.randomTile, true, true);
						game.unitManager.moveUnit(enemyHero, _tutorialArea.randomTile, true, true);				
					}
		 			else if (_enemyHeroes.length >= rand && _allyHeroes.length >= rand - 1)
					{				
						game.sceneManager.cameraShake(3, Util.secToFrames(1));
						SoundManager.instance().playSound(SoundResources.gong);	
						text.text = "You have been summoned to the skirmish!";
						game.textManager.addText("DuelWarning", text);	
						game.sceneManager.cameraSnapTo(_playerHero);
						
						_playerHero.setProp(UnitProperties.Health, _playerHero.properties[UnitProperties.MaxHealth]);
						_playerHero.setProp(UnitProperties.Mana, _playerHero.properties[UnitProperties.MaxMana]);				
						movedAllyUnits.push(_playerHero);
						game.unitManager.moveUnit(_playerHero, _tutorialArea.randomTile, true, true);
						game.effectManager.addEffectByType(_typesRepository.effectTypes.Teleport, _playerHero.physicalCenter);
						
						for (var i:int = 0; i < rand; ++i)
						{
							movedEnemyUnits.push(_enemyHeroes[i]);
							_enemyHeroes[i].setProp(UnitProperties.Health, _enemyHeroes[i].properties[UnitProperties.MaxHealth]);
							_enemyHeroes[i].setProp(UnitProperties.Mana, _enemyHeroes[i].properties[UnitProperties.MaxMana]);
							_enemyHeroes[i].ai.suspendRetreat = true;
							game.unitManager.moveUnit(_enemyHeroes[i], _tutorialArea.randomTile, true, true);
							game.effectManager.addEffectByType(_typesRepository.effectTypes.Teleport, _enemyHeroes[i].physicalCenter);
						}
						for (var i:int = 0; i < rand - 1; ++i)
						{
							movedAllyUnits.push(_allyHeroes[i]);
							_allyHeroes[i].setProp(UnitProperties.Health, _allyHeroes[i].properties[UnitProperties.MaxHealth]);
							_allyHeroes[i].setProp(UnitProperties.Mana, _allyHeroes[i].properties[UnitProperties.MaxMana]);
							_allyHeroes[i].ai.suspendRetreat = true;					
							game.unitManager.moveUnit(_allyHeroes[i], _tutorialArea.randomTile, true, true);
							game.effectManager.addEffectByType(_typesRepository.effectTypes.Teleport, _allyHeroes[i].physicalCenter);
						}						
					}
					
					var allyUnits:Array = movedAllyUnits.concat();
					var enemyUnits:Array = movedEnemyUnits.concat();
					
					if (allyUnits.length && enemyUnits.length)
					{				
						Trigger.addRepeat(function(state:Object, t:Timer):void 
						{
							for (var i:int = 0; i < enemyUnits.length; ++i)
							{
								if (!enemyUnits[i].isActive) enemyUnits.splice(i, 1);
							}
							for (var i:int = 0; i < allyUnits.length; ++i)
							{	
								if (!allyUnits[i].isActive) allyUnits.splice(i, 1);	
							}
							
							var won:Boolean = (enemyUnits.length == 0);
							var lost:Boolean = (allyUnits.length == 0);
							
							if (won || lost)
							{
								var rand:int = Utils.rand(1, _enemyHeroes.length - 1);
								var text:Text = new Text();
								text.relativeX = TextPosition.CENTER;
								text.relativeY = TextPosition.CENTER;
								text.color = 0xFF0000;
								text.time = Util.secToFrames(4);
								text.size = 17;	
								if (won) text.text = "You have won the duel!";
								else text.text = "You have lost the duel!";
								game.textManager.addText("DuelEndWarning", text);
								t.remove();
								
								if (won)
								{
									if (_playerHero.isActive) 
									{
										GameManager.instance().showWarning("You earned 300 gold (duel).", 5, true);
										_playerHero.fraction.addResource(ResourceType.Gold, 300);
									}
									else
									{
										GameManager.instance().showWarning("You earned 200 gold (duel).", 5, true);
										_playerHero.fraction.addResource(ResourceType.Gold, 200);								
									}
								
									game.eventManager.dispatch(new GameEvent(GameEvents.CUSTOM, {duel:true}));
								}
								
								if (_playerHero.isActive) game.sceneManager.cameraCenterOnUnit(_playerHero);
								else game.sceneManager.cameraCenterOnUnit(_lightCastle);
								
								for (var i:int = 0; i < allyUnits.length; ++i)
								{
									game.unitManager.moveUnit(allyUnits[i], _goodPlaceArea.centerTile, true);
									if (allyUnits[i].ai) allyUnits[i].ai.suspendRetreat = false;
									game.effectManager.addEffectByType(_typesRepository.effectTypes.Teleport, allyUnits[i].physicalCenter);
									allyUnits[i].setProp(UnitProperties.Health, allyUnits[i].properties[UnitProperties.MaxHealth]);
									allyUnits[i].setProp(UnitProperties.Mana, allyUnits[i].properties[UnitProperties.MaxMana]);							
								}
								for (var i:int = 0; i < enemyUnits.length; ++i)
								{
									game.unitManager.moveUnit(enemyUnits[i], _badPlaceArea.centerTile, true);
									enemyUnits[i].ai.suspendRetreat = false;
									game.effectManager.addEffectByType(_typesRepository.effectTypes.Teleport, enemyUnits[i].physicalCenter);
									enemyUnits[i].setProp(UnitProperties.Health, enemyUnits[i].properties[UnitProperties.MaxHealth]);
									enemyUnits[i].setProp(UnitProperties.Mana, enemyUnits[i].properties[UnitProperties.MaxMana]);								
								}												
							}
							
						}, new GameTime(0, 1));
					}
				});
			}
		}
		
		private function startLightningStorm():void
		{			
			var text:Text = new Text();
			text.relativeX = TextPosition.CENTER;
			text.relativeY = TextPosition.CENTER;
			text.text = "Storm is comming!";
			text.color = 0xFFFF00;
			text.time = Util.secToFrames(4);
			text.size = 19;
			game.textManager.addText("StormWarning", text);
			SoundManager.instance().playSound(SoundResources.thunder);

			game.sceneManager.applyTransform(0.5, 0.5, 0.5, new GameTime(0, 2));			
			Trigger.afterPeriodRepeat(new GameTime(0, 3), new GameTime(0, 0.2), 420,
				function(state:Object):Boolean {
					return Utils.rand(0, 3) >= 2;
				},
				function():void {
					var tile:IsoTile;
								
					if (Utils.rand(0, 10) >= 8) tile = game.unitManager.units[Utils.rand(0, game.unitManager.units.length - 1)].tile;
					else tile = game.world.area.randomTile;
					
					if (tile)
					{
						var endPos:Point = tile.center;
						
						var startPos:Point = endPos.clone();
						var rand:int = Utils.rand(5,30);
						startPos.offset(-160 - rand, -160 - rand);
						
						var duration:int =  Utils.rand(5,18);
						game.effectManager.addGeneratedEffect(_typesRepository.effectTypes.GeneratedLightningForkFree, startPos, endPos, duration);
						game.effectManager.addEffectByType(_typesRepository.effectTypes.Sparks2, endPos, duration); 
						SoundManager.instance().playSoundAtPosiion(tile, SoundResources.thunder, 0, 1.2);

						if (tile.unit && tile.unit.properties[UnitProperties.Armor] != ArmorType.DIVINE)
						{
							var dmg:int = ArmorAndDamage.getUnitDamage(Utils.rand(150, 350), DamageType.Piersing, tile.unit);
							tile.unit.changeProp(UnitProperties.Health, -dmg);
							if (Utils.rand(0, 10) > 6 || tile.unit.properties[UnitProperties.Health] <= 0)
							{
								var newUnit:Unit = game.unitManager.createUnitFromType(_typesRepository.unitTypes.LightningSpirit, game.fractionManager.passiveAgressive);
								newUnit.addItems([_typesRepository.inventoryItems.runeOfMana,
												 _typesRepository.inventoryItems.runeOfMana,
												 _typesRepository.inventoryItems.runeOfMana]);
							}
							SoundManager.instance().playSoundAtPosiion(tile, SoundResources.magicHit3);
						}
						else
						{						
							var tiles:Vector.<IsoTile> = game.world.getTilesAroundTile(tile);
							
							for (var i:int = 0; i < tiles.length; ++i)
							{
								var tl:IsoTile = tiles[i];
								if (tl.unit && tl.unit.properties[UnitProperties.Armor] != ArmorType.DIVINE)
								{
									var dmg:int = ArmorAndDamage.getUnitDamage(Utils.rand(80, 100), DamageType.Piersing, tl.unit);
									tl.unit.changeProp(UnitProperties.Health, -dmg);
									SoundManager.instance().playSoundAtPosiion(tl, SoundResources.magicHit3);
								}								
							}
						}
					}					
				}
			);
		}
				
		private function getHeroTypeFromSlot(slot:PlayerSlot):UnitType
		{
			if (slot.hero.toLowerCase() == "random")
			{
				var heroTypes:Array = [];
				for (var id:String in _heroTypes) 
				{
					heroTypes.push(_heroTypes[id]);
				}
				
				var rand:int = Utils.rand(0, heroTypes.length - 1);
				
				
				return heroTypes[rand];
			}
			else
			{
				return _heroTypes[slot.hero];
			}
		}
																																						
		private function onUnitDeath(ev:GameEvent):void
		{
			var unit:Unit = ev.properties.unit as Unit;
			var hero:Hero = unit as Hero;
			if (hero && !hero.summoner)
			{
				GameManager.instance().showWarning(hero.name + " has died.", 5, true);
				if (hero.fraction.isCurrentPlayer())
				{
					++_deaths;
					
					// create timer
					var text:Text = new Text();
					text.relativeX = TextPosition.CENTER;
					text.relativeY = TextPosition.CENTER;
					var reviveIn:int = calcHeroReviveTime(hero);
					text.text = "Your Hero will be revived in " + reviveIn + " seconds";
					text.color = 0xFF0000;
					text.time = Util.secToFrames(3);
					text.size = 15;
					game.textManager.addText("heroDiedWarning", text);
					
					Trigger.addRepeat(function(state:Object, t:Timer):void
					{
						_dashboard.value = "Revive in: " + new GameTime(0, reviveIn - t.passedTime.seconds).toString();
						if (t.passedTime.seconds > reviveIn)
						{
							_dashboard.value = "Kills/Deaths: " + _kills + "/" + _deaths;
							t.remove();
						}	
					}, new GameTime(0, 1));
					
					_heroKillsWithoutDeath = 0;
					reviveHero(hero, _goodPlaceArea);
				}
				else
				{
					var text:Text = new Text();
					text.relativeX = TextPosition.CENTER;
					text.relativeY = TextPosition.CENTER;
					var reviveIn:int = calcHeroReviveTime(hero);
					text.text = hero.name + " has been slain by the ";
					if (hero.lastHitBy is Hero) text.text += hero.lastHitBy.name;
					else text.text += hero.lastHitBy.fraction.name;
											
					text.color = 0xFF0000;
					text.time = Util.secToFrames(3);
					text.size = 15;
					game.textManager.addText("heroDiedWarning", text);
										
					if (hero.fraction.isEnemyOf(_playerHero.fraction))
					{
						if (hero.lastHitBy == _playerHero)
						{
							GameManager.instance().showWarning("You earned 300 gold...", 5, true);
							
							++_heroKillsWithoutDeath;
							if (_heroKillsWithoutDeath >= 5)
							{
								var text:Text = new Text();
								text.relativeX = TextPosition.CENTER;
								text.relativeY = TextPosition.CENTER;
								text.text = GameManager.instance().currentPlayer.name + " is Godlike!";														
								text.color = 0xFF0000;
								text.time = Util.secToFrames(3);
								text.size = 17;
								game.textManager.addText("godLike", text);									
							}
							else if (_heroKillsWithoutDeath >= 3)
							{
								var text:Text = new Text();
								text.relativeX = TextPosition.CENTER;
								text.relativeY = TextPosition.CENTER;
								text.text = GameManager.instance().currentPlayer.name + " is on killing spree!";					
								text.color = 0xFF0000;
								text.time = Util.secToFrames(3);
								text.size = 17;
								game.textManager.addText("killingSpree", text);								
							}
						}
						reviveHero(hero, _badPlaceArea);
					}
					else
					{
						reviveHero(hero, _goodPlaceArea);
					}
				}
			}
			else if (unit is Structure)
			{
				GameManager.instance().showWarning(unit.fraction.locName + " lost a building...", 5, true);
			}
			else if (unit.type == _typesRepository.unitTypes.UndeadKing)
			{
				var text:Text = new Text();
				text.relativeX = TextPosition.CENTER;
				text.relativeY = TextPosition.CENTER;
				text.text = unit.type.locName + " has been slain by the ";
				if (unit.lastHitBy is Hero) 
				{
					text.text += unit.lastHitBy.name;
					if (!unit.lastHitBy.hasItem(_typesRepository.inventoryItems.crownOfUndead))
					{
						unit.lastHitBy.addItem(_typesRepository.inventoryItems.crownOfUndead);
					}
				}
				else text.text += unit.lastHitBy.fraction.name;
										
				text.color = 0xFF0000;
				text.time = Util.secToFrames(3);
				text.size = 15;
				game.textManager.addText("undeadKingDiedWarning", text);				
			}
			
			if (unit.lastHitBy == _playerHero)
			{
				_kills++;
				_dashboard.value = "Kills/Deaths:    " + _kills + "/" + _deaths;
			}
		}
		
		private function reviveHero(hero:Hero, area:Area):void
		{
			Trigger.afterPeriod(new GameTime(0, calcHeroReviveTime(hero)),
				function():void {
					if (!hero.isActive)
					{
						game.unitManager.reviveUnit(hero, area.centerTile);
						if (hero.fraction.isCurrentPlayer())
						{
							game.sceneManager.cameraFree();
							game.sceneManager.cameraCenterOnUnit(hero);
							game.selectionManager.selectUnit(hero);
							game.effectManager.addEffectByType(_typesRepository.effectTypes.LevelUp, hero.physicalCenter);
						}
						GameManager.instance().showWarning(hero.name + " has revived.", 5, true);
					}
				});
		}
		
		private function calcHeroReviveTime(hero:Hero):int
		{
			return Math.min(10 + hero.level*5, 180);
		}
		
		public override function addQuests():void
		{
			var quest:QuestDescription = new QuestDescription();
			quest.tokens.push(new QuestDescriptionToken("Enemy Castle", _typesRepository.unitTypes.Castle));
			quest.tokens.push(new QuestDescriptionToken("Your Castle", _typesRepository.unitTypes.Fotress));			
			quest.name = "main";
			quest.locName = _typesRepository.loc.get("LblMain");
			quest.description = _typesRepository.loc.get("LblMainQuestDesc");
			quest.completed = false;

			game.questManager.addQuest(quest);
			
			quest = new QuestDescription();
			quest.name = "rules";
			quest.locName = _typesRepository.loc.get("LblRules");
			quest.description = _typesRepository.loc.get("LblRulesDesc");
			quest.completed = false;
			quest.optional = true;
						
			game.questManager.addQuest(quest);
			
			quest = new QuestDescription();
			quest.tokens.push(new QuestDescriptionToken("Undead King", _typesRepository.unitTypes.UndeadKing));
			quest.name = "undeadKing";
			quest.locName = _typesRepository.loc.get("LblUndeadKing");
			quest.description = _typesRepository.loc.get("LblUndeadKingDesc");
			quest.completed = false;
			quest.optional = true;
						
			game.questManager.addQuest(quest);	
			
			quest = new QuestDescription();
			quest.name = "duels";
			quest.locName = _typesRepository.loc.get("LblDuels");
			quest.description = _typesRepository.loc.get("LblDuelsDesc");
			quest.completed = false;
			quest.optional = true;
						
			game.questManager.addQuest(quest);	
			
			quest = new QuestDescription();
			quest.name = "dog";
			quest.locName = _typesRepository.loc.get("LblDog");
			quest.description = _typesRepository.loc.get("LblDogDesc");
			quest.completed = false;
			quest.optional = true;
						
			game.questManager.addQuest(quest);	
			
			quest = new QuestDescription();
			quest.name = "specialization";
			quest.locName = _typesRepository.loc.get("LblSpecialization");
			quest.description = _typesRepository.loc.get("LblSpecializationDesc");
			quest.completed = false;
			quest.optional = true;
						
			game.questManager.addQuest(quest);														
		}		
	}
}