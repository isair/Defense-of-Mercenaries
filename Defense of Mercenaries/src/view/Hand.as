package view
{
	import model.Card;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Hand extends Sprite
	{
		private var cards:Array = null;
		
		public function Hand()
		{
			super();
			
			y = 650;
			generateHand();
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event):void
		{
			for(var i:int=0; i<cards.length; i++)
			{
				cards[i].x = 90 * i;
				
				addChild(cards[i]);
			}
		}
		
		public function generateHand():void
		{
			cards = new Array(6);
			
			// Placeholder hand generation 
			
			var card1:Card = new Card(1);
			var card2:Card = new Card(2);
			var card3:Card = new Card(3);
			var card4:Card = new Card(4);
			var card5:Card = new Card(5);
			var card6:Card = new Card(6);
			
			cards[0] = card1;
			cards[1] = card2;
			cards[2] = card3;
			cards[3] = card4;
			cards[4] = card5;
			cards[5] = card6;
		}
	}
}