package engine.spells
{
	import engine.core.isometric.IsoTile;
	import engine.game.Game;
	import engine.structures.Structure;
	
	public class SpellEffectTeleport extends SpellEffectBase
	{
		public function SpellEffectTeleport()
		{
			super();
		}
		
		public override function applyToTile(target:IsoTile):Object
		{
			if (!startTime)
				startTime = Game.instance().gameTime.value;
				
			if (lifeTime >= duration)
				return lifeTime;
				
			if (!(owner is Structure) && owner.isActive)
			{
				var tile:IsoTile = target;
				if (!tile.isFreeFor(owner))
					tile = Game.instance().world.getFreeTileAroundPoint(target, 3, null, owner.type.isFlying);
					
				if (tile)
				{
					Game.instance().unitManager.moveUnit(owner, tile, false);
				}
			}
			
			return ++lifeTime;			
		}		
	}
}