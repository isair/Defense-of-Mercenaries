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
    private var speed:int = 0;
	private var position:Point = null;
	
	private var path:Path = null;
	private var moveDirection:int = Path.NONE;
	private var distanceMoved:Number = 0;

    public function Enemy(health:Number, armor:Number, speed:int, position:Point, path:Path)
    {
      super();
	  
	  this.health = health;
	  this.armor = armor;
	  this.speed = speed;
	  this.position = position;
	  this.path = path;
	  
	  addEventListener(Event.ADDED_TO_STAGE, init);
    }
	
	public function init(e:Event):void
	{
		addChild(new Quad(Main.tileSize, Main.tileSize, 0xcc0000, true));
	}
	
	public function update(deltaTime:Number):void
	{
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
			var deltaPos:Number = (((Main.tileSize as Number) * deltaTime) / (speed * 1000));
			distanceMoved += deltaPos;
			
			if (distanceMoved >= Main.tileSize)
				deltaPos -= (distanceMoved - Main.tileSize);
			
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
			
			if (distanceMoved >= Main.tileSize)
				moveDirection = Path.NONE;
		}
	}
  }
}

