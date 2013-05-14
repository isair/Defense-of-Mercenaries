package model.tower
{
	import model.projectile.CannonProjectile;
	import model.enemy.Enemy;
	import model.tile.Tile;
	
	import starling.display.Quad;
	import starling.events.Event;
	import starling.display.Shape;
	
	public class CannonTower extends Tower
	{
		private static var towerShape:Quad = new Quad(GlobalState.tileSize, GlobalState.tileSize, 0x009933, true);
		private var shape:Quad;
		private var damage:int = 20;
		private var blastRadius:Number = GlobalState.tileSize;

		public function CannonTower()
		{
			super();
			
			super.attackInterval = 2500;
			super.currentInterval = super.attackInterval - 1;
		}
		
		public override function init(e:Event):void
		{
			this.shape = new Quad(GlobalState.tileSize, GlobalState.tileSize, 0x009933, true);
			addChild(shape);
		}
		
		public override function shoot(enemy:Enemy):void
		{			
			var bullet:CannonProjectile = new CannonProjectile(enemy, GlobalState.tileSize/8, damage, this, blastRadius);
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