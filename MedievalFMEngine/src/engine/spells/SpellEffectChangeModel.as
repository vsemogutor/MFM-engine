package engine.spells
{
	import engine.animation.UnitSprite;
	import engine.game.Game;
	import engine.units.Unit;
	import engine.util.StrUtil;
	
	public class SpellEffectChangeModel extends SpellEffectBase
	{
		private var _model:String;
		private var _modelInternal:UnitSprite;
								
		public function get modelName():String {
			return _model;
		}

		public function set modelName(model:String):void {
			_model = model;
		}
				
		public function SpellEffectChangeModel()
		{
			super();
		}

		public override function apply(target:Unit):Object
		{		
			if (!startTime)
				startTime = Game.instance().gameTime.value;
				
			if (lifeTime > duration)
				return lifeTime;
						
			if ((lifeTime % period) == 0)
			{
				if (!_modelInternal)
				{
					_modelInternal = Game.instance().spriteRepository.getByName(_model) as UnitSprite;
				}
				
				target.setModel(_modelInternal);
			}
				
			return ++lifeTime;
		}
		
		public override function cleanup(target:Unit):void
		{
			if (StrUtil.startsWith(target.model.name, _modelInternal.name))
			{
				target.setModel(target.type.model.clone());
			}
		}		
	}
}