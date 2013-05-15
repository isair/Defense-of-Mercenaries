package state
{
	import asset.EmbeddedMenuAssets;
	
	import flash.display.Stage;
	import flash.media.SoundChannel;
	
	import starling.core.Starling;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	import starling.text.TextField;

	public class Menu extends GameState
	{
		private var assetManager:AssetManager;
		
		private var welcomeText:TextField;
		private var startPrompt:TextField;
		
		public function Menu()
		{
			super();
		}
		
		public override function init(e:Event):void
		{
			assetManager = new AssetManager();
			
			// Enqueue menu assets.
			assetManager.enqueue(EmbeddedMenuAssets);
			
			assetManager.loadQueue(function(ratio:Number):void
			{
				if (ratio == 1.0) startMenu();
			});
		}
		
		private function startMenu():void
		{
			var size:Number = GlobalState.mapSize * GlobalState.tileSize;
			
			welcomeText = new TextField(size, GlobalState.tileSize * 4, "WELCOME TO DEFENSE OF MERCENARIES", "Verdana", 25);
			startPrompt = new TextField(size, GlobalState.tileSize * 4, "TAP TO START GAME", "Verdana", 25);
			
			startPrompt.y = welcomeText.y + 100;
			
			addChild(new Quad(size, size, 0x81E01B, true));
			
			addChild(welcomeText);
			addChild(startPrompt);
			
			// Start the background music.
			var bgm:SoundChannel = assetManager.playSound("bgm", 0, int.MAX_VALUE);
			
			// Add touch event listener.
			addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(e:TouchEvent):void
		{
			if (e.getTouch(this).phase == TouchPhase.ENDED)
				Main.getInstance().setState(Game);
		}
	}
}