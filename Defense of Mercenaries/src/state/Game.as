package state
{
	import asset.EmbeddedGameAssets;
	
	import flash.media.SoundChannel;
	
	import model.Base;
	import model.Gate;
	import model.Map;
	import model.Obstacle;
	import model.tower.SlowTower;
	import model.tower.Tower;
	
	import starling.events.Event;
	import starling.utils.AssetManager;
	
	import view.Interface;
	
	public class Game extends GameState
	{
		var assetManager:AssetManager;
		
		public function Game()
		{
			super();
		}
		
		public override function init(e:Event):void
		{
			assetManager = new AssetManager();
			assetManager.verbose = true;
			
			// Enqueue game assets.
			assetManager.enqueue(EmbeddedGameAssets);
			
			assetManager.loadQueue(function(ratio:Number):void
			{
				trace("Loading assets, progress:", ratio);
				
				if (ratio == 1.0)
					startGame();
			});
		}
		
		private function startGame():void
		{
			var map:Map = new Map();
			map.generateMap();
			
			Settings.currentMap = map;
			
			var ui:Interface = new Interface();
			Settings.ui = ui;
			
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
			
			// Start the background music.
			var bgm:SoundChannel = assetManager.playSound("bgm");
		}
	}
}
