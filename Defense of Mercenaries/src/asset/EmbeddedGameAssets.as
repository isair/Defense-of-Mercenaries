package asset
{
	public class EmbeddedGameAssets
	{
		[Embed(source="/asset/music/To-New-World.mp3")]
		public static const bgm:Class;
		
		[Embed(source="/asset/tile/grass.png")]
		public static const grassTexture:Class;
		
		public function EmbeddedGameAssets() {}
	}
}