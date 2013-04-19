package model.tower
{
	import model.GameObject;
	import model.enemy.Enemy;
	
	import starling.display.Sprite;
	import starling.display.Quad;
	import starling.events.Event;
	
	public class Projectile extends Sprite implements GameObject
	{
			private var target:Enemy;
			private var velocity:Number;
			private var velocityX:Number;
			private var velocityY:Number;
			private var deltaX:Number;
			private var deltaY:Number;
			
			public function Projectile(target:Enemy, x:Number, y:Number, velocity:Number)
			{
				super();
				
				this.x = x;
				this.y = y;
				this.velocity = velocity;
				
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
			
			private function init():void
			{
				var shape:Quad = new Quad(2, 2, 0x000000, true);
				
				addChild(shape);
			}
			
			public function update(deltaTime:Number):void
			{				
				deltaX = this.x - target.x;
				deltaY = this.y - target.y;
				
				if( (deltaX < (Settings.tileSize / 4)) && (deltaY < (Settings.tileSize / 4)))
				{
					// deal damage to enemy
					this.removeFromParent(true);
				}
				else
				{
					velocityX = (deltaX / deltaY) * velocity;
					velocityY = (deltaY / deltaX) * velocity;
				
					this.x += velocityX;
					this.y += velocityY;
				}
			}
		}
	}