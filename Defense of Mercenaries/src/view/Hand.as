package view
{
	import model.Card;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.events.Event;
	
	public class Hand extends Sprite
	{
		private var cards:Array = null;
		
		public function Hand()
		{
			super();
			
			generateCards();
			generateGoldCounter();
			generateButton();
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event):void
		{
			for(var i:int=0; i<cards.length; i++)
			{
				cards[i].x = Settings.tileSize * 2.25 * i;
				
				addChild(cards[i]);
			}
		}
		
		public function generateCards():void
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
		
		public function generateGoldCounter():void
		{
			var goldCounter:Quad = new Quad(Settings.tileSize * 2.5, Settings.tileSize, 0xE0E01B, true);
			goldCounter.x = 540;
			
			var gold:TextField = new TextField(Settings.tileSize * 2.5, Settings.tileSize, "GOLD", "Arial", 30, 0x000000);
			gold.x = 540;
			
			addChild(goldCounter);
			addChild(gold);
		}
		
		public function generateButton():void
		{
			var button:Quad = new Quad(Settings.tileSize * 2.5, Settings.tileSize * 1.75, 0xF01620, true);
			button.x = 540;
			button.y = Settings.tileSize * 1.25;
			
			addChild(button);
		}
	}
}