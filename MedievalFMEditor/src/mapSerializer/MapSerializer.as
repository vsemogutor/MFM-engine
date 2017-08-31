package mapSerializer
{
	import de.polygonal.ds.HashMapValIterator;
	
	import engine.area.Area;
	import engine.core.isometric.IsoTile;
	import engine.core.isometric.IsoWorld;
	import engine.game.Game;
	import engine.objects.isometric.IsoObject;
	import engine.tileset.CliffTileType;
	import engine.units.Unit;
	
	public class MapSerializer
	{
		private var _world:IsoWorld;
		private var _game:Game;
		
		public function MapSerializer(game:Game)
		{
			_game = game;
			_world = game.world;
		}
		
		public function serializeMap(pretty:Boolean):XML
		{	
			XML.prettyPrinting = pretty;
						
			var root:XML = getRootTag();
			
			var tiles:XML = <tiles></tiles>;
			root.appendChild(tiles);
			for (var i:int = 0; i < _world.tiles.length; ++i)
			{
				tiles.appendChild(getTileXml(_world.tiles[i]));
			}

			var units:XML = <units></units>;
			root.appendChild(units);		
			for (var i:int = 0; i < _game.unitManager.units.length; ++i)
			{
				units.appendChild(getUnitXml(_game.unitManager.units[i]));
			}
			
			var objects:XML = <objects></objects>;
			root.appendChild(objects);		
			for (var i:int = 0; i < _game.objectManager.objects.length; ++i)
			{
				objects.appendChild(getObjectXml(_game.objectManager.objects[i]));
			}
			
			var areas:XML = <areas></areas>;
			root.appendChild(areas);
			var iter:HashMapValIterator = _game.areaManager.areas.iterator() as HashMapValIterator;
			while (iter.hasNext())
			{
			   	areas.appendChild(getAreaXml(iter.next() as Area));
			}
			
			var gameStateXml:XML = getGameStateXml();
			root.appendChild(gameStateXml);
									
			return root;
		}
		
		private function getRootTag():XML
		{
			var root:XML = new XML(<map></map>);
			root.@width = _world.xGridSize;
			root.@height = _world.yGridSize;
			
			return root;
		}
		
		private function getTileXml(tile:IsoTile):XML
		{
			var tileXml:XML = <t/>;
			tileXml.@id = tile.type.id;
			tileXml.@x=tile.xindex;
			tileXml.@y=tile.yindex;
						
			if (tile.tileTypeVariation)
				tileXml.@v = tile.tileTypeVariation;
				
			if (tile._tileTypeBL)
				tileXml.@bl = tile._tileTypeBL;
				
			if (tile._tileTypeBR)
				tileXml.@br = tile._tileTypeBR;

			if (tile._tileTypeTL)
				tileXml.@tl = tile._tileTypeTL;
				
			if (tile._tileTypeTR)
				tileXml.@tr = tile._tileTypeTR;				
			
			if (tile.cliffType)
			{
				tileXml.@cid = tile.cliffType.id;
				tileXml.@c = tile.cliffTypeVariation;
				
				if (tile.buildable && tile.cliffTypeVariation == CliffTileType.FLAT)
				{
					tileXml.@b = 1;
				}
			}
			else
			{
				if (tile.passable)
					tileXml.@p = 1;
				
				if (tile.buildable)
					tileXml.@b = 1;
			}
				
			if (tile.region)
				tileXml.@r = tile.region;
			
			return tileXml;		
		}
		
		private function getUnitXml(unit:Unit):XML
		{
			var xml:XML = <unt></unt>;
			xml.@tid = unit.type.id;
			xml.@fid = unit.fraction.id;
			xml.@x = unit.tile.xindex;			
			xml.@y = unit.tile.yindex;
			xml.@id = unit.id;
			xml.@dir = unit.direction;
			xml.@nm = unit.name || "";	
			
			if (unit.items.length > 0)
			{
				var itemsXml:XML = <its></its>;
				for (var i:int = 0; i < unit.items.length; ++i)
				{
					itemsXml.appendChild(<it>{unit.items[i].id}</it>);
				}
				xml.appendChild(itemsXml);
			}		
						
			return xml;		
		}
		
		private function getObjectXml(object:IsoObject):XML
		{
			var xml:XML = <obj/>;
			xml.@tid = object.type.id;
			xml.@x = object.tile.xindex;			
			xml.@y = object.tile.yindex;
			xml.@id = object.id;			
						
			return xml;		
		}

		private function getAreaXml(area:Area):XML
		{
			var xml:XML = <area></area>;
			xml.@id = area.id;
			xml.@name = area.name;			
			xml.@x = area.x;			
			xml.@y = area.y;
			xml.@w = area.width;			
			xml.@h = area.height;
								
			return xml;		
		}
		
		private function getGameStateXml():XML
		{
			var xml:XML = <gameState></gameState>;
			xml.appendChild(<idSeed>{_game.idManager.nextId()}</idSeed>);
								
			return xml;		
		}
	}
}