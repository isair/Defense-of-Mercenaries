package model.tower
{
	import model.enemy.Enemy;
	import model.projectile.CannonProjectile;
	import model.tile.Tile;	
	import asset.EmbeddedGameAssets;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Shape;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	import state.Game;
	
	public class CannonTower extends Tower
	{
		private static var occupiersAtlas:TextureAtlas = EmbeddedGameAssets.getOccupiersAtlas();
		private static var cannonTowerTexture:Texture = occupiersAtlas.getTexture("cannontower");
		private static var cannonTowerShape:Image = new Image(cannonTowerTexture);
		private var blastRadius:Number = GlobalState.tileSize * 1.5;

		public function CannonTower()
		{
			super();
			
			super.damage = 25;
			super.range = GlobalState.tileSize * 5;
			super.attackInterval = 3000;
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
			shape.graphics.drawCircle(GlobalState.tileSize / 2, GlobalState.tileSize / 2, GlobalState.tileSize * 5);
			shape.graphics.endFill();
			ghostArray[0] = shape;

			var ghost:Quad = cannonTowerShape;
			ghost.alpha = 0.3;
			ghostArray[1] = ghost;
			
			return ghostArray;
		}
		
		public static function fetchImage():void
		{
			occupiersAtlas = EmbeddedGameAssets.getOccupiersAtlas();
			cannonTowerTexture = occupiersAtlas.getTexture("cannontower");
			cannonTowerShape = new Image(cannonTowerTexture);
		}
	}
}