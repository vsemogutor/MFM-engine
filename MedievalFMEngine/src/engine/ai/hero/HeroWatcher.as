package engine.ai.hero
{
	import __AS3__.vec.Vector;
	
	import engine.ai.AiHintType;
	import engine.core.events.GameEvent;
	import engine.core.events.GameEvents;
	import engine.game.Game;
	import engine.heros.Hero;
	import engine.items.InventoryItem;
	import engine.spells.SpellEffectBase;
	import engine.spells.SpellEffectSummon;
	import engine.spells.SpellType;
	import engine.units.support.UnitSpellItem;
	
	public class HeroWatcher
	{
		private var _spellsMap:Vector.<Array> = new Vector.<Array>(AiHintType.Count);
		private var _itemsMap:Vector.<Array> = new Vector.<Array>(AiHintType.Count);
		public var hasHealingSpells:Boolean = false;
				
		private var _hero:Hero;
		
		public function HeroWatcher(hero:Hero)
		{
			_hero = hero;
							
			initSpellMap();
			initItemsMap();
			
			Game.instance().eventManager.addEventListener(GameEvents.HERO_GAIN_SKILL, onSkillGained, false, 0, true);
			Game.instance().eventManager.addEventListener(GameEvents.UNIT_GAIN_ITEM, onItemGainedLost, false, 0, true);
			Game.instance().eventManager.addEventListener(GameEvents.UNIT_LOST_ITEM, onItemGainedLost, false, 0, true);					
		}
		
		public function hasAvaliableSpells():Boolean
		{
			var spells:Vector.<UnitSpellItem> = _hero.getSpellList();
			var len:int = spells.length;
			
			for (var i:int = 0; i < len; ++i)
			{
				if (spells[i].avaliable) return true;
			}
			
			return false;
		}
		
		public function getSpellsByAiType(aiType:int, onlyActive:Boolean = true):Array
		{
			if (onlyActive) 
			{
				var spells:Array = _spellsMap[aiType];
				var list:Array = new Array();
				var len:int = spells.length;
				
				for (var i:int = 0; i < len; ++i)
				{	
					var spType:SpellType = spells[i];
					if (spType.validateCost(_hero) && _hero.isReadyToCast(spType))
					{
						if (spType.effects.length)
						{
							var effect:SpellEffectBase = spType.effects[0];
							if (effect is SpellEffectSummon)
							{
								if (!SpellEffectSummon(effect).checkSummonLimit(_hero))
									continue;
							}
						}
			
						list.push(spType);
					}
				}
				
				return list;				
			}
			else
			{
				return _spellsMap[aiType];
			}
		}
		
		public function getItemsByAiType(aiType:int):Array
		{
			var items:Array = _itemsMap[aiType];
			var list:Array = new Array();
			var len:int = items.length;
			
			for (var i:int = 0; i < len; ++i)
			{	
				var itm:InventoryItem = items[i];
				if (_hero.canUseItem(itm))
				{
					list.push(itm);
				}
			}
			
			return list;
		}
				
		private function initSpellMap():void
		{
			for (var i:int = 0; i < AiHintType.Count; ++i)
			{
				_spellsMap[i] = new Array();
			}
			
			var len:int = _hero.spells.length;
			
			for (var i:int = 0; i < len; ++i)
			{	
				var spType:SpellType = _hero.spells[i];
				if (spType.aiHint)
				{
					_spellsMap[spType.aiHint].push(spType);
				}
			}			
		}

		private function initItemsMap():void
		{
			for (var i:int = 0; i < AiHintType.Count; ++i)
			{
				_itemsMap[i] = new Array();
			}	
			
			var len:int = _hero.items.length;
			
			for (var i:int = 0; i < len; ++i)
			{	
				var item:InventoryItem = _hero.items[i];
				if (item.aiHint)
				{
					_itemsMap[item.aiHint].push(item);
					
					if (item.aiHint == AiHintType.Heal)
						hasHealingSpells = true;
				}
			}		
		}
		
		private function onSkillGained(ev:GameEvent):void
		{
			if (ev.properties.unit == _hero)
				initSpellMap();
		}
		
		private function onItemGainedLost(ev:GameEvent):void
		{
			if (ev.properties.unit == _hero)
				initItemsMap();
		}
	}
}