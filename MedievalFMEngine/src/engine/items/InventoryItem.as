package engine.items
{
	import __AS3__.vec.Vector;
	
	import engine.animation.AnimatedSprite;
	import engine.heros.Hero;
	import engine.heros.SkillBranch;
	import engine.spells.SpellEffectBase;
	import engine.util.Constants;
	import engine.util.Util;
	
	import mx.core.BitmapAsset;
	
	public final class InventoryItem
	{
		public var name:String;
		private var _description:String;
		public var type:int;
		public var id:int = Constants.UNDEFINED;		
		public var goldCost:int;
		private var _icon:BitmapAsset;
		public var model:AnimatedSprite;		
		private var _effects:Vector.<SpellEffectBase> = new Vector.<SpellEffectBase>();
		public var aiHint:int;
		public var cooldown:int;
		public var dropChance:int = 0;
		public var requiredSpecialization:SkillBranch;
				
		public function set description(value:String):void {
			_description = value;
		}
		
		public function get description():String {
			var res:String = _description || "";
			for (var i:int = 0; i < _effects.length; ++i)
				if (_effects[i] is InventoryItemEffect)
					res = res.replace("{" + i  +"}", InventoryItemEffect(_effects[i]).change);
					
			if (cooldown)
				res += "\r\nCooldown: " + Util.framesToSec(cooldown) + " sec.";	
				
			if (type == InventoryItemType.USABLE)
				res += "\r\nDrag on hero to use."
				
			if (requiredSpecialization)
			{
				res += "\r\n*Can only be used by Heroes with '" + requiredSpecialization.name + "' specialization.";
			}
					
			return res;
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
						
		public function get effects():Vector.<SpellEffectBase>{
			return _effects;
		}
		
		public function apply(hero:Hero):void
		{
			for (var i:int = 0; i < _effects.length; ++i)
			{
				_effects[i].apply(hero);
			}			
		}
		
		public function applyFiltered(hero:Hero, attributeChangers:Boolean):void
		{
			if (attributeChangers)
			{
				for (var i:int = 0; i < _effects.length; ++i)
				{
					if (_effects[i] is InventoryItemEffectChangeHeroAttribute)
							_effects[i].apply(hero);
				}	
			}
			else
			{
				for (var i:int = 0; i < _effects.length; ++i)
				{
					//if (!(_effects[i] is InventoryItemEffectChangeHeroAttribute))
					_effects[i].apply(hero);
				}				
			}	
		}		

		public function cleanUp(hero:Hero):void
		{
			for (var i:int = 0; i < _effects.length; ++i)
			{
				_effects[i].cleanup(hero);
			}			
		}
				
		public function clone():InventoryItem
		{
			var item:InventoryItem = new InventoryItem();
			item.id = this.id;
			item.icon = this.icon;
			item.type = this.type;
			item.goldCost = this.goldCost;
			item.description = this._description;
			item.name = this.name;
			item._effects = this._effects;
			item.model = this.model.clone();
			item.dropChance = this.dropChance;
			item.aiHint = this.aiHint;
			item.cooldown = this.cooldown;
			
			return item;
		}
	}
}