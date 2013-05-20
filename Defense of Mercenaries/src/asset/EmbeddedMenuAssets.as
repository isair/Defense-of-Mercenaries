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
		
		[Embed(source="/asset/menu/bgMenu.png")]
		public static const bgMenu:Class;
		
		[Embed(source="/asset/menu/bgMenuNormal.png")]
		public static const bgMenuNormal:Class;
		
		[Embed(source="/asset/menu/victory.png")]
		public static const victory:Class;
		
		[Embed(source="/asset/menu/gameover.png")]
		public static const gameover:Class;
		
		public function EmbeddedMenuAssets() {}
	}
}