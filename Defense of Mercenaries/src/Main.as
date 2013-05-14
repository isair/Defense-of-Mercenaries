package
{
	import flash.display.Sprite;
	import flash.media.SoundMixer;
	
	import starling.core.Starling;
	
	import state.GameState;
	import state.Menu;
	
	[SWF(frameRate="60", width="640", height="960", backgroundColor="0x333333")]
	public class Main extends Sprite
	{
		private static var instance:Main;
		private var starling:Starling;
		
		public function Main()
		{
			if (instance) return;
			
			instance = this;
			
			setState(Menu);
		}
		
		public static function getInstance():Main
		{
			return instance;
		}
		
		public function setState(state:Class):void
		{
			// If there exists a previous game state, clean it.
			if (starling)
			{
				SoundMixer.stopAll();
				starling.dispose();
			}
			
			// Create new game state.
			starling = new Starling(state, stage);
			starling.antiAliasing = 1;
			starling.start();
		}
		
		/* Some static helper functions after this point. */
		
		public static function randomBetween(min:Number, max:Number):Number
		{
			return (Math.floor(Math.random() * (max - min + 1)) + min);
		}
	}
}