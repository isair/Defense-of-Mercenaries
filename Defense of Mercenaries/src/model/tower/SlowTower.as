package model.tower
{
	import model.enemy.Enemy;
	import model.projectile.SlowProjectile;
	import model.tile.Tile;
	
	import starling.display.Quad;
	import starling.display.Shape;
	import starling.events.Event;
	
	public class SlowTower extends Tower
	{
		private static var towerShape:Quad = new Quad(GlobalState.tileSize, GlobalState.tileSize, 0x3787B0, true);
		private var shape:Quad;
		private var damage:int = 15;
		private var slowAmount:Number = 40;
		private var slowDuration:Number = 2700;
		
		public function SlowTower()
		{
			super();
		}
		
		public override function init(e:Event):void
		{
			this.shape = new Quad(GlobalState.tileSize, GlobalState.tileSize, 0x3787B0, true);
			addChild(shape);
		}
		
		public override function findFirstEnemy():Boolean
		{
			var firstSlowedEnemy:Enemy = null;
			var firstEnemy:Enemy = null;
			var currentLeast:int = 9999;
			
			for (var i:int = 0; i < GlobalState.currentMap.numChildren; i++)
			{
				var child:Object = GlobalState.currentMap.getChildAt(i);
				
				if (child is Enemy)
				{
					if (inRange(child as Enemy))
					{
						if ((child as Enemy).id < currentLeast)
						{
							if (!(child as Enemy).slowed)
							{
								firstEnemy = (child as Enemy);
							}
							
							currentLeast = (child as Enemy).id;
							firstSlowedEnemy = (child as Enemy);
						}
					}
				}
			}
			
			if (firstSlowedEnemy == null)
				return false;
			else
			{
				if (firstEnemy == null)
					shoot(firstSlowedEnemy);
				else
					shoot(firstEnemy);
				
				return true;
			}
		}
		
		public override function shoot(enemy:Enemy):void
		{			
			var bullet:SlowProjectile = new SlowProjectile(enemy, GlobalState.tileSize/4, damage, this, slowAmount, slowDuration);
			bullet.x = x + GlobalState.tileSize / 2;
			bullet.y = y + GlobalState.tileSize / 2;
			GlobalState.currentMap.addChild(bullet);
		}
		
		public static function getGhost():Array
		{
			var ghostArray:Array = new Array(2);
			
			var shape:Shape = new Shape();
			shape.graphics.beginFill(0xFF0000, 0.3);
			shape.graphics.lineStyle(1, 0xFF0000, 0.7);
			shape.graphics.drawCircle(GlobalState.tileSize / 2, GlobalState.tileSize / 2, GlobalState.tileSize * 5);
			shape.graphics.endFill();
			ghostArray[0] = shape;
			
			var ghost:Quad = towerShape;
			ghost.alpha = 0.3;
			ghostArray[1] = ghost;
			
			return ghostArray;
		}
	}
}