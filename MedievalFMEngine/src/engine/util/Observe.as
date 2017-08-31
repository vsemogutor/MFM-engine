package engine.util
{
	public class Observe
	{
		public var handler : Function; 
	 	
	 	public function Observe() : void
	 	{
	 		
	 	}
	 	
		public function set source( source : * ) : void 
	  	{ 
	        	handler.call(); 
	  	} 
	}
}