package model
{
  import starling.display.Sprite;
  import starling.display.Quad;
  import starling.events.Event;

  public class Enemy extends Sprite implements GameObject
  {
    private var health:int = 0;
    private var armor:int = 0;
    private var speed:int = 0;

    public function Enemy()
    {
      super();
	  
	  addEventListener(Event.ADDED_TO_STAGE, init);
    }
	
	public function init(e:Event):void
	{
		addChild(new Quad(Main.tileSize, Main.tileSize, 0xcc0000, true));
	}
	
	public function update(deltaTime:Number):void
	{
		
	}
  }
}

