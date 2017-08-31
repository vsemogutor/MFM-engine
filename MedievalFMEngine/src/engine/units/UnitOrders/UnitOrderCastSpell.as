package engine.units.UnitOrders
{
	import engine.core.isometric.IsoTile;
	import engine.game.Game;
	import engine.game.GameManager;
	import engine.spells.Spell;
	import engine.spells.SpellType;
	import engine.structures.Structure;
	import engine.units.Unit;
	import engine.units.UnitState;
	import engine.util.TileUtil;
	
	public final class UnitOrderCastSpell extends UnitOrderBase
	{
		public var _spellType:SpellType;
		public var _spell:Spell;
		
		public function get spellType():SpellType {
			return _spellType;
		}

		public function get spell():Spell {
			return _spell;
		}
				
		public function UnitOrderCastSpell(unit:Unit, target:*, spellType:SpellType)
		{
			_spell = Game.instance().spellManager.createSpellFromType(spellType, target, unit);
			super(unit, _spell.getTile());
			_spellType = spellType;
			_target = _spell.target;
		}
		
		public override function execute():int
		{
			if (_unit.state != UnitState.Waiting)
				return IN_PROGRESS;
			
			var target:Unit = _target as Unit;
			
			if (target && !_spell.isAllowedTarget(target))
			{
				if (target.isActive && _unit.fraction.isCurrentPlayer())
					GameManager.instance().showWarning("Wrong target.");
				return ABORTED;	
			}
				
			if (!_spell.canCast())
			{
				if (_unit.fraction.isCurrentPlayer())
					GameManager.instance().showWarning("Unable cast this spell now.");
				return ABORTED;
			};
			
			if (_completed || !_unit.isReadyToCast(_spell.type))
				return COMPLETE;
			
			var sTile:IsoTile = _spell.getTile();
			if (!sTile) return 1;
					
			var dist:int = TileUtil.getTileDist(_unit.tile, sTile);
			if (dist <= _spellType.range)
			{
				_targetTile = sTile;
				_unit.state = UnitState.Casting;			
			}
			else
			{
				if (_unit is Structure)
				{
					_targetTile = sTile;
					if (_unit.fraction.isCurrentPlayer() && _unit.displaySelection.duration)
						GameManager.instance().showWarning("Target is too far.");
					return COMPLETE;
				}
				else
				{
					setTargetTileAndResetPath(sTile, dist);
			
					var moveOrder:UnitOrderMove = new UnitOrderMove(_unit, _targetTile, false);
					moveOrder.target = target;
					moveOrder.execute();
				}
			}
				
			return IN_PROGRESS;
		}
	}
}