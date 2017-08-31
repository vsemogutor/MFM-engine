package engine.spells
{
	import __AS3__.vec.Vector;
	
	import de.polygonal.ds.HashMap;
	
	import engine.core.Direction;
	import engine.core.ManagerBase;
	import engine.core.isometric.IsoTile;
	import engine.sound.SoundManager;
	import engine.structures.Structure;
	import engine.units.Unit;
	import engine.util.Constants;
	import engine.util.Util;
	
	import flash.geom.Point;
	import flash.net.registerClassAlias;
	import flash.utils.Dictionary;
	
	public final class SpellManager extends ManagerBase
	{
		private var _spells:Vector.<Spell> = new Vector.<Spell>(); 
		private var _spellTypes:HashMap = new HashMap(); 
		
		public function get spellTypes():HashMap{
			return _spellTypes;
		}
				
		public function SpellManager()
		{
			super();
			
			registerClassAlias(Util.getClassAlias(SpellEffect), SpellEffect);
			registerClassAlias(Util.getClassAlias(SpellEffectBase), SpellEffectBase);
			registerClassAlias(Util.getClassAlias(SpellEffectSummon), SpellEffectSummon);
			registerClassAlias(Util.getClassAlias(SpellEffectDispell), SpellEffectDispell);
			registerClassAlias(Util.getClassAlias(SpellEffectDrain), SpellEffectDrain);
			registerClassAlias(Util.getClassAlias(SpellEffectChangeModel), SpellEffectChangeModel);
			registerClassAlias(Util.getClassAlias(SpellEffectResetCooldowns), SpellEffectResetCooldowns);
			registerClassAlias(Util.getClassAlias(SpellEffectCastSpell), SpellEffectCastSpell);
			registerClassAlias(Util.getClassAlias(SpellEffectMirrorImage), SpellEffectMirrorImage);
			registerClassAlias(Util.getClassAlias(SpellEffectUnsummon), SpellEffectUnsummon);
			registerClassAlias(Util.getClassAlias(SpellEffectTeleport), SpellEffectTeleport);
			registerClassAlias(Util.getClassAlias(AbilityEffect), AbilityEffect);
			registerClassAlias(Util.getClassAlias(SpellEffectDrainSummon), SpellEffectDrainSummon);	
			registerClassAlias(Util.getClassAlias(SpellEffectInstantKill), SpellEffectInstantKill);
			registerClassAlias(Util.getClassAlias(SpellEffectColorTransform), SpellEffectColorTransform);
			registerClassAlias(Util.getClassAlias(SpellEffectQuake), SpellEffectQuake);	
			registerClassAlias(Util.getClassAlias(SpellEffectTeleportOther), SpellEffectTeleportOther);	
			registerClassAlias(Util.getClassAlias(SpellEffectTimeStop), SpellEffectTimeStop);	
			registerClassAlias(Util.getClassAlias(SpellEffectTownPortal), SpellEffectTownPortal);	
			registerClassAlias(Util.getClassAlias(SpellEffectInvisibility), SpellEffectInvisibility);														
		}
		
		public function addSpellType(spellType:SpellType, id:int = -1):int
		{
			if (id != Constants.UNDEFINED)
				spellType.id = id;
			else if (spellType.id ==  Constants.UNDEFINED)
				spellType.id = idManager.idByName(spellType.name);
			
			spellType.validateDefinition();
			_spellTypes.set(spellType.id, spellType);
			
			return spellType.id;
		}
		
		public function createSpellFromType(type:SpellType, target:*, owner:Unit = null):Spell
		{
			var spell:Spell = new Spell(type, target, owner);
			spell.projectileModel = type.projectileModel;
			spell.specialEffect = type.specialEffect;
			
			if (type.targetType == TargetType.Self)
			{
				spell.setTarget(owner);
			}
			
			return spell;
		}
		
		public function createSpellFromTypeId(type:int, target:*, owner:Unit = null):Spell
		{
			var spType:SpellType = getSpellTypeById(type);
			return spType ? createSpellFromType(spType, target, owner) : null;
		}
		
		public function getSpellTypeById(id:int):SpellType
		{
			return _spellTypes.get(id) as SpellType;
		}
		
		public function castSpell(spell:Spell, ignoreProjectile:Boolean = false, ignoreCost:Boolean=false, position:Point = null):Boolean
		{		
			if (!ignoreProjectile && !spell.canCast())
				return false;
				
			if (spell.projectileModel && !ignoreProjectile && spell.type.visualType == SpellVisualType.Normal)
			{
				game.projectileManager.addForSpell(spell, false, position);
				if (spell.type.soundPack.attack)
					SoundManager.instance().playSoundOnUnit(spell.owner, spell.type.soundPack.attack, spell.type.soundPack.attackRepeat);					 
			}
			else
			{
				spell.lifeTime = 0;
				_spells.push(spell);
				if (spell.type.soundPack.hit)
					SoundManager.instance().playSoundOnUnit(spell.owner, spell.type.soundPack.hit, spell.type.soundPack.hitRepeat);	
			}
			
			if (spell.owner && !ignoreCost)
			{
				spell.type.subtractCost(spell.owner);
			}
			
			return true;
		}
		
		public function removeSpellFromUnit(spell:SpellType, unit:Unit):void
		{
			for (var i:int = unit.spellEffects.length - 1; i >= 0; --i)
			{
				if (spell.hasEffect(unit.spellEffects[i]))
				{
					unit.spellEffects[i].cleanup(unit);
					unit.spellEffects.splice(i, 1);
				}
			}			
		}

		public function processSpells():void
		{
			for (var i:int = 0; i < _spells.length; ++i)
			{
				var spell:Spell = _spells[i];

				if (spell.lifeTime >= spell.type.duration)
				{
					_spells.splice(i, 1);
					continue;
				}
				
				if (spell.lifeTime % spell.type.period == 0)
				{				
					if ((spell.type.castType == SpellCastType.Unit || spell.type.castType == SpellCastType.Aura
						|| spell.type.castType == SpellCastType.Self)
						&& spell.target && spell.type.snapToUnit)
					{
						spell.targetPos.x = spell.target.physicalCenter.x;
						spell.targetPos.y = spell.target.physicalCenter.y;
						
						if (spell.lifeTime == 0)
						{
							if (spell.specialEffect)
							{
								game.effectManager.addEffectByType(spell.specialEffect, spell.targetPos, spell.type.sfxDuration, spell.target);
							}
								
							if (spell.type.specialGeneratedEffect)
							{
								var startPos:Point;
								if (spell.type.visualType == SpellVisualType.Rain) 
								{
									startPos = spell.getRandomTargetInRadius();
									startPos.offset(-spell.type.rainHeight,  -spell.type.rainHeight);
								}
								else spell.owner.physicalCenter;
								
								game.effectManager.addGeneratedEffect(spell.type.specialGeneratedEffect, startPos, 
									spell.targetPos, spell.type.sfxDuration, spell.owner, spell.target);
							}	
						}
					}
					else if (spell.lifeTime == 0 && spell.specialEffect)
					{
						game.effectManager.addEffectByType(spell.specialEffect, 
							spell.targetPos, spell.type.sfxDuration);
					}
					
					if (spell.type.quakeDuration)
					{
						var tile:IsoTile = spell.getTile();
						if (tile && Math.abs(tile.xindex - world.centerTile.xindex + 3) <= game.sceneManager.visibleAreaTileWidth
							&& Math.abs(tile.yindex - world.centerTile.yindex + 3) <= game.sceneManager.visibleAreaTileHeight )
							game.sceneManager.cameraShake(4, spell.type.quakeDuration);
					}
	
					if (spell.type.visualType == SpellVisualType.Ray)
					{
						if (spell.lifeTime % (spell.type.projectileSpeed - 1) == 0)
							game.projectileManager.addForSpell(spell, true);
						applySpell(spell);
					}
					else if (spell.type.castType == SpellCastType.Aura)
					{
						if (!spell.lifeTime) applySpell(spell);
					}
					else
					{
						if (spell.type.visualType == SpellVisualType.Rain && spell.type.projectileModel)
						{
							if (spell.lifeTime % spell.type.rainDelay == 0)
							{
								game.projectileManager.addForSpell(spell, true);							
							}
						}
						
						applySpell(spell);
					}
				}
				
				spell.lifeTime++;											
			}
		}
		
		private function applySpell(spell:Spell):void
		{
			var center:IsoTile = spell.getTile();
			
			if (spell.type.radius <= 1)
			{
				spell.apply(center);
				return;
			}
			
			if (spell.type.cone)
			{
				var xLimit:int;
				var yLimit:int;
				var bottomLimit:int;
				var rightLimit:int;
				
				var unit:Unit = spell.owner;
							
				if (unit.direction == Direction.UpLeft)
				{
					xLimit = unit.tile.xindex - spell.type.radius;
					rightLimit = unit.tile.xindex - 1;
					yLimit = unit.tile.yindex - spell.type.radius;
					bottomLimit = unit.tile.yindex + spell.type.radius;					
				}	
				else if (unit.direction == Direction.UP)
				{
					xLimit = unit.tile.xindex - spell.type.radius;
					rightLimit = unit.tile.xindex;
					yLimit = unit.tile.yindex - spell.type.radius;
					bottomLimit = unit.tile.yindex;
				}	
				else if (unit.direction == Direction.UpRight)
				{
					xLimit = unit.tile.xindex - spell.type.radius;
					rightLimit = unit.tile.xindex + spell.type.radius;
					yLimit = unit.tile.yindex - spell.type.radius;
					bottomLimit = unit.tile.yindex - 1;	
				}	
				else if (unit.direction == Direction.Right)
				{
					xLimit = unit.tile.xindex;
					rightLimit = unit.tile.xindex + spell.type.radius;
					yLimit = unit.tile.yindex - spell.type.radius;
					bottomLimit = unit.tile.yindex;		
				}	
				else if (unit.direction == Direction.DownRight)
				{
					xLimit = unit.tile.xindex + 1;
					rightLimit = unit.tile.xindex + spell.type.radius;
					yLimit = unit.tile.yindex - spell.type.radius;
					bottomLimit = unit.tile.yindex + spell.type.radius;
				}	
				else if (unit.direction == Direction.Down)
				{
					xLimit = unit.tile.xindex;
					rightLimit = unit.tile.xindex + spell.type.radius;
					yLimit = unit.tile.yindex;
					bottomLimit = unit.tile.yindex + spell.type.radius;
				}	
				else if (unit.direction == Direction.DownLeft)												
				{
					xLimit = unit.tile.xindex - spell.type.radius;
					rightLimit = unit.tile.xindex + spell.type.radius;
					yLimit = unit.tile.yindex + 1;
					bottomLimit = unit.tile.yindex + spell.type.radius;					
				}
				else if (unit.direction == Direction.Left)
				{
					xLimit = unit.tile.xindex - spell.type.radius;
					rightLimit = unit.tile.xindex;
					yLimit = unit.tile.yindex;
					bottomLimit = unit.tile.yindex + spell.type.radius;					
				}
				
				var tiles:Vector.<IsoTile> = world.getTilesAroundTile(unit.tile);
				for (var i:int = 0; i < tiles.length; ++i)
				{
					var tile:IsoTile = tiles[i];
					if (tile.xindex >= xLimit && tile.xindex <= rightLimit
						&& tile.yindex >= yLimit && tile.yindex <= bottomLimit)
						spell.apply(tile);
				}
			}
			else
			{
				var x1:int = center.xindex - spell.type.radius;
				var x2:int = center.xindex + spell.type.radius;
				var y1:int = center.yindex - spell.type.radius;
				var y2:int = center.yindex + spell.type.radius;
				
				var effectsAdded:Dictionary;
				for (var i:int = x1; i <= x2; ++i)
				{
					for (var j:int = y1; j <= y2; ++j)
					{
						var tile:IsoTile = world.getTile(i, j);
						if (tile)
						{
							if (tile.unit is Structure)
							{
								if ( (!effectsAdded || !effectsAdded[tile.unit.id]) 
									&& spell.type.affectBuildings)
								{
									spell.apply(tile);
									if (!effectsAdded) effectsAdded = new Dictionary();
									effectsAdded[tile.unit.id] = true;
								}
							}
							else
							{
								spell.apply(tile);
							}
						}
					}			
				}
			}
		}
	}
}