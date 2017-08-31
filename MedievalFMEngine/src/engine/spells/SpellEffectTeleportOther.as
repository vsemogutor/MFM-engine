package engine.spells
{
	import engine.core.isometric.IsoTile;
	import engine.game.Game;
	import engine.structures.Structure;
	import engine.units.Unit;
	
	public class SpellEffectTeleportOther extends SpellEffectBase
	{		
		public function SpellEffectTeleportOther()
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
				var tile:IsoTile = Game.instance().world.getFreeTileAroundPoint(owner.tile, 3, null, target.type.isFlying);
					
				if (tile)
				{
					Game.instance().unitManager.moveUnit(target, tile, false);
				}
			}
			
			return ++lifeTime;			
		}		
	}
}