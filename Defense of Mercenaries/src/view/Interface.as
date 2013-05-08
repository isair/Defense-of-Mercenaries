package view
{
	import model.Card;
	import model.tile.Tile;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class Interface extends Sprite
	{
		private var hand:Hand;
		
		public function Interface()
		{
			super();
			
			hand = new Hand();
			hand.y = 650;
			addChild(hand);
		}
		
		public function handleTouch(card:Card, touch:Touch):void
		{
			switch(touch.phase)
			{				
				case TouchPhase.MOVED:
					
					card.price.text = "dragging";
					
					// dragging
					card.addResetCounter();
					
					break;
				
				case TouchPhase.ENDED:
					
					// released
					card.addResetCounter();
					
					break;
			}

			//When construction completes -- deduct gold
		}
	}
}