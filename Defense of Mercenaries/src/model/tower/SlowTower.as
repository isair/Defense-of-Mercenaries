package model.tower
{
	import model.projectile.SlowProjectile;
	import model.enemy.Enemy;
	import model.tile.Tile;
	
	import starling.display.Quad;
	import starling.events.Event;
	
	public class SlowTower extends Tower
	{
		private var shape:Quad;
		private var damage:int = 15;
		private var attackInterval:int = 1500;
		private var slowAmount:Number = 30;
		private var slowDuration:Number = 500;

		public function SlowTower()
		{
			super();
		}
		
		public override function init(e:Event):void
		{
			shape = new Quad(Settings.tileSize, Settings.tileSize, 0x3787B0, true);
			addChild(shape);
		}
		
		// TO-DO: Rotational slow mechanism
		public override function shoot(enemy:Enemy):void
		{			
			var bullet:SlowProjectile = new SlowProjectile(enemy, 10, damage, this, slowAmount, slowDuration);
			bullet.x = x + Settings.tileSize / 2;
			bullet.y = y + Settings.tileSize / 2;
			Settings.currentMap.addChild(bullet);
		}
	}
}