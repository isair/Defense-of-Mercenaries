package asset
{
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	import game.state.Game;
	
	public class EmbeddedGameAssets
	{
		[Embed(source="/asset/fonts/ahronbd.ttf", embedAsCFF="false", fontFamily="Aharoni")]
		private static const Aharoni:Class;
		
		[Embed(source="/asset/music/Dust and Bones.mp3")]
		public static const bgm:Class;
		
		[Embed(source="/asset/sounds/enemy death.mp3")]
		public static const deathSound:Class;
		
		[Embed(source="/asset/sounds/explosion.mp3")]
		public static const explosionSound:Class;
		
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
		
		[Embed(source="/asset/tile/grass.xml", mimeType="application/octet-stream")]
		private static const grassData:Class;
		
		[Embed(source="/asset/tile/grass.png")]
		private static const grassTexture:Class;
		
		private static var grassAtlas:TextureAtlas = null;
		
		[Embed(source="/asset/tower/occupiers.xml", mimeType="application/octet-stream")]
		private static const occupiersData:Class;
		
		[Embed(source="/asset/tower/occupiers.png")]
		private static const occupiersTexture:Class;
		
		private static var occupiersAtlas:TextureAtlas = null;
		
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
			occupiersAtlas = new TextureAtlas(Texture.fromBitmap(new occupiersTexture()), XML(new occupiersData()));
			grassAtlas = new TextureAtlas(Texture.fromBitmap(new grassTexture()), XML(new grassData()));
		}
		
		public static function getEnemyAtlas():TextureAtlas
		{
			return enemyAtlas;
		}
		
		public static function getRoadsAtlas():TextureAtlas
		{
			return roadsAtlas;
		}
		
		public static function getOccupiersAtlas():TextureAtlas
		{
			return occupiersAtlas;
		}
		
		public static function getGrassAtlas():TextureAtlas
		{
			return grassAtlas;
		}
	}
}