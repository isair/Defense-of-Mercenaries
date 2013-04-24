package model
{
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	import state.Game;

	public class Card extends Sprite
	{
		
		private var type:int;
		
		public function Card(type:int)
		{
			super();
			
			this.type = type;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event):void
		{
			var shape:Quad = new Quad(Settings.tileSize * 2, Settings.tileSize * 3, 0x4DB370, true);
			
			// Placeholder price tag
			var price:TextField = new TextField(Settings.tileSize * 2, 20, "price", "Arial", 12, 0x000000);
			price.y = Settings.tileSize * 3 - 20;
			
			addChild(shape);
			addChild(price);
		}	
		
		public function getType():int
		{
			return this.type;
		}
	}
}