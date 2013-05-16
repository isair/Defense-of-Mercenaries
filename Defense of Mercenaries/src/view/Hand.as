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
				cards[i].x = GlobalState.tileSize * 2.25 * i;
				cards[i].y = GlobalState.tileSize / 4;
				
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
			var goldCounter:Quad = new Quad(GlobalState.tileSize * 2.5, GlobalState.tileSize, 0xE0E01B, true);
			goldCounter.x = GlobalState.tileSize * 13.5;
			goldCounter.y = GlobalState.tileSize / 4;
			goldText = new TextField(GlobalState.tileSize * 2.5, GlobalState.tileSize, GlobalState.currentGold+"", "Aharoni", 30, 0x000000);
			goldText.x = GlobalState.tileSize * 13.5;
			goldText.y = GlobalState.tileSize / 4;
			
			addChild(goldCounter);
			addChild(goldText);
		}
		
		public function generateButton():void
		{
			
			var button:Quad = new Quad(GlobalState.tileSize * 2.5, GlobalState.tileSize * 1.75, 0xF01620, true);
			button.x = GlobalState.tileSize * 13.5;
			button.y = GlobalState.tileSize * 1.50;
			
			addChild(button);
			
			button.touchable = true ;
			
			button.addEventListener(TouchEvent.TOUCH, buttonTouched) ;		
		}
		
		public function generateBackground():void
		{
			var background:Quad = new Quad(GlobalState.tileSize * 16, GlobalState.tileSize * 3.5, 0x111111, true);
			addChild(background);
		}
		
		public function buttonTouched(ev:TouchEvent):void
		{		
			var touch:Touch = ev.getTouch(this, TouchPhase.ENDED);
			
			if (touch) 
			{
				GlobalState.currentGold += 10; 
			}
		}
		
		public function update(deltaTime:Number):void
		{
			if (!GlobalState.roundBreak)
			{
				timePassed += deltaTime;
				goldText.text = GlobalState.currentGold+"";
				
				if (timePassed > 3000)
				{
					GlobalState.currentGold += 1;
					timePassed -= 3000;
				}
			}
		}
	}
}