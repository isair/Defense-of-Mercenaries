package model.tower
{
	import model.GameObject;
	import model.Occupier;
	import model.enemy.Enemy;
	import model.tile.Tile;
	
	import starling.display.Quad;
	import starling.events.Event;
	
	public class Tower extends Occupier implements GameObject
	{
		private var level:int;
		private var position:Tile;
		private var purchaseCost:int;
		private var upgradeModifier:int;
		private var damage:int;
		private var range:int;
		private var influenceRange:int;
		private var shape:Quad; //Placeholder graphics variable
		private var attackInterval:int;
		private var currentInterval:int = 0;
		
		public function Tower(purchaseCost:int, upgradeModifier:int, damage:int, range:int, attackInterval:int, influenceRange:int)
		{
			super();
			
			this.level = 1;
			
			this.purchaseCost = purchaseCost;
			this.upgradeModifier = upgradeModifier;
			this.damage = damage;
			this.range = range;
			this.attackInterval = attackInterval;
			this.influenceRange = influenceRange;
			this.shape = new Quad(Settings.tileSize, Settings.tileSize, 0x0000FF, true);
		}
				
		public override function init(e:Event):void
		{			
			addChild(shape);
		}

		public function update(deltaTime:Number):void
		{
			currentInterval += deltaTime;
			
			if (currentInterval > attackInterval)
			{	
				findFirstEnemy();
				
				currentInterval -= attackInterval;
			}
		}
		
		private function findFirstEnemy():void
		{
			for (var i:int = 0; i < stage.numChildren; i++)
			{
				var child:Object = stage.getChildAt(i);
				
				if (child is Enemy){
					shoot(child as Enemy);
					break;
				}
			}

		}
		
		private function shoot(enemy:Enemy)
		{
			var bullet:Projectile = new Projectile(enemy, position.getCenterX(), position.getCenterY(), 5);
		}
		
		// Placeholder upgrade cost calculation
		private function getUpgradeCost(level:int):int
		{
			return (upgradeModifier * level);
		}
	}
}