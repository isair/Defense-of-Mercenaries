package
{
	import model.Map;
	import view.Interface;

	public class Settings
	{
		public static const tileSize:int = 40, mapSize:int = 16;
		public static var currentMap:Map = null;
		public static var currentGold:int = 300;
		public static var ui:Interface;
		
		public function Settings() {}
	}
}