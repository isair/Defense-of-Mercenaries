package state
{			
	import model.Base;
	import model.Gate;
	import model.Map;
	import model.Obstacle;
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
			
			var tower:Tower = new Tower(10, 5, 10, 10, 60, 10);
			map.insertOccupier(tower, 3, 3);
			
			var base:Base = new Base();
			map.insertOccupier(base, 8, 10);
			
			var gate:Gate = new Gate();
			map.insertGate(gate, 0, 0);
			gate.calculatePath(base);
			
			var obstacle1:Obstacle = new Obstacle();
			var obstacle2:Obstacle = new Obstacle();
			
			map.insertOccupier(obstacle1, 10, 10);
			map.insertOccupier(obstacle2, 10, 7);
			
			addChild(map);
			addChild(ui);
			
			

		}
	}
}
