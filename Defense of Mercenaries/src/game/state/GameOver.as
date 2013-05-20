package game.state
{
	import asset.EmbeddedMenuAssets;
	
	import flash.media.SoundChannel;
	
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	import starling.text.TextField;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	
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
			
			assetManager.enqueue(EmbeddedMenuAssets);
			
			assetManager.loadQueue(function(ratio:Number):void
			{
				if (ratio == 1.0) startGameOverScreen();
			});
		}
		
		private function startGameOverScreen():void
		{
			var texture:Texture = assetManager.getTexture("gameover");
			var image:Image = new Image(texture);
			
			GlobalState.reset();
			
			addChild(image);
			
			var bgm:SoundChannel = assetManager.playSound("gameOver", 0, int.MAX_VALUE);
			
			addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(this);
			
			if (touch && touch.phase == TouchPhase.ENDED)
				Main.getInstance().setState(Menu);
		}
	}
}