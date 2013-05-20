package game.ui
{
	import starling.textures.Texture;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	
	import game.state.Game;
	import game.GameObject;
	
	public class Card extends Sprite implements GameObject
	{
		public var type:int;
		public var cost:int;
		private var shape:Image;
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
			var texture:Texture;
			
			switch (type)
			{
				case 1: 
					texture = Game.assetManager.getTexture("basicTexture");
					cost = 10;
					break;
				
				case 2:
					texture = Game.assetManager.getTexture("frostTexture");
					cost = 20;
					break;
				
				case 3:
					texture = Game.assetManager.getTexture("rapidTexture");
					cost = 30;
					break;
				
				case 4:
					texture = Game.assetManager.getTexture("cannonTexture");
					cost = 50;
					break;
			}
			
			shape = new Image(texture);
			
			// Placeholder price tag
			
			addChild(shape);
		}
		
		public function cardTouched(ev:TouchEvent):void
		{
			var touch:Touch = ev.getTouch(this);
			
			if ( (touch != null) && (touch.phase != TouchPhase.HOVER) )
			{
				GlobalState.ui.handleTouch(this, touch);	
			}
		}
		
		public function isTouched(touch:Touch):Boolean
		{
			var globalX:Number = this.x;
			var globalY:Number = this.y + 650;
			
			if((touch.globalX > globalX) && (touch.globalX < globalX + GlobalState.tileSize * 2) &&
				(touch.globalY > globalY) && (touch.globalY < globalY + GlobalState.tileSize * 3))
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
				if(GlobalState.currentGold < this.cost)
				{
					disable();
				}
			}
			else
			{
				if(GlobalState.currentGold >= this.cost)
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