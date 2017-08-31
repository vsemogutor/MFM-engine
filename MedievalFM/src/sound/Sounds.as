package sound
{
	import engine.game.GameManager;
	
	import flash.media.SoundTransform;
	
	import mx.core.SoundAsset;
	
	public class Sounds
	{
		public static function play(snd:SoundAsset):void 
		{
			if (!snd)
				return;
				
			var transform:SoundTransform = new SoundTransform(GameManager.instance().options.soundVolume);
			snd.play(0, 0, transform);
		}
		
		[Embed(source="../../assets/sounds/mouse_click.mp3")] 
		private static const _mouseClickClass:Class; 
		public static const mouseClick:SoundAsset = new _mouseClickClass();
		 
		public static const buttonClick:SoundAsset = new _mouseClickClass();  

		[Embed(source="../../assets/sounds/mouse_click1.mp3")] 
		private static const _mouseClick1Class:Class; 
		public static const mouseClick1:SoundAsset = new _mouseClick1Class();
						
		[Embed(source="../../assets/sounds/autocast_click.mp3")] 
		private static const _autocastClickClass:Class; 
		public static const autocastClick:SoundAsset = new _autocastClickClass(); 
		
		public static const checkSound:SoundAsset = new _autocastClickClass();
				
		[Embed(source="../../assets/sounds/slide.mp3")] 
		public static const slideClass:Class; 
		public static const slideClick:SoundAsset = new slideClass(); 
		
		[Embed(source="../../assets/sounds/place_building.mp3")] 
		private static const _placeBuildingClass:Class; 
		public static const placeBuilding:SoundAsset = new _placeBuildingClass();
		
		public static const link:SoundAsset = new _autocastClickClass();		
	}
}