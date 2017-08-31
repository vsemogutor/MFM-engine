package alderun
{
	import computers.utils.Utils;
	
	import engine.area.Area;
	import engine.core.GameTime;
	import engine.core.events.GameEvent;
	import engine.core.events.GameEvents;
	import engine.dashboard.Dashboard;
	import engine.fraction.FractionControllerType;
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
	import engine.units.Unit;
	import engine.units.UnitType;
	import engine.util.DialogResult;
	import engine.util.Util;
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	import mx.core.ByteArrayAsset;
	
	import resources.BitmapResources;
	import resources.MusicResources;
	import resources.SoundResources;
	
	public class Alderun extends Mission
	{
		[Embed(source="localization/LocalizationEN.xml", mimeType="application/octet-stream")] 
		private static const _localizationClass:Class;
		private static var _localization:Localization;
				
		[Embed(source="xml/alderun.xml", mimeType="application/octet-stream")] 
		private const _mapXmlClass:Class; 
		private static var _mapXml:XML;
		
		private var _typesRepository:TypesRepository = new TypesRepository();
				
		private var _castle:Unit; 
		private var _castleArea:Area;				
		private var _heroSpawnArea:Area;
				 
		private var  _playerHero:Hero;
		private var _heroTypes:Object;	
		
		private var _dashboard:Dashboard;
		
		private var _kills:int;
		private var _deaths:int;
		private var _heroKillsWithoutDeath:int = 0;										
								
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
		
		public function Alderun()
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
		}
		
		public override function beforeWorldInit():void
		{
			_tileset = new Tileset();
			tileset.addTileType("Grass[Buildable,Passable]", true, true, 0, 0, true);
			tileset.addTileType("Dirt[Passable,Buildable]", true, true, 0, 1);
			tileset.addTileType("Stone[Passable,NonBuildable]", true, false, 0, 2);
			tileset.addTileType("Water[NonBuildable,NonPassable]", false, false, 0, 5, false, true);
			tileset.addCliffType("Cliff[NonBuildable,NonPassable]", 0, 6);		
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
			_kills = 0;
			_deaths = 0;	
			 
			_castleArea = game.areaManager.getByName("fortressArea");				
			_castle = game.unitManager.getUnitByName("fortress");
			_heroSpawnArea = game.areaManager.getByName("heroSpawnArea");	
			
			_heroTypes = {
				"mage": _typesRepository.unitTypes.HeroMage,
				"paladin": _typesRepository.unitTypes.HeroPaladin,
				"lich": _typesRepository.unitTypes.HeroLich,
				"barbar": _typesRepository.unitTypes.HeroBarbar
			};						
			
			_playerHero = game.unitManager.createUnitFromType(_heroTypes[stateBag.hero], _typesRepository.fractions.player) as Hero;			
			game.unitManager.placeUnitOnWorld(_playerHero, _heroSpawnArea.centerTile, true);
			game.sceneManager.cameraCenterOnUnit(_playerHero);	
			game.selectionManager.selectUnit(_playerHero);	
			_playerHero.displaySelection.setActive(0x1831E7, Util.secToFrames(3));
			if (_stateBag.startLevel > 1) _playerHero.levelUp(_stateBag.startLevel - 1);
			

/* 			var potions:Array = [ _typesRepository.inventoryItems.potionOfGreaterMana, _typesRepository.inventoryItems.potionOfHealing];
			var stockItems:Array = game.inventoryItemManager.getItemsByCost(1, 1000).concat(potions);
			var rareItems:Array = game.inventoryItemManager.getItemsByCost(1000);
			var items:Array = stockItems.concat(rareItems);	 */					
			
/* 			game.unitManager.getUnitByName("MerchantLight").addStockItems(stockItems);
			game.unitManager.getUnitByName("MerchantRareLight").addStockItems(rareItems);
			game.unitManager.getUnitByName("MerchantDark").addStockItems(items);
			game.unitManager.getUnitByName("MerchantMiddle").addStockItems(stockItems); */
									
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
										//_playerHero.addItem(_typesRepository.inventoryItems.woodenShield);
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
														game.sceneManager.cameraCenterOnUnit(_playerHero);
														game.sceneManager.cameraFreeze();
														
														Trigger.afterPeriod(new GameTime(0, 2), function():void {
//															_playerHero.removeItem(_typesRepository.inventoryItems.woodenShield);
															arrow = UIShapeManager.showArrow(new Point(150, 298), new Point(30, 350));
															var arrow1:UIShape = UIShapeManager.showArrow(new Point(250, 298), new Point(280, 450));
															showTutor("There are two merchants at your base. One sells common items and another sells rare items. You have some amount of gold initially so you can spend it here.", function():void {
																UIShapeManager.hideShape(arrow);
																UIShapeManager.hideShape(arrow1);
																game.sceneManager.cameraFree();									
																game.sceneManager.cameraMove(_castle.tile.xindex - 4, _castle.tile.yindex - 4, true);
																_castle.displaySelection.setActive(0x00FF00, Util.secToFrames(3));
																showTutor("This is your Castle, you must protect it at all cost.", function():void {
																	game.sceneManager.cameraFree();
																	game.sceneManager.cameraCenterOnUnit(_playerHero);
																		
																	showTutor("You can snap/unsnap camera to Hero by pressing 'Space'. When camera is snapped You can also move Hero by clicking on the minimap.", function():void {
																		showTutor("Now you are ready. Good luck!", function():void {
																			enableCheats();
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
							});
						});
					}
					else
					{
						enableCheats();
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
			if (!showTutorial()) enableCheats();
				
			Trigger.afterPeriod(new GameTime(0, 1), function():void {
				GameManager.instance().showWarning("SquirrelFM's Aeon Survival version 1", 10, true, 0xFFFFFF);	
			});
						
			Trigger.afterPeriod(new GameTime(0, 6), function():void {
				GameManager.instance().showWarning("Game will start in 30 sec. Prepare yourself.", 16, true, 0xFF0000);	
			});
			
			Trigger.afterPeriod(new GameTime(0, 10), function():void {
				GameManager.instance().showWarning("Please refer to Help and Rules if something is not clear.", 10, true, 0x19D345);	
			});	

			Trigger.afterPeriod(new GameTime(0, 20), function():void {
				GameManager.instance().showWarning("Inspired by w3 Team Survival.", 9, true, 0xFFFFFF);	
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
			
			
/* 			Trigger.add("WinCondition", 
				function():Boolean {
					return !_darkCastle.isActive;
				},
				function():void {
					SoundManager.instance().playSound(SoundResources.gong);	
					game.stop(GameResultType.VICTORY, true);
				},
				new GameTime(0, 5)
			); */
			
			Trigger.add("LooseCondition", 
				function():Boolean {
					return !_castle.isActive;
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
				SoundResources.ambientCricket,
				SoundResources.ambientBirds1,
				SoundResources.ambientBirds2,
				SoundResources.ambientOwl1,
				SoundResources.ambientOwl2,
				SoundResources.ambientWind ]);			
			SoundManager.instance().setAmbientLoopAreaList([ 
				{area: game.world.area, sound:SoundResources.ambientCricketLong}]);			
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
						game.unitManager.placeUnitOnWorld(allyHero, _heroSpawnArea.centerTile, true);
						game.effectManager.addEffectByType(_typesRepository.effectTypes.Teleport, allyHero.physicalCenter);
						if (_stateBag.startLevel > 1) allyHero.levelUp(_stateBag.startLevel - 1);
					}					
				}			
			}); 						 				
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
					reviveHero(hero, _heroSpawnArea);
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
										
					reviveHero(hero, _heroSpawnArea);
				}
			}
			else if (unit is Structure)
			{
				GameManager.instance().showWarning(unit.fraction.locName + " lost a building...", 5, true);
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
		}		
	}
}