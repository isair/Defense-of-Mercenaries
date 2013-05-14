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
	import view.Interface;
	
	import starling.events.Event;
	import starling.utils.AssetManager;
	
	public class Game extends GameState
	{
		public static var assetManager:AssetManager = null;
		
		public function Game()
		{
			super();
		}
		
		public override function init(e:Event):void
		{
			assetManager = new AssetManager();
			
			// Enqueue game assets.
			assetManager.enqueue(EmbeddedGameAssets);
			
			assetManager.loadQueue(function(ratio:Number):void
			{
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
			
			var base:Base = new Base();
			Settings.base = base;
			map.insertOccupier(base, 8, 10);
			
			var obstacle1:Obstacle = new Obstacle();
			var obstacle2:Obstacle = new Obstacle();			
			var obstacle3:Obstacle = new Obstacle();
			var obstacle4:Obstacle = new Obstacle();
			
			map.insertOccupier(obstacle1, 10, 10);
			map.insertOccupier(obstacle2, 10, 7);
			map.insertOccupier(obstacle3, 3, 7);
			map.insertOccupier(obstacle4, 6, 2);
			
			var gate:Gate = new Gate(base);
			map.insertGate(gate, 0, 0);
			
			addChild(map);
			addChild(ui);
			
			// Start the background music.
			var bgm:SoundChannel = assetManager.playSound("bgm", 0, int.MAX_VALUE);
			
			// Start the first round with 5 waves and with power multiplier as 1.
			gate.start(5, 1, onRoundEnd);
			Settings.roundBreak = false;
		}
		
		private function onRoundEnd():void
		{
			Settings.roundBreak = true;
		}
	}
}
