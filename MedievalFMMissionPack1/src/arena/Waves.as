package arena
{
	import __AS3__.vec.Vector;
	
	import engine.area.Area;
	import engine.core.GameTime;
	import engine.game.Game;
	import engine.trigger.Trigger;
	import engine.units.Unit;
	import engine.units.groups.UnitGroup;
	
	internal final class Waves
	{
		private var game:Game;
		private var _typesRepository:TypesRepository;
		
		private var _lightBarracksTop:Unit; 
		private var _lightBarracksBottom:Unit; 
		private var _lightCastle:Unit; 
		private var _darkBarracksTop:Unit; 
		private var _darkBarracksBottom:Unit; 
		private var _darkCastle:Unit; 
		
		private var _lightTopArea:Area;
		private var _lightMiddleArea:Area;		
		private var _lightBottomArea:Area;

		private var _darkTopArea:Area;
		private var _darkMiddleArea:Area;		
		private var _darkBottomArea:Area;
		
		private var _lightTop1Area:Area;
		private var _lightMiddle1Area:Area;		
		private var _lightBottom1Area:Area;

		private var _darkTop1Area:Area;
		private var _darkMiddle1Area:Area;		
		private var _darkBottom1Area:Area;		

		private var _neutralTop1Area:Area;
		private var _neutralMiddle1Area:Area;		
		private var _neutralBottom1Area:Area;
		
		private var _goodPlaceArea:Area;
		private var _badPlaceArea:Area;		
		
		private const MELEE_1_COUNT:int = 3;
		private const RANGE_1_COUNT:int = 2;
		private const RANGE_2_COUNT:int = 2;
		private const MELEE_2_COUNT:int = 2;										
		private const SIEDGE_1_COUNT:int = 2;
		
		private const START_DELAY_W60:int = 30;		
		private const START_DELAY_W80:int = 80 - START_DELAY_W60;	
		private const START_DELAY_W100:int = 100 - START_DELAY_W60;
		private const START_DELAY_W120:int = 120 - START_DELAY_W60;
		private const START_DELAY_W140:int = 140 - START_DELAY_W60;
														
		public function init(game:Game, typesRepository:TypesRepository):void
		{
			this.game = game;
			this._typesRepository = typesRepository;
			
			_lightBarracksTop = game.unitManager.getUnitByName("LightBarracksTop");	
			_lightCastle = game.unitManager.getUnitByName("LightAncient");	
			_lightBarracksBottom = game.unitManager.getUnitByName("LightBarracksBottom");

			_darkBarracksTop = game.unitManager.getUnitByName("DarkBarracksTop");	
			_darkCastle = game.unitManager.getUnitByName("DarkAncient");	
			_darkBarracksBottom = game.unitManager.getUnitByName("DarkBarracksBottom");
						
			_lightTopArea = game.areaManager.getByName("LightTop");
			_lightMiddleArea = game.areaManager.getByName("LightMiddle");
			_lightBottomArea = game.areaManager.getByName("LightBottom");			

			_darkTopArea = game.areaManager.getByName("DarkTop");
			_darkMiddleArea = game.areaManager.getByName("DarkMiddle");
			_darkBottomArea = game.areaManager.getByName("DarkBottom");	

			_lightTop1Area = game.areaManager.getByName("LightTop1");
			_lightMiddle1Area = game.areaManager.getByName("LightMiddle1");
			_lightBottom1Area = game.areaManager.getByName("LightBottom1");			

			_darkTop1Area = game.areaManager.getByName("DarkTop1");
			_darkMiddle1Area = game.areaManager.getByName("DarkMiddle1");
			_darkBottom1Area = game.areaManager.getByName("DarkBottom1");	

			_neutralTop1Area = game.areaManager.getByName("NeutralTop");
			_neutralMiddle1Area = game.areaManager.getByName("NeutralMiddle");
			_neutralBottom1Area = game.areaManager.getByName("NeutralBottom");
						
			_goodPlaceArea = game.areaManager.getByName("GoodPlace");
			_badPlaceArea = game.areaManager.getByName("BadPlace");	
												
			darkInLightTopGoToGoodPlace();
			darkInLightBottomGoToGoodPlace();

			lightInDarkTopGoToBadPlace();
			lightInDarkBottomGoToBadPlace();
									
			waveLightFootmanTop();
			waveLightFootmanMiddle();
			waveLightFootmanBottom();
			waveDarkFootmanTop();
			waveDarkFootmanMiddle();
			waveDarkFootmanBottom();
			
			waveLightArcherTop();
			waveLightArcherMiddle();
			waveLightArcherBottom();
			waveDarkArcherTop();
			waveDarkArcherMiddle();
			waveDarkArcherBottom();
			
			waveLightRange2Top();
			waveLightRange2Middle();
			waveLightRange2Bottom();
			waveDarkRange2Top();
			waveDarkRange2Middle();
			waveDarkRange2Bottom();
			
			waveLightKnightTop();
			waveLightKnightMiddle();
			waveLightKnightBottom();
			waveDarkOgreTop();
			waveDarkOgreMiddle();
			waveDarkOgreBottom();
			
			waveLightBallistaTop();
			waveLightBallistaMiddle();
			waveLightBallistaBottom();
			waveDarkBallistaTop();
			waveDarkBallistaMiddle();
			waveDarkBallistaBottom();
		}
		
		private function createWave(delay:GameTime, period:GameTime, condition:Function, waveDescription:Object, onComplete:Function = null):void
		{
			Trigger.afterPeriodRepeat(delay, period, Trigger.INFINITE,
				function(state:Object):Boolean {
					return condition(state);
				},				
				function():void {
					var area:Area = waveDescription.area;
					var units:Vector.<Unit> = game.unitManager.createUnitsFromType(
						waveDescription.count, waveDescription.type, waveDescription.fraction);
						
					if (waveDescription.items)
					{
						for (var i:int = 0; i < units.length; ++i)
						{
							units[i].addItems(waveDescription.items);
						}
					}	
											
					game.unitManager.placeUnitsOnWorld(units, area, true, true);
					var waveGroup:UnitGroup = new UnitGroup();
					waveGroup.addUnits(units);
					
					Trigger.afterPeriod(new GameTime(1), function():void {
						waveGroup.orderAttackMove(waveDescription.destination);
					});
					
/* 					Trigger.afterPeriodRepeat(new GameTime(0, 8), new GameTime(0, 3), -1, null,
						function(state:Object, t:Timer):void {
							if (waveGroup.isEmpty())
							{
								t.remove();
							}
							else if (waveDescription.destination1.isAnyUnitInArea(waveGroup))
							{
								waveGroup.orderAttackMove(waveDescription.destination2);
								t.remove();
							}
						}
					); */
					
					if (onComplete != null)
					{
						game.groupManager.watch(waveGroup, true);						
						Trigger.add(null, 
							function():Boolean {
								return waveGroup.isEmpty();
							},
							function():void {
								onComplete();
							}, 
							new GameTime(0, 1)	
						);	
					}	
				});			
		}
		
		
		private function darkInLightTopGoToGoodPlace():void
		{
			Trigger.addRepeat(function():void {
				var group:UnitGroup = UnitGroup.fromArea(_lightTopArea, _typesRepository.fractions.darkForces);
				group.orderAttackMove(_goodPlaceArea.centerTile);
			},
			new GameTime(0, 11));
		}

		private function darkInLightBottomGoToGoodPlace():void
		{
			Trigger.addRepeat(function():void {
				var group:UnitGroup = UnitGroup.fromArea(_lightBottomArea, _typesRepository.fractions.darkForces);
				group.orderAttackMove(_goodPlaceArea.centerTile);
			},
			new GameTime(0, 11));
		}
		
		private function lightInDarkTopGoToBadPlace():void
		{
			Trigger.addRepeat(function():void {
				var group:UnitGroup = UnitGroup.fromArea(_darkTopArea, _typesRepository.fractions.lightForces);
				group.orderAttackMove(_badPlaceArea.centerTile);
			},
			new GameTime(0, 11));
		}
		
		private function lightInDarkBottomGoToBadPlace():void
		{
			Trigger.addRepeat(function():void {
				var group:UnitGroup = UnitGroup.fromArea(_darkBottomArea, _typesRepository.fractions.lightForces);
				group.orderAttackMove(_badPlaceArea.centerTile);
			},
			new GameTime(0, 11));
		}
				

		
		public function waveLightFootmanTop():void
		{
			createWave(new GameTime(0, START_DELAY_W60), new GameTime(0, 60), 
				function():Boolean {
					return _lightBarracksTop.isActive;
				},		
				{
					type: 			_typesRepository.unitTypes.Footman, 
					fraction: 		_typesRepository.fractions.lightForces,
					count: 			MELEE_1_COUNT,
					area: 			_lightTopArea,
					destination:	_darkTopArea.centerTile					
				}
			);	
		}

		public function waveLightFootmanMiddle():void
		{
			createWave(new GameTime(0, START_DELAY_W60), new GameTime(0, 60), 
				function():Boolean {
					return _lightCastle.isActive;
				},		
				{
					type: 			_typesRepository.unitTypes.Footman, 
					fraction: 		_typesRepository.fractions.lightForces,
					count: 			MELEE_1_COUNT,
					area: 			_lightMiddleArea,
					destination:	_badPlaceArea.centerTile					
				}
			);			
		}
		
		public function waveLightFootmanBottom():void
		{
			createWave(new GameTime(0, START_DELAY_W60), new GameTime(0, 60), 
				function():Boolean {
					return _lightBarracksBottom.isActive;
				},		
				{
					type: 			_typesRepository.unitTypes.Footman, 
					fraction: 		_typesRepository.fractions.lightForces,
					count: 			MELEE_1_COUNT,
					area: 			_lightBottomArea,
					destination:	_darkBottomArea.centerTile					
				}
			);			
		}
		
		public function waveDarkFootmanTop():void
		{
			createWave(new GameTime(0, START_DELAY_W60), new GameTime(0, 60), 
				function():Boolean {
					return _darkBarracksTop.isActive;
				},		
				{
					type: 			_typesRepository.unitTypes.Orc, 
					fraction: 		_typesRepository.fractions.darkForces,
					count: 			MELEE_1_COUNT,
					area: 			_darkTopArea,
					destination:	_lightTopArea.centerTile					
				}
			);	
		}
		
		public function waveDarkFootmanMiddle():void
		{
			createWave(new GameTime(0, START_DELAY_W60), new GameTime(0, 60), 
				function():Boolean {
					return _darkCastle.isActive;
				},		
				{
					type: 			_typesRepository.unitTypes.Orc, 
					fraction: 		_typesRepository.fractions.darkForces,
					count: 			MELEE_1_COUNT,
					area: 			_darkMiddleArea,
					destination:	_goodPlaceArea.centerTile					
				}
			);	
		}
		
		public function waveDarkFootmanBottom():void
		{
			createWave(new GameTime(0, START_DELAY_W60), new GameTime(0, 60), 
				function():Boolean {
					return _darkBarracksBottom.isActive;
				},		
				{
					type: 			_typesRepository.unitTypes.Orc, 
					fraction: 		_typesRepository.fractions.darkForces,
					count: 			MELEE_1_COUNT,
					area: 			_darkBottomArea,
					destination:	_lightBottomArea.centerTile					
				}
			);	
		}

		public function waveLightArcherTop():void
		{
			createWave(new GameTime(0, START_DELAY_W80), new GameTime(0, 80), 
				function():Boolean {
					return _lightBarracksTop.isActive;
				},		
				{
					type: 			_typesRepository.unitTypes.Archer, 
					fraction: 		_typesRepository.fractions.lightForces,
					count: 			RANGE_1_COUNT,
					area: 			_lightTopArea,
					destination:	_darkTopArea.centerTile					
				}
			);	
		}

		public function waveLightArcherMiddle():void
		{
			createWave(new GameTime(0, START_DELAY_W80), new GameTime(0, 80), 
				function():Boolean {
					return _lightCastle.isActive;
				},		
				{
					type: 			_typesRepository.unitTypes.Archer, 
					fraction: 		_typesRepository.fractions.lightForces,
					count: 			RANGE_1_COUNT,
					area: 			_lightMiddleArea,
					destination:	_badPlaceArea.centerTile					
				}
			);	
		}
	
		public function waveLightArcherBottom():void
		{
			createWave(new GameTime(0, START_DELAY_W80), new GameTime(0, 80), 
				function():Boolean {
					return _lightBarracksBottom.isActive;
				},		
				{
					type: 			_typesRepository.unitTypes.Archer, 
					fraction: 		_typesRepository.fractions.lightForces,
					count: 			RANGE_1_COUNT,
					area: 			_lightBottomArea,
					destination:	_darkBottomArea.centerTile					
				}
			);	
		}

		public function waveDarkArcherTop():void
		{
			createWave(new GameTime(0, START_DELAY_W80), new GameTime(0, 80), 
				function():Boolean {
					return _darkBarracksTop.isActive;
				},		
				{
					type: 			_typesRepository.unitTypes.SkeletonArcher, 
					fraction: 		_typesRepository.fractions.darkForces,
					count: 			RANGE_1_COUNT,
					area: 			_darkTopArea,
					destination:	_lightTopArea.centerTile					
				}
			);	
		}
	
		public function waveDarkArcherMiddle():void
		{
			createWave(new GameTime(0, START_DELAY_W80), new GameTime(0, 80), 
				function():Boolean {
					return _darkCastle.isActive;
				},		
				{
					type: 			_typesRepository.unitTypes.SkeletonArcher, 
					fraction: 		_typesRepository.fractions.darkForces,
					count: 			RANGE_1_COUNT,
					area: 			_darkMiddleArea,
					destination:	_goodPlaceArea.centerTile					
				}
			);	
		}

		public function waveDarkArcherBottom():void
		{
			createWave(new GameTime(0, START_DELAY_W80), new GameTime(0, 80), 
				function():Boolean {
					return _darkBarracksBottom.isActive;
				},		
				{
					type: 			_typesRepository.unitTypes.SkeletonArcher, 
					fraction: 		_typesRepository.fractions.darkForces,
					count: 			RANGE_1_COUNT,
					area: 			_darkBottomArea,
					destination:	_lightBottomArea.centerTile					
				}
			);	
		}

		public function waveLightRange2Top():void
		{
			createWave(new GameTime(0, START_DELAY_W100), new GameTime(0, 100), 
				function():Boolean {
					return _lightBarracksTop.isActive;
				},		
				{
					type: 			_typesRepository.unitTypes.DwafGuard, 
					fraction: 		_typesRepository.fractions.lightForces,
					count: 			RANGE_2_COUNT,
					area: 			_lightTopArea,
					destination:	_darkTopArea.centerTile,
					items:			[_typesRepository.inventoryItems.runeOfMana.clone()]										
				}
			);	
		}	
		
		public function waveLightRange2Middle():void
		{
			createWave(new GameTime(0, START_DELAY_W100), new GameTime(0, 100), 
				function():Boolean {
					return _lightCastle.isActive;
				},		
				{
					type: 			_typesRepository.unitTypes.DwafGuard, 
					fraction: 		_typesRepository.fractions.lightForces,
					count: 			RANGE_2_COUNT,
					area: 			_lightMiddleArea,
					destination:	_badPlaceArea.centerTile,
					items:			[_typesRepository.inventoryItems.runeOfMana.clone()]										
				}
			);	
		}		
		
		public function waveLightRange2Bottom():void
		{
			createWave(new GameTime(0, START_DELAY_W100), new GameTime(0, 100), 
				function():Boolean {
					return _lightBarracksBottom.isActive;
				},		
				{
					type: 			_typesRepository.unitTypes.DwafGuard, 
					fraction: 		_typesRepository.fractions.lightForces,
					count: 			RANGE_2_COUNT,
					area: 			_lightBottomArea,
					destination:	_darkBottomArea.centerTile,
					items:			[_typesRepository.inventoryItems.runeOfMana.clone()]										
				}
			);	
		}

		public function waveDarkRange2Top():void
		{
			createWave(new GameTime(0, START_DELAY_W100), new GameTime(0, 100), 
				function():Boolean {
					return _darkBarracksTop.isActive;
				},		
				{
					type: 			_typesRepository.unitTypes.Ghast, 
					fraction: 		_typesRepository.fractions.darkForces,
					count: 			RANGE_2_COUNT,
					area: 			_darkTopArea,
					destination:	_lightTopArea.centerTile,
					items:			[_typesRepository.inventoryItems.runeOfMana.clone()]										
				}
			);	
		}
		
		public function waveDarkRange2Middle():void
		{
			createWave(new GameTime(0, START_DELAY_W100), new GameTime(0, 100), 
				function():Boolean {
					return _darkCastle.isActive;
				},		
				{
					type: 			_typesRepository.unitTypes.Ghast, 
					fraction: 		_typesRepository.fractions.darkForces,
					count: 			RANGE_2_COUNT,
					area: 			_darkMiddleArea,
					destination:	_goodPlaceArea.centerTile,
					items:			[_typesRepository.inventoryItems.runeOfMana.clone()]										
				}
			);	
		}

		public function waveDarkRange2Bottom():void
		{
			createWave(new GameTime(0, START_DELAY_W100), new GameTime(0, 100), 
				function():Boolean {
					return _darkBarracksBottom.isActive;
				},		
				{
					type: 			_typesRepository.unitTypes.Ghast, 
					fraction: 		_typesRepository.fractions.darkForces,
					count: 			RANGE_2_COUNT,
					area: 			_darkBottomArea,
					destination:	_lightBottomArea.centerTile,
					items:			[_typesRepository.inventoryItems.runeOfMana.clone()]									
				}
			);	
		}

		public function waveLightKnightTop():void
		{
			createWave(new GameTime(0, START_DELAY_W120), new GameTime(0, 120), 
				function():Boolean {
					return _lightBarracksTop.isActive;
				},		
				{
					type: 			_typesRepository.unitTypes.Knight, 
					fraction: 		_typesRepository.fractions.lightForces,
					count: 			MELEE_2_COUNT,
					area: 			_lightTop1Area,
					destination:	_darkTopArea.centerTile,
					items:			[_typesRepository.inventoryItems.runeOfHealth.clone()]											
				}
			);	
		}

		public function waveLightKnightMiddle():void
		{
			createWave(new GameTime(0, START_DELAY_W120), new GameTime(0, 120), 
				function():Boolean {
					return _lightCastle.isActive;
				},		
				{
					type: 			_typesRepository.unitTypes.Knight, 
					fraction: 		_typesRepository.fractions.lightForces,
					count: 			MELEE_2_COUNT,
					area: 			_lightMiddle1Area,
					destination:	_badPlaceArea.centerTile,
					items:			[_typesRepository.inventoryItems.runeOfHealth.clone()]											
				}
			);	
		}

		public function waveLightKnightBottom():void
		{
			createWave(new GameTime(0, START_DELAY_W120), new GameTime(0, 120), 
				function():Boolean {
					return _lightBarracksBottom.isActive;
				},		
				{
					type: 			_typesRepository.unitTypes.Knight, 
					fraction: 		_typesRepository.fractions.lightForces,
					count: 			MELEE_2_COUNT,
					area: 			_lightBottom1Area,
					destination:	_darkBottomArea.centerTile,
					items:			[_typesRepository.inventoryItems.runeOfHealth.clone()]									
				}
			);	
		}
		public function waveDarkOgreTop():void
		{
			createWave(new GameTime(0, START_DELAY_W120), new GameTime(0, 120), 
				function():Boolean {
					return _darkBarracksTop.isActive;
				},		
				{
					type: 			_typesRepository.unitTypes.Ogre, 
					fraction: 		_typesRepository.fractions.darkForces,
					count: 			MELEE_2_COUNT,
					area: 			_darkTop1Area,
					destination:	_lightTopArea.centerTile,
					items:			[_typesRepository.inventoryItems.runeOfHealth.clone()]											
				}
			);	
		}
		
		public function waveDarkOgreMiddle():void
		{
			createWave(new GameTime(0, START_DELAY_W120), new GameTime(0, 120), 
				function():Boolean {
					return _darkCastle.isActive;
				},		
				{
					type: 			_typesRepository.unitTypes.Ogre, 
					fraction: 		_typesRepository.fractions.darkForces,
					count: 			3,
					area: 			_darkMiddle1Area,
					destination:	_goodPlaceArea.centerTile,
					items:			[_typesRepository.inventoryItems.runeOfHealth.clone()]								
				}
			);	
		}

		public function waveDarkOgreBottom():void
		{
			createWave(new GameTime(0, START_DELAY_W120), new GameTime(0, 120), 
				function():Boolean {
					return _darkBarracksBottom.isActive;
				},		
				{
					type: 			_typesRepository.unitTypes.Ogre, 
					fraction: 		_typesRepository.fractions.darkForces,
					count: 			MELEE_2_COUNT,
					area: 			_darkBottom1Area,
					destination:	_lightBottomArea.centerTile,
					items:			[_typesRepository.inventoryItems.runeOfHealth.clone()]											
				}
			);	
		}

		public function waveLightBallistaTop():void
		{
			createWave(new GameTime(0, START_DELAY_W140), new GameTime(0, 140), 
				function():Boolean {
					return _lightBarracksTop.isActive;
				},		
				{
					type: 			_typesRepository.unitTypes.Ballista, 
					fraction: 		_typesRepository.fractions.lightForces,
					count: 			SIEDGE_1_COUNT,
					area: 			_lightTopArea,
					destination:	_darkTopArea.centerTile,
					items:			[_typesRepository.inventoryItems.coin.clone()]				
				}
			);	
		}

		public function waveLightBallistaMiddle():void
		{
			createWave(new GameTime(0, START_DELAY_W140), new GameTime(0, 140), 
				function():Boolean {
					return _lightCastle.isActive;
				},		
				{
					type: 			_typesRepository.unitTypes.Ballista, 
					fraction: 		_typesRepository.fractions.lightForces,
					count: 			SIEDGE_1_COUNT,
					area: 			_lightMiddleArea,
					destination:	_badPlaceArea.centerTile,
					items:			[_typesRepository.inventoryItems.coin.clone()]											
				}
			);	
		}

		public function waveLightBallistaBottom():void
		{
			createWave(new GameTime(0, START_DELAY_W140), new GameTime(0, 140), 
				function():Boolean {
					return _lightBarracksBottom.isActive;
				},		
				{
					type: 			_typesRepository.unitTypes.Ballista, 
					fraction: 		_typesRepository.fractions.lightForces,
					count: 			SIEDGE_1_COUNT,
					area: 			_lightBottomArea,
					destination:	_darkBottomArea.centerTile,
					items:			[_typesRepository.inventoryItems.coin.clone()]											
				}
			);	
		}
	
		public function waveDarkBallistaTop():void
		{
			createWave(new GameTime(0, START_DELAY_W140), new GameTime(0, 140), 
				function():Boolean {
					return _darkBarracksTop.isActive;
				},		
				{
					type: 			_typesRepository.unitTypes.SiedgeGolem, 
					fraction: 		_typesRepository.fractions.darkForces,
					count: 			SIEDGE_1_COUNT,
					area: 			_darkTopArea,
					destination:	_lightTopArea.centerTile,
					items:			[_typesRepository.inventoryItems.coin.clone()]											
				}
			);	
		}

		public function waveDarkBallistaMiddle():void
		{
			createWave(new GameTime(0, START_DELAY_W140), new GameTime(0, 140), 
				function():Boolean {
					return _darkCastle.isActive;
				},		
				{
					type: 			_typesRepository.unitTypes.SiedgeGolem, 
					fraction: 		_typesRepository.fractions.darkForces,
					count: 			SIEDGE_1_COUNT,
					area: 			_darkMiddleArea,
					destination:	_goodPlaceArea.centerTile,
					items:			[_typesRepository.inventoryItems.coin.clone()]								
				}
			);	
		}

		public function waveDarkBallistaBottom():void
		{
			createWave(new GameTime(0, 140 - START_DELAY_W140), new GameTime(0, 140), 
				function():Boolean {
					return _darkBarracksBottom.isActive;
				},		
				{
					type: 			_typesRepository.unitTypes.SiedgeGolem, 
					fraction: 		_typesRepository.fractions.darkForces,
					count: 			SIEDGE_1_COUNT,
					area: 			_darkBottomArea,
					destination:	_lightBottomArea.centerTile,
					items:			[_typesRepository.inventoryItems.coin.clone()]											
				}
			);	
		}		

	}
}