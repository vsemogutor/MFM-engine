package engine.units
{
	import __AS3__.vec.Vector;
	
	import engine.animation.UnitSprite;
	import engine.core.IdManager;
	import engine.fraction.Fraction;
	import engine.fraction.ResourceType;
	import engine.heros.HeroProperties;
	import engine.localization.Localizable;
	import engine.projectile.ProjectileBehaviour;
	import engine.sound.UnitSoundPack;
	import engine.spells.SpellType;
	import engine.units.upgrade.*;
	import engine.util.Constants;
	import engine.util.Util;
	
	import mx.core.BitmapAsset;
	
	public class UnitType extends Localizable
	{
		private static var _copyId:int = 0;
		
		public var properties:Vector.<int> = new Vector.<int>(UnitProperties.Count);
		public var dependencies:Vector.<UnitType> = new Vector.<UnitType>();
		public var buildList:Vector.<UnitType> = new Vector.<UnitType>();
		public var spellList:Vector.<SpellType> = new Vector.<SpellType>();
		public var costResources:Vector.<int> = new Vector.<int>(ResourceType.Count);
		public var activeSpell:SpellType;
		public var name:String;
		private var _locName:String;		
		public var description:String;
		public var model:UnitSprite;
		public var id:int = Constants.UNDEFINED;
		public var isUpgrade:Boolean;
		public var type:int = UnitTypes.Unit;
		public var constructionTime:int =  1;
		public var bountyResources:Vector.<int> = new Vector.<int>(ResourceType.Population);
		public var soundPack:UnitSoundPack = new UnitSoundPack();
		public var icon:BitmapAsset;
		public var isFlying:Boolean;
		public var isTrader:Boolean;
		public var level:int = 0;
		public var primaryProperty:int = HeroProperties.Stength;
		public var agilityPerLevel:int = 1;
		public var strengthPerLevel:int = 1;
		public var intellectPerLevel:int = 1;
		public var heroNames:Array = ["none"];
		public var canRepair:Boolean = false;
														
		public var xLength:int = 1;
		public var yLength:int = 1;
		
		public function get locName():String {
			return _locName;
		}
		
		public function set locName(value:String):void {
			_locName = value;
		}
				
		public function UnitType(setDefaults:Boolean=false)
		{
			if (setDefaults)
				this.setDefaults();
		}
		
		public function getBuildList(upgrades:Boolean):Vector.<UnitType>
		{
			var list:Vector.<UnitType> = new Vector.<UnitType>();
			for (var i:int = 0; i < buildList.length; ++i)
			{
				if (buildList[i].isUpgrade == upgrades)
					list.push(buildList[i]);
			}
			
			return list;
		}
		
		public function validateCost(fraction:Fraction):Boolean
		{
			var len:int = ResourceType.PopulationProduction;
			for (var i:int = 0; i < len; ++i)
			{
				if (fraction.getResource(i) < costResources[i])
					return false;
			}
			
			return true;
		}
		
		public function validatePopulationCost(fraction:Fraction):Boolean
		{
			return fraction.getResource(ResourceType.PopulationProduction) >= costResources[ResourceType.Population];
		}
		
		public function subtractCost(fraction:Fraction, reverse:Boolean=false):void
		{
			for (var i:int = 0; i < ResourceType.PopulationProduction; ++i)
				fraction.addResource(i, reverse ?  costResources[i] : -costResources[i]);
		}
		
		public function setCost(gold:int, crystals:int=0, population:int=0):void
		{
			costResources[ResourceType.Gold] = gold;
			costResources[ResourceType.Crystal] = crystals;
			costResources[ResourceType.Population] = population;						
		}		
		
		public function checkDependencies(fraction:Fraction):Boolean
		{
			return fraction.checkDependenceies(dependencies);
		}
		
		public function hasSpell(type:SpellType):Boolean
		{
			return spellList.indexOf(type) != -1;
		}
		
		public function canBuild():Boolean
		{
			return buildList.length > 0;
		}
			
		public function canMove():Boolean
		{
			return type != UnitTypes.Structure && properties[UnitProperties.CanMove];
		}

		public function canAttack():Boolean
		{
			return properties[UnitProperties.AttackRange] > 0;
		}
		
		public function canLink():Boolean
		{
			return false; //properties[UnitProperties.CanLink] != 0;
		}
		
		public function setDefaults():void
		{
			var frame:int = Util.secToFrames(1);
			var halfFrame:int = frame/2;
			
			properties[UnitProperties.MoveSpeed] = frame + halfFrame;
			properties[UnitProperties.Health] = 1;
			properties[UnitProperties.AttackRange] = 1;
			properties[UnitProperties.AttackSpeed] = halfFrame;
			properties[UnitProperties.AttackDmgMin] = 1;	
			properties[UnitProperties.AttackDmgMax] = 1;		
			properties[UnitProperties.ProjectileSpeed] = halfFrame;	
			properties[UnitProperties.ProjectileBehaviour] = ProjectileBehaviour.SNAP_TO_TARGET;	
			properties[UnitProperties.AttackDelay] = frame<<1;
			properties[UnitProperties.MaxHealth] = 1;
			properties[UnitProperties.CastDelay] = frame<<1;
			properties[UnitProperties.CastSpeed] = halfFrame;	
			properties[UnitProperties.CanMove] = Constants.TRUE;
			properties[HeroProperties.Stength] = 1;
			prototype[UnitProperties.MoveAnimSpeed] = properties[UnitProperties.MoveSpeed]*4;
		}
				
		public function getAutocastSpells():Array
		{
			var spells:Array = [];
			for (var i:int = 0; i < spellList.length; ++i)
			{
				if (spellList[i].autocastType)
					spells.push(spellList[i]);
			}
			
			return spells;
		}	
		
		public function clone():UnitType
		{
			var newType:UnitType = new UnitType(false);
			newType.activeSpell = activeSpell;
			newType.bountyResources = bountyResources.concat();
			newType.buildList = buildList.concat();
			newType.constructionTime = constructionTime;
			newType.costResources = costResources.concat();
			newType.dependencies = dependencies.concat();
			newType.description = description;
			newType.icon = icon;
			newType.isUpgrade = isUpgrade;
			newType.name = name + "Copy" + (_copyId++).toString();
			newType.model = model;
			newType.properties = properties.concat();
			newType.soundPack = soundPack;
			newType.spellList = spellList.concat();
			newType.type = type;
			newType.xLength = xLength;
			newType.yLength = yLength;
			newType.id = IdManager.idByName(newType.name);
			
			return newType;
		}	
				
		// validation ------------------------------------------------
		public function validateDefinition():Boolean
		{
			if (xLength <= 0 || yLength <= 0)
				throw new Error("object height or width is incorrect");
				
			if (type < UnitTypes.Unit || type > UnitTypes.Structure)
				throw new Error("unit type is incorrect");

			if (id == Constants.UNDEFINED)
				throw new Error("id is not set");
				
			if (!model || !model is UnitSprite)
				throw new Error("model is not set or incorrect");
				
			if (!name)
				throw new Error("name is not set");
				
			if (!properties || properties.length != UnitProperties.Count)
				throw new Error("properties are not set");
				
			if (constructionTime <= 0)
				throw new Error("Construction time can't be less that 1");
				
			for (var i:int = 0; i < dependencies.length; ++i)
			{
				if (dependencies[i] is UnitTypeUpgrade)
					throw new Error("wrong type dependency:" + dependencies[i].name);
			}
			
			for (var i:int = 0; i < buildList.length; ++i)
			{
				// units can build structures and vice versa
				if (type == buildList[i].type)
					throw new Error("this type can build type:" + dependencies[i].name);
					
				if (this is UnitUpgrade)
					throw new Error("upgrade can't have build list"); 
			}
			
			if (this is UnitUpgrade)
			{
				if (spellList.length > 0)
					throw new Error("upgrade can't have spell list"); 
			}
			
			if (activeSpell && spellList.indexOf(activeSpell) == -1)
				throw new Error("active spell not in spell list"); 
				
			return validateProperties(properties);
		}
		
		public function validateProperties(properties:Vector.<int>):Boolean
		{
			if (properties[UnitProperties.MaxHealth] <= 0)
				throw new Error(getError("max health"));
			
			if (properties[UnitProperties.MaxMana] < 0)
				throw new Error(getError("max mana"));	
		
			if (type == UnitTypes.Unit && properties[UnitProperties.MoveSpeed] <= 0)
				throw new Error(getError("move speed"));	
				
			if (properties[UnitProperties.ProjectileSpeed] < 0)
				throw new Error("projectile speed is incorrect");	
				
			if (properties[UnitProperties.AttackDmgType] < DamageType.Normal || 
				properties[UnitProperties.AttackDmgType] > DamageType.Hero)
				throw new Error(getError("attack type"));	
				
			if (properties[UnitProperties.AttackRange])
			{
				if (properties[UnitProperties.AttackSpeed] <= 0)
					throw new Error(getError("attack speed"));
					
				if (properties[UnitProperties.AttackDelay] <= 0)
					throw new Error(getError("attack delay"));
			}			
										
			return true;
		}
		
		private function getError(propName:String):String
		{
			return propName + " is not set or incorrect for type " + name;
		}
		
		protected override function localize():void
		{
			if (!_locName)
				_locName = locString("U" + name) || name;
			if (!description)
				description = locString("U" + name + "Desc");
		}
	}
}