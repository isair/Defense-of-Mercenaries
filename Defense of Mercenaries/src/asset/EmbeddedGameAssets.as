package asset
{
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	import state.Game;
	
	public class EmbeddedGameAssets
	{
		[Embed(source="/asset/fonts/ahronbd.ttf", embedAsCFF="false", fontFamily="Aharoni")]
		private static const Aharoni:Class;
		
		[Embed(source="/asset/music/Dust and Bones.mp3")]
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
		
		[Embed(source="/asset/interface/bottomwall.png")]
		public static const hudTexture:Class;
		
		[Embed(source="/asset/interface/border.png")]
		public static const borderTexture:Class;
		
		[Embed(source="/asset/interface/gate.png")]
		public static const gateTexture:Class;
		
		[Embed(source="/asset/interface/towercard.png")]
		public static const basicTexture:Class;
		
		[Embed(source="/asset/interface/frostcard.png")]
		public static const frostTexture:Class;

		[Embed(source="/asset/interface/rapidcard.png")]
		public static const rapidTexture:Class;
		
		[Embed(source="/asset/interface/cannoncard.png")]
		public static const cannonTexture:Class;
		
		[Embed(source="/asset/interface/boostcard.png")]
		public static const boostTexture:Class;
		
		[Embed(source="/asset/interface/freezecard.png")]
		public static const freezeTexture:Class;
		
		[Embed(source="/asset/interface/goldbar.png")]
		public static const goldbarTexture:Class;
		
		[Embed(source="/asset/interface/callwave.png")]
		public static const callwaveTexture:Class;
		
		[Embed(source="/asset/interface/startround.png")]
		public static const startroundTexture:Class;
		
		[Embed(source="/asset/enemy/enemy.xml", mimeType="application/octet-stream")]
		private static const enemyData:Class;
		
		[Embed(source="/asset/enemy/enemy.png")]
		private static const enemyTexture:Class;
		
		private static var enemyAtlas:TextureAtlas = null;
		
		[Embed(source="/asset/tile/roads.xml", mimeType="application/octet-stream")]
		private static const roadsData:Class;
		
		[Embed(source="/asset/tile/roads.png")]
		private static const roadsTexture:Class;
		
		private static var roadsAtlas:TextureAtlas = null;

		public function EmbeddedGameAssets() {}
		
		public static function generateEnemyAtlas():void
		{
			enemyAtlas = new TextureAtlas(Texture.fromBitmap(new enemyTexture()), XML(new enemyData()));
			roadsAtlas = new TextureAtlas(Texture.fromBitmap(new roadsTexture()), XML(new roadsData()));
		}
		
		public static function getEnemyAtlas():TextureAtlas
		{
			return enemyAtlas;
		}
		
		public static function getRoadsAtlas():TextureAtlas
		{
			return roadsAtlas;
		}
	}
}