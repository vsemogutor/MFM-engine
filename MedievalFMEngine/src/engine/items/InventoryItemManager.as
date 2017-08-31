package engine.items
{
	import de.polygonal.ds.HashMap;
	
	import engine.core.ManagerBase;
	import engine.util.Constants;
	import engine.util.Util;
	
	import flash.net.registerClassAlias;
	
	public final class InventoryItemManager extends ManagerBase
	{
		private var _itemTypes:HashMap = new HashMap(); 
		
		public function get itemTypes():HashMap{
			return _itemTypes;
		}
		
		public function InventoryItemManager()
		{
			super();
			registerClassAlias(Util.getClassAlias(InventoryItem), InventoryItem);
		}
		
		public function getItemsArray():Array
		{
			return itemTypes.toValSet().toArray();
		}
		
		public function getItemsByType(type:int):Array
		{
			var array:Array =  itemTypes.toValSet().toArray();
			var res:Array = [];
			
			for (var i:int = 0; i < array.length; ++i)
			{
				if (array[i].type == type) res.push(array[i]);
			}
			
			return res;
		}	
		
		public function getItemsByCost(minCost:int, maxCost:int = int.MAX_VALUE):Array
		{
			var array:Array =  itemTypes.toValSet().toArray();
			var res:Array = [];
			
			for (var i:int = 0; i < array.length; ++i)
			{
				if (array[i].goldCost >= minCost && array[i].goldCost < maxCost) res.push(array[i]);
			}
			
			return res;
		}			

		public function addItemType(item:InventoryItem, id:int = -1):int
		{
			if (id != Constants.UNDEFINED)
				item.id = id;
			else if (item.id == Constants.UNDEFINED)
				item.id = idManager.idByName(item.name);
			
			_itemTypes.set(item.id, item);
			
			return item.id;
		}
		
		public function getItemTypeById(id:int):InventoryItem
		{
			return InventoryItem(_itemTypes.get(id)).clone();
		}
		
		public function getItemTypeByName(name:String):InventoryItem
		{
			return getItemTypeById(idManager.idByName(name));
		}
	}
}