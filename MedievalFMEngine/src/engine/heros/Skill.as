package engine.heros
{
	import __AS3__.vec.Vector;
	
	import engine.localization.Localizable;
	import engine.spells.SpellCastType;
	import engine.spells.SpellType;
	import engine.units.Unit;
	import engine.units.UnitProperties;
	
	import mx.core.BitmapAsset;
	
	public final class Skill extends Localizable
	{
		public var applyToSummon:Boolean;
		protected var _changeProperties:Vector.<int> = new Vector.<int>(UnitProperties.Count);
		protected var _addSpells:Vector.<SpellType> = new Vector.<SpellType>();
		protected var _skillLevels:Vector.<Skill> = new Vector.<Skill>();
		public var dependsOnSkill:Skill;
		public var dependsOnLevel:int;
		public var category:String;		
		private var _icon:BitmapAsset;
		public var name:String;
		public var locName:String;
		public var description:String;
		public var aiHint:int;
		
		public function Skill()
		{
			_skillLevels.push(this);
		}
		
		public function get isAura():Boolean {
			for (var i:int = 0; i < _addSpells.length; ++i)
			{
				if (_addSpells[i].castType == SpellCastType.Aura)
					return true;
			}
			
			return false;
		}
		
		public function get maxLevel():int {
			return _skillLevels.length;
		}
		
		public function get icon():BitmapAsset {
			if (_icon)
				return new BitmapAsset(_icon.bitmapData);
			else
				return null;
		}		
		
		public function set icon(value:BitmapAsset):void {
			_icon = value;
		}
		
		public function get changeProperties():Vector.<int>{
			return _changeProperties;
		}
		
		public function get spellsToAdd():Vector.<SpellType>{
			return _addSpells;
		}
		
		public function get skillLevels():Vector.<Skill>{
			return _skillLevels;
		}
		
		public function addSpells(spells:Array):void
		{
			for (var i:int = 0; i < spells.length; ++i)
			{
				if (_addSpells.indexOf(spells[i]) == -1)
				{
					aiHint = spells[i].aiHint;
					_addSpells.push(spells[i]);
					if (!icon && spells[i].icon)
						icon = new BitmapAsset(spells[i].icon.bitmapData);
				}
			}
		}	
		
		public function addSkillLevels(skills:Array):void
		{
			for (var i:int = 0; i < skills.length; ++i)
			{
				var skill:Skill = skills[i];
				if (!skill.name)
					skill.name = this.name;
					
				if (!skill.icon)
					skill.icon = this.icon;
					
				if (!skill.description)
					skill.description = this.description;
					
				if (!skill.category)
					skill.category = this.category;	
					
				if (!skill.aiHint)
					skill.aiHint = this.aiHint;		
				
				_skillLevels.push(skill);
			}
		}
		
		public function getSkillLevel(hero:Hero):Skill
		{
			var level:int = hero.getSkillLevel(this);
			if (level >= 0 && level - 1 < _skillLevels.length)
				return _skillLevels[level - 1];
			
			return null;
		}	

		public function getNextSkillLevel(hero:Hero):Skill
		{
			var level:int = hero.getSkillLevel(this);
			if (level >= 0 && level < _skillLevels.length)
				return _skillLevels[level];
			
			return _skillLevels[_skillLevels.length - 1];
		}
						
		public function isAvaliable(hero:Hero, skillLevel:int):Boolean
		{			
			if (skillLevel - 1 >= maxLevel)
			{
				return false;
			}

			var skill:Skill = _skillLevels[skillLevel - 1];
						
			if (skill.dependsOnSkill && !hero.hasSkill(dependsOnSkill))
			{
				return false;
			}
			
			if (skill.dependsOnLevel && hero.level < dependsOnLevel)
			{
				return false;
			}
			
			return true;
		}
		
		public function apply(target:Unit, skillLevel:int = 0):void
		{	
			if (target is Hero)
			{
				// skill upgrades hero
				var hero:Hero = target as Hero;
				if (!isAvaliable(hero, skillLevel))
					return;
	
				var skill:Skill = _skillLevels[skillLevel - 1];
								
				var oldIndx:int = cleanUpPreviousLevels(hero);
				
				if (!applyToSummon)
				{
					for (var i:int = 0; i < skill._changeProperties.length; ++i)
					{
						hero.heroProperties[i] += skill._changeProperties[i];
					}
				}
				
				for (var i:int = 0; i < skill._addSpells.length; ++i)
				{
					hero.addSpell(skill._addSpells[i], oldIndx);
				}	
			}
			else if (applyToSummon)
			{
				// skill upgrades some other units (usually summons)
				if (skillLevel >= 0 && (skillLevel - 1) < _skillLevels.length)
				{
					var skill:Skill = _skillLevels[skillLevel - 1];
					for (var i:int = 0; i < skill._changeProperties.length; ++i)
					{
						target.baseProperties[i] += skill._changeProperties[i];
					}	
				}			
			}
		}
		
		private function cleanUpPreviousLevels(hero:Hero):int
		{
			var indx:int = -1;
			var spIndx:int = - 1;
			
			for (var i:int = 0; i < _addSpells.length; ++i)
			{
				spIndx = hero.removeSpell(_addSpells[i]);
				if (spIndx >= 0) indx = spIndx;
			}
			
			for (var i:int = 0; i < _skillLevels.length; ++i)
			{
				for (var j:int = 0; j < _skillLevels[i]._addSpells.length; ++j)
				{
					spIndx = hero.removeSpell(_skillLevels[i]._addSpells[j]);
					if (spIndx >= 0) indx = spIndx;
				}					
			}
			
			return indx;			
		}
		
		public function getTooltipDescription():String
		{
			var desc:String = "";
			if (description) 
			 	desc = description;
			
			if (_addSpells.length)
			{
				for (var i:int = 0; i < _addSpells.length; ++i)
				{
					if (i > 0 && desc) desc += "\r\n"
					desc += _addSpells[i].getDescription();
				}
			}
			else
			{
				desc += "\r\nPassive.";
			}
			
			var prop:int = 0;
			for (var i:int = 0; i < _changeProperties.length; ++i) 
			{
				if (_changeProperties[i])
				{
					desc = desc.replace("{" + prop  + "}", _changeProperties[i]);
					prop++;
				}
			}
			
			return desc;
		}
		
		protected override function localize():void
		{
			if (!locName)
				locName = locString(name) || name;
			if (!description)
				description = locString(name + "Desc");
		}		
	}
}