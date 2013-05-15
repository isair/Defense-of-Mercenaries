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
		
		[Embed(source="/asset/tower/base.png")]
		public static const baseTexture:Class;
		
		[Embed(source="/asset/tower/obs1.png")]
		public static const obs1Texture:Class;
		
		[Embed(source="/asset/tower/obs2.png")]
		public static const obs2Texture:Class;

		[Embed(source="/asset/tower/obs3.png")]
		public static const obs3Texture:Class;
		
		[Embed(source="/asset/interface/wall.png")]
		public static const wallTexture:Class;
		
		[Embed(source="/asset/interface/gate.png")]
		public static const gateTexture:Class;
				
		public function EmbeddedGameAssets() {}
	}
}