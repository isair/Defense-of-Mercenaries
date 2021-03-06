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
	import starling.events.TouchPhase;
	
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
			var texture:Texture = assetManager.getTexture("victory");
			var image:Image = new Image(texture);
			
			addChild(image);			
			
			GlobalState.reset();
						
			var victoryTrack:SoundChannel = assetManager.playSound("victoryTrack", 0, int.MAX_VALUE);
			
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