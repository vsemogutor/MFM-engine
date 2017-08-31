package engine.util
{
	public final class Constants
	{
		public static const FRAME_RATE:int = 20;
		public static const UNDEFINED:int = -1;
		public static const TRUE:int = 1;
		public static const FALSE:int = 0;	
		public static const TILE_WIDTH:int = 48;
		public static const TILE_HEIGHT:int = TILE_WIDTH/2;
						
		public static const TILE_U:int = TILE_WIDTH/2;
		public static const TILE_V:int = TILE_U/2;
		
		public static const SELECTION_ALPHA:Number = 0.4;	
		
		public static const PATH_EXPIRATION_TIME:int = FRAME_RATE - 3;
		public static const ORDER_DISCARD_TIME:int = 30*FRAME_RATE;
		
		public static const MAX_TRAIN_QUEUE_SIZE:int = 25;
		public static const MAX_UI_TRAIN_QUEUE_SIZE:int = 7;
		
		public static const MAX_CALL_FOR_HELP_RANGE:int = 5;	
		
		public static const AI_HERO_THIINK_INTERVAL:int = FRAME_RATE - 2;	
		
		public static const STOCK_RESET_INTERVAL:int = FRAME_RATE*60;
		
		public static const UNIT_MOVE_QUANT_TIME:int = 8;		
		public static const UNIT_MOVE_QUANT_POS:int = TILE_WIDTH/UNIT_MOVE_QUANT_TIME;
		public static const UNIT_MOVE_QUANT_NEG:int = -UNIT_MOVE_QUANT_POS;
	}
}