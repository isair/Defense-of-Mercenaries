package model.tower
{
	import model.projectile.SlowProjectile;
	import model.enemy.Enemy;
	import model.tile.Tile;
	
	import starling.display.Quad;
	import starling.events.Event;
	import starling.display.Shape;
	
	public class SlowTower extends Tower
	{
		private static var towerShape:Quad = new Quad(Settings.tileSize, Settings.tileSize, 0x3787B0, true);
		private var shape:Quad;
		private var damage:int = 15;
		private var attackInterval:int = 1500;
		private var currentInterval:int = attackInterval - 1;
		private var slowAmount:Number = 30;
		private var slowDuration:Number = 500;

		public function SlowTower()
		{
			super();
		}
		
		public override function init(e:Event):void
		{
			this.shape = new Quad(Settings.tileSize, Settings.tileSize, 0x3787B0, true);
			addChild(shape);
		}
		
		public override function shoot(enemy:Enemy):void
		{			
			var bullet:SlowProjectile = new SlowProjectile(enemy, 10, damage, this, slowAmount, slowDuration);
			bullet.x = x + Settings.tileSize / 2;
			bullet.y = y + Settings.tileSize / 2;
			Settings.currentMap.addChild(bullet);
		}
		
		public static function getGhost():Array
		{
			var ghostArray:Array = new Array(2);
			
			var shape:Shape = new Shape();
			shape.graphics.beginFill(0xFF0000, 0.3);
			shape.graphics.lineStyle(1, 0xFF0000, 0.7);
			shape.graphics.drawCircle(Settings.tileSize / 2, Settings.tileSize / 2, Settings.tileSize * 5);
			shape.graphics.endFill();
			ghostArray[0] = shape;

			var ghost:Quad = towerShape;
			ghost.alpha = 0.3;
			ghostArray[1] = ghost;
			
			return ghostArray;
		}
	}
}