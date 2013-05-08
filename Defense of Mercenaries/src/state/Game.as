package state
{			
	import model.Base;
	import model.Gate;
	import model.Map;
	import model.Obstacle;
	import model.tower.Tower;
	import model.tower.SlowTower;
	
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
			
			Settings.currentMap = map;
			
			var ui:Interface = new Interface();
			
			var slowTower:SlowTower = new SlowTower();
			var tower:Tower = new Tower();

			map.insertOccupier(tower, 8, 3);
			map.insertOccupier(slowTower, 3, 3);
			
			var base:Base = new Base();
			map.insertOccupier(base, 8, 10);
			
			var obstacle1:Obstacle = new Obstacle();
			var obstacle2:Obstacle = new Obstacle();			
			var obstacle3:Obstacle = new Obstacle();
			var obstacle4:Obstacle = new Obstacle();
			
			map.insertOccupier(obstacle1, 10, 10);
			map.insertOccupier(obstacle2, 10, 7);
			map.insertOccupier(obstacle3, 3, 7);
			map.insertOccupier(obstacle4, 6, 2);
			
			var gate:Gate = new Gate();
			map.insertGate(gate, 0, 0);
			gate.calculatePath(base);
			
			addChild(map);
			addChild(ui);
		}
	}
}
