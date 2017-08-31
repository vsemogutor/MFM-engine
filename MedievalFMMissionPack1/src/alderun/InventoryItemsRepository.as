package alderun
{
	import engine.ai.ItemAiHintType;
	import engine.core.GameTime;
	import engine.game.Game;
	import engine.heros.HeroProperties;
	import engine.items.InventoryItem;
	import engine.items.InventoryItemEffect;
	import engine.items.InventoryItemEffectAddSpell;
	import engine.items.InventoryItemEffectChangeHeroAttribute;
	import engine.items.InventoryItemEffectGold;
	import engine.items.InventoryItemEffectPermament;
	import engine.items.InventoryItemType;
	import engine.spells.SpellEffectCastSpell;
	import engine.units.UnitProperties;
	import engine.util.BitmapTransformer;
	
	import mx.core.BitmapAsset;
	
	import resources.BitmapResources;
	
	public final class InventoryItemsRepository
	{
		private var game:Game;
		private var _typesRepository:TypesRepository;
																	
		public function init(game:Game, typesRepository:TypesRepository):void
		{
			this.game = game;
			this._typesRepository = typesRepository;


		}

	}
}