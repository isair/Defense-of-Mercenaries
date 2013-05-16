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
		
		[Embed(source="/asset/menu/mainmenu.png")]
		public static const mainmenu:Class;
		
		[Embed(source="/asset/menu/victory.png")]
		public static const victory:Class;
		
		[Embed(source="/asset/menu/mainmenu.png")]
		public static const gameover:Class;

		
		public function EmbeddedMenuAssets() {}
	}
}