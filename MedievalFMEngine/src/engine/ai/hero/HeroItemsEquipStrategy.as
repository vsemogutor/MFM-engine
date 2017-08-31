package engine.ai.hero
{
	import engine.ai.ItemAiHintType;
	import engine.core.events.GameEvent;
	import engine.core.events.GameEvents;
	import engine.game.Game;
	import engine.heros.Hero;
	import engine.items.InventoryItem;
	import engine.items.InventoryItemType;
	
	public class HeroItemsEquipStrategy
	{
		protected var _hero:Hero;
		private static const POWER_UPS:Array = [ItemAiHintType.PowerUpAgility];
				
		public function HeroItemsEquipStrategy(hero:Hero)
		{
			_hero = hero;
			Game.instance().eventManager.addEventListener(GameEvents.UNIT_GAIN_ITEM, onItemGainedInternal, false, 0, true);			
		}
		
		private function onItemGainedInternal(ev:GameEvent):void
		{
			if (ev.properties.unit == _hero)
			{
				onItemGained(ev.properties.item);
			}
		}

		protected function onItemGained(item:InventoryItem):void
		{
			if (item)
			{
				if (item.type != InventoryItemType.USABLE)
				{
					if (!_hero.equippedItems[item.type]
						|| _hero.equippedItems[item.type].goldCost < item.goldCost)
					{
						_hero.equipItem(item);
					}
				}
				else
				{
					if (ItemAiHintType.isPowerUp(item.aiHint))
					{
						_hero.useItem(item);
					}
				}				
			}
		}		

	}
}