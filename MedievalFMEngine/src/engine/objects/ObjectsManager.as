package engine.objects
{
	import __AS3__.vec.Vector;
	
	import de.polygonal.ds.HashMap;
	
	import engine.core.ManagerBase;
	import engine.core.events.GameEvent;
	import engine.core.events.GameEvents;
	import engine.objects.isometric.IsoObject;
	import engine.units.Unit;
	import engine.util.Constants;
	
	import flash.geom.Point;
	
	import mx.collections.ArrayCollection;

	public final class ObjectsManager extends ManagerBase
	{
		private var _objects:Vector.<IsoObject> = new Vector.<IsoObject>();
		private var _objectTypes:HashMap = new HashMap();
		public var renderablesRepository:ArrayCollection;
		
		public function get objects():Vector.<IsoObject> {
			return _objects;
		}
		
		public function get objectTypes():HashMap {
			return _objectTypes;
		}
		
		public function placeObjectOnWorld(object:BaseObject, position:*):Boolean 
		{
			if (!object || object.isInWorld)
				return false;
			
			if (object is Unit)
			{
				return game.unitManager.placeUnitOnWorld(object as Unit, position);
			}
			
			var pos:Point;
			
			if (position is Point)
				pos = position;
			else
				pos = new Point(position.xindex, position.yindex);
			
			var ret:Boolean = world.placeObjectOnWorld(object, pos);
			if (ret)
			{
				_objects.push(object);
				eventManager.dispatch(new GameEvent(GameEvents.OBJECT_ADDED, {object:object}));
			}
			object.isInWorld = ret;
			
			return ret;
		}
		
		public function addObjectType(type:ObjectType, id:int = -1):int
		{
			if (id != Constants.UNDEFINED)
				type.id = id;
			else if (type.id == Constants.UNDEFINED)
				type.id = idManager.idByName(type.name);
			
			if (_objectTypes.get(id))
				throw new Error("object type already defined");
			
			type.validateDefinition();
			type.setColor();
			_objectTypes.set(type.id, type);
			
			return type.id;
		}
		
		public function createObjectFromType(typeOrId:*):IsoObject
		{
			var type:ObjectType;
			if (typeOrId is int)
				type = ObjectType(_objectTypes.get(typeOrId));
			else 
				type = typeOrId;
				
			
			var object:IsoObject = new IsoObject(type);
			object.id = idManager.nextId();
			object.setModel(type.model.clone());
			
			return object;
		}
		
		public function removeObject(object:BaseObject):void
		{
			world.removeObjectFromWorld(object);
			var oLen:int = _objects.length;
			for (var i:int = 0; i < oLen; ++i)
			{
				if (_objects[i].id == object.id)
				{
					_objects.splice(i, 1);
					eventManager.dispatch(new GameEvent(GameEvents.OBJECT_REMOVED, {object:object}));
					break;
				}
			}
		}

	}
}