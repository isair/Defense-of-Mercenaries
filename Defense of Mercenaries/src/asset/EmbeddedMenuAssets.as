package asset
{
	public class EmbeddedMenuAssets
	{
		[Embed(source="/asset/music/Escadre.mp3")]
		public static const bgm:Class;
		
		public function EmbeddedMenuAssets() {}
	}
}