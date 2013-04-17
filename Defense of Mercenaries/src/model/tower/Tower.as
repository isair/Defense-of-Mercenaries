package model.tower
{
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import model.Occupier;
	import model.tile.Tile;
	
	public class Tower extends Occupier
	{
		private var level:int;
		private var type:TowerType;
		private var position:Tile;
		
		public function Tower(type:TowerType)
		{
			super();
			
			this.level = 1;
			this.type = type;			
		}
				
		public override function init(e:Event):void
		{
			var shape:Quad = type.getShape();
			
			addChild(shape);
		}
		
		public function getType():TowerType
		{
			return this.type;
		}
		
		// Placeholder upgrade cost calculation
		public function getUpgradeCost(level:int):int
		{
			return (type.getUpgradeModifier() * level);
		}
	}
}