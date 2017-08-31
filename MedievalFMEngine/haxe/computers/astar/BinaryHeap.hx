package computers.astar;

class BinaryHeap
{
	// first element is not used
	public var heapLen:Int;
	private static var heap:flash.Vector<AstarNode>;
	
	public inline function getHeap():flash.Vector<AstarNode>
	{
		return heap;
	}
	
	public function new(size:UInt)
	{
		if (heap == null || size != heap.length)
			heap = new flash.Vector<AstarNode>(size);
		heapLen = 1;
	}
	
	public function addToHeap(newTile:AstarNode):Void
	{
		var cp:Int = heapLen;
		heap[heapLen] = newTile;
		++heapLen;
	
		while(cp != 1)
		{
			var n1:AstarNode = heap[cp];
			var n2:AstarNode = heap[cp>>1];
			if(n1.getF() <= n2.getF())
			{
				heap[cp>>1] = n1;
				heap[cp] = n2;
				cp = cp>>1;
			} 
			else 
			{
				break;	
			}
		}
	}
	
	public function getLowest():AstarNode 
	{
		var cp:Int = 1; //current position
		var np:Int; //next position
		var lowest:AstarNode = heap[1];
		var hLength:Int = heapLen - 1;
		var hnp:Int;
		
		if(heap.length == 2)
		{
			--heapLen;
		} 
		else 
		{
			heap[1] = heap[hLength];
			--heapLen;
		}

		while(true)
		{
			np = cp;
			hnp = np<<1;
			if((cp<<1)+1 < hLength )
			{
				if(heap[np].getF() >= heap[hnp].getF() ) cp = hnp;
				if(heap[cp].getF()  >= heap[hnp+1].getF() ) cp = hnp+1;
			} 
			else if((np<<1) < hLength )
			{
				if(heap[np].getF()  >= heap[hnp].getF() ) cp = hnp;
			}
			
			if(np != cp)
			{
				var t:AstarNode = heap[np];
				heap[np] = heap[cp];
				heap[cp] = t;
			} 
			else 
			{
				return lowest; 
			}
		}
		return null;
	}
	
	public inline function getLength():Int
	{
		return (heapLen - 1);
	}
	
	public function updateList(node:AstarNode):Void
	{
		var cp:Int = 0;
		var id:Int = node.id;
		for (i in 1...heapLen)
		{
			if(heap[i].id == id) 
			{
				cp = i;
				break;
			}
		}
		
		while(cp > 1)
		{
			var n1:AstarNode = heap[cp];
			var n2:AstarNode = heap[cp>>1];
			if(n1.getF() <= n2.getF())
			{
				heap[cp>>1] = n1;
				heap[cp] = n2;
				cp = cp>>1;
			} 
			else 
			{
				break;	
			}
		}
	}
}