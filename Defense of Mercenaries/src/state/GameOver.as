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
	
	public class GameOver extends GameState
	{
		private var assetManager:AssetManager;
		
		private var gameOverText:TextField;
		private var restartPrompt:TextField;
		
		public function GameOver()
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
				if (ratio == 1.0) startGameOverScreen();
			});
		}
		
		private function startGameOverScreen():void
		{
			var size:Number = GlobalState.mapSize * GlobalState.tileSize;
			
			gameOverText = new TextField(size, GlobalState.tileSize * 4, "GAME OVER", "Verdana", 25);
			restartPrompt = new TextField(size, GlobalState.tileSize * 4, "TAP TO RETURN TO MAIN MENU", "Verdana", 25);
			
			restartPrompt.y = gameOverText.y + 100;
			
			addChild(new Quad(size, size, 0xD49A3D, true));
			
			addChild(gameOverText);
			addChild(restartPrompt);
			
			// Start the background music.
			var bgm:SoundChannel = assetManager.playSound("bgm", 0, int.MAX_VALUE);
			
			// Add touch event listener.
			addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(e:TouchEvent):void
		{
			if (e.getTouch(this).phase == TouchPhase.ENDED)
				Main.getInstance().setState(Menu);
		}
	}
}