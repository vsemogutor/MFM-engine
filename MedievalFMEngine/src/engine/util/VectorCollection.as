package engine.util
{
    import __AS3__.vec.Vector;
    import flash.utils.*;
    import mx.collections.*;

    public final class VectorCollection extends ListCollectionView implements IExternalizable
    {
        public function VectorCollection(source:Object)
        {
            this.source = source;
        } 

        public function get source():Object
        {
            if (this.list is VectorArray)
            {
                return VectorArray(this.list).source;
            }
            return null;
        } 

        public function set source(value:Object):void
        {
            this.list = new VectorArray(Vector.<Object>(value));
        } 

        public function readExternal(input:IDataInput):void
        {
            if (list is IExternalizable)
            {
                IExternalizable(list).readExternal(input);
            }
            else
            {
                source = input.readObject() as Vector.<Object>;
            }
        } 

        public function writeExternal(output:IDataOutput):void
        {
            if (this.list is IExternalizable)
            {
                IExternalizable(list).writeExternal(output);
            }
            else
            {
                output.writeObject(source);
            }
        } 
    }
}