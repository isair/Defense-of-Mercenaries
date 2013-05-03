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
		private var shape:Quad;
		private var strength:int;
		private var owner:Tower;
		
		public function Projectile(target:Enemy, velocity:Number, strength:int, owner:Tower)
		{
			super();
			
			this.target = target;
			this.velocity = velocity;
			this.strength = strength;
			this.owner = owner;
			this.shape = new Quad(5, 5, 0x000000, true);
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init():void
		{
			addChild(shape);
		}
		
		public function update(deltaTime:Number):void
		{						
			var deltaX = (target.x + Settings.tileSize / 2) - (x + owner.x);
			var deltaY = (target.y + Settings.tileSize / 2) - (y + owner.y);
			
			var hyp = Math.sqrt( deltaX * deltaX + deltaY * deltaY );
			
			var absX:Number = Math.abs(deltaX);
			var absY:Number = Math.abs(deltaY);
						
			if( (absX < (Settings.tileSize / 4)) && (absY < (Settings.tileSize / 4)))
			{
				target.damage(strength);
				
				this.removeFromParent(true);
			}
			else
			{
				var velocityX = (deltaX / hyp) * velocity;
				var velocityY = (deltaY / hyp) * velocity;
				
				x += (((Settings.tileSize as Number) * deltaTime * velocityX) / 1000);
				y += (((Settings.tileSize as Number) * deltaTime * velocityY) / 1000);
			}
		}
	}
}