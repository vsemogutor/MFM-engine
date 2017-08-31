package engine.fraction
{
	import de.polygonal.ds.HashMap;
	import de.polygonal.ds.HashMapValIterator;
	
	import engine.core.ManagerBase;
	import engine.core.events.GameEvent;
	import engine.core.events.GameEvents;
	import engine.game.Game;
	import engine.structures.Structure;
	import engine.units.Unit;
	import engine.util.Constants;
	
	public final class FractionManager extends ManagerBase
	{
		private var _fractions:HashMap = new HashMap();
		private var _passive:Fraction;
		private var _passiveAgressive:Fraction;
		private var _player:Fraction;
				
		public function get fractions():HashMap
		{
			return _fractions;
		}
		
		public function get passive():Fraction
		{
			return _passive;
		}
		
		public function get player():Fraction
		{
			return _player;
		}
		
		public function get passiveAgressive():Fraction
		{
			return _passiveAgressive;
		}
		
		public function FractionManager()
		{
			super();
			
			_passive = new Fraction("Neutral", FractionControllerType.Passive, 0xBDB13A);
			addFraction(_passive, PredefinedFractions.Passive);
			
			_passiveAgressive = new Fraction("Aggressive", FractionControllerType.Passive, 0xFF0000);
			addFraction(_passiveAgressive, PredefinedFractions.PassiveAgressive);
			
			//add dummy for player fraction
			_player = new Fraction("PlayerFractionIsNotSet", FractionControllerType.Passive, 0x00FF00);		
			
			eventManager.addEventListener(GameEvents.UNIT_DEATH, onUnitDeath);
			eventManager.addEventListener(GameEvents.UNIT_ADDED, onUnitAdded);			
		}		
			
		public function addFraction(fraction:Fraction, id:int=-1):void
		{
			if (!fraction.name)
				throw new Error("fraction name is not set");
			
			if (id != Constants.UNDEFINED)
				fraction.id = id;
			else if (fraction.id == Constants.UNDEFINED)
				fraction.id = idManager.idByName(fraction.name);
			
			if (_fractions.get(fraction.id))
				throw new Error("fraction already defined");
			
			_fractions.set(fraction.id, fraction);
		}
		
		public function setRelationships(fraction1:Fraction, fraction2:Fraction, relationshipType:int):void
		{
			if (fraction1 == fraction2)
				return;
		
			fraction1.fractionRelationships[fraction2.id] = relationshipType;
			fraction2.fractionRelationships[fraction1.id] = relationshipType;	
		}
		
		public function getRelationships(fraction1:Fraction, fraction2:Fraction):int
		{
			return fraction1.getRelationships(fraction2);
		}
		
		public function getFractionById(id:int):Fraction
		{
			return _fractions.get(id) as Fraction;
		}

		public function getFractionByName(name:String):Fraction
		{
			return _fractions.get(idManager.idByName(name)) as Fraction;
		}
				
		public function setPlayerFraction(fraction:Fraction):void
		{
			_player = fraction;
		}	
		
				
		private function onUnitDeath(evt:GameEvent):void
		{
			var unit:Unit = evt.properties.unit;
			var killer:Unit = evt.properties.lastHitBy;
			
			if (killer)
			{
				if (unit is Structure)
				{
					++killer.fraction.statistics.buildingsDestroyed;
					++unit.fraction.statistics.buildingsLost;
				}
				else
				{
					++killer.fraction.statistics.unitsKilled;
					++unit.fraction.statistics.unitsLost;
				}
			}
		}

		private function onUnitAdded(evt:GameEvent):void
		{
			var unit:Unit = evt.properties.unit;
			
			// summoned units is not counted in stat
			if (!unit.summoner)
			{
				if (unit is Structure)
					++unit.fraction.statistics.buildingsConstructed;
				else
					++unit.fraction.statistics.unitsTrained;
			}
		}
		
		public function resetFractionsPopulation():void
		{
			var iter:HashMapValIterator = _fractions.iterator() as HashMapValIterator;
			while (iter.hasNext())
			{
				var fraction:Fraction = iter.next() as Fraction;
			    fraction.setResource(ResourceType.Population, 0, false);
			    fraction.setResource(ResourceType.PopulationProduction, 0, false);
			}
		}
	}
}