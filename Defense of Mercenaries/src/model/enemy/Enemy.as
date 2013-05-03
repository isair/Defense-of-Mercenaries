package model.enemy
{
	import flash.geom.Point;
	
	import model.GameObject;
	import model.Path;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Enemy extends Sprite implements GameObject
	{
		private var health:Number = 0;
		private var armor:Number = 0;
		private var speed:Number = 0;
		private var position:Point = null;
		
		private var slowed:Boolean = false;
		private var slowAmount:Number = 0;
		private var slowDuration:Number = 0;
		
		private var path:Path = null;
		private var moveDirection:int = Path.NONE;
		private var distanceMoved:Number = 0;
		
		public function Enemy(health:Number, speed:Number, position:Point, path:Path)
		{
			super();
			
			this.health = health;
			this.speed = speed;
			this.position = position;
			this.path = path;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event):void
		{
			addChild(new Quad(Settings.tileSize, Settings.tileSize, 0xcc0000, true));
		}
		
		public function damage(value:int):void
		{
			health = health - value;
			
			if(health <= 0)
			{
				this.removeFromParent(true);
			}
		}
		
		public function slow(amount:Number, duration:Number):void
		{
			this.slowAmount = amount;
			this.slowDuration = duration;
			
			if(!slowed)
			{
				this.speed = speed * (100 - slowAmount) / 100;
				this.slowed = true;
			}
		}
		
		public function update(deltaTime:Number):void
		{
			if (this.slowed)
			{
				this.slowDuration -= deltaTime;
				
				if (this.slowDuration <= 0)
				{
					this.slowed = false;
					this.slowAmount = 0;
					this.speed = 1;
				}
			}
			
			if (moveDirection == Path.NONE) // If not moving, check path for directions.
			{
				moveDirection = path.popNextDirection();
				distanceMoved = 0;
				
				// TODO: Reduce base health at the end of the path.
				if (moveDirection == Path.NONE)
					this.removeFromParent(true);
			}
			else // Move in given direction for a single tile length.
			{
				var deltaPos:Number = (((Settings.tileSize as Number) * deltaTime * speed) / (1000));
				distanceMoved += deltaPos;
				
				if (distanceMoved >= Settings.tileSize)
					deltaPos -= (distanceMoved - Settings.tileSize);
				
				switch (moveDirection)
				{
					case Path.UP:
						y -= deltaPos;
						break;
					
					case Path.RIGHT:
						x += deltaPos;
						break;
					
					case Path.DOWN:
						y += deltaPos;
						break;
					
					case Path.LEFT:
						x -= deltaPos;
						break;
					
					default:
						break;
				}
				
				if (distanceMoved >= Settings.tileSize)
					moveDirection = Path.NONE;
			}
		}
	}
}

