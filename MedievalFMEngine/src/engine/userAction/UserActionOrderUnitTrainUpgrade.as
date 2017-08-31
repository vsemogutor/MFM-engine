package engine.userAction
{
	import engine.game.Game;
	import engine.units.Unit;
	import engine.units.UnitType;
	import engine.units.groups.UnitGroup;
	import engine.util.Constants;
	
	public class UserActionOrderUnitTrainUpgrade extends UserActionOrderUnitGroup
	{
		private var _type:UnitType;
		
		public function UserActionOrderUnitTrainUpgrade(group:UnitGroup, type:UnitType)
		{
			_type = type;
			super(group);
			_success = false;
		}
		
		internal override function enter():void
		{
			if (Game.instance().sceneManager.isInCinematicMode)
			{
				done();
				return;
			}
			
			var unit:Unit = _group.selectedUnit;
			if (unit)
			{
				_success = unit.trainUpgrade(_type, Constants.MAX_UI_TRAIN_QUEUE_SIZE);
			}
	
			done();
		}
		
		internal override function cleanup():void
		{
			done();
		}
	}
}