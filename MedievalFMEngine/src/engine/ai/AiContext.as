package engine.ai
{
	import engine.heros.Hero;
	
	public dynamic class AiContext
	{
		public function AiContext(ai:AiBase)
		{
			this.ai = ai;
		}
		
		public var conditions:Array = new Array();
		public var signals:Array = new Array();
		public var ai:AiBase;
	}
}