package model
{
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Tower extends Sprite implements Occupier
	{
		private var level:int;
		private var type:TowerType;
		private var position:Tile;
		
		public function Tower(type:TowerType)
		{
			this.level = 1;
			this.type = type;
		}
		
		public function insert(position:Tile):void
		{
			this.position = position;
			
			x = position.getX();
			y = position.getY();
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event):void
		{
			var shape:Quad = type.getShape();
			
			addChild(shape);
		}

		
		public function getPosition():Tile
		{
			return this.position;
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