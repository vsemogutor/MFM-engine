package engine.userAction
{
	import engine.area.Area;
	import engine.cursor.CursorType;
	import engine.game.Game;
	import engine.sound.SoundManager;
	import engine.spells.SpellCastType;
	import engine.spells.SpellType;
	import engine.spells.TargetType;
	import engine.units.Unit;
	import engine.units.groups.UnitGroup;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class UserActionOrderUnitCast extends UserActionOrderUnitGroup
	{
		private var _spellType:SpellType;
		private var _target:Unit;
		private var _area:Area;		
		private static const AreaValidColor:int = 0x00FF11;
				
		public function UserActionOrderUnitCast(group:UnitGroup, spellType:SpellType)
		{
			super(group);
			_spellType = spellType;
			_needsSelection = true;
			_cursorType = CursorType.SELECT;
			if (_spellType.radius > 0)
			{
				_area = new Area(null, -100, -100, _spellType.radius*2 + 1, _spellType.radius*2 + 1);
				_area.color = AreaValidColor;
				_area.ellips = true;
			}			
		}
		
		internal override function process():Boolean
		{	
			if (!_group.selectedUnit)
				done();
			
			return super.process();
		}
		
		internal override function enter():void
		{
			super.enter();
			if (_area) Game.instance().areaManager.displayArea(_area, true);
			
			if (_spellType.targetType == TargetType.Self
				|| _spellType.castType == SpellCastType.Self)
			{
				_group.selectedUnit.castSpell(_group.selectedUnit, _spellType);
				SoundManager.instance().clickSound();
				done();
			}
		}
		
		public override function onMouseDown(evt:MouseEvent):void
		{
			_success = checkPosition(evt.localX, evt.localY) && _group.selectedUnit;
			if (_success)
			{
				if (_spellType.castType == SpellCastType.Place)
					_group.selectedUnit.castSpell(_currentTile, _spellType);
				else
				{
					_target.displaySelection.setActive(0x3C3CEB);
					_group.selectedUnit.castSpell(_target || _currentTile.unit, _spellType);
				}
			}
			done();
		}
	
		protected override function onMouseMove(evt:MouseEvent):void
		{
			checkPosition(evt.localX, evt.localY);
		}
		
		private function checkPosition(x:int, y:int):Boolean
		{
			_currentTile = Game.instance().sceneManager.pickIsoTile(x, y);
			
			if (_currentTile)
			{
				if (_spellType.castType == SpellCastType.Place)
				{
					if (_currentTile && _area)
					{
						_area.x = _currentTile.xindex;
						_area.y = _currentTile.yindex;
					}
			
					return true;
				}
				else
				{
					_target = Game.instance().sceneManager.getUnitAtScreenPosition(new Point(x, y)) || _currentTile.unit;
					var result:Boolean =  _spellType.isAllowedTarget(_group.selectedUnit, _target);
					
					if (_area)
					{
						if (result)
						{
							_area.x = _currentTile.xindex;
							_area.y = _currentTile.yindex;						
						}
						else
						{
							_area.x = -100;
							_area.y = -100;						
						}
					}
					
					return result;
				}	
			}
			
			return false;
		}
		
		internal override function cleanup():void
		{
			super.cleanup();
			if (_area) Game.instance().areaManager.displayArea(_area, false);
		}				
	}
}