package
{
	import flash.display.Sprite;
	
	import starling.core.Starling;
	
	import state.Game;
	
	[SWF(frameRate="60", width="640", height="960", backgroundColor="0x333333")]
	public class Main extends Sprite
	{
		public static var tileSize:int = 40;
		
		private var starling:Starling = null;
		
		public function Main()
		{
			starling = new Starling(Game, stage);
			starling.antiAliasing = 1;
			starling.start();
		}
	}
}