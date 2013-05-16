package asset
{
	public class EmbeddedMenuAssets
	{
		[Embed(source="/asset/music/Escadre.mp3")]
		public static const bgm:Class;
		
		[Embed(source="/asset/music/Game Over.mp3")]
		public static const gameOver:Class;
		
		[Embed(source="/asset/music/Forgotten Victory.mp3")]
		public static const victoryTrack:Class;
		
		public function EmbeddedMenuAssets() {}
	}
}