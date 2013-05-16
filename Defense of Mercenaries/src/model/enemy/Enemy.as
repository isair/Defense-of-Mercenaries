package model.enemy
{
	import asset.EmbeddedGameAssets;
	
	import flash.geom.Point;
	
	import model.GameObject;
	import model.Path;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	import state.Game;
	
	public class Enemy extends Sprite implements GameObject
	{
		public var id:int;
		
		private var health:Number;
		private var maxHealth:Number;
		private var speed:Number = 0.7;
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
		private var totalDistanceMoved:Number = 0;
		private var upDown:Boolean = false;
		
		private var currentClip:MovieClip;
		private var upClip:MovieClip;
		private var leftClip:MovieClip;
		private var rightClip:MovieClip;
		private var downClip:MovieClip;
		
		public function Enemy(health:Number, position:Point, path:Path, id:int)
		{
			super();
			
			this.id = id;
			this.health = health;
			this.maxHealth = health;
			this.position = position;
			this.path = path;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event):void
		{
			var atlas:TextureAtlas = EmbeddedGameAssets.getEnemyAtlas();
			
			upClip = new MovieClip(atlas.getTextures("up"), 5);
			leftClip = new MovieClip(atlas.getTextures("left"), 5);
			rightClip = new MovieClip(atlas.getTextures("right"), 5);
			downClip = new MovieClip(atlas.getTextures("down"), 5);
			
			upClip.x = - GlobalState.tileSize / 2;
			upClip.y = - GlobalState.tileSize / 2;
			downClip.x = - GlobalState.tileSize / 2;
			downClip.y = - GlobalState.tileSize / 2;
			leftClip.x = - GlobalState.tileSize / 2;
			leftClip.y = - GlobalState.tileSize / 2;
			rightClip.x = - GlobalState.tileSize / 2;
			rightClip.y = - GlobalState.tileSize / 2;
			
			currentClip = downClip;

			healthBar = new Quad(GlobalState.tileSize * (4/5), GlobalState.tileSize / 10, 0x69E01F, true);
			healthBarEmpty = new Quad(GlobalState.tileSize * (4/5), GlobalState.tileSize / 10, 0xE33D3D, true);
			healthBar.x = GlobalState.tileSize / 10 - GlobalState.tileSize / 2;
			healthBarEmpty.x = GlobalState.tileSize / 10 - GlobalState.tileSize / 2;
			healthBar.y = - GlobalState.tileSize / 5 - GlobalState.tileSize / 2;
			healthBarEmpty.y = - GlobalState.tileSize / 5 - GlobalState.tileSize / 2;
			healthBar.alpha = 0;
			healthBarEmpty.alpha = 0;
			
			//addChild(new Quad(GlobalState.tileSize, GlobalState.tileSize, 0xcc0000, true));
			addChild(currentClip);
			addChild(healthBarEmpty);
			addChild(healthBar);
			
			Starling.juggler.add(downClip);
			Starling.juggler.add(upClip);
			Starling.juggler.add(leftClip);
			Starling.juggler.add(rightClip);
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
			Starling.juggler.remove(downClip);
			Starling.juggler.remove(upClip);
			Starling.juggler.remove(leftClip);
			Starling.juggler.remove(rightClip);
		}
		
		public function unfreeze():void
		{
			this.frozen = false;
			Starling.juggler.add(downClip);
			Starling.juggler.add(upClip);
			Starling.juggler.add(leftClip);
			Starling.juggler.add(rightClip);
		}
		
		public function getDistanceMoved():Number
		{
			return totalDistanceMoved;
		}
		
		public function updateClip(clip:MovieClip):void
		{
			removeChild(currentClip);
			currentClip = clip;
			addChild(currentClip);
		}
		
		public function update(deltaTime:Number):void
		{
			if (damaged)
			{
				healthBar.width = GlobalState.tileSize * (4/5) * (health / maxHealth);
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
					totalDistanceMoved += deltaPos;
					
					if (distanceMoved >= GlobalState.tileSize)
						deltaPos -= (distanceMoved - GlobalState.tileSize);
					
					switch (moveDirection)
					{
						case Path.UP:
							if (currentClip != upClip)
							{
								updateClip(upClip);
							}
							
							if(!upDown)
							{
								upDown = true;
								GlobalState.currentMap.childrenSort();
							}
							
							y -= deltaPos;
							break;
						
						case Path.RIGHT:
							if (currentClip != rightClip)
							{
								updateClip(rightClip);
							}
							
							if(upDown)
								upDown = false;

							x += deltaPos;
							break;
						
						case Path.DOWN:
							if (currentClip != downClip)
							{
								updateClip(downClip);
							}

							if(!upDown)
							{
								upDown = true;
								GlobalState.currentMap.childrenSort();
							}

							y += deltaPos;
							break;
						
						case Path.LEFT:
							if (currentClip != leftClip)
							{
								updateClip(leftClip);
							}

							if(upDown)
								upDown = false;

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

