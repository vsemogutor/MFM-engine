package engine.projectile
{
	import __AS3__.vec.Vector;
	
	import computers.utils.Utils;
	
	import engine.core.ManagerBase;
	import engine.core.fm_internal;
	import engine.core.isometric.IsoTile;
	import engine.spells.Spell;
	import engine.spells.SpellCastType;
	import engine.spells.SpellVisualType;
	import engine.units.*;
	import engine.util.TileUtil;
	
	import flash.geom.Point;

	use namespace fm_internal;
		
	public final class ProjectileManager extends ManagerBase
	{
		private static const CACHE_SIZE:int = 600;
		private var _cacheTop:int = CACHE_SIZE;
		private var _cache:Vector.<Projectile> = new Vector.<Projectile>(CACHE_SIZE);
		private var _projectiles:Vector.<Projectile> = new Vector.<Projectile>();

		public function get projectiles():Vector.<Projectile> {
			return _projectiles;
		}
				
		public function ProjectileManager()
		{
			super();
			initCache();
		}
		
		public function processProjectiles():void
		{
			var projLen:int = _projectiles.length;
			for (var i:int = 0; i < projLen; ++i)
			{
				var projectile:Projectile = _projectiles[i];
				
				if (projectile.move())
				{
					if (projectile.target && projectile.behaviourType != ProjectileBehaviour.NORMAL)
					{
						projectile.apply(projectile.target);
					}
					else
					{
						var tp:Point = TileUtil.isoToTile(projectile.targetPos.x, projectile.targetPos.y);
						if (tp.x <= 0) tp.x = 1;
						if (tp.y <= 0) tp.y = 1;	
											
						var tile:IsoTile = world.getTile(tp.x, tp.y);
						projectile.apply(tile);
					}
					
					projectile.stop();
					_projectiles.splice(i, 1);
					--projLen;
					
					returnToCache(projectile);
				}
			}
		}
		
		public function addForUnit(owner:Unit):void
		{
			var projectile:Projectile = getFromCache();
			projectile.setTarget(owner._target, owner.properties[UnitProperties.ProjectileBehaviour]);
			projectile.owner = owner;

			projectile.model = game.spriteRepository.getById(owner.properties[UnitProperties.ProjectileModelId]);			
			projectile.position = owner.getProjectilePosition(projectile);
			projectile.speed = owner.properties[UnitProperties.ProjectileSpeed];	
			projectile.direction = Utils.getDir(projectile.position, projectile.targetPos);
			projectile.model.currentAnimationIndx = projectile.direction;
			projectile.isSpell = false;
			projectile.trajectory = 0;
										
			if (owner.properties[UnitProperties.AttackVisualEffectId])
			{
				projectile.visalEffect = game.effectManager.getEffectType(owner.properties[UnitProperties.AttackVisualEffectId]);
			}
			else
			{
				projectile.visalEffect = null;
			}	
			
			if (owner.properties[UnitProperties.AttackSpell])
			{
				projectile.spell = game.spellManager.createSpellFromTypeId(
					owner.properties[UnitProperties.AttackSpell], projectile.getTarget(), owner);
			}
			else
			{
				projectile.spell = null;
			}
				
			_projectiles.push(projectile);
		}
		
		public function addForSpell(spell:Spell, ignoreSpell:Boolean=false, position:Point=null):void
		{
			var projectile:Projectile = getFromCache();
			
			if (spell.type.visualType == SpellVisualType.Rain)
			{
				if (spell.type.castType == SpellCastType.Place)
				{
					var target:Point = spell.getRandomTargetInRadius();
					projectile.setTarget(target);
					if (!position) position = new Point(target.x - spell.type.rainHeight, target.y - spell.type.rainHeight);					
				}
				else
				{
					projectile.setTarget(spell.getTarget(), 
						spell.type.snapToUnit ? ProjectileBehaviour.SNAP_TO_TARGET : ProjectileBehaviour.NORMAL);
					
					var target:Point = spell.getRandomTargetInRadius();
					position = new Point(target.x - spell.type.rainHeight, target.y - spell.type.rainHeight);
				}
			}
			else
			{	
				projectile.setTarget(spell.getTarget(), 
					spell.type.snapToUnit ? ProjectileBehaviour.SNAP_TO_TARGET : ProjectileBehaviour.NORMAL);
			}
			
			projectile.owner = spell.owner;	

			projectile.model = spell.projectileModel.clone();				
			projectile.position = position || spell.owner.getProjectilePosition(projectile);
			projectile.speed = spell.type.projectileSpeed;
			projectile.direction = Utils.getDir(projectile.position, projectile.targetPos);
			projectile.model.currentAnimationIndx = projectile.direction;
			projectile.isSpell = true;
			projectile.trajectory = spell.type.projectileTrajectory;
				
			if (!ignoreSpell) projectile.spell = spell;
			else projectile.spell = null;
			
			projectile.visalEffect = null;
			_projectiles.push(projectile);
		}
		
		private function initCache():void
		{
			for (var i:int = 0; i < CACHE_SIZE; ++i)
				_cache[i] = new Projectile();
		}
	
		private function getFromCache():Projectile
		{
			if (_cacheTop <= 0)
				return new Projectile();
			
			return _cache[--_cacheTop];
		}
		
		private function returnToCache(projectile:Projectile):void
		{
			if (_cacheTop >= CACHE_SIZE) return;
			_cache[_cacheTop] = projectile;
			++_cacheTop;
		}
		
		public function unsnapFrom(unit:Unit):void
		{
			var projLen:int = _projectiles.length;
			for (var i:int = 0; i < projLen; ++i)
			{
				var projectile:Projectile = _projectiles[i];
				
				if (projectile.target == unit && projectile.behaviourType == ProjectileBehaviour.SNAP_TO_TARGET)
				{
					projectile.setTarget(unit.center, ProjectileBehaviour.NORMAL);
				}
			} 
		}
	}
}