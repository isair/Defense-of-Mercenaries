package state
{			
	import model.Base;
	import model.Gate;
	import model.Map;
	import model.tower.Tower;
	
	import starling.events.Event;
	
	import view.Interface;
	
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
			
			var ui:Interface = new Interface();

			// TODO: Remove TowerType class. Instead use different classes that extend the Tower class.
			
			var tower:Tower = new Tower(10, 5, 10, 10, 60, 10);
			map.insertOccupier(tower, 3, 3);
			
			var base:Base = new Base();
			map.insertOccupier(base, 8, 10);
			
			var gate:Gate = new Gate();
			map.insertGate(gate, 0, 0);
			gate.calculatePath(base);
			
			addChild(map);
			addChild(ui);
		}
	}
}
