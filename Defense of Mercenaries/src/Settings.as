package
{
	import model.Base;
	import model.Map;
	
	import view.Interface;

	public class Settings
	{
		public static const tileSize:int = 40, mapSize:int = 16;
		
		public static var base:Base = null;
		public static var currentMap:Map = null;
		public static var ui:Interface;

		public static var roundBreak:Boolean = false;
		public static var waveBreak:Boolean = true;
		public static var currentRound:int = 0;
		public static var currentWave:int = 0;
		public static var currentGold:int = 30;
		
		public static var boostActive:Boolean = false;
		public static var boostTimer:Number = 0;
		public static var freezeActive:Boolean = false;
		public static var freezeTimer:Number = 0;
		
		public function Settings() {}
	}
}