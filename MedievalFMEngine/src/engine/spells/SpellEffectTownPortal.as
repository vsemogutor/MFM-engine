package engine.spells
{
	import engine.core.isometric.IsoTile;
	import engine.game.Game;
	import engine.heros.Hero;
	import engine.structures.Structure;
	import engine.units.Unit;
	
	public class SpellEffectTownPortal extends SpellEffectBase
	{
		public function SpellEffectTownPortal()
		{
			super();
		}
		
		public override function apply(target:Unit):Object
		{
			if (!startTime)
				startTime = Game.instance().gameTime.value;
				
			if (lifeTime >= duration)
				return lifeTime;
				
			if (!(target is Structure) && target.isActive)
			{
				var tile:IsoTile = Game.instance().world.getTile(target.fraction.startPoint.x, target.fraction.startPoint.y);
				if (tile)
				{
					if (!tile.isFreeFor(owner))
						tile = Game.instance().world.getFreeTileAroundPoint(tile, 6, null, target.type.isFlying);
						
					if (tile)
					{
						Game.instance().unitManager.moveUnit(target, tile, false);
						if (target is Hero && target.fraction.isCurrentPlayer())
						{
							Game.instance().sceneManager.cameraCenterOnUnit(target);
						}
					}
				}
			}
			
			return ++lifeTime;			
		}		
	}
}