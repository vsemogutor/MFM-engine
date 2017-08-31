package engine.util
{    
    import __AS3__.vec.Vector;
    
    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;
    import flash.utils.IDataInput;
    import flash.utils.IDataOutput;
    import flash.utils.IExternalizable;
    
    import mx.collections.IList;
    import mx.core.IPropertyChangeNotifier;
    import mx.events.CollectionEvent;
    import mx.events.CollectionEventKind;
    import mx.events.PropertyChangeEvent;
    import mx.events.PropertyChangeEventKind;
    import mx.resources.IResourceManager;
    import mx.resources.ResourceManager;
    import mx.utils.ArrayUtil;

    internal final class VectorArray extends EventDispatcher implements IList, IExternalizable, IPropertyChangeNotifier
    {
        private var _uid:String = "";
        private var _source:Vector.<Object> = null;
        private var resourceManager:IResourceManager = null;
        private var dispatchItemEvents:uint = 0;
        private var sourceAsArray:Array = null;
        private var sourceAsArrayValid:Boolean = false;

        public function VectorArray(source:Vector.<Object>)
        {
            this.resourceManager = ResourceManager.getInstance();
            this.source = source;
        } 

        public function get source() : Vector.<Object>
        {
            return this._source;
        } 

        public function set source(value:Vector.<Object>) : void
        {
            var len:uint = 0;
            var evt:CollectionEvent = null;
            if (this._source && this._source.length)
            {
                len = this._source.length;
                while (len--)
                {
                    this.stopMonitorUpdates(this._source[len]);
                }
            }
            this._source = value ? (value) : (new Vector.<Object>);
            len = this._source.length;
            while (len--)
            {
                this.monitorUpdates(this._source[len]);
            }
            if (this.dispatchItemEvents == 0)
            {
                evt = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                evt.kind = CollectionEventKind.RESET;
                this.dispatchEvent(evt);
            }
            this.sourceAsArrayValid = false;
        } 

        public function get length() : int
        {
            if (this.source)
            {
                return this.source.length;
            }
            return 0;
        } 

        public function addItem(item:Object) : void
        {
            this.addItemAt(item, this.length);
        } 

        public function addItemAt(item:Object, index:int) : void
        {
            if (index > this.length)
            {
                throw new RangeError(this.resourceManager.getString("collections", "outOfBounds", [index]));
            }
            this.source.splice(index, 0, item);
            this.monitorUpdates(item);
            this.dispatchCollectionEvent(CollectionEventKind.ADD, item, index);
            this.sourceAsArrayValid = false;
        } 

        public function getItemAt(index:int, prefetch:int = 0) : Object
        {
            if (index >= this.length)
            {
                throw new RangeError(this.resourceManager.getString("collections", "outOfBounds", [index]));
            }
            return this.source[index];
        } 

        public function getItemIndex(item:Object) : int
        {
            return ArrayUtil.getItemIndex(item, this.toArray());
        } 

        public function itemUpdated(item:Object, property:Object = null, oldValue:Object = null, newValue:Object = null) : void
        {
            var evt:PropertyChangeEvent = null;
            evt = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
            evt.kind = PropertyChangeEventKind.UPDATE;
            evt.source = item;
            evt.property = property;
            evt.oldValue = oldValue;
            evt.newValue = newValue;
            this.onItemUpdate(evt);
            this.sourceAsArrayValid = false;
        } 

        public function removeAll() : void
        {
            var len:uint = 0;
            len = this.source.length;
            while (len--)
            {
                this.stopMonitorUpdates(this.source[len]);
            }
            this.source.splice(0, this.source.length);
            this.dispatchCollectionEvent(CollectionEventKind.RESET);
            this.sourceAsArrayValid = false;
        } 

        public function removeItemAt(index:int) : Object
        {
            var itm:Object = null;
            if (index >= this.source.length)
            {
                throw new RangeError(this.resourceManager.getString("collections", "outOfBounds", [index]));
            }
            itm = this.source.splice(index, 1)[0];
            this.sourceAsArrayValid = false;
            this.stopMonitorUpdates(itm);
            this.dispatchCollectionEvent(CollectionEventKind.REMOVE, itm, index);
            return itm;
        } 

        public function setItemAt(item:Object, index:int) : Object
        {
            var itm:Object = null;
            var collEvtExist:Boolean = false;
            var propEvtExist:Boolean = false;
            var propEvt:PropertyChangeEvent = null;
            var collEvt:CollectionEvent = null;
            if (index >= this.source.length)
            {
                throw new RangeError(this.resourceManager.getString("collections", "outOfBounds", [index]));
            }
            itm = this.source[index];
            this.source[index] = item;
            this.sourceAsArrayValid = false;
            this.stopMonitorUpdates(itm);
            this.monitorUpdates(item);
            if (this.dispatchItemEvents == 0)
            {
                collEvtExist = this.hasEventListener(CollectionEvent.COLLECTION_CHANGE);
                propEvtExist = this.hasEventListener(PropertyChangeEvent.PROPERTY_CHANGE);
                if (propEvtExist)
                {
                    propEvt = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                    propEvt.kind = PropertyChangeEventKind.UPDATE;
                    propEvt.oldValue = itm;
                    propEvt.newValue = item;
                    propEvt.property = index;
                }
                if (collEvtExist)
                {
                    collEvt = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                    collEvt.kind = CollectionEventKind.REPLACE;
                    collEvt.location = index;
                    collEvt.items.push(propEvt);
                    this.dispatchEvent(collEvt);
                }
                if (propEvtExist)
                {
                    this.dispatchEvent(propEvt);
                }
            }
            return itm;
        } 

        public function toArray() : Array
        {
            var len:uint = 0;
            if (!this.sourceAsArrayValid)
            {
                this.sourceAsArray = new Array(this.source.length);
                len = this.source.length;
                while (len--)
                {
                    this.sourceAsArray[len] = this.source[len];
                }
                this.sourceAsArrayValid = false;
            }
            return this.sourceAsArray.concat();
        } 

        public function writeExternal(output:IDataOutput) : void
        {
            output.writeObject(this._source);
        } 

        public function readExternal(input:IDataInput) : void
        {
            this.source = input.readObject();
        } 

        public function get uid() : String
        {
            return this._uid;
        } 

        public function set uid(value:String) : void
        {
            this._uid = value;
        } 

        private function monitorUpdates(item:Object) : void
        {
            if (item is IEventDispatcher)
            {
                IEventDispatcher(item).addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onItemUpdate, false, 0, true);
            }
        } 

        protected function stopMonitorUpdates(item:Object) : void
        {
            if (item is IEventDispatcher)
            {
                IEventDispatcher(item).removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onItemUpdate);
            }
        } 

        protected function onItemUpdate(event:PropertyChangeEvent) : void
        {
            var propEvt:PropertyChangeEvent = null;
            var itemIndx:uint = 0;
            this.dispatchCollectionEvent(CollectionEventKind.UPDATE, event);
            if (this.hasEventListener(PropertyChangeEvent.PROPERTY_CHANGE))
            {
                propEvt = PropertyChangeEvent(event.clone());
                itemIndx = this.getItemIndex(event.target);
                propEvt.property = itemIndx.toString() + "." + event.property;
                this.dispatchEvent(propEvt);
            }
        } 

        private function dispatchCollectionEvent(kind:String, item:Object = null, location:int = -1) : void
        {
            var collEvt:CollectionEvent = null;
            var propEvt:PropertyChangeEvent = null;
            if (this.dispatchItemEvents == 0)
            {
                if (this.hasEventListener(CollectionEvent.COLLECTION_CHANGE))
                {
                    collEvt = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                    collEvt.kind = kind;
                    collEvt.items.push(item);
                    collEvt.location = location;
                    this.dispatchEvent(collEvt);
                }
                if (this.hasEventListener(PropertyChangeEvent.PROPERTY_CHANGE))
                {
                    this.hasEventListener(PropertyChangeEvent.PROPERTY_CHANGE);
                }
                if (kind == CollectionEventKind.REMOVE)
                {
                    propEvt = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                    propEvt.property = location;
                    if (kind == CollectionEventKind.ADD)
                    {
                        propEvt.newValue = item;
                    }
                    else
                    {
                        propEvt.oldValue = item;
                    }
                    this.dispatchEvent(propEvt);
                }
            }
        } 
    }
}