package state
{
	import asset.EmbeddedMenuAssets;
	
	import flash.media.SoundChannel;
	
	import starling.display.Quad;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	import starling.text.TextField;
	
	public class VictoryScreen extends GameState
	{
		private var assetManager:AssetManager;	
		private var gameOverText:TextField;
		private var restartPrompt:TextField;
		
		public function VictoryScreen()
		{
			super();
		}
		
		public override function init(e:Event):void
		{
			assetManager = new AssetManager();
			
			assetManager.enqueue(EmbeddedMenuAssets);
			
			assetManager.loadQueue(function(ratio:Number):void
			{
				if (ratio == 1.0) startVictoryScreen();
			});
		}
		
		private function startVictoryScreen():void
		{
			var size:Number = GlobalState.mapSize * GlobalState.tileSize;
			
			gameOverText = new TextField(size, GlobalState.tileSize * 4, "VICTORY!", "Verdana", 25);
			restartPrompt = new TextField(size, GlobalState.tileSize * 4, "TAP TO RETURN TO MAIN MENU", "Verdana", 25);
			restartPrompt.y = gameOverText.y + 100;
			
			addChild(new Quad(size, size, 0x1BD3E0, true));
			addChild(gameOverText);
			addChild(restartPrompt);
			
			var victoryTrack:SoundChannel = assetManager.playSound("victoryTrack", 0, int.MAX_VALUE);
			
			addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(e:TouchEvent):void
		{
			if (e.getTouch(this).phase == TouchPhase.ENDED)
				Main.getInstance().setState(Menu);
		}
	}
}