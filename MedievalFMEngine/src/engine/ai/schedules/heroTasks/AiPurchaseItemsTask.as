package engine.ai.schedules.heroTasks
{
	import computers.utils.Utils;
	
	import engine.ai.AiContext;
	import engine.ai.ItemAiHintType;
	import engine.ai.schedules.AiSchedule;
	import engine.ai.schedules.tasks.AiHeroTask;
	import engine.fraction.ResourceType;
	import engine.items.InventoryItem;
	import engine.items.InventoryItemType;
	import engine.units.Unit;

	public class AiPurchaseItemsTask extends AiHeroTask
	{
		public function AiPurchaseItemsTask(schedule:AiSchedule=null)
		{
			super(schedule);
		}
		
		public override function execute(context:AiContext):Boolean
		{
			var store:Unit = context.nearStore as Unit;
			if (store)
			{
				var items:Vector.<InventoryItem> = store.items;
				
				for (var i:int = 0; i < items.length; ++i)
				{
					var item:InventoryItem = items[i];
					if (item.type && item.aiHint && item.goldCost < _hero.fraction.getResource(ResourceType.Gold))
					{
						if (item.type != InventoryItemType.USABLE)
						{
							if (!_hero.equippedItems[item.type]
								|| _hero.equippedItems[item.type].goldCost < item.goldCost)
							{
								_hero.addItem(item);
								store.removeItem(item);
								_hero.fraction.addResource(ResourceType.Gold, -item.goldCost);
							}
						}
						else if (!_hero.hasItem(item))
						{
							if (ItemAiHintType.isPowerUp(item.aiHint))
							{
								if (_hero.level > 3 && _hero.fraction.getResource(ResourceType.Gold) >= 1500)
								{
									var rand:int = Utils.rand(0, 2);
									if (rand == 1)
									{
										_hero.addItem(item);
										store.removeItem(item);
										_hero.fraction.addResource(ResourceType.Gold, -item.goldCost*0.9);										
									}
								}
							}
							else if (_hero.fraction.getResource(ResourceType.Gold) >= 500)
							{
								_hero.addItem(item);
								store.removeItem(item);
								_hero.fraction.addResource(ResourceType.Gold, -item.goldCost);
							}
						}
					}
				}
				
				items = _hero.items;
				for (var i:int = 0; i < items.length; ++i)
				{ 
					if (items[i].type != InventoryItemType.USABLE)
					{
						var item:InventoryItem = items[i];
						_hero.removeItem(item);
						_hero.fraction.addResource(ResourceType.Gold, item.goldCost);
					}
				}
			}
			
			return true;
		}
	}
}