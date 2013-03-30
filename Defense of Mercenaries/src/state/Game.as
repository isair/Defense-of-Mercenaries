package state
{
	import flash.geom.Point;
	
	import model.Map;
	import model.Tile;
	import model.Tower;
	import model.TowerType;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Game extends Sprite
	{
		public function Game()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAdd);
		}
		
		private function onAdd(event:Event):void
		{
			var map:Map = new Map();
			var type:TowerType = new TowerType("Basic Tower", 10, 5, 10, 10, 1, 10, new Quad(Settings.tileSize, Settings.tileSize, 0x0000FF, true));
			var tower:Tower = new Tower(type);
			map.insertTower(tower, 3, 3);
			
			addChild(map);
			map.generateMap();
		}
	}
}