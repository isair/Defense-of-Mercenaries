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
		public var id:int;
		
		private var health:Number = 100;
		private var speed:Number = 1;
		private var position:Point = null;
		private var dead:Boolean = false;
		
		private var healthBar:Quad;
		private var healthBarEmpty:Quad;
		private var damaged:Boolean = false;
		
		public var slowed:Boolean = false;
		private var frozen:Boolean = false;
		private var slowAmount:Number = 0;
		private var slowDuration:Number = 0;
		
		private var path:Path = null;
		private var moveDirection:int = Path.NONE;
		private var distanceMoved:Number = 0;
		
		public function Enemy(health:Number, speed:Number, position:Point, path:Path, id:int)
		{
			super();
			
			this.id = id;
			this.health = health;
			this.speed = speed;
			this.position = position;
			this.path = path;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event):void
		{
			healthBar = new Quad(GlobalState.tileSize * (4/5), GlobalState.tileSize / 10, 0x69E01F, true);
			healthBarEmpty = new Quad(GlobalState.tileSize * (4/5), GlobalState.tileSize / 10, 0xE33D3D, true);
			healthBar.x = GlobalState.tileSize / 10;
			healthBarEmpty.x = GlobalState.tileSize / 10;
			healthBar.y = - GlobalState.tileSize / 5;
			healthBarEmpty.y = - GlobalState.tileSize / 5;
			healthBar.alpha = 0;
			healthBarEmpty.alpha = 0;
			addChild(new Quad(GlobalState.tileSize, GlobalState.tileSize, 0xcc0000, true));
			addChild(healthBarEmpty);
			addChild(healthBar);
		}
		
		public function damage(value:int):void
		{
			health = health - value;
			
			if(health <= 0 && !this.dead)
			{
				this.dead = true;
				GlobalState.currentGold += 5;
				this.removeFromParent(true);
			}
			
			if (!damaged)
			{
				damaged = true;
				healthBar.alpha = 1;
				healthBarEmpty.alpha = 1;
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
		
		public function freeze():void
		{
			this.frozen = true;
		}
		
		public function unfreeze():void
		{
			this.frozen = false;
		}
		
		public function update(deltaTime:Number):void
		{
			if (damaged)
			{
				healthBar.width = GlobalState.tileSize * (4/5) * (health / 100);
			}
			
			if (!frozen)
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
					{
						GlobalState.base.damage();
						this.removeFromParent(true);
					}
				}
				else // Move in given direction for a single tile length.
				{
					var deltaPos:Number = (((GlobalState.tileSize as Number) * deltaTime * speed) / (1000));
					distanceMoved += deltaPos;
					
					if (distanceMoved >= GlobalState.tileSize)
						deltaPos -= (distanceMoved - GlobalState.tileSize);
					
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
					
					if (distanceMoved >= GlobalState.tileSize)
						moveDirection = Path.NONE;
				}
			}
		}
	}
}

