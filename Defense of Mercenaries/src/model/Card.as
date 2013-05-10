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
	
	public class Card extends Sprite implements GameObject
	{
		
		public var type:int; // 1 refers to regular Tower, 2 refers to slowTower, 3 refers to area-of-effect Tower
		public var cost:int; // purchase cost for tower
		public var price:TextField = new TextField(Settings.tileSize * 2, 20, "price: ", "Arial", 12, 0x000000);
		private var shape:Quad;
		private var recentlyClicked:Boolean = false;
		private var timePassed:Number = 0;
		
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
			price.text = "price: " + cost;
			price.y = Settings.tileSize * 3 - 20;
			
			addChild(shape);
			addChild(price);
		}
		
		public function priceDefault():void
		{
			price.text = "price: " + cost;
		}
		
		public function cardTouched(ev:TouchEvent):void
		{
			var touch:Touch = ev.getTouch(this);
			
			if( touch.phase != TouchPhase.HOVER )
			{
				if( Settings.currentGold >= cost )
				{
					// send the touch to interface to handle
					Settings.ui.handleTouch(this, touch);			
				}
					
				else
				{
					// block touch handling if not enough $$$
					price.text = "$$$";
					addResetCounter();
				}
			}
		}
		
		public function addResetCounter():void
		{
			recentlyClicked = true;
			timePassed = 0;
		}
		
		public function isTouched(touch:Touch):Boolean
		{
			var globalX:Number = this.x;
			var globalY:Number = this.y + 650;
			
			if((touch.globalX > globalX) && (touch.globalX < globalX + Settings.tileSize * 2) &&
				(touch.globalY > globalY) && (touch.globalY < globalY + Settings.tileSize * 3))
			{
				return true;
			}
			else
				return false;
		}
		
		public function getType():int
		{
			return this.type;
		}
		
		public function update(deltaTime:Number):void
		{		
			if(recentlyClicked)
			{
				timePassed += deltaTime;	
				
				if(timePassed > 500)
				{
					timePassed = 0;
					recentlyClicked = false;
					priceDefault();
				}
			}
		}
	}
}