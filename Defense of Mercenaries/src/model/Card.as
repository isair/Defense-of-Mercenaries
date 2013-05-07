package model
{
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	
	import state.Game;
	
	public class Card extends Sprite
	{
		
		private var type:int; // 1 refers to regular Tower, 2 refers to slowTower, 3 refers to area-of-effect Tower
		private var cost:int; // purchase cost for tower
		private var price:TextField;
		private var shape:Quad ;
		
		public function Card(type:int)
		{
			super();
			
			this.type = type;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(TouchEvent.TOUCH, cardTouched);
		}
		
		public function init(e:Event):void
		{
			
			switch (type)
			{
				case 1: 
					shape = new Quad(Settings.tileSize * 2, Settings.tileSize * 3, 0x4DB370, true);
					cost = 20;
					break;
				
				case 2:
					shape = new Quad(Settings.tileSize * 2, Settings.tileSize * 3, 0x25E01B, true);
					cost = 50;
					break;
				
				case 3:
					shape = new Quad(Settings.tileSize * 2, Settings.tileSize * 3, 0xEDF5F5, true);
					cost = 100;
					break;
			}
			
			// Placeholder price tag
			price = new TextField(Settings.tileSize * 2, 20, "price: " + cost, "Arial", 12, 0x000000);
			price.y = Settings.tileSize * 3 - 20;
			
			addChild(shape);
			addChild(price);
		}
		
		public function cardTouched(ev:TouchEvent):void
		{
			var touch:Touch = ev.getTouch(this, TouchPhase.ENDED);
			
			if (touch) {
				if (Settings.currentGold < cost) {
					price.text = "more gold";
				}
				else {
					price.text = "PURCHASED" ; 
					Settings.currentGold = Settings.currentGold - cost;
				}
			}
		}
		
		public function getType():int
		{
			return this.type;
		}
	}
}