package alderun
{
	import common.EffectTypesRepository;
	import common.ObjectsRepository;
	
	import engine.localization.Localization;
		
	public class TypesRepository
	{
		private var _fraction:Fractions = new Fractions();
		private var _unitTypes:UnitTypesRepository = new UnitTypesRepository();
		private var _objectsRepository:ObjectsRepository = new ObjectsRepository();
		private var _effectsRepository:EffectTypesRepository = new EffectTypesRepository();
		private var _spellTypesRepository:SpellTypesRepository = new SpellTypesRepository();
		private var _customModelsRepository:CustomModelsRepository = new CustomModelsRepository();
		private var _localization:Localization;
		private var _inventoryItems:InventoryItemsRepository = new InventoryItemsRepository();
		private var _skillTreeRepository:SkillTreeRepository = new SkillTreeRepository();
						
		internal function get loc():Localization {
			return _localization;
		}
		
		internal function get inventoryItems():InventoryItemsRepository {
			return _inventoryItems;
		}
		
		internal function get skillTreeRepository():SkillTreeRepository {
			return _skillTreeRepository;
		}

		internal function set loc(value:Localization):void {
			_localization = value;
		}
				
		internal function get fractions():Fractions {
			return _fraction;
		}
		
		internal function get unitTypes():UnitTypesRepository {
			return _unitTypes;
		}
		
		internal function get customModelsRepository():CustomModelsRepository {
			return _customModelsRepository;
		}
		
		internal function get objectsRepository():ObjectsRepository {
			return _objectsRepository;
		}
		
		internal function get effectTypes():EffectTypesRepository {
			return _effectsRepository;
		}	
		
		internal function get spellTypes():SpellTypesRepository {
			return _spellTypesRepository;
		}		
	}
}