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
	
	public class BonusCard extends Card
	{
		private var shape:Quad;
		private var recentlyClicked:Boolean = false;
		private var timePassed:Number = 0;	
		private var disabled:Boolean = false;
		
		public function BonusCard(type:int)
		{
			super(type);
		}
		
		public override function init(e:Event):void
		{
			switch (type)
			{
				case 5: 
					shape = new Quad(Settings.tileSize * 2, Settings.tileSize * 3, 0xE0D91B, true);
					cost = 100;
					break;
				
				case 6: 
					shape = new Quad(Settings.tileSize * 2, Settings.tileSize * 3, 0xE0811B, true);
					cost = 100;
					break;
			}
			
			// Placeholder price tag
			price.text = "price: " + cost;
			price.y = Settings.tileSize * 3 - 20;
			
			addChild(shape);
			addChild(price);
		}
		
		public override function cardTouched(ev:TouchEvent):void
		{
			var touch:Touch = ev.getTouch(this);
			
			if( (touch != null) && (touch.phase == TouchPhase.ENDED) )
			{
					Settings.ui.handleBonusTouch(this, touch);			
			}
		}
		
		public override function update(deltaTime:Number):void
		{			
			if(!disabled)
			{
				if ( Settings.currentGold < this.cost )
				{
					disable();
				}
					
				else if ( this.type == 5 && Settings.boostActive )
				{
					disable();
				}
					
				else if ( this.type == 6 && Settings.freezeActive )
				{
					disable();
				}
			}
				
			else
			{
				if ( Settings.currentGold >= cost )
				{
					if ( this.type == 5 && !Settings.boostActive )
					{
						enable();
					}
						
					else if ( this.type == 6 && !Settings.freezeActive )
					{
						enable();
					}
				}
			}
		}
		
		public override function enable():void
		{
			this.touchable = true;
			this.shape.alpha = 1;
			this.disabled = false;
		}
		
		public override function disable():void
		{
			this.touchable = false;
			this.shape.alpha = 0.4;
			this.disabled = true;
		}
		
	}
}