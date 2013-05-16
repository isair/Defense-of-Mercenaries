package view
{	
	import model.BonusCard;
	import model.Card;
	import model.GameObject;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	import state.Game;
	
	public class Hand extends Sprite implements GameObject
	{
		private var cards:Array = null;
		private var goldText:TextField;
		private var timePassed:Number = 0;
		
		private var buttonDisabled:Boolean = false;
		private var button:Image;
		
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
				cards[i].x = GlobalState.tileSize * 2 * i + (GlobalState.tileSize / 8) * (i+1);
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
			var	texture:Texture = Game.assetManager.getTexture("goldbarTexture");
			var goldCounter:Image = new Image(texture);
			
			goldCounter.x = GlobalState.tileSize * 13.5 - GlobalState.tileSize / 4;
			goldCounter.y = GlobalState.tileSize / 4;
			goldText = new TextField(GlobalState.tileSize * 2, GlobalState.tileSize * 0.9, GlobalState.currentGold+"", "Aharoni", 30, 0x000000);
			goldText.x = GlobalState.tileSize * 14  - GlobalState.tileSize / 4;
			goldText.y = GlobalState.tileSize / 4;
			
			addChild(goldCounter);
			addChild(goldText);
		}
		
		public function generateButton():void
		{
			var texture:Texture = Game.assetManager.getTexture("startroundTexture");
			button = new Image(texture);
			button.x = GlobalState.tileSize * 13.5 - GlobalState.tileSize / 4;
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
			
			if (GlobalState.roundBreak && touch)
				Game.newRound();
		}
		
		public function enableButton():void
		{
			buttonDisabled = false;
			button.touchable = true;
			button.alpha = 1;
		}
		
		public function disableButton():void
		{
			buttonDisabled = true;
			button.touchable = false;
			button.alpha = 0.3;
		}
		
		public function update(deltaTime:Number):void
		{
			goldText.text = GlobalState.currentGold+"";

			if (!GlobalState.roundBreak)
			{
				if (!buttonDisabled)
					disableButton();
				
				timePassed += deltaTime;
				
				if (timePassed > 3000)
				{
					GlobalState.currentGold += 1;
					timePassed -= 3000;
				}
			}
			
			else
			{
				if (buttonDisabled)
					enableButton();
			}
		}
	}
}