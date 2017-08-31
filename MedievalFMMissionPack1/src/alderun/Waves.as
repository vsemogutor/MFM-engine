package alderun
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
		private static const START_DELAY:int = 30;
		
		private var game:Game;
		private var _typesRepository:TypesRepository;
		
		private var _spawnAreaTop:Area; 
		private var _spawnAreaLeft:Area; 
		private var _spawnAreaRight:Area; 
		private var _spawnAreaBottom:Area;  
		
		private var _castle:Unit; 
		private var _castleArea:Area;
		private var _spawnAreas:Array;
														
		public function init(game:Game, typesRepository:TypesRepository):void
		{
			this.game = game;
			this._typesRepository = typesRepository;

			_castle = game.unitManager.getUnitByName("fortress");				
			_castleArea = game.areaManager.getByName("fortressArea");
			
			_spawnAreaTop = game.areaManager.getByName("spawnAreaTop");
			_spawnAreaLeft = game.areaManager.getByName("spawnAreaLeft");			
			_spawnAreaRight = game.areaManager.getByName("spawnAreaRight");
			_spawnAreaBottom = game.areaManager.getByName("spawnAreaBottom");
			
			_spawnAreas = [_spawnAreaTop, _spawnAreaLeft, _spawnAreaRight, _spawnAreaBottom];	
									
			wave1();
 			wave2();
			wave3();
			wave4();
/*			wave5();
			wave6();
			wave7();
			wave8();
			wave9();
			wave10();
			wave11();
			wave12(); */
		}
		
		private function createWave(delay:GameTime, waveDescription:Object, onComplete:Function = null):void
		{
			Trigger.afterPeriod(delay,		
				function():void {
					var area:Area = waveDescription.area;
					var batchCount:int = waveDescription.batchCount;
					var delay:int = 0;
					
					for (var i:int = 0; i < batchCount; ++i)
					{
						Trigger.afterPeriod(new GameTime(0, delay), 
						function():void 
						{
							var units:Vector.<Unit> = game.unitManager.createUnitsFromType(
								waveDescription.batch, waveDescription.type, waveDescription.fraction);
								
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
						
						delay += waveDescription.batchDelay;
					}	
				});			
		}
		
		
		public function wave1():void
		{
			const WAVE1_COUNT:int = 10;
			
			for (var i:int = 0; i < _spawnAreas.length; ++i)
			{
				createWave(new GameTime(0, 30), 	
					{
						type: 			_typesRepository.unitTypes.Spider, 
						fraction: 		_typesRepository.fractions.darkForces,
						batchCount: 	10,
						batch:			3,
						batchDelay:		2,
						area: 			_spawnAreas[i],
						destination:	_castleArea.centerTile					
					}
				);
			}									
		}
		
		public function wave2():void
		{
			const WAVE1_COUNT:int = 10;
			
			for (var i:int = 0; i < _spawnAreas.length; ++i)
			{
				createWave(new GameTime(0, 120), 	
					{
						type: 			_typesRepository.unitTypes.Wolf, 
						fraction: 		_typesRepository.fractions.darkForces,
						batchCount: 	10,
						batch:			3,
						batchDelay:		2,
						area: 			_spawnAreas[i],
						destination:	_castleArea.centerTile					
					}
				);
			}									
		}
		
		public function wave3():void
		{
			const WAVE1_COUNT:int = 10;
			
			for (var i:int = 0; i < _spawnAreas.length; ++i)
			{
				createWave(new GameTime(0, 210), 	
					{
						type: 			_typesRepository.unitTypes.LizardMan, 
						fraction: 		_typesRepository.fractions.darkForces,
						batchCount: 	10,
						batch:			3,
						batchDelay:		2,
						area: 			_spawnAreas[i],
						destination:	_castleArea.centerTile					
					}
				);
			}									
		}
		
		public function wave4():void
		{
			const WAVE1_COUNT:int = 10;
			
			for (var i:int = 0; i < _spawnAreas.length; ++i)
			{
				createWave(new GameTime(0, 300), 	
					{
						type: 			_typesRepository.unitTypes.Zombie, 
						fraction: 		_typesRepository.fractions.darkForces,
						batchCount: 	10,
						batch:			3,
						batchDelay:		2,
						area: 			_spawnAreas[i],
						destination:	_castleArea.centerTile					
					}
				);
			}									
		}
		
		public function wave5():void
		{
			const WAVE1_COUNT:int = 10;
			
			for (var i:int = 0; i < _spawnAreas.length; ++i)
			{
				createWave(new GameTime(0, START_DELAY), 	
					{
						type: 			_typesRepository.unitTypes.Spider, 
						fraction: 		_typesRepository.fractions.darkForces,
						batchCount: 	10,
						batch:			3,
						batchDelay:		2,
						area: 			_spawnAreas[i],
						destination:	_castleArea.centerTile					
					}
				);
			}									
		}
		
		public function wave6():void
		{
			const WAVE1_COUNT:int = 10;
			
			for (var i:int = 0; i < _spawnAreas.length; ++i)
			{
				createWave(new GameTime(0, START_DELAY), 	
					{
						type: 			_typesRepository.unitTypes.Spider, 
						fraction: 		_typesRepository.fractions.darkForces,
						batchCount: 	4,
						batch:			10,
						batchDelay:		10,
						area: 			_spawnAreas[i],
						destination:	_castleArea.centerTile					
					}
				);
			}									
		}
		
		public function wave7():void
		{
			const WAVE1_COUNT:int = 10;
			
			for (var i:int = 0; i < _spawnAreas.length; ++i)
			{
				createWave(new GameTime(0, START_DELAY), 	
					{
						type: 			_typesRepository.unitTypes.Spider, 
						fraction: 		_typesRepository.fractions.darkForces,
						batchCount: 	4,
						batch:			10,
						batchDelay:		10,
						area: 			_spawnAreas[i],
						destination:	_castleArea.centerTile					
					}
				);
			}									
		}
		
		public function wave8():void
		{
			const WAVE1_COUNT:int = 10;
			
			for (var i:int = 0; i < _spawnAreas.length; ++i)
			{
				createWave(new GameTime(0, START_DELAY), 	
					{
						type: 			_typesRepository.unitTypes.Spider, 
						fraction: 		_typesRepository.fractions.darkForces,
						batchCount: 	4,
						batch:			10,
						batchDelay:		10,
						area: 			_spawnAreas[i],
						destination:	_castleArea.centerTile					
					}
				);
			}									
		}
		
		public function wave9():void
		{
			const WAVE1_COUNT:int = 10;
			
			for (var i:int = 0; i < _spawnAreas.length; ++i)
			{
				createWave(new GameTime(0, START_DELAY), 	
					{
						type: 			_typesRepository.unitTypes.Spider, 
						fraction: 		_typesRepository.fractions.darkForces,
						batchCount: 	4,
						batch:			10,
						batchDelay:		10,
						area: 			_spawnAreas[i],
						destination:	_castleArea.centerTile					
					}
				);
			}									
		}	
		
		public function wave10():void
		{
			const WAVE1_COUNT:int = 10;
			
			for (var i:int = 0; i < _spawnAreas.length; ++i)
			{
				createWave(new GameTime(0, START_DELAY), 	
					{
						type: 			_typesRepository.unitTypes.Spider, 
						fraction: 		_typesRepository.fractions.darkForces,
						batchCount: 	4,
						batch:			10,
						batchDelay:		10,
						area: 			_spawnAreas[i],
						destination:	_castleArea.centerTile					
					}
				);
			}									
		}
		
		public function wave11():void
		{
			const WAVE1_COUNT:int = 10;
			
			for (var i:int = 0; i < _spawnAreas.length; ++i)
			{
				createWave(new GameTime(0, START_DELAY), 	
					{
						type: 			_typesRepository.unitTypes.Spider, 
						fraction: 		_typesRepository.fractions.darkForces,
						batchCount: 	4,
						batch:			10,
						batchDelay:		10,
						area: 			_spawnAreas[i],
						destination:	_castleArea.centerTile					
					}
				);
			}									
		}
		
		public function wave12():void
		{
			const WAVE1_COUNT:int = 10;
			
			for (var i:int = 0; i < _spawnAreas.length; ++i)
			{
				createWave(new GameTime(0, START_DELAY), 	
					{
						type: 			_typesRepository.unitTypes.Spider, 
						fraction: 		_typesRepository.fractions.darkForces,
						batchCount: 	4,
						batch:			10,
						batchDelay:		10,
						area: 			_spawnAreas[i],
						destination:	_castleArea.centerTile					
					}
				);
			}									
		}																						
	}
}