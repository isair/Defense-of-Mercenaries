package asset
{
	public class EmbeddedMenuAssets
	{
		[Embed(source="/asset/music/Dust and Bones.mp3")]
		public static const bgm:Class;
		
		[Embed(source="/asset/music/Game Over.mp3")]
		public static const gameOver:Class;
		
		public function EmbeddedMenuAssets() {}
	}
}