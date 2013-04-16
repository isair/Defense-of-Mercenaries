package state
{
	import flash.geom.Point;
	
	import model.Map;
	import model.Tile;
	import model.Tower;
	import model.TowerType;
	import model.Base;
	import model.Gate;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.display.Quad;
	
	public class Game extends GameState
	{
		public function Game()
		{
			super();
		}
		
		public override function onAdd(e:Event):void
		{
			var map:Map = new Map();
			map.generateMap();

			var type:TowerType = new TowerType("Basic Tower", 10, 5, 10, 10, 1, 10, new Quad(Settings.tileSize, Settings.tileSize, 0x0000FF, true));
			var base:Base = new Base();
			var tower:Tower = new Tower(type);
			var gate:Gate = new Gate();
			map.insertGate(gate, 1, 1);
			map.insertOccupier(base, 8, 10);
			map.insertOccupier(tower, 3, 3);
			
			addChild(map);
		}
	}
}