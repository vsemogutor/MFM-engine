package images
{
	import flash.display.Bitmap;
	
	import mx.core.BitmapAsset;
	
	public final class Images
	{
		[Embed(source="../../assets/normal_cursor.png")] 
		public static const normalCursorClass:Class; 

		[Embed(source="../../assets/normal_active_cursor.png")] 
		public static const normalActiveCursorClass:Class; 
				
		[Embed(source="../../assets/select_cursor.png")] 
		public static const selectCursorClass:Class; 
		public static const selectCursorSize:int = 19;

		[Embed(source="../../assets/attack_active_cursor.png")] 
		public static const attackActiveCursorClass:Class; 
				
		[Embed(source="../../assets/attack_cursor.png")] 
		public static const attackCursorClass:Class; 
		public static const attackCursorSize:int = 19;	

		[Embed(source="../../assets/trade_cursor.png")] 
		public static const tradeCursorClass:Class; 
				
		[Embed(source="../../assets/flag_animation.png")] 
		public static const flagAnimClass:Class;
		public static const flagAnim:BitmapAsset = new flagAnimClass();	
		
/* 		[Embed(source="../../assets/branding/std as3.0 cs3.png")] 
		public static var imageSponsorClass1:Class; 
				
		[Embed(source="../../assets/branding/ninjalogo.jpg")] 
		public static var imageSponsorClass2:Class;  */
		
		[Embed(source="../../assets/game_logo.png")] 
		public static var gameLogo:Class; 	
		
		[Embed("../../assets/plus_orange.png")]
		public static const plusButtonClass:Class;
		public static const plusButtonImage:BitmapAsset = new plusButtonClass();	
		
		[Embed("../../assets/left_orange.png")]
		public static const leftButtonClass:Class;
		public static const leftButtonImage:BitmapAsset = new leftButtonClass();
		
		[Embed("../../assets/right_orange.png")]
		public static const rightButtonClass:Class;
		public static const rightButtonImage:BitmapAsset = new rightButtonClass();	
		
		[Embed("../../assets/anchor.png")]
		public static const anchorClass:Class;
		public static const anchorImage:BitmapAsset = new anchorClass();
		
		[Embed("../../assets/configure.png")]
		public static const configureClass:Class;
		
		[Embed("../../assets/preset_normal.png")]
		public static const presetNormalClass:Class;															
	}
}