package
{
	import model.Base;
	import model.Map;
	
	import view.Interface;
	
	import state.Game;

	public class GlobalState
	{
		public static const tileSize:int = 40, mapSize:int = 16;
		public static var base:Base = null;
		public static var currentMap:Map = null;
		public static var ui:Interface = null;
		public static var roundBreak:Boolean = true;
		public static var currentRound:int = 0;
		public static var currentWave:int = 0;
		public static var currentGold:int = 20;
		public static var boostActive:Boolean = false;
		public static var boostTimer:Number = 0;
		public static var freezeActive:Boolean = false;
		public static var freezeTimer:Number = 0;
		
		public function GlobalState() {}
		
		public static function reset():void
		{
			base = null;
			currentMap = null;
			ui = null;
			roundBreak = true;
			currentRound = 0;
			currentWave = 0;
			currentGold = 20;
			boostActive = false;
			boostTimer = 0;
			freezeActive = false;
			freezeTimer = 0;
			
			if (Game.assetManager)
			{
				Game.assetManager.dispose();
				Game.assetManager.purge();
				Game.assetManager = null;
			}
			
			Game.gate = null;
		}
	}
}