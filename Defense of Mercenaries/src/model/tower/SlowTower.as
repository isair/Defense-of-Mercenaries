package model.tower
{
	import model.enemy.Enemy;
	import model.projectile.SlowProjectile;
	import model.tile.Tile;
	import state.Game;
	
	import starling.display.Sprite;
	import starling.display.Quad;
	import starling.display.Shape;
	import starling.events.Event;
	import starling.display.Image;
	import starling.textures.Texture;
	
	public class SlowTower extends Tower
	{
		private static 	var slowTowerTexture:Texture = Game.assetManager.getTexture("slowTowerTexture");
		private static var slowTowerShape:Image = new Image(slowTowerTexture);
		private var slowAmount:Number = 40;
		private var slowDuration:Number = 2700;
		
		public function SlowTower()
		{
			super();
			
			super.damage = 9;
		}
		
		public override function init(e:Event):void
		{
			var slowTowerShape:Image = new Image(slowTowerTexture);
			slowTowerShape.y = - GlobalState.tileSize / 2;
			addChild(slowTowerShape);
		}
		
		public override function findFirstEnemy():Boolean
		{
			var firstSlowedEnemy:Enemy = null;
			var firstEnemy:Enemy = null;
			var currentLeast:int = 9999;
			
			var targets:Sprite = GlobalState.currentMap.getEnemiesAndOccupiers();

			for (var i:int = 0; i < targets.numChildren; i++)
			{
				var child:Object = targets.getChildAt(i);
				
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
			
			var ghost:Quad = slowTowerShape;
			ghost.alpha = 0.3;
			ghostArray[1] = ghost;
			
			return ghostArray;
		}
	}
}