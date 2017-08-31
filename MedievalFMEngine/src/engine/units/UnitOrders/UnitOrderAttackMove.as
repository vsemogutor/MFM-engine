package engine.units.UnitOrders
{
	import computers.utils.Utils;
	
	import engine.core.fm_internal;
	import engine.core.isometric.IsoTile;
	import engine.game.Game;
	import engine.heros.Hero;
	import engine.units.Unit;
	import engine.units.UnitProperties;
	import engine.units.UnitState;
	import engine.util.TileUtil;
	import engine.util.Util;
	
	use namespace fm_internal;
		
	public class UnitOrderAttackMove extends UnitOrderMove
	{
		private var _lastCheckForEnemyTime:int = Utils.rand(0, 8);
		
		public function UnitOrderAttackMove(unit:Unit, tile:IsoTile, hasPriority:Boolean=true)
		{
			super(unit, tile, hasPriority);
		}
		
		public override function execute():int
		{
			if (_unit.state != UnitState.Waiting)
				return IN_PROGRESS;
							
			if (_unit.actionTryAutocast())
			{
				return IN_PROGRESS;
			}
				
			var attackRange:int = _unit.properties[UnitProperties.AttackRange];
			var canAttack:Boolean = attackRange > 0;
			var gt:int = Game.instance().gameTime.value;
			var checkDelay:int = (_unit is Hero ? 3 : 8);		
			if (gt - _lastCheckForEnemyTime >= checkDelay && canAttack && _unit.type.canAttack())
			{
				if (!_target || !_target.isActive || TileUtil.getTileDist(_unit._tile, _target.tile) > attackRange)
				{
					var enemy:Unit = _unit.actionCheckForEnemy(true);
					if (enemy)
					{
						_unit.actionTryChangeAim(enemy);
						_lastCheckForEnemyTime = gt;
					}
				}
			}	
			
			if (unit.isAllowedTarget(_target as Unit) && canAttack)
			{
				executeOtherFirst(new UnitOrderAttack(_unit, _target as Unit));
				return IN_PROGRESS;
			}	
			else
			{
				_target = null;
			}	
			
			return super.execute();
		}
	}
}