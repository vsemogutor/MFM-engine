package engine.mission
{
	import engine.computers.ExperienceCalculator;
	import engine.core.fm_internal;
	import engine.game.Game;
	import engine.localization.Localization;
	import engine.tileset.Tileset;
	
	import flash.display.BitmapData;
	use namespace fm_internal;
		
	public class Mission
	{
		protected var _name:String;
		protected var _tilesetName:String = "";
		protected var _description:String = "";
		protected var _type:String = "";
		protected var _enabled:Boolean = true;
		protected var _tileset:Tileset = new Tileset();	
		protected var _stateBag:Object = new Object();		
		protected var game:Game;
		protected var _playerTeams:Array = new Array();	
		protected var _expGainRate:Number;	
		
		public function get mapXml():XML{
			throw new Error("Must implement");
		}
		
		public function get tilesetBitmap():BitmapData{
			throw new Error("Must implement");
		}
		
		public function get localization():Localization{
			throw new Error("Must implement");
		}
		
		public function get enabled():Boolean{
			return _enabled;
		}	

		public function get stateBag():Object{
			return _stateBag;
		}
				
		public function get name():String{
			return _name;
		}
		
		public function get description():String{
			return _description;
		}
		
		public function get tilesetName():String{
			return _tilesetName;
		}	

		public function get type():String{
			return _type;
		}		
		
		public function get tileset():Tileset{
			return _tileset;
		}		

		public function get playerTeams():Array{
			return _playerTeams;
		}

		public function get expGainRate():Number{
			return _expGainRate;
		}

		public function set expGainRate(value:Number):void{
			_expGainRate = value;
		}
								
		internal final function init(game:Game):void
		{
			this.game = game;
			game.localizationManager.setLocalization(localization);
		}
		
		public final function getDefinedType(name:String, type:String=null):Object
		{
			return null;
		}

		internal final function beforeWorldInitInternal():void
		{			
			defineTileTypes();
			defineVisualEffectsTypes();
			defineObjectTypes();
			defineFractions();
			defineUnitTypes();
			defineSpellTypes();
			defineUnitSpells();
			defineUpgradeTypes();
			defineUnitBuildList();
			defineAreas();
			defineSkillTree();
			defineInventoryItems();
			
			beforeWorldInit();
		}
				
		public function beforeWorldInit():void
		{
		}
		
		public function afterWorldInit():void
		{
		}
		
		internal function afterWorldInitInternal():void
		{
			ExperienceCalculator.setExpGainRate(_expGainRate);
			addTimers();
			addTriggers();
			addQuests();
			
			if (!stateBag.editor) afterWorldInit();
		}
		
		public function defineTileTypes():void
		{
		}

		public function defineFractions():void
		{
		}
		
		public function defineObjectTypes():void
		{
		}
				
		public function defineVisualEffectsTypes():void
		{
		}

		public function defineSpellTypes():void
		{
		}
	
		public function defineUnitTypes():void
		{
		}
		
		public function defineUnitSpells():void
		{
		}
	
		public function defineUpgradeTypes():void
		{
		}
	
		public function defineUnitBuildList():void
		{
		}
		
		public function defineAreas():void
		{
		}
		
		public function unitSpells():void
		{
		}
		
		public function defineInventoryItems():void
		{
		}
		
		public function defineSkillTree():void
		{
		}

		public function addTriggers():void
		{
		}
		
		public function addTimers():void
		{
		}

		public function addQuests():void
		{
		}
											
		public function beforeStart():void
		{
		}
	}
}