package model.tower
{
	import model.GameObject;
	import model.enemy.Enemy;
	
	import flash.geom.Point;
	
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
			private var shape:Quad;
			
			public function Projectile(target:Enemy, velocity:Number)
			{
				super();
				
				this.target = target;
				this.velocity = velocity;
				shape = new Quad(5, 5, 0x000000, true);
				
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
			
			private function init():void
			{
				addChild(shape);
			}
			
			public function update(deltaTime:Number):void
			{				
				deltaX = x - target.x;
				deltaY = y - target.y;
				
				if( (deltaX < (Settings.tileSize / 4)) && (deltaY < (Settings.tileSize / 4)))
				{
					// deal damage to enemy
					this.removeFromParent(true);
				}
				else
				{
					velocityX = (deltaX / deltaY) * velocity;
					velocityY = (deltaY / deltaX) * velocity;
				
					x += velocityX;
					y += velocityY;
				}
			}
		}
	}