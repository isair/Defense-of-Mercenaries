package state
{
	
	// useless comment by cgulduren
	import flash.geom.Point;
	
	import model.Map;
	import model.tile.Tile;
	import model.tower.Tower;
	import model.tower.TowerType;
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

			// TODO: Remove TowerType class. Instead use different classes that extend the Tower class.
			var type:TowerType = new TowerType("Basic Tower", 10, 5, 10, 10, 1, 10, new Quad(Settings.tileSize, Settings.tileSize, 0x0000FF, true));
			
			var tower:Tower = new Tower(type);
			map.insertOccupier(tower, 3, 3);
			
			var base:Base = new Base();
			map.insertOccupier(base, 8, 10);
			
			var gate:Gate = new Gate();
			gate.calculatePath(base);
			map.insertGate(gate, 0, 0);
			
			addChild(map);
		}
	}
}