package engine.loaders
{
	import engine.area.Area;
	import engine.computers.PathFinder;
	import engine.core.events.EngineEvents;
	import engine.core.isometric.IsoTile;
	import engine.core.isometric.IsoWorld;
	import engine.fraction.Fraction;
	import engine.game.Game;
	import engine.objects.ObjectType;
	import engine.objects.isometric.IsoObject;
	import engine.tileset.CliffTileType;
	import engine.tileset.TileType;
	import engine.tileset.TilesetMapEditor;
	import engine.units.Unit;
	import engine.units.UnitType;
	import engine.util.TileUtil;
	import engine.util.Util;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
	public final class MapLoader extends EventDispatcher
	{
		private var _world:IsoWorld;
		
		public function get world():IsoWorld {
			return _world;
		}
		
		public function loadMap(map:XML):IsoWorld
		{
			//trace(map.toXMLString());
			_world = createIsoWorld(map);
			dispatchEvent(new Event(EngineEvents.WORLD_CREATED));
						
			loadUnits(map.units.unt);
			loadObjects(map.objects.obj);
			loadAreas(map.areas.area);
			loadGameState(map.gameState);
			
			dispatchEvent(new Event(EngineEvents.MAP_LOADED));
			return _world;
		}
		
		private function loadGameState(gameState:XMLList):void
		{
			Game.instance().idManager.setSeed(gameState.idSeed);
		}	
		
		private function loadUnits(unitsXml:XMLList):void
		{
			var game:Game = Game.instance();
			for each (var unitXml:XML in unitsXml)
			{
				var type:UnitType = game.unitManager.unitTypes.get(int(unitXml.@tid)) as UnitType;
				var fraction:Fraction = game.fractionManager.fractions.get(int(unitXml.@fid)) as Fraction;
				if (type && fraction)
				{
					var unit:Unit = game.unitManager.unitFactory.createUnit(type, fraction);
					unit.direction = int(unitXml.@dir);
					var name:String = unitXml.@nm;
					if (name) unit.name = name;
					else unit.id = int(unitXml.@id);
					
					if (unitXml.its)
					{
						var childs:XMLList = unitXml.its.it;
						for each (var itemXml:XML in childs)
						{
							unit.addItem(game.inventoryItemManager.getItemTypeById(int(itemXml.toString())));
						}
					}
					
					game.unitManager.placeUnitOnWorld(unit, new Point(unitXml.@x, unitXml.@y), false, true);
				}
				else
				{
					trace("Error adding unit from map file - type or fraction is missing");
				}
			}
		}
		
		private function loadObjects(objectsXml:XMLList):void
		{
			for each (var objectXml:XML in objectsXml)
			{
				var type:ObjectType = Game.instance().objectManager.objectTypes.get(int(objectXml.@tid)) as ObjectType;
				if (type)
				{
					var object:IsoObject = Game.instance().objectManager.createObjectFromType(type);
					object.id = objectXml.@id;
					Game.instance().objectManager.placeObjectOnWorld(object, new Point(objectXml.@x, objectXml.@y));
				}
				else
				{
					trace("Error adding object from map file - type is missing");
				}
			}
		}
		
		private function createIsoWorld(map:XML): IsoWorld
		{	
			var xGridSize:int = map.@width;
			var yGridSize:int = map.@height;
								
			var iw:IsoWorld = new IsoWorld(xGridSize, yGridSize);
			iw.tileset = Game.instance().missionManager.currentMission.tileset;
			iw.tilesetMapEditor = new TilesetMapEditor(iw);
			iw.tileset.load(Game.instance().missionManager.currentMission.tilesetBitmap);			
	
			var xt:int = 0;
			var yt:int = 0;
			
			var tiles:XMLList = map.tiles.t;
			for each (var tile:XML in tiles)
			{
				if (tile.@x >= xGridSize || tile.@y >= yGridSize)
					continue;
					
				var it:IsoTile = createTile(tile.@x, tile.@y, 
					iw.tileset.tileTypes[int(tile.@id)], 
					tile.@cid ? iw.tileset.tileTypes[int(tile.@cid)] : null,
					Util.parseBool(tile.@p),
					Util.parseBool(tile.@b));

				it.tileTypeVariation = int(tile.@v);
				tile.@c && (it.cliffTypeVariation = int(tile.@c));
				it._tileTypeBL = int(tile.@bl);
				it._tileTypeBR = int(tile.@br);
				it._tileTypeTL = int(tile.@tl);
				it._tileTypeTR = int(tile.@tr);	
				it.region = int(tile.@r);	
																															
				iw.tiles[it.xindex*yGridSize + it.yindex] = it;
				yt++;				
				if( yt == iw.yGridSize ) {
					yt = 0;
					xt++;					
				}			    
			}
			
			if (tiles.length() != iw.tiles.length)
			{
				for (var i:int = 0; i < xGridSize; ++i)
				{
					for (var j:int = 0; j < yGridSize; ++j)
					{
						var indx:int = i*yGridSize + j;
		
						if (iw.tiles[indx]) continue;
						
						var type:TileType = iw.tileset.primaryTileType;
						var it:IsoTile = createTile(i, j, type, null, type.passable, type.buildable);
						
						iw.tiles[indx] = it;
					}
				}
				
				for (var i:int = 0; i < iw.tiles.length; ++i)
				{	
					iw.tilesetMapEditor.resetTile(iw.tiles[i]);	
				}
			}

			Game.instance().attachWorld(iw);			

			iw.pathFinder = new PathFinder(iw);
			return iw;
		}
		
		private function createTile(x:int, y:int, type:TileType, cliffTileType:TileType, passable:Boolean, buildable:Boolean):IsoTile
		{
			var it:IsoTile = new IsoTile();
			it.xindex = x;
			it.yindex = y;
			it.type = type;
			it.passable = passable;
			it.buildable = buildable;
			it.cliffType = cliffTileType as CliffTileType;	
			if (it.cliffType)
				it.z = 	it.cliffType.height;	
			
			var p:Point = TileUtil.tileToIso(it.xindex, it.yindex);
			it.x = p.x;
			it.y = p.y;																										
			return it;		
		}

		private function loadAreas(areasXml:XMLList):void
		{
			for each (var areaXml:XML in areasXml)
			{
				var area:Area = new Area(areaXml.@name, areaXml.@x, areaXml.@y, areaXml.@w, areaXml.@h);
				Game.instance().areaManager.addArea(area, areaXml.@id);
			}
		}
	}
}