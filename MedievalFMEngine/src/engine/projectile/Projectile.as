package engine.projectile
{
	import __AS3__.vec.Vector;
	
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;
	
	import computers.utils.Utils;
	
	import engine.animation.AnimatedSprite;
	import engine.core.isometric.*;
	import engine.game.Game;
	import engine.specialEffects.SpecialEffectType;
	import engine.spells.Spell;
	import engine.units.*;
	import engine.util.Constants;
	
	import flash.geom.Point;
	
	public final class Projectile
	{						
		internal var properties:Vector.<int>;
		internal var spell:Spell;
		internal var isSpell:Boolean;
		public var model:AnimatedSprite;
		internal var visalEffect: SpecialEffectType;
		internal var owner:Unit;
		internal var target:Unit;	
		internal var targetPos:Point;	
		internal var speed:int; // num of frames to cover one tile
		internal var behaviourType:int;	
		public var position:Point;
		internal var direction:int;
		internal var trajectory:int;
				
		public function Projectile(_target:* = null,  behaviour:int = 0)
		{
			if (_target) setTarget(_target, behaviour);
		}
		
		public function setTarget(_target:*, behaviour:int = 0):void
		{
			if (_target is Point)
			{
				target = null;
				targetPos = _target.clone();
				behaviourType = ProjectileBehaviour.NORMAL;
			}
			else if (_target is Unit)
			{
				behaviourType = behaviour;
				if (behaviourType != ProjectileBehaviour.NORMAL)
				{
					target = _target;
					targetPos = target.physicalCenter;
				}
				else
				{
					targetPos = _target.tile.center;
					target = null;
				}		
			}
			else if (_target is IsoTile)
			{
				targetPos = target.center;
				target = null;
				behaviourType = ProjectileBehaviour.NORMAL;
			}
		}
		
		public function getTarget():*
		{
			return target || targetPos;
		}
		 
		public function apply(target:*):void
		{
			if (!isSpell)
				owner.hit(target);
				
			if (spell)
				Game.instance().spellManager.castSpell(spell, true, true);
				
			if (visalEffect)
				Game.instance().effectManager.addEffectByType(visalEffect, targetPos);
		}
		
		public function move():Boolean
		{
			if (target && !targetPos.equals(target.physicalCenter) 
				&& behaviourType == ProjectileBehaviour.SNAP_TO_TARGET)
			{
				stop();
				targetPos = target.physicalCenter;
			}
				
			if (!TweenMax.isTweening(this.position) || behaviourType == ProjectileBehaviour.SNAP_TO_OWNER)
			{
				model.currentAnimationIndx = direction;								
				if (behaviourType != ProjectileBehaviour.SNAP_TO_OWNER)
				{			

					model.play(model.currentAnimationFramesNum);
					var time:int = (Utils.getDistance(targetPos, position)/Constants.TILE_U)*speed;
					
					if (!trajectory)
					{
						TweenMax.to(this.position, time, 
							{x:targetPos.x, y:targetPos.y, useFrames:true, ease:Linear.easeOut});
					}
					else
					{			
						var dx:int = targetPos.x - position.x;
						var dy:int = targetPos.y - position.y;
						
						if (Math.abs(dx) > 40 && Math.abs(dy) > 40)
							TweenMax.to(this.position, time/3, 
								{x: ( dx/3 + Utils.rand(-20, 20)).toString() , y: (dy/3 + Utils.rand(-20, 20)).toString(), useFrames:true, ease:Linear.easeOut});						
						else					
							TweenMax.to(this.position, time, 
								{x:targetPos.x, y:targetPos.y, useFrames:true, ease:Linear.easeOut});																		
					}
				}
				else
				{				
					var complete:Boolean = model.play(model.currentAnimationFramesNum, 1);
					return complete;
				}
			}
			
			// avoid Math.abs for perf reasons
			var xd:int = targetPos.x - position.x;
			if (xd < 0) xd = -xd;
			var yd:int = targetPos.y - position.y;		
			if (yd < 0) yd = -yd;
			
			return (xd <= (model.frameWidth/3)) && (yd <= (model.frameHeight/3));
		}
		
		public function stop():void
		{
			TweenMax.killTweensOf(this.position);
			model.stop();
		}	
	}
}