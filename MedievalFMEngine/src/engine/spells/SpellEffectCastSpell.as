package engine.spells
{
	import computers.utils.Utils;
	
	import engine.core.isometric.IsoWorld;
	import engine.game.Game;
	import engine.units.Unit;
	
	import flash.geom.Rectangle;
	
	public class SpellEffectCastSpell extends SpellEffectBase
	{
		private static var targets:Array = new Array(10);
				
		public var spellTypeId:int;	
		public var castFromTargetPosition:Boolean = true;
		public var nextTargetIsRandom:Boolean = true;	
		public var castTimes:int = 1;
		
		public function SpellEffectCastSpell()
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
				var newTarget:Unit = null;
				var targetsNum:int = 0;
				var type:SpellType = Game.instance().spellManager.getSpellTypeById(spellTypeId);
				if (nextTargetIsRandom)
				{
					targetsNum = getTargets(target);
				}
				else
				{
					if (type.castType == SpellCastType.Self)
						newTarget = owner || target;
					else
						newTarget = target;
				}
						
				for (var i:int = 0; i < castTimes; ++i)
				{			
					if (targetsNum > 0)
					{
						var indx:int = Utils.rand(0, targetsNum - 1);
						newTarget = targets[indx];
						targets[indx] = targets[targetsNum - 1];
						targetsNum--;
					}
							
					if (newTarget)
					{
						var spell:Spell = Game.instance().spellManager.createSpellFromType(type, newTarget, owner || target);
						if (castFromTargetPosition)
							Game.instance().spellManager.castSpell(spell, false, true, target.physicalCenter);
						else
							Game.instance().spellManager.castSpell(spell, false, true);
					}
				}
			}
				
			return ++lifeTime;			
		}
		
		private function getTargets(target:Unit):int
		{
			var world:IsoWorld = Game.instance().world;
			var spellType:SpellType = Game.instance().spellManager.getSpellTypeById(spellTypeId);
			var boundary:Rectangle = world.getRangeAroundTile(target.tile, 4);
				
			var x1:int = boundary.x;
			var x2:int = boundary.right;
			var y1:int = boundary.y;
			var y2:int = boundary.bottom;			
			
			var targetsNum:int = 0;
			
			for (var i:int = x1; i < x2; ++i)
			{
				for (var j:int = y1; j < y2; ++j)
				{
					var unit:Unit = world.getTileUnsafe(i, j).unit;
					if (unit != target && spellType.isAllowedTarget(owner, unit))
					{
						targets[targetsNum] = unit;
						if (++targetsNum >= 4) break;
					}
				} 
			}
			

			if (targetsNum >= 2) 
			{
				targets[++targetsNum] = target;
			}
			
			return targetsNum;;		
		}
	}
}