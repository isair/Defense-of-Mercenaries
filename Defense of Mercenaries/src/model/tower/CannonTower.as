package model.tower
{
	import model.enemy.Enemy;
	import model.projectile.CannonProjectile;
	import model.tile.Tile;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Shape;
	import starling.events.Event;
	import starling.textures.Texture;
	
	import state.Game;
	
	public class CannonTower extends Tower
	{
		private static 	var cannonTowerTexture:Texture = Game.assetManager.getTexture("cannonTowerTexture");
		private static var cannonTowerShape:Image = new Image(cannonTowerTexture);
		private var damage:int = 13;
		private var blastRadius:Number = GlobalState.tileSize;

		public function CannonTower()
		{
			super();
			
			super.attackInterval = 2500;
			super.currentInterval = super.attackInterval - 1;
		}
		
		public override function init(e:Event):void
		{
			var cannonTowerShape:Image = new Image(cannonTowerTexture);
			cannonTowerShape.y = - GlobalState.tileSize / 2;
			addChild(cannonTowerShape);
		}
		
		public override function shoot(enemy:Enemy):void
		{			
			var bullet:CannonProjectile = new CannonProjectile(enemy, GlobalState.tileSize/10, damage, this, blastRadius);
			bullet.x = x + GlobalState.tileSize / 2;
			bullet.y = y;
			GlobalState.currentMap.addChild(bullet);
		}
		
		public static function getGhost():Array
		{
			var ghostArray:Array = new Array(2);
			
			var shape:Shape = new Shape();
			shape.graphics.beginFill(0xFF0000, 0.3);
			shape.graphics.lineStyle(1, 0xFF0000, 0.7);
			shape.graphics.drawCircle(GlobalState.tileSize / 2, GlobalState.tileSize / 2, GlobalState.tileSize * 3.5);
			shape.graphics.endFill();
			ghostArray[0] = shape;

			var ghost:Quad = cannonTowerShape;
			ghost.alpha = 0.3;
			ghostArray[1] = ghost;
			
			return ghostArray;
		}
	}
}