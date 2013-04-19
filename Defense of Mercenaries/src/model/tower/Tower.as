package model.tower
{
	import model.Occupier;
	import model.tile.Tile;
	
	import starling.display.Quad;
	import starling.events.Event;
	import model.GameObject;
	
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
				shootFirstEnemy();
				
				currentInterval -= attackInterval;
			}
		}
		
		private function shootFirstEnemy():void
		{
			// TODO Auto Generated method stub
		}
		
		// Placeholder upgrade cost calculation
		public function getUpgradeCost(level:int):int
		{
			return (upgradeModifier * level);
		}
	}
}