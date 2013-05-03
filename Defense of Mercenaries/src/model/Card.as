package model
{
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.events.TouchEvent;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	
	import state.Game;

	public class Card extends Sprite
	{
		
		private var type:int;
		private var price:TextField;
		
		public function Card(type:int)
		{
			super();
			
			this.type = type;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(TouchEvent.TOUCH, cardTouched);
		}
		
		public function init(e:Event):void
		{
			var shape:Quad = new Quad(Settings.tileSize * 2, Settings.tileSize * 3, 0x4DB370, true);
			
			// Placeholder price tag
			price = new TextField(Settings.tileSize * 2, 20, "price", "Arial", 12, 0x000000);
			price.y = Settings.tileSize * 3 - 20;
			
			addChild(shape);
			addChild(price);
		}
		
		public function cardTouched(ev:TouchEvent):void
		{
			var touch:Touch = ev.getTouch(this, TouchPhase.ENDED);
			
			if (touch) {
				price.text = "TOUCHED" ; }
		}
		
		public function getType():int
		{
			return this.type;
		}
	}
}