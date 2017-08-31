package engine.spells
{
	import __AS3__.vec.Vector;
	
	import computers.utils.Utils;
	
	import engine.game.Game;
	import engine.structures.Structure;
	import engine.text.Text;
	import engine.units.DamageType;
	import engine.units.Unit;
	import engine.units.UnitProperties;
	import engine.util.Constants;
	import engine.util.Util;
	
	public class SpellEffect extends SpellEffectBase
	{
		public var propertyId:int;
		public var minChange:Number;
		public var maxChange:Number;
		public var coeficientPropertyId:int = -1;	
		public var opType:int;	
		public var dmgType:int = DamageType.Spell;
		public var dmgSubtype:int = 0;
		public var _affectedByMagicResistance:int = 1;
		private var _applied:Boolean;
		public var gainSpellBonusCoeff:Number = 1;
		public var critChance:int;
		public var critOnSameDamage:Boolean;
				
		public function set affectedByMagicResistance(value:Boolean):void {
			_affectedByMagicResistance = (value ? 1 : 0);
		}
		
		public function SpellEffect() 
		{
			id = Game.instance().idManager.nextId();
		}		
		
		public override function apply(target:Unit):Object
		{		
			if (!startTime)
				startTime = Game.instance().gameTime.value;
				
			if (lifeTime >= duration)
				return 0;
			
			var res:int = target.properties[UnitProperties.MagicRes] * _affectedByMagicResistance;
			var curApplyChance:int = applyChance;
			if (res < 100 && (lifeTime % period) == 0)
			{	
				if (!_applied)
				{
					// from certain point resistance affects spell apply chance
					if (res >= 30)
					{
						curApplyChance = 100 - (res>>1);
					}
				}
				else
				{
					// if effect has proc'ed - chance to resist lowered
					if (res >= 70)
					{
						curApplyChance = 100 - res>>2 + lifeTime/Constants.FRAME_RATE;
					}					
				}
				
				if (!curApplyChance || Utils.rand(1, 100) <= curApplyChance)
				{		
					if (!_applied)
					{
						if (dmgSubtype)
						{
							var effects:Vector.<SpellEffectBase> = target.spellEffects;	
							for (var i:int = 0; i < effects.length; ++i)
							{
								var effect:SpellEffect = effects[i] as SpellEffect;
								if (effect && effect != this)
								{ 
									if (effect.dmgSubtype != dmgSubtype)
									{
										if (Utils.rand(0,2) == 1)
										{
											effect.cleanup(target);
											effects.splice(i, 1);
										}
									}
									else if (critOnSameDamage)
									{
										if (critChance > 10)
										{
											critChance = 100;
											effect.cleanup(target);
											effects.splice(i, 1);											
										} 
									}
								}
							}
						}			
					}
								
					_applied = true;
					
					var effChange:int;
					
					if (!maxChange)
						maxChange = effChange = minChange;
					else
						effChange = Utils.rand(minChange, maxChange);
								
					if (coeficientPropertyId != -1)
					{
						effChange = target.properties[coeficientPropertyId] * (effChange/100);
					}
					
					switch (opType)
					{
						case SpellEffectOperationType.Add:
						{
							if (effChange < 0)
							{
								if (propertyId == UnitProperties.Health)
								{
									effChange += effChange*(owner.properties[UnitProperties.SpellBonus]/100)*gainSpellBonusCoeff;
									if (critChance && critChance > Utils.rand(1, 100)) 
									{
										effChange = (effChange<<1);
										Game.instance().textManager.addTextOnUnit(target, new Text("crit", Util.secToFrames(1.2)));
									}
									effChange = owner.makeDamage(target, -effChange, -effChange, dmgType);
								}
								else
									target.changeProp(propertyId, effChange);								
							}
							else
							{
								if (propertyId == UnitProperties.Health)
								{
									if (!(target is Structure))
										target.changeProp(propertyId, effChange, target.properties[UnitProperties.MaxHealth]);
								}
								else if (propertyId == UnitProperties.Mana)
								{
									target.changeProp(propertyId, effChange, target.properties[UnitProperties.MaxMana]);
								}
								else
								{
									target.changeProp(propertyId, effChange);
								}
							}
						}
						break;
						
						case SpellEffectOperationType.Set:
							target.setProp(propertyId, effChange);
						break;
						
						case SpellEffectOperationType.Multiply:
							target.setProp(propertyId, target.properties[propertyId]*effChange);
						break;
					}
				}
			}
			
				
			++lifeTime;
			return effChange;
		}
	}
}