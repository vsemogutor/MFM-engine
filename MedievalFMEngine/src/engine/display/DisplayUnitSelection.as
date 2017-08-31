package engine.display
{
	import engine.cursor.CursorManager;
	import engine.fraction.Fraction;
	import engine.game.Game;
	import engine.objects.BaseObject;
	import engine.selection.SelectionManager;
	import engine.units.Unit;
	import engine.util.Constants;

public final class DisplayUnitSelection
	{
		public static const SELECTION_COLOR:uint = 0x00BF11;
		public static const SELECTION_ACTIVE_COLOR:uint = 0x00FF11;
		public static const SELECTION_COLOR_ENEMY:uint = 0xBF0011;
		public static const SELECTION_COLOR_NEUTRAL:uint = 0xDFD620;		
				
		public var unit:BaseObject;
		public var color:uint;
		public var duration:int;
		internal var processed:Boolean;	
		internal var display:Boolean;			
		
		public function DisplayUnitSelection(unit:BaseObject, color:uint=SELECTION_COLOR, duration:int = -1)
		{
			this.unit = unit;
			this.color = color;
			this.duration = duration;
		}
		
		internal function reset():void
		{
			if (!processed)
				return;
			
			processed = false;
						
			if (duration > 0)
			{
				display = (((duration/(Constants.FRAME_RATE>>1)) & 1) == 0);
				--duration; 
			}
			else
			{
				var selManager:SelectionManager = Game.instance().selectionManager;
				var underCursor:Boolean = (unit == CursorManager.instance().getUnitUnderCursor());
				var selected:Boolean = (selManager.selectedUnit == unit);
								
				if (selected || underCursor)
				{
					display = true;
					var u:Unit = unit as Unit;
					if (u)
					{
						var playerFraction:Fraction = Game.instance().fractionManager.player;
						if (u.fraction.isAllyOf(playerFraction))
							color = selected ? SELECTION_ACTIVE_COLOR : SELECTION_COLOR;
						else if (u.fraction.isEnemyOf(playerFraction))
							color = SELECTION_COLOR_ENEMY;
						else
							color = SELECTION_COLOR_NEUTRAL;
					}
					else
					{
						color = SELECTION_ACTIVE_COLOR;
					}
				}
				else if (selManager.selectedUnitGroup.contains(unit))
				{
					display = true;
					color = SELECTION_COLOR;				
				}
				else
				{
					display = false;
				}
			}
		}
		
		public function setActive(color:uint = SELECTION_COLOR, duration:int = 32):void
		{
			this.color = color;
			this.duration = duration;
		}
	}
}