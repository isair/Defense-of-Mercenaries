package model
{
  import starling.display.Sprite;

  public class Gate extends Sprite implements GameObject
  {
    private var spawnQueue:Array = null;
	private var spawnTimePassed:Number = 0;

    public function Gate()
    {
      super();
    }
	
	public override function update(deltaTime:Number):void
	{
		spawnTimePassed += deltaTime;
		
		if (spawnTimePassed > 500)
			trace("Spawned.");
	}
  }
}
