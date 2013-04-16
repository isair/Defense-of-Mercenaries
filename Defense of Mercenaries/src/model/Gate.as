package model
{
  	import starling.display.Quad;
  	import starling.display.Sprite;

  	public class Gate extends Sprite implements GameObject
  	{
		private var spawnQueue:Array = null;
		private var spawnTimePassed:Number = 0;
		private var position:Tile;
		private var storedEnemies:int = 0;
		// private var path:Path;

    	public function Gate()
    	{
			super();
    	}
		
		public function insert(position:Tile):void
		{
			this.position = position;
			this.storedEnemies = 3;
			
			x = position.getX();
			y = position.getY();
		}
		
		public function update(deltaTime:Number):void
		{
			spawnTimePassed += deltaTime;
			
			if (spawnTimePassed > 1000)
			{
				//trace("Test");
				
				if(storedEnemies > 0)
				{
					storedEnemies--;
					spawnEnemy();
				}
				
				spawnTimePassed -= 1000;
			}
		}
		
		public function spawnEnemy():void
		{
			// to-do
		}
  }
}
