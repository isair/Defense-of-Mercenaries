package asset
{
	public class EmbeddedGameAssets
	{
		[Embed(source="/asset/music/To-New-World.mp3")]
		public static const bgm:Class;
		
		public function EmbeddedGameAssets() {}
	}
}