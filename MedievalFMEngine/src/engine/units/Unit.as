package engine.units
{
	import __AS3__.vec.Vector;
	
	import com.greensock.TweenMax;
	import com.greensock.easing.Cubic;
	import com.greensock.easing.Linear;
	
	import computers.utils.Utils;
	
	import engine.animation.*;
	import engine.computers.ArmorAndDamage;
	import engine.computers.ExperienceCalculator;
	import engine.core.Direction;
	import engine.core.events.GameEvent;
	import engine.core.events.GameEvents;
	import engine.core.fm_internal;
	import engine.core.isometric.IsoTile;
	import engine.core.isometric.IsoWorld;
	import engine.display.DisplayInfo;
	import engine.display.DisplayUnitSelection;
	import engine.fraction.Fraction;
	import engine.fraction.ResourceType;
	import engine.game.Game;
	import engine.heros.Hero;
	import engine.items.InventoryItem;
	import engine.items.InventoryItemType;
	import engine.objects.*;
	import engine.projectile.Projectile;
	import engine.sound.SoundManager;
	import engine.specialEffects.SpecialEffects;
	import engine.spells.*;
	import engine.structures.Structure;
	import engine.text.Text;
	import engine.units.UnitOrders.*;
	import engine.util.Constants;
	import engine.util.TileUtil;
	import engine.util.Util;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	use namespace fm_internal;
			
	public class Unit extends UnitBase
	{	
		public function Unit(type:UnitType, fraction:Fraction)
		{
			_displaySelection = new DisplayUnitSelection(this);
			_displayInfo = new DisplayInfo(this);
			_type = type;
			properties = type.properties.concat();
			baseProperties = type.properties.concat();
			this.setFraction(fraction);
		}
			
		// Methods ----------------------------------------
		public function move(tile:IsoTile):void
		{
			setOrder(new UnitOrderMove(this, tile));
		}

		public function attackMove(tile:IsoTile):void
		{
			setOrder(new UnitOrderAttackMove(this, tile));
		}
				
		public function attack(unit:Unit):void
		{
			if (!_type.canAttack())
				return;
				
			setOrder(new UnitOrderAttack(this, unit));
		}

		public function castSpell(target:*, spellType:SpellType):void
		{
			if (!spellType.checkDependencies(this.fraction)
			 	|| !_type.hasSpell(spellType))
				return;
			
			setOrder(new UnitOrderCastSpell(this, target, spellType));
		}
		
		public function repair(unit:Unit):void
		{
			setOrder(new UnitOrderRepair(this, unit));
		}
		
		public function stand():void
		{
			setOrder(new UnitOrderStand(this));
		}
		
		public function holdPosition():void
		{
			setOrder(new UnitOrderStand(this, true));
		}
		
		public function wander():void
		{
			setOrder(new UnitOrderWander(this));
		}
		
		public function link(target:Unit):void
		{
			setOrder(new UnitOrderLink(this, target));
		}
		
		public function construct(type:UnitType, targetTile:IsoTile):void
		{
			setOrder(new UnitOrderConstruct(this, type, targetTile));
		}
		
		public function trainUpgrade(type:UnitType, maxQueueSize:int = Constants.MAX_TRAIN_QUEUE_SIZE):Boolean
		{
			// units can't train other units
			return false;
		}
		
		public function actionLink(target:Unit):void
		{
			if (target != linkedTo)
			{
				actionUnlink();
				linkedTo = target;
			}
			
			if (linkedTo && linkedTo.isActive && !linkedTo.linkedUnits.contains(this))
			{
				linkedTo.linkedUnits.addItem(this);
				Game.instance().eventManager.dispatch(new GameEvent(GameEvents.LINK_ESTABLISHED, {unit:this}));
			}
		}
		
		public function actionUnlink():void
		{
			if (linkedTo)
			{
				var indx:int = linkedTo.linkedUnits.getItemIndex(this);
				if (indx >= 0)
					linkedTo.linkedUnits.removeItemAt(indx);
				linkedTo = null;
				Game.instance().eventManager.dispatch(new GameEvent(GameEvents.LINK_BROKEN, {unit:this}));
			}
		}	
		
		public function actionMoveToPoint(dest:Point):void
		{			
			if (!TweenMax.isTweening(this))
			{
				var dx:int = (dest.x - this.center.x);
				var dy:int = (dest.y - this.center.y);
				
				// Move units in short quants, so we can change unit speed while moving
				if (dx > Constants.UNIT_MOVE_QUANT_POS) dx = Constants.UNIT_MOVE_QUANT_POS;
				else if (dx < Constants.UNIT_MOVE_QUANT_NEG) dx = Constants.UNIT_MOVE_QUANT_NEG;
				
				if (dy > Constants.UNIT_MOVE_QUANT_POS) dy = Constants.UNIT_MOVE_QUANT_POS;
				else if (dy < Constants.UNIT_MOVE_QUANT_NEG) dy = Constants.UNIT_MOVE_QUANT_NEG;				
				
				var animDuration:int = properties[UnitProperties.MoveAnimSpeed];
				var duration:int = properties[UnitProperties.MoveSpeed]/Constants.UNIT_MOVE_QUANT_TIME;
				
				if (dx == 0)
				{
					TweenMax.to(this, duration, {y:dy.toString(), useFrames:true, ease:Linear.easeOut});
				}	
				else if (dy == 0)
				{
					TweenMax.to(this, duration, {x:dx.toString(), useFrames:true, ease:Linear.easeOut});
				}
				else if ( (dx + dy) == 0 && duration > dx && duration > dy && duration <= 7)
				{
					++duration;
					TweenMax.to(this, duration, {x:dx.toString(), useFrames:true, ease:Linear.easeOut});
					TweenMax.to(this, duration, {y:dy.toString(), useFrames:true, ease:Cubic.easeOut});					
				}			
				else
				{
					TweenMax.to(this, duration, {x:dx.toString(), y:dy.toString(), useFrames:true, ease:Linear.easeOut});						
				}
				
				_model.setCurrent(UnitAnimation.Move, this._direction);
				_model.play(animDuration);
			}
		}
		
		public function actionCheckForEnemy(canMoveToTarget:Boolean):Unit
		{
			var bestAim:Unit;

			var world:IsoWorld = Game.instance().world;
			var yGridSize:int = world.yGridSize;
			var boundary:Rectangle;
			
			if (canMoveToTarget)
				boundary = world.getRangeAroundTile(_tile, properties[UnitProperties.SightRange]);
			else
				boundary = world.getRangeAroundTile(_tile, 
					Math.min(properties[UnitProperties.SightRange], properties[UnitProperties.AttackRange]));
				
				
			var bestRating:Number = -1000000;
			var x1:int = boundary.left;
			var x2:int = boundary.right;
			var y1:int = boundary.top;
			var y2:int = boundary.bottom;				
			
			for (var i:int = x1; i < x2; ++i)
			{
				for (var j:int = y1; j < y2; ++j)
				{
					var unit:Unit = world.tiles[i*yGridSize + j].unit;
					if (unit && isAllowedEnemyTargetUnsafe(unit))
					{
						var rating:Number = getAttackRating(unit);
						if (rating > bestRating)
						{
							bestRating = rating;
							bestAim = unit;
						} 
					}
				} 
			}
				
			return bestAim;
		}	
		
		public function getVisibles(ignoreModifiers:Boolean=false):VisibleUnits
		{
			var units:VisibleUnits = new VisibleUnits();

			var world:IsoWorld = Game.instance().world;
			var sightRange:int = properties[UnitProperties.SightRange];
			if (ignoreModifiers) sightRange = Math.max(sightRange, _type.properties[UnitProperties.SightRange]);
			var boundary:Rectangle = world.getRangeAroundTile(_tile, sightRange);
				
			var x1:int = boundary.left;
			var x2:int = boundary.right;
			var y1:int = boundary.top;
			var y2:int = boundary.bottom;				
			
			for (var i:int = x1; i < x2; ++i)
			{
				for (var j:int = y1; j < y2; ++j)
				{
					var tile:IsoTile = world.getTileUnsafe(i, j);
					var unit:Unit = tile.unit;
					if (isValidEnemyTarget(unit))
					{
						if (unit is Hero)
							units.enemy.unshift(unit); // heroes has highter priority so added first
						else
							units.enemy.push(unit);
					}
					else if (isAllowedAllyTarget(unit))
					{
						units.friendly.push(unit);
					}
					
					if (tile.items)
					{
						units.items.push(tile);
					}
				} 
			}
			
			return units;		
		}
				
		protected function getAttackRating(target:Unit):Number
		{
			// close and low heath units are better targets
			// if attacks me - also better target
			return Utils.rand(0, attackRatingRand) - (TileUtil.getTileDist(_tile, target._tile)) + int(target._order.target == this)*5; 
				//(target.properties[UnitProperties.Health]>>1) + 
		}
		
		public function actionTryChangeAim(newAim:Unit):void
		{
			if (_order.target == newAim)
				return;
				
			if (this.isAIControlled || !_order.target || !_order.target.isActive)
			{
				_order.target = newAim;
			}
		}
		
		public function actionAttack(target:Unit=null):int
		{
			target = target || _target;
			
			if (!target || !target.isActive || properties[UnitProperties.AttackRange] <= 0 || !target.visible)
				return 1;
			
			turnToUnit(target);
			this.model.setCurrent(UnitAnimation.Attack, _direction);
			
			if (Game.instance().gameTime.value - lastActionTime < properties[UnitProperties.AttackDelay])
				return 0;
				
			var complete:Boolean = this.model.play(this.properties[UnitProperties.AttackSpeed], 1);
			
			if (_model.currentFrameIndx == UnitSprite(_model).attackFrame)
			{				
				lastActionTime = Game.instance().gameTime.value;
				
				SoundManager.instance().playSoundOnUnit(this, _type.soundPack.attack);				
				if (this.properties[UnitProperties.ProjectileModelId])
				{
					Game.instance().projectileManager.addForUnit(this);
				}
				else
				{	
					var visEffectId:int = properties[UnitProperties.AttackVisualEffectId];
					if (visEffectId)
						Game.instance().effectManager.addEffectByType(
							Game.instance().effectManager.getEffectType(visEffectId), 
							target.physicalCenter);	

					var dmg:int = hit(target);					
					if (properties[UnitProperties.AttackSpell])
					{
						var spell:Spell = Game.instance().spellManager.createSpellFromTypeId(
							properties[UnitProperties.AttackSpell], target, this);
							
						if (spell) Game.instance().spellManager.castSpell(spell);
						else trace("Spell not found for " + this.name);
					}	
					
					if (properties[UnitProperties.AttackRange] <= 1)
					{
						var dmgRet:int = target.properties[UnitProperties.DamageRetention];
						if (dmgRet > 0)
							target.makeDamage(this, dmgRet, dmgRet, DamageType.Magic);
					}
					
					visible = true;	
				}
			}
			
			if (complete)
			{
				return 1;
			}
			return 0;
		}
		
		public function actionCast(spell:Spell):int
		{			
			if (properties[UnitProperties.CastDelay] >= Spell.MAX_CAST_DELAY)
				return 1;
			
			var targetTile:IsoTile = spell.getTile();
			
			turnToTile(targetTile);
			_model.setCurrent(UnitAnimation.Cast, _direction);
			
			var delay:int;
			if (spell.type.visualType == SpellVisualType.Ray)
				delay = Math.max(properties[UnitProperties.CastDelay], spell.type.duration);
			else
				delay = properties[UnitProperties.CastDelay];

			var gt:int = Game.instance().gameTime.value;
			
			if (gt - lastCastTime < delay)
				return 0;
							
			var lastSpCast:int = getSpellLastCastTime(spell.type);

			if (_model.currentFrameIndx == UnitSprite(_model).attackFrame
				&& lastSpCast + spell.type.cooldown < gt)
			{
				lastActionTime = gt;
				lastCastTime = lastActionTime;
				lastCastSpell = spell.type;
				setSpellLastCastTime(spell.type, lastCastTime);
				Game.instance().spellManager.castSpell(spell);
				visible = true;	
			}
			
			var complete:Boolean = _model.play(this.properties[UnitProperties.CastSpeed], 1);
			if (complete) 
			{
				lastActionTime = gt;
				return 1;
			}			
			
			return 0;
		}
	
		public function actionTryAutocast():Boolean
		{
			if (_activeSpell && this.isReadyToCast(_activeSpell) && _activeSpell.validateCost(this))
			{
				if (_activeSpell.autocastType == SpellAutocastType.AUTOCAST)
				{
					var boundary:Rectangle = 
						Game.instance().world.getRangeAroundTile(_tile, _activeSpell.range);
								
					for (var i:int = boundary.left; i < boundary.right; ++i)
					{
						for (var j:int = boundary.top; j < boundary.bottom; ++j)
						{
							var unit:Unit = Game.instance().world.getTile(i, j).unit;
							if (unit && _activeSpell.isAllowedTarget(this, unit) && _activeSpell.checkAutocastTarget(unit))
							{
								setOrder(new UnitOrderCastSpell(this, unit, _activeSpell));
								return true;
							}
						} 
					}
				}
			}
			
			return false;
		}

		public function hit(target:*, minDmg:int = int.MIN_VALUE, maxDmg:int = int.MIN_VALUE, dmgType:int=0):int
		{
			var range:int = properties[UnitProperties.AttackDamageRange];
			
			SoundManager.instance().playSoundOnUnit(this, _type.soundPack.hit);
			if (!range) 
			{
				if (target is Unit)
					return makeDamage(target, minDmg, maxDmg, dmgType, ( (!visible) ? 1.3 : 0));
				else
					return makeDamage((target as IsoTile).unit, minDmg, maxDmg, dmgType);
			}
			else
			{
				var center:IsoTile = (target is Unit) ? (target as Unit)._tile : target;
				var world:IsoWorld = Game.instance().world;
								
				var rangeRect:Rectangle = world.getRangeAroundTile(center, range);
				var l:int = rangeRect.left;
				var r:int = rangeRect.right;
				var t:int = rangeRect.top;
				var b:int = rangeRect.bottom;				
				
				var damageMadeTo:Dictionary;
				for (var i:int = l; i <= r; ++i)
				{
					for (var j:int = t; j <= b; ++j)
					{
						var tile:IsoTile = world.getTileUnsafe(i, j);
						if ((isAllowedEnemyTarget(tile.unit) || target == tile.unit))
						{
							var ratio:Number = 1 - TileUtil.getTileDist(tile, center)/range;
							if (ratio <= 0) ratio = 1/(range + 1);
							if (ratio <= 0.5)
								ratio += ratio*0.35;
									
							if (tile.unit is Structure)
							{
								if (!damageMadeTo || !damageMadeTo[tile.unit.id])
								{
									makeDamage(tile.unit, minDmg, maxDmg, dmgType, ratio);
									if (!damageMadeTo) damageMadeTo = new Dictionary();
									damageMadeTo[tile.unit.id] = true;
								}
							}
							else
							{
								makeDamage(tile.unit, minDmg, maxDmg, dmgType, ratio);								
							}
						}
					}
				}
				
			}
			
			return 0;
			
/* 			for (var i:int = 0; i < linkedUnits.length; ++i)
			{
				var prevlinked:Unit = this;
				var linkedTo:Unit = linkedUnits[i];
				while (linkedTo && linkedTo.isActive && linkedTo.linkedTo == prevlinked
					&& linkedTo.state == UnitState.Linked && linkedTo.activeSpell)
				{
					var spell:Spell = Game.instance().spellManager.createSpellFromType(linkedTo.activeSpell, target, linkedTo);
					if (Game.instance().spellManager.castSpell(spell, false))
					{
						prevlinked = linkedTo;
						linkedTo = linkedTo.linkedTo;
					}
					else
					{
						break;
					}
				}
			} */
		}
				
		public function makeDamage(target:Unit, minDmg:int = int.MIN_VALUE, maxDmg:int = int.MIN_VALUE, dmgType:int=0, ratio:Number=0):int
		{
			if (!target || target.properties[UnitProperties.Health] <= 0) return 0;
			
			if (minDmg == int.MIN_VALUE)
				minDmg = properties[UnitProperties.AttackDmgMin];
				
			if (maxDmg == int.MIN_VALUE)
				maxDmg = properties[UnitProperties.AttackDmgMax];
			
			var dmg:int = Utils.rand(minDmg, maxDmg);
			if (ratio)
				dmg = dmg*ratio;
			
			dmg = ArmorAndDamage.getUnitDamage(dmg, properties[UnitProperties.AttackDmgType], target);
			
			if (dmg > 0)
			{
				target.lastHitBy = this;
				target.lastHitDamageType = dmgType;
				target.lastHitTime = Game.instance().gameTime.value;
				target.visible = true;
			}
			
			target.changeProp(UnitProperties.Health, -dmg);
			
			return dmg;
		}

		public function actionRepair(target:Unit):int
		{
			_direction = Utils.getDir(this.center, target.center);
			_model.setCurrent(UnitAnimation.Attack, _direction);
			
			if (Game.instance().gameTime.value - lastActionTime < Util.secToFrames(1))
				return 0;
				
			var complete:Boolean = _model.play(this.properties[UnitProperties.AttackSpeed], 1);
			
			if (_model.currentFrameIndx == (_model.currentAnimationFramesNum>>1))
			{
				var constrTime:int = target._type.constructionTime/this.properties[UnitProperties.AttackSpeed];
				if (constrTime <= 0)
					constrTime = 1;
					
				if (target.properties[UnitProperties.Health] < target.properties[UnitProperties.MaxHealth])
				{
					target.changeProp(UnitProperties.Health, 
						target.baseProperties[UnitProperties.MaxHealth] / constrTime, 
						target.baseProperties[UnitProperties.MaxHealth]);
				}
			}
			if (complete)
			{
				return 1;
			}
			
			return 0;
		}
	
		public function actionDie():void
		{		
			if (this is Structure) 
				Game.instance().effectManager.addEffectByTypeId(SpecialEffects.BuildingDemolition, this.center);
			else 
				Game.instance().effectManager.addEffectByTypeId(SpecialEffects.Death, this.physicalCenter);
				
			if (type.soundPack.death)
				SoundManager.instance().playSoundOnUnit(this, type.soundPack.death, 0, 0.9);	
				
			Game.instance().eventManager.dispatch(new GameEvent(GameEvents.UNIT_DEATH, {unit:this, lastHitBy:lastHitBy}));
			
			if (lastHitBy && lastHitBy.fraction != fraction && !this.summoner)
			{				
				if (lastHitBy.fraction.isCurrentPlayer())
					Game.instance().textManager.addTextOnUnit(this, new Text("+" + type.bountyResources[ResourceType.Gold] + "g", Util.secToFrames(1.2)));
				lastHitBy.fraction.distributeExpAndBounty(lastHitBy, ExperienceCalculator.getExperienceForKill(this), type.bountyResources);
			}
			
			for (var i:int = 0; i < _spellEffects.length; ++i)
				_spellEffects[i].cleanup(this);
				
			if (_items.length && _tile)
			{
				for (var i:int = 0; i < items.length; ++i)
				{
					if (items[i].dropChance && items[i].dropChance >= Utils.rand(1, 100))
					{
						tile.placeItem(items[i]);
						break;
					}
				}
			}
			
			_spellEffects = new Vector.<SpellEffectBase>();
				
			this.isActive = false;
			this.state = UnitState.Dead;
		}	
		
		public function setTile(tile:IsoTile):Boolean
		{
			if (type.isFlying)
			{
				if (_tile == tile) return true;
			
				if (!tile)
				{
					_tile.unitFlying = null;
					Game.instance().world.pathFinder.setWalkable(this, true);
					return true;
				}
				else if (tile.isFreeToFly)
				{ 
					if (_tile)
					{
						_tile.unitFlying = null;
						Game.instance().world.pathFinder.setWalkable(this, true);
					}
					_tile = tile;
					_tile.unitFlying = this;
					return true;
				}
			}
			else
			{
				if (_tile == tile) return false;
				
				if (!tile)
				{
					_tile.unit = null;
					Game.instance().world.pathFinder.setWalkableLand(_tile, true);
					return true;
				}
				else if (tile.isFreeToMove)
				{ 
					if (_tile)
					{
						_tile.unit = null;
						Game.instance().world.pathFinder.setWalkableLand(_tile, true);
					}
					_tile = tile;
					_tile.unit = this;
					_z = tile.z;
					
					return true;
				}
			}
			
			return false;
		}

		public function isValidTarget(target:BaseObject):Boolean
		{
			if (target == this || !target || !target.isActive || !(target is Unit))
				return false;
				
			return true;
		}
				
		public function isAllowedTarget(target:Unit):Boolean
		{
			if (!target || target == this || !target.isActive || target.properties[UnitProperties.ArmorType] == ArmorType.DIVINE || !target.visible)
				return false;
			
			// if they are in different regions it is unlikelly that unit can reach target
			if (this.tile.region != target.tile.region && this.properties[UnitProperties.AttackRange] < 2)
				return false;
				
			return true;
		}
		
		public function isAllowedAllyTarget(target:Unit):Boolean
		{
			if (!target || !target.isActive || !target.fraction.isAllyOf(this.fraction))
				return false;
				
			return true;
		}

		public function isValidEnemyTarget(target:Unit):Boolean
		{
			if (!target || !target.isActive || !target.fraction.isEnemyOf(this.fraction)
				|| target.properties[UnitProperties.ArmorType] == ArmorType.DIVINE || !target.visible)
				return false;
								
			return true;
		}

		public function isAllowedEnemyTargetUnsafe(target:Unit):Boolean
		{
			return target.fraction.isEnemyOf(this.fraction)
				&& target.visible 
				&& target.properties[UnitProperties.ArmorType] != ArmorType.DIVINE
				&& (this.tile.region == target.tile.region || this.properties[UnitProperties.AttackRange] > 1);
				// if they are in different regions it is unlikelly that unit can reach target
		}
						
		public function isAllowedEnemyTarget(target:Unit):Boolean
		{
			return target && target.fraction.isEnemyOf(this.fraction) 
				&& target.visible
				&& target.properties[UnitProperties.ArmorType] != ArmorType.DIVINE
				&& (this.tile.region == target.tile.region || this.properties[UnitProperties.AttackRange] > 1);
				// if they are in different regions it is unlikelly that unit can reach target
		}
		
		public function isAllowedFractionTarget(target:Unit):Boolean
		{
			if (!target || !target.isActive || target.fraction != this.fraction)
				return false;
				
			return true;
		}
		
		public function setFraction(_fraction:Fraction):void
		{
			if (fraction)
				fraction.detachUnit(this);
				
			fraction = _fraction;
			if (fraction)
				fraction.attachUnit(this);
		}
		
		public function getProjectilePosition(projectile:Projectile):Point
		{
			var pos:Point = physicalCenter;
			var dh:Number = 0, dw:Number = 0;
			var w:Number = (projectile.model.frameWidth>>1);
				
			if (_direction == Direction.Right)
			{
				if (w >= Constants.TILE_U) w = w>>1;
				dh = -w;
				dw = w;
			}
			else if (_direction == Direction.DownRight)
			{
				dw = w;
			}
			else if (_direction == Direction.Down)
			{
				dh = w;
				dw = w;
			}
			else if (_direction == Direction.DownLeft)
			{	
				dh = w;
			}
			else if (_direction == Direction.Left)
			{	
				if (w >= Constants.TILE_U) w = w>>1;
				dh = w;
				dw = -w;
			}
			else if (_direction == Direction.UpLeft)
			{
				dw = -w;
			}
			else if (_direction == Direction.UP)
			{
				dh = -w;
				dw = -w;			
			}
			else if (_direction == Direction.UpRight)
			{
				dh = -w;
			}
				
			pos.x += dw;
			pos.y += dh;
																		
			return pos;
		}
		
		public function applySpells():void
		{
			var effects:Vector.<SpellEffectBase> = this.spellEffects;
			for (var speIndx:int = 0; speIndx < effects.length; ++speIndx)
			{
				var eff:SpellEffectBase = effects[speIndx];
				if (eff.isExpired())
				{
					eff.cleanup(this);
					effects.splice(speIndx, 1);
				}
				else
				{
					eff.apply(this);
				}
			}
		}
		
		public function addItem(item:InventoryItem):void
		{
			_items.push(item);
			if (_type.type != UnitTypes.Hero)
			{
				function sort(item1:InventoryItem, item2:InventoryItem):int {
					if (item1.type == item2.type)
						return (item1.goldCost - item2.goldCost);
					else
						return (item1.type - item2.type);
				}	
				
				_items.sort(sort);
			}
			
			Game.instance().eventManager.dispatch(new GameEvent(GameEvents.UNIT_GAIN_ITEM, {unit:this, item:item}));
		}
		
		public function addStockItems(items:Array):void
		{
			if (!_type.isTrader) return;
			
			for (var i:int = 0; i < items.length; ++i)
			{
				_stockItems.push(items[i]);
				addItem(items[i]);
			}		
		}
		
		public function resetStockItems():void
		{
			if (Game.instance().gameTime.value % Constants.STOCK_RESET_INTERVAL == 0)
			{
				for (var i:int = 0; i < _stockItems.length; ++i)
				{
					if (_items.indexOf(_stockItems[i]) == -1)
					{
						addItem(_stockItems[i]);
					}
				}
			}
		}

		public function addItems(items:Array):void
		{
			for (var i:int = 0; i < items.length; ++i)
			{
				if (items[i].type == InventoryItemType.USABLE_IMMEDIATE && this.isInWorld)
				{
					if (this is Hero) Hero(this).useItem(items[i]);
				}
				else
				{					
					_items.push(items[i]);
					Game.instance().eventManager.dispatch(new GameEvent(GameEvents.UNIT_GAIN_ITEM, {unit:this, item:items[i]}));
				}
			}
		}		
		
		/**
		 * Remove item from unit 
		 * @param item
		 * @param onlyNotEquiped This is only for heroes since only heroes can equip items
		 */
		public function removeItem(item:InventoryItem, onlyNotEquiped:Boolean = false):void
		{
			var indx:int = _items.indexOf(item);
			if (indx != -1)
			{
				_items.splice(indx, 1);
				Game.instance().eventManager.dispatch(new GameEvent(GameEvents.UNIT_LOST_ITEM, {unit:this, item:item}));
			}
		}
		
		public function hasItem(item:InventoryItem):Boolean
		{
			return _items.indexOf(item) != -1;
		}
		
		
		public function actionCallForHelp(target:Unit):void
		{
			if (!target.isActive) return;

			var gameTime:int = Game.instance().gameTime.value;
			if (lastCallForHelpTime + (Constants.FRAME_RATE << 1) > gameTime)
				return;

			lastCallForHelpTime = gameTime;
			
			if (Utils.rand(0, 2) == 1)
				return;
			
			var world:IsoWorld = Game.instance().world;
			var boundary:Rectangle = world.getRangeAroundTile(_tile, Math.min(properties[UnitProperties.SightRange], Constants.MAX_CALL_FOR_HELP_RANGE));
					
			var x1:int = boundary.left;
			var x2:int = boundary.right;
			var y1:int = boundary.top;
			var y2:int = boundary.bottom;
							
			for (var i:int = x1; i < x2; ++i)
			{
				for (var j:int = y1; j < y2; ++j)
				{
					var unit:Unit = world.getTileUnsafe(i, j).unit;
					if (unit && unit.fraction == this.fraction)
					{
						unit.requestHelp(target);
					}
				} 
			}			
		}
		
		protected function requestHelp(target:Unit):void
		{
			if (_order.target) return;
			
			if (_order is UnitOrderStand || _order is UnitOrderAttackMove)
			{
				_order.target = target;
			}
		}
		
		public function isReadyToCast(spType:SpellType):Boolean
		{
			// spells with no cost are treated as abilities - so they can't be silenced			
			return ((properties[UnitProperties.CastDelay] < Spell.MAX_CAST_DELAY || !spType.cost && properties[UnitProperties.AttackRange] > 0) 
				&& getSpellLastCastTime(spType) + spType.cooldown <= Game.instance().gameTime.value);
		}
		
		public function resetPath():void
		{
			path = new Vector.<IsoTile>();
			pathDemanded = false;
		}
	}
}