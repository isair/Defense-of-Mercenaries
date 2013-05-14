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
		public var type:int;
		public var cost:int;
		public var price:TextField = new TextField(Settings.tileSize * 2, 20, "price: ", "Arial", 12, 0x000000);
		private var shape:Quad;
		private var recentlyClicked:Boolean = false;
		private var timePassed:Number = 0;
		private var disabled:Boolean = false;
		
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
					cost = 30;
					break;
				
				case 3:
					shape = new Quad(Settings.tileSize * 2, Settings.tileSize * 3, 0x2FB54A, true);
					cost = 30;
					break;
				
				case 4:
					shape = new Quad(Settings.tileSize * 2, Settings.tileSize * 3, 0x1C9133, true);
					cost = 50;
					break;
			}
			
			// Placeholder price tag
			price.text = "price: " + cost;
			price.y = Settings.tileSize * 3 - 20;
			
			addChild(shape);
			addChild(price);
		}
		
		public function cardTouched(ev:TouchEvent):void
		{
			var touch:Touch = ev.getTouch(this);
			
			if ( (touch != null) && (touch.phase != TouchPhase.HOVER) )
			{
				Settings.ui.handleTouch(this, touch);	
			}
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
			if(!disabled)
			{
				if(Settings.currentGold < this.cost)
				{
					disable();
				}
			}
			else
			{
				if(Settings.currentGold >= this.cost)
				{
					enable();
				}
			}
		}
		
		public function enable():void
		{
			this.touchable = true;
			this.shape.alpha = 1;
			this.disabled = false;
		}
		
		public function disable():void
		{
			this.touchable = false;
			this.shape.alpha = 0.4;
			this.disabled = true;
		}
	}
}