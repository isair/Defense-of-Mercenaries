package game.state
{
	import asset.EmbeddedMenuAssets;
	
	import flash.display.Stage;
	import flash.media.SoundChannel;
	
	import model.filter.NormalMapFilter;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	
	public class Menu extends GameState
	{
		private var assetManager:AssetManager;
		
		private var bgImage:Image;
		private var bgFilter:NormalMapFilter;
		
		private var welcomeText:TextField;
		private var startPrompt:TextField;
		
		public function Menu()
		{
			super();
		}
		
		public override function init(e:Event):void
		{
			assetManager = new AssetManager();
			
			assetManager.enqueue(EmbeddedMenuAssets);
			
			assetManager.loadQueue(function(ratio:Number):void
			{
				if (ratio == 1.0) startMenu();
			});
		}
		
		private function startMenu():void
		{
			bgFilter = new NormalMapFilter(assetManager.getTexture("bgMenuNormal"));
			bgImage = new Image(assetManager.getTexture("bgMenu"));
			bgFilter.sendLightPosition(0.5, 0.5);
			bgImage.filter = bgFilter;
			addChild(bgImage);			
			
			var bgm:SoundChannel = assetManager.playSound("bgm", 0, int.MAX_VALUE);
			
			addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(this);
			
			if (touch)
			{
				bgFilter.sendLightPosition(touch.globalX / stage.width, touch.globalY / stage.height);
				
				if (touch.phase == TouchPhase.ENDED)
					Main.getInstance().setState(Game);
			}
		}
	}
}