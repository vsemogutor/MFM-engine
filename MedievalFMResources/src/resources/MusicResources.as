package resources
{
	import mx.core.SoundAsset;
	
	public final class MusicResources
	{
		[Embed(source="../../Music/1.mp3")]
		public static const track1Class:Class; 
		public static const track1:SoundAsset = new track1Class(); 
		
		[Embed(source="../../Music/2.mp3")]
		public static const track2Class:Class; 
		public static const track2:SoundAsset = new track2Class(); 
	}
}