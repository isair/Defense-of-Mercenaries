package view
{
	import model.GameObject;
	
	import starling.display.Sprite;
	
	import starling.text.TextField;
	import starling.events.Event;
	import starling.display.Quad;
	
	public class HUD extends Sprite implements GameObject
	{
		
		public function HUD()
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event):void
		{
			generateBackground();
			generateWaveText();
		}
		
		public function update(deltaTime:Number):void
		{
		
		}
		
		public function generateBackground():void
		{
			var hudBackground:Quad = new Quad(Settings.tileSize * 16, Settings.tileSize * 0.75, 0x8884CF, true);
			addChild(hudBackground);
		}
		
		public function generateWaveText():void
		{
			var waveText:TextField = new TextField(Settings.tileSize * 16, Settings.tileSize * 0.5, "WAVES LEFT: ", "Arial", 13, 0x000000);
			addChild(waveText);
		}
	}
}