package model.tower
{
	import flash.geom.Point;
	
	import model.GameObject;
	import model.enemy.Enemy;
	
	import starling.display.Quad;
	import starling.display.Sprite;
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
			private var strength:int;
			private var hit:Boolean = false;
			
			public function Projectile(target:Enemy, velocity:Number, strength:int)
			{
				super();
				
				this.target = target;
				this.velocity = velocity;
				this.strength = strength;
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
					if(!hit)
					{
						target.damage(strength);
						hit = true;
					}
					
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