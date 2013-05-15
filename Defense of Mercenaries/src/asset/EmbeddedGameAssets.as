package asset
{
	public class EmbeddedGameAssets
	{
		[Embed(source="/asset/music/To-New-World.mp3")]
		public static const bgm:Class;
		
		[Embed(source="/asset/tile/grass.png")]
		public static const grassTexture:Class;
		
		[Embed(source="/asset/tile/road.png")]
		public static const roadTexture:Class;
		
		[Embed(source="/asset/tower/tower.png")]
		public static const towerTexture:Class;
		
		[Embed(source="/asset/tower/slowtower.png")]
		public static const slowTowerTexture:Class;
		
		[Embed(source="/asset/tower/fasttower.png")]
		public static const fastTowerTexture:Class;
		
		[Embed(source="/asset/tower/cannontower.png")]
		public static const cannonTowerTexture:Class;

		public function EmbeddedGameAssets() {}
	}
}