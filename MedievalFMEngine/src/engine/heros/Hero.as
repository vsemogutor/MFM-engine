package engine.heros
{
	import __AS3__.vec.Vector;
	
	import computers.utils.Utils;
	
	import engine.ai.hero.HeroAi;
	import engine.animation.AnimatedSprite;
	import engine.animation.UnitSprite;
	import engine.computers.ExperienceCalculator;
	import engine.core.events.GameEvent;
	import engine.core.events.GameEvents;
	import engine.core.fm_internal;
	import engine.core.isometric.IsoTile;
	import engine.fraction.Fraction;
	import engine.game.Game;
	import engine.game.GameManager;
	import engine.items.InventoryItem;
	import engine.items.InventoryItemType;
	import engine.sound.BuildInSounds;
	import engine.sound.SoundManager;
	import engine.specialEffects.SpecialEffects;
	import engine.spells.Spell;
	import engine.spells.SpellCastType;
	import engine.spells.SpellType;
	import engine.text.Text;
	import engine.units.Unit;
	import engine.units.UnitOrders.UnitOrderCastSpell;
	import engine.units.UnitProperties;
	import engine.units.UnitType;
	import engine.units.support.UnitSpellItem;
	import engine.util.Constants;
	import engine.util.TileUtil;
	import engine.util.Util;
	
	import flash.utils.Dictionary;
	
	use namespace fm_internal;
			
	public final class Hero extends Unit
	{		
		private var _experience:int;
		private var _level:int = 1;
		private var _skillPoints:int = 1;
		private var _equippedItems:Vector.<InventoryItem> = new Vector.<InventoryItem>(InventoryItemType.COUNT);
		private var _skills:Dictionary = new Dictionary();
		private var _spells:Vector.<SpellType> = new Vector.<SpellType>();
		private var _ai:HeroAi;
		private var _thinkInterval:int;
		private var _itemsLastUseTime:Dictionary = new Dictionary();
		public var heroProperties:Vector.<int>;
		
		private var _momento:Object = new Object();
		
		public function get equippedItems():Vector.<InventoryItem>{
			return _equippedItems;
		}
	
		public function get skills():Dictionary{
			return _skills;
		}
	
		public function get spells():Vector.<SpellType>{
			return _spells;
		}	
		
		public function get experience():int{
			return _experience;
		}	
	
		public function get skillPoints():int{
			return _skillPoints;
		}	

		public function set skillPoints(value:int):void{
			_skillPoints = value;
		}
		
		public function get level():int{
			return _level;
		}	

		public function get ai():HeroAi{
			return _ai;
		}
								
		public function Hero(type:UnitType, fraction:Fraction)
		{
			super(type, fraction);
			heroProperties = type.properties.concat();
			calculateProperties();	
			_thinkInterval = Utils.rand(2, Constants.AI_HERO_THIINK_INTERVAL);	
		}
		
		public override function castSpell(target:*, spellType:SpellType):void
		{
			if (!hasSpell(spellType))
				return;
			
			setOrder(new UnitOrderCastSpell(this, target, spellType));
		}
		
		public override function setActiveSpell(spellType:SpellType):void
		{
			if (!spellType || (hasSpell(spellType) && spellType.autocastType))
				_activeSpell = spellType;
		}
		
		protected override function getAttackRating(target:Unit):Number
		{
			// close and low heath units are better targets
			// if attacks me - also better target
			if (_ai)
			{
				return (int(target.order.target == this)*2) - (TileUtil.getTileDist(_tile, target._tile)/2) 
					- (target.properties[UnitProperties.Health]/properties[UnitProperties.AttackDmgMax])/2 + (target is Hero ? this._level * 10 : 0)
					- (target.summoner ? 10 : 0);
			} 	
			else
			{
				return (int(target.order.target == this)) - (TileUtil.getTileDist(_tile, target._tile)/2);
			}
		}
		
		public function calculatePropertiesBasedOnStats():void
		{
			for (var i:int = UnitProperties.SpellBonus; i < UnitProperties.Count; ++i)
			{
				baseProperties[i] = heroProperties[i];
			}	
												
			properties[HeroProperties.Stength] = baseProperties[HeroProperties.Stength];
			properties[HeroProperties.Agility] = baseProperties[HeroProperties.Agility];			
			properties[HeroProperties.Intellect] = baseProperties[HeroProperties.Intellect];
						
			applyItems(true);
			
			var strength:int = properties[HeroProperties.Stength];
			baseProperties[UnitProperties.MaxHealth] = heroProperties[UnitProperties.MaxHealth] + strength * 25;
			baseProperties[UnitProperties.HealthRegen] = heroProperties[UnitProperties.HealthRegen] + strength*0.09;
				
			var intellect:int = properties[HeroProperties.Intellect];
			baseProperties[UnitProperties.MaxMana] = heroProperties[UnitProperties.MaxMana] + intellect * 15;
			baseProperties[UnitProperties.ManaRegen] = heroProperties[UnitProperties.ManaRegen] + intellect*0.158;
						
			var agility:int = properties[HeroProperties.Agility];
			baseProperties[UnitProperties.Armor] = heroProperties[UnitProperties.Armor] + agility * 0.3;
			baseProperties[UnitProperties.AttackDelay] = heroProperties[UnitProperties.AttackDelay] - agility * 0.02;
			baseProperties[UnitProperties.AttackSpeed] = heroProperties[UnitProperties.AttackSpeed] - agility * 0.02;
			
			baseProperties[UnitProperties.AttackDmgMin] = heroProperties[UnitProperties.AttackDmgMin] + properties[type.primaryProperty];
			baseProperties[UnitProperties.AttackDmgMax] = heroProperties[UnitProperties.AttackDmgMax] + properties[type.primaryProperty];
		}
		
		public function applyItems(attributeChangers:Boolean):void
		{
			for (var i:int = 0; i < _equippedItems.length; ++i)
			{
				if (_equippedItems[i])
					_equippedItems[i].applyFiltered(this, attributeChangers);
			}
		}
		
		public function levelUp(numOfLevels:int = 1):void
		{
			_experience = 0;
			_level += numOfLevels;
			_skillPoints += numOfLevels;
			heroProperties[HeroProperties.Stength] += type.strengthPerLevel*numOfLevels;
			heroProperties[HeroProperties.Agility] += type.agilityPerLevel*numOfLevels;			
			heroProperties[HeroProperties.Intellect] += type.intellectPerLevel*numOfLevels;
			
			changeProp(UnitProperties.Health, 100);
			changeProp(UnitProperties.Mana, 100);
						
			Game.instance().eventManager.dispatch(new GameEvent(GameEvents.HERO_LEVEL_UP, {unit:this}));
			Game.instance().effectManager.addEffectByTypeId(SpecialEffects.LevelUp, this.physicalCenter, 0, this);
			
			if (fraction.isCurrentPlayer())
			{
				GameManager.instance().showWarning(name + " level up!");
				SoundManager.instance().playBuildInSound(BuildInSounds.LEVEL_UP);
			}
		}
		
		public function addExperience(exp:int):void
		{
			_experience += exp;
			if (ExperienceCalculator.canLevelUp(_level, _experience))
				levelUp();
		}
		
		public override function getSpellList():Vector.<UnitSpellItem>
		{
			var list:Vector.<UnitSpellItem> = new Vector.<UnitSpellItem>();
			var len:int = _spells.length;
			var gt:int = Game.instance().gameTime.value;
			var readyToCast:Boolean = (gt - lastCastTime >= properties[UnitProperties.CastDelay]);
			var canCast:Boolean = this.properties[UnitProperties.CastDelay] < Spell.MAX_CAST_DELAY;
			
			for (var i:int = 0; i < len; ++i)
			{	
				var spType:SpellType = _spells[i];
				var spLastCastTime:int = getSpellLastCastTime(spType);
				var cooldown:int = spLastCastTime + spType.cooldown - gt;
				if (cooldown < 0) cooldown = 0;
				var spellReadyToCast:Boolean = (cooldown <= 0) && (canCast || spType.cost == 0) && (!spType.canCastOnlyIfNotVisible || !visible);
				list.push( new UnitSpellItem(spType, readyToCast && spellReadyToCast && spType.validateCost(this), spType == activeSpell, cooldown));
			}
			
			return list;
		}
		
		public override function hasItem(item:InventoryItem):Boolean
		{
			return super.hasItem(item) || _equippedItems.indexOf(item) != -1;
		}
		
		public override function removeItem(item:InventoryItem, onlyNotEquiped:Boolean = false):void
		{
			super.removeItem(item);
			
			if (!onlyNotEquiped)
			{
				if (_equippedItems[item.type] == item)
					_equippedItems[item.type] == null;
			}
		}	
		
		public function equipItem(item:InventoryItem):Boolean
		{
			// check if could be equipped
			if (item.type == InventoryItemType.NONE)
				return false;
				
			// check if already equipped
			if (_equippedItems[item.type] == item)
				return false;
				
			// check if has item
			if (!hasItem(item))
				return false;
			
			if (item.requiredSpecialization && !this.isSpecializedInto(item.requiredSpecialization))
				return false;
			
			removeItem(item, true);
			if (_equippedItems[item.type] != null)
			{
				unEquipItem(_equippedItems[item.type]);
			}

			_equippedItems[item.type] = item;
			Game.instance().eventManager.dispatch(new GameEvent(GameEvents.HERO_ITEM_EQUIPED, {unit:this, item:item}));
			
			return true;
		}	
		
		public function unEquipItem(item:InventoryItem):void
		{
			// check if equipped
			if (_equippedItems[item.type] == item)
			{
				item.cleanUp(this);
				_equippedItems[item.type] = null;
				addItem(item);
			}
		}	
		
		public function useItem(item:InventoryItem):void
		{
			if (item.type == InventoryItemType.USABLE || item.type == InventoryItemType.USABLE_IMMEDIATE
				&& canUseItem(item))
			{
				item.apply(this);
				Game.instance().effectManager.addEffectByTypeId(SpecialEffects.ItemUsed, this.physicalCenter, 0, this);
				if (fraction.isCurrentPlayer()) SoundManager.instance().playBuildInSound(BuildInSounds.USE_ITEM);
				removeItem(item);
				_itemsLastUseTime[item.id] = Game.instance().gameTime.value;
				
				if (this.fraction.isCurrentPlayer())
				{
					Game.instance().textManager.addTextOnUnit(this, new Text(item.name, Util.secToFrames(1.2)));
				}
			}
		}			
		
		public function backUpProperties():void
		{
			_momento.properties = properties.concat();
			_momento.baseProperties = baseProperties.concat();			
		}
		
		public function restoreProperties():void
		{
			if (_momento.properties)
				Utils.copyVector(_momento.properties, this.properties);
				
			if (_momento.baseProperties)
				Utils.copyVector(_momento.baseProperties, this.baseProperties);				
		}
		
		/**
		 * Use this ONLY with combination of backUpProperties() and restoreProperties(),
		 * otherwise you can corrupt unit state! 
		 * This method helps to get hero actual state outside of the main game loop.
		 */
		public function calculateProperties():void
		{		
			this.calculatePropertiesBasedOnStats();
			Utils.copyVector(this.baseProperties, this.properties);	
			this.applyItems(false);			
			this.applySpells();
		}
		
		public function hasSkill(skill:Skill):Boolean
		{
			return getSkillLevel(skill) > 0;
		}
		
		public function getSkillLevel(skill:Skill):int
		{
			return _skills[skill] || 0;
		}
		
		public function addSkill(skill:Skill, tradeForSkillPoint:Boolean = true):Boolean	
		{
			if (_skillPoints > 0 || !tradeForSkillPoint)
			{
				var nextLevel:int = getSkillLevel(skill) + 1;
				
				if (!skill.isAvaliable(this, nextLevel))
					return false;
				
				skill.apply(this, nextLevel);
				_skills[skill] = nextLevel;
				
				if (tradeForSkillPoint) _skillPoints--;
				
				Game.instance().eventManager.dispatch(new GameEvent(GameEvents.HERO_GAIN_SKILL, {unit:this, skill:skill}));
				return true;				
			}
			
			return false;
		}
		
		public function setAi(ai:HeroAi):void
		{
			_ai = ai;
		}
		
		public function processAi():void
		{
			if (_ai && (--_thinkInterval <= 0))
			{
				_ai.execute();
				_thinkInterval = Constants.AI_HERO_THIINK_INTERVAL;
			}
		}
		
		public function addSpell(spell:SpellType, indx:int = -1):void
		{
			if (!hasSpell(spell))
			{
				if (spell.castType == SpellCastType.Aura)
				{
					auraSpell = spell;
				}
				else if (indx < 0)
				{
					_spells.push(spell);					
				}
				else
				{
					_spells.splice(indx, 0, spell);
				}
			}
		}
		
		public function removeSpell(spell:SpellType):int
		{
			var indx:int = _spells.indexOf(spell);
			if (indx >= 0)
				_spells.splice(indx, 1);
				
			if (auraSpell == spell)
				auraSpell = null;
				
			return indx;	
		}

		public function hasSpell(spell:SpellType):Boolean		
		{
			return _spells.indexOf(spell) >= 0;
		}
		
		protected function setItemLastUseTime(item:InventoryItem, time:int):void
		{
			_itemsLastUseTime[item.id] = time;
		}
		
		protected function getItemLastUseTime(item:InventoryItem):int
		{
			return int(_itemsLastUseTime[item.id] || int.MIN_VALUE);			
		}
		
		public function canUseItem(item:InventoryItem):Boolean
		{
			return getItemLastUseTime(item) + item.cooldown <= Game.instance().gameTime.value
					&& this.properties[UnitProperties.CanMove];
		}	
		
		public override function setModel(model:AnimatedSprite):void 
		{
			var key:String = model.name + "_" + fraction.color;
			var uModel:UnitSprite = Game.instance().spriteRepository.getByName(key) as UnitSprite;
			if (!uModel)
			{
				uModel = Game.instance().spriteRepository.addGlowUnitSprite(key, model as UnitSprite, fraction.color, 0.4, 8);
			}
			
			super.setModel(uModel.clone());
		}	
		
		public override function setTile(tile:IsoTile):Boolean
		{
			var res:Boolean	= super.setTile(tile);
			
			if (res && tile)
			{
				tile.transferItems(this);
			}
			
			return res;
		}
		
		public function isSpecializedInto(branch:SkillBranch):Boolean
		{
			var points:int = 0;
			var skills:Vector.<Skill> = branch.skills;
			for (var i:int = 0; i < skills.length; ++i)
			{
				points += getSkillLevel(skills[i]);
			}
			
			return points >= 9;
		}					
	}
}