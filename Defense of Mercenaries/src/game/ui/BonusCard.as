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
	
	public class BonusCard extends Card
	{
		private var shape:Image;
		private var recentlyClicked:Boolean = false;
		private var timePassed:Number = 0;	
		private var disabled:Boolean = false;
		
		public function BonusCard(type:int)
		{
			super(type);
		}
		
		public override function init(e:Event):void
		{
			var texture:Texture;
			
			switch (type)
			{
				case 5: 
					texture = Game.assetManager.getTexture("boostTexture");
					cost = 100;
					break;
				
				case 6: 
					texture = Game.assetManager.getTexture("freezeTexture");
					cost = 100;
					break;
			}
			
			shape = new Image(texture);
			
			// Placeholder price tag
			addChild(shape);
		}
		
		public override function cardTouched(ev:TouchEvent):void
		{
			var touch:Touch = ev.getTouch(this);
			
			if( (touch != null) && (touch.phase == TouchPhase.ENDED) )
			{
				GlobalState.ui.handleBonusTouch(this, touch);			
			}
		}
		
		public override function update(deltaTime:Number):void
		{			
			if(!disabled)
			{
				if (GlobalState.roundBreak)
				{
					disable();
				}
				else if ( GlobalState.currentGold < this.cost )
				{
					disable();
				}
					
				else if ( this.type == 5 && GlobalState.boostActive )
				{
					disable();
				}
					
				else if ( this.type == 6 && GlobalState.freezeActive )
				{
					disable();
				}
			}
				
			else
			{
				if ( !GlobalState.roundBreak )
				{
					if ( GlobalState.currentGold >= cost )
					{
						if ( this.type == 5 && !GlobalState.boostActive )
						{
							enable();
						}
							
						else if ( this.type == 6 && !GlobalState.freezeActive )
						{
							enable();
						}
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