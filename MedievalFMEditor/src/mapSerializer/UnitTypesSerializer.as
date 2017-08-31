package mapSerializer
{
	import de.polygonal.ds.HashMapValIterator;
	
	import engine.core.isometric.IsoWorld;
	import engine.fraction.ResourceType;
	import engine.game.Game;
	import engine.projectile.ProjectileBehaviour;
	import engine.units.ArmorType;
	import engine.units.DamageType;
	import engine.units.UnitProperties;
	import engine.units.UnitType;
	import engine.units.UnitTypes;
	import engine.units.upgrade.UnitTypeUpgrade;
	
	import resources.BitmapResources;
	import resources.SoundResources;
	
	public class UnitTypesSerializer
	{
		private var _world:IsoWorld;
		private var _game:Game;
		
		public function UnitTypesSerializer(game:Game)
		{
			_game = game;
			_world = game.world;
		}
		
		public function serialize():String
		{
			var res:String = "\tpublic class UnitTypesRepository\r\n\t{\r\n";
			
			var iter:HashMapValIterator = _game.unitManager.unitTypes.iterator() as HashMapValIterator;
			while (iter.hasNext())
			{
				var type:UnitType = iter.next() as UnitType;
				var name:String = type.name.replace(/[ ())]/gi, "");
				res += "\t\tpublic var " + name + ":UnitType;\r\n";
			}
			
			res += "\r\n\t\tpublic function init(game:Game, typesRepository:TypesRepository):void \r\n\t\t{\r\n";
			iter = _game.unitManager.unitTypes.iterator() as HashMapValIterator;
			while (iter.hasNext())
			{
				// base
				var type:UnitType = iter.next() as UnitType;
				var name:String = type.name.replace(/[ ())]/gi, "");
				res += "\t\t\t" + name + " = new UnitType(true);\r\n";
				res += "\t\t\t" + name + ".model = game.spriteRepository.getByName(\"" + type.model.name + "\") as UnitSprite;\r\n";
				res += "\t\t\t" + name + ".name = \"" + type.name + "\";\r\n";
				res += "\t\t\t" + name + ".id = " + type.id.toString() + ";\r\n";	
				res += "\t\t\t" + name + ".description = \"" + (type.description || " ") + "\";\r\n";				
				res += "\t\t\t" + name + ".type = UnitTypes." + UnitTypes.getTypeName(type.type) + ";\r\n";						
				res += "\t\t\t" + name + ".xLength = " + type.xLength.toString() + ";\r\n";
				res += "\t\t\t" + name + ".yLength = " + type.yLength.toString() + ";\r\n";				
				res += "\t\t\t" + name + ".isUpgrade = " + type.isUpgrade.toString() + ";\r\n";
				res += "\t\t\t" + name + ".isFlying = " + type.isFlying.toString() + ";\r\n";
				res += "\t\t\t" + name + ".isTrader = " + type.isTrader.toString() + ";\r\n";
				res += "\t\t\t" + name + ".constructionTime = " + type.constructionTime.toString() + ";\r\n";
				res += "\t\t\tgame.unitManager.addUnitType(" + name + ");\r\n";
											
				// properties
				if (type.properties[UnitProperties.Armor])
					res += "\t\t\t" + name + ".properties[UnitProperties.Armor] = " + type.properties[UnitProperties.Armor].toString() + ";\r\n";				
				res += "\t\t\t" + name + ".properties[UnitProperties.ArmorType] = ArmorType." + ArmorType.getTypeName(type.properties[UnitProperties.ArmorType]) + ";\r\n";	
				if (type.properties[UnitProperties.AstralRes])
					res += "\t\t\t" + name + ".properties[UnitProperties.AstralRes] = " + type.properties[UnitProperties.AstralRes].toString() + ";\r\n";							
				res += "\t\t\t" + name + ".properties[UnitProperties.AttackDelay] = " + type.properties[UnitProperties.AttackDelay].toString() + ";\r\n";
				res += "\t\t\t" + name + ".properties[UnitProperties.AttackDmgMax] = " + type.properties[UnitProperties.AttackDmgMax].toString() + ";\r\n";
				res += "\t\t\t" + name + ".properties[UnitProperties.AttackDmgMin] = " + type.properties[UnitProperties.AttackDmgMin].toString() + ";\r\n";
				res += "\t\t\t" + name + ".properties[UnitProperties.AttackDmgType] = DamageType." + DamageType.getTypeName(type.properties[UnitProperties.AttackDmgType]) + ";\r\n";												
				res += "\t\t\t" + name + ".properties[UnitProperties.AttackRange] = " + type.properties[UnitProperties.AttackRange].toString() + ";\r\n";
				res += "\t\t\t" + name + ".properties[UnitProperties.AttackSpeed] = " + type.properties[UnitProperties.AttackSpeed].toString() + ";\r\n";				
				res += "\t\t\t" + name + ".properties[UnitProperties.AttackSpell] = " + type.properties[UnitProperties.AttackSpell].toString() + ";\r\n";				
				res += "\t\t\t" + name + ".properties[UnitProperties.AttackVisualEffectId] = " + type.properties[UnitProperties.AttackVisualEffectId].toString() + ";\r\n";												
				res += "\t\t\t" + name + ".properties[UnitProperties.CastDelay] = " + type.properties[UnitProperties.CastDelay].toString() + ";\r\n";				
				res += "\t\t\t" + name + ".properties[UnitProperties.CastSpeed] = " + type.properties[UnitProperties.CastSpeed].toString() + ";\r\n";				
				if (type.properties[UnitProperties.HealthRegenRate])
					res += "\t\t\t" + name + ".properties[UnitProperties.HealthRegenRate] = " + type.properties[UnitProperties.HealthRegenRate].toString() + ";\r\n";
				if (type.properties[UnitProperties.HealthRegen])
					res += "\t\t\t" + name + ".properties[UnitProperties.HealthRegen] = " + type.properties[UnitProperties.HealthRegen].toString() + ";\r\n";				
				res += "\t\t\t" + name + ".properties[UnitProperties.IsMechanical] = " + type.properties[UnitProperties.IsMechanical].toString() + ";\r\n";				
				if (type.properties[UnitProperties.MagicRes])
					res += "\t\t\t" + name + ".properties[UnitProperties.MagicRes] = " + type.properties[UnitProperties.MagicRes].toString() + ";\r\n";	
				if (type.properties[UnitProperties.ManaRegenRate])
					res += "\t\t\t" + name + ".properties[UnitProperties.ManaRegenRate] = " + type.properties[UnitProperties.ManaRegenRate].toString() + ";\r\n";				
				if (type.properties[UnitProperties.ManaRegen])
					res += "\t\t\t" + name + ".properties[UnitProperties.ManaRegen] = " + type.properties[UnitProperties.ManaRegen].toString() + ";\r\n";				
				if (type.properties[UnitProperties.MaxHealth])
					res += "\t\t\t" + name + ".properties[UnitProperties.MaxHealth] = " + type.properties[UnitProperties.MaxHealth].toString() + ";\r\n";				
				if (type.properties[UnitProperties.MaxMana])
					res += "\t\t\t" + name + ".properties[UnitProperties.MaxMana] = " + type.properties[UnitProperties.MaxMana].toString() + ";\r\n";				
				if (type.properties[UnitProperties.MoveSpeed])
					res += "\t\t\t" + name + ".properties[UnitProperties.MoveSpeed] = " + type.properties[UnitProperties.MoveSpeed].toString() + ";\r\n";
				res += "\t\t\t" + name + ".properties[UnitProperties.ProjectileBehaviour] = ProjectileBehaviour." + ProjectileBehaviour.getTypeName(type.properties[UnitProperties.ProjectileBehaviour]) + ";\r\n";				
				res += "\t\t\t" + name + ".properties[UnitProperties.ProjectileModelId] = " + type.properties[UnitProperties.ProjectileModelId].toString() + ";\r\n";				
				res += "\t\t\t" + name + ".properties[UnitProperties.ProjectileSpeed] = " + type.properties[UnitProperties.ProjectileSpeed].toString() + ";\r\n";	
				res += "\t\t\t" + name + ".properties[UnitProperties.SightRange] = " + type.properties[UnitProperties.SightRange].toString() + ";\r\n";								
				res += "\t\t\t" + name + ".properties[UnitProperties.AttackDamageRange] = " + type.properties[UnitProperties.AttackDamageRange].toString() + ";\r\n";	
																			
				// spells
				for (var sp:int = 0; sp < type.spellList.length; ++sp)
				{
					res += "\t\t\t" + name + ".spellList.push(game.spellManager.getSpellTypeById(" + type.spellList[sp].id + "));\r\n";								
				}
				
				if (type.activeSpell)
					res += "\t\t\t" + name + ".activeSpell = game.spellManager.getSpellTypeById(" + type.activeSpell.id + ");\r\n";
					
				// costs
				if (type.costResources[ResourceType.Crystal])
					res += "\t\t\t" + name + ".costResources[ResourceType.Crystal] = " + type.costResources[ResourceType.Crystal].toString() + ";\r\n";				
				if (type.costResources[ResourceType.Gold])
					res += "\t\t\t" + name + ".costResources[ResourceType.Gold] = " + type.costResources[ResourceType.Gold].toString() + ";\r\n";	
				if (type.costResources[ResourceType.Population])
				res += "\t\t\t" + name + ".costResources[ResourceType.Population] = " + type.costResources[ResourceType.Population].toString() + ";\r\n";	
				if (type.costResources[ResourceType.PopulationProduction])
					res += "\t\t\t" + name + ".costResources[ResourceType.PopulationProduction] = " + type.costResources[ResourceType.PopulationProduction].toString() + ";\r\n";					
						
						
				// bounty
				if (type.bountyResources[ResourceType.Crystal])
					res += "\t\t\t" + name + ".bountyResources[ResourceType.Crystal] = " + type.bountyResources[ResourceType.Crystal].toString() + ";\r\n";				
				if (type.bountyResources[ResourceType.Gold])
					res += "\t\t\t" + name + ".bountyResources[ResourceType.Gold] = " + type.bountyResources[ResourceType.Gold].toString() + ";\r\n";
							
				// sounds
				if (type.soundPack.hit)
				{
					for (var key:String in SoundResources.sounds)
						if (SoundResources.sounds[key] == type.soundPack.hit) 
							res += "\t\t\t" + name + ".soundPack.hit = SoundResources." + key + ";\r\n";
				}			
				if (type.soundPack.attack)
				{
					for (var key:String in SoundResources.sounds)
						if (SoundResources.sounds[key] == type.soundPack.attack) 
							res += "\t\t\t" + name + ".soundPack.attack = SoundResources." + key + ";\r\n";
				}
				
				// icon
				if (type.icon)
				{
					for (var key:String in BitmapResources.bitmaps)
						if (BitmapResources.bitmaps[key] == type.icon.bitmapData) 
							res += "\t\t\t" + name + ".icon = new BitmapAsset(BitmapResources." + key + ".bitmapData);\r\n";
				}							
				
																								
				res += "\r\n";
			}
			
			res += "\t\t\tdefineBuildLists(game, typesRepository);\r\n";
			res += "\t\t\tdefineDependencies(game, typesRepository);\r\n";
			res += "\t\t\tdefineUpgradeLists(game, typesRepository);\r\n";
			res += "\t\t}\r\n\r\n";
						
			// build list
			res += "\r\n\t\tpublic function defineBuildLists(game:Game, typesRepository:TypesRepository):void \r\n\t\t{\r\n";
			iter = _game.unitManager.unitTypes.iterator() as HashMapValIterator;
			while (iter.hasNext())
			{
				var type:UnitType = iter.next() as UnitType;
				var name:String = type.name.replace(/[ ())]/gi, "");
				for (var bi:int = 0; bi < type.buildList.length; ++bi)
				{
					if (type.buildList[bi] && !type.buildList[bi].isUpgrade)
						res += "\t\t\t" + name + ".buildList.push(" + type.buildList[bi].name.replace(/ /gi, "") + ");\r\n";	
				}
			}
			res += "\t\t}\r\n\r\n";
			
			
			// dependencies	
			res += "\r\n\t\tpublic function defineDependencies(game:Game, typesRepository:TypesRepository):void \r\n\t\t{\r\n";
			iter = _game.unitManager.unitTypes.iterator() as HashMapValIterator;
			while (iter.hasNext())
			{
				var type:UnitType = iter.next() as UnitType;
				var name:String = type.name.replace(/[ ())]/gi, "");
				for (var di:int = 0; di < type.dependencies.length; ++di)
				{
					res += "\t\t\t" + name + ".dependencies.push(" + type.dependencies[di].name.replace(/ /gi, "") + ");\r\n";	
				}
			}
			
			res += "\t\t}\r\n\r\n";
						
			// upgrade list
			res += "\r\n\t\tpublic function defineUpgradeLists(game:Game, typesRepository:TypesRepository):void \r\n\t\t{\r\n";
			iter = _game.unitManager.unitTypes.iterator() as HashMapValIterator;
			while (iter.hasNext())
			{
				var type:UnitType = iter.next() as UnitType;
				var name:String = type.name.replace(/[ ())]/gi, "");
				for (var bi:int = 0; bi < type.buildList.length; ++bi)
				{
					if (type.buildList[bi] && type.buildList[bi].isUpgrade)
					{
						var toType:UnitType = !(type.buildList[bi] is UnitTypeUpgrade) ? type.buildList[bi] : UnitTypeUpgrade(type.buildList[bi]).toType;
						var upgradeName:String;
						upgradeName = (name + toType.name + "Upgrade" + bi.toString()).replace(/[ ())]/gi, "");
						res += "\t\t\tvar " + upgradeName + ":UnitTypeUpgrade = new UnitTypeUpgrade();\r\n";
						res += "\t\t\t" + upgradeName + ".toType = " + toType.name.replace(/[ ())]/gi, "") + ";\r\n";
						res += "\t\t\t" + upgradeName + ".name = \"" + toType.name + " Upgrade\";\r\n";
						res += "\t\t\t" + upgradeName + ".description = \"" + toType.description + "\";\r\n";
						res += "\t\t\t" + upgradeName + ".constructionTime = " + toType.constructionTime + ";\r\n";	
						res += "\t\t\t" + upgradeName + ".costResources[ResourceType.Crystal] = " + toType.costResources[ResourceType.Crystal].toString() + ";\r\n";				
						res += "\t\t\t" + upgradeName + ".costResources[ResourceType.Gold] = " + toType.costResources[ResourceType.Gold].toString() + ";\r\n";													
						res += "\t\t\t" + upgradeName + ".icon = " + toType.name.replace(/[ ())]/gi, "") + ".icon;\r\n";							
						res += "\t\t\t" + name + ".buildList.push(" + upgradeName + ");\r\n\r\n";
					}	
				}
			}
			
			res += "\t\t}\r\n\r\n";			
			
			res += "\t}";
			
			return res;
		}
	}
}