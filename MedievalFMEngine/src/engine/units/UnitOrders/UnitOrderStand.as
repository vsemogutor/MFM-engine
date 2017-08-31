package engine.units.UnitOrders
{
	import computers.utils.Utils;
	
	import engine.core.Direction;
	import engine.core.fm_internal;
	import engine.game.Game;
	import engine.heros.Hero;
	import engine.structures.Structure;
	import engine.units.Unit;
	import engine.units.UnitProperties;
	import engine.units.UnitState;
	import engine.util.Constants;
	import engine.util.TileUtil;
	
	use namespace fm_internal;

	public final class UnitOrderStand extends UnitOrderBase
	{
		private var _holdPosition:Boolean;
		private var _checkForEnemyTimer:int;
		private static const CHECK_FOR_ENEMY_DELAY_DEFAULT:int = (Constants.FRAME_RATE/2);
		private var _checkForEnemyDelay:int = CHECK_FOR_ENEMY_DELAY_DEFAULT;
		
		public function UnitOrderStand(unit:Unit, holdPosition:Boolean = false)
		{
			_holdPosition = holdPosition;
			_checkForEnemyTimer = Utils.rand(0, CHECK_FOR_ENEMY_DELAY_DEFAULT);
			super(unit, unit.tile);
		}
		
		public override function execute():int
		{
			if (_unit.state != UnitState.Waiting)
				return 0;//IN_PROGRESS;
			
			if (_unit.actionTryAutocast())
			{
				return 0;//IN_PROGRESS;
			}
			
			var attackRange:int = unit.properties[UnitProperties.AttackRange];
				
			var canAttack:Boolean = attackRange > 0;
			var inRange:Boolean = _target && TileUtil.getTileDist(_unit.tile, _target.tile) <= attackRange;
			if (_checkForEnemyTimer == 0 && canAttack && _unit.type.canAttack() && _unit.visible)
			{
				if (!inRange || !_target.isActive)
				{
				 	var enemy:Unit = _unit.actionCheckForEnemy(!_holdPosition && _unit.properties[UnitProperties.CanMove] && _unit.type.canMove());
				 	
					if (enemy)
					{
						_unit.actionTryChangeAim(enemy);
					}
				}
			}
			else
			{
				if (++_checkForEnemyTimer >= _checkForEnemyDelay) _checkForEnemyTimer = 0;
			}
			
			if (_target && _target.isActive && canAttack && (inRange || _unit.properties[UnitProperties.CanMove]))
			{
				_checkForEnemyDelay = CHECK_FOR_ENEMY_DELAY_DEFAULT;
				executeOtherFirst(new UnitOrderAttack(_unit, _target as Unit));				
				return 0; //IN_PROGRESS;
			}
			else
			{
				_target = null;
				if ( !(unit is Hero) && _checkForEnemyDelay < (CHECK_FOR_ENEMY_DELAY_DEFAULT<<1) + 4) ++_checkForEnemyDelay;
				
				if (_targetTile != _unit._tile && !(_unit is Structure))
				{
					// return to initial position
					var moveOrder:UnitOrderMove = new UnitOrderMove(_unit, _targetTile, false);
					moveOrder.target = target;
					moveOrder.execute();
					return 0;
				}
				else if (Utils.rand(0, 450) == 1 && !Game.instance().sceneManager.isInCinematicMode
					&& unit.properties[UnitProperties.CanMove])
					_unit.direction = Utils.rand(Direction.Right, Direction.DownRight);
			}
				
			return 0; //IN_PROGRESS;
		}
	}
}