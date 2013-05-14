package view
{	
	import model.Card;
	import model.GameObject;
	import model.BonusCard;
	
	import starling.display.Button;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	
	public class Hand extends Sprite implements GameObject
	{
		private var cards:Array = null;
		private var buttonText:TextField;
		private var goldText:TextField;
		private var timePassed:Number = 0;
		
		public function Hand()
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event):void
		{
			generateBackground();
			generateCards();
			generateGoldCounter();
			generateButton();
			
			for(var i:int=0; i<cards.length; i++)
			{
				cards[i].x = Settings.tileSize * 2.25 * i;
				cards[i].y = Settings.tileSize / 4;
				
				addChild(cards[i]);
			}
		}
		
		public function generateCards():void
		{
			cards = new Array(6);
			
			var card1:Card = new Card(1);
			var card2:Card = new Card(2);
			var card3:Card = new Card(3);
			var card4:Card = new Card(4);
			var card5:BonusCard = new BonusCard(5);
			var card6:BonusCard = new BonusCard(6);
			
			cards[0] = card1;
			cards[1] = card2;
			cards[2] = card3;
			cards[3] = card4;
			cards[4] = card5;
			cards[5] = card6;
		}
		
		public function getCards():Array
		{
			return cards;
		}
		
		public function generateGoldCounter():void
		{
			var goldCounter:Quad = new Quad(Settings.tileSize * 2.5, Settings.tileSize, 0xE0E01B, true);
			goldCounter.x = Settings.tileSize * 13.5;
			goldCounter.y = Settings.tileSize / 4;
			
			goldText = new TextField(Settings.tileSize * 2.5, Settings.tileSize, Settings.currentGold+"", "Arial", 30, 0x000000);
			goldText.x = Settings.tileSize * 13.5;
			goldText.y = Settings.tileSize / 4;
			
			addChild(goldCounter);
			addChild(goldText);
		}
		
		public function generateButton():void
		{
			
			var button:Quad = new Quad(Settings.tileSize * 2.5, Settings.tileSize * 1.75, 0xF01620, true);
			button.x = Settings.tileSize * 13.5;
			button.y = Settings.tileSize * 1.50;
			
			buttonText = new TextField(Settings.tileSize * 2, Settings.tileSize * 1.25, "END TURN", "Arial", Settings.tileSize * 15 / 40, 0x000000);
			buttonText.x = Settings.tileSize * 13.5;
			buttonText.y = Settings.tileSize * 1.65;
			
			addChild(button);
			addChild(buttonText);
			
			button.touchable = true ;
			buttonText.touchable = false;
			
			button.addEventListener(TouchEvent.TOUCH, buttonTouched) ;		
		}
		
		public function generateBackground():void
		{
			var background:Quad = new Quad(Settings.tileSize * 16, Settings.tileSize * 3.5, 0x111111, true);
			addChild(background);
		}
		
		public function buttonTouched(ev:TouchEvent):void
		{		
			var touch:Touch = ev.getTouch(this, TouchPhase.ENDED);
			
			if (touch) 
			{
				Settings.currentGold += 10; 
			}
		}
		
		public function update(deltaTime:Number):void
		{
			if (Settings.roundBreak)
			{
				timePassed += deltaTime;
				goldText.text = Settings.currentGold+"";
				
				if (timePassed > 3000)
				{
					Settings.currentGold += 1;
					timePassed -= 3000;
				}
			}
		}
	}
}