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
	import view.TopHUD;	
	
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
			
			assetManager.enqueue(EmbeddedGameAssets);
			EmbeddedGameAssets.generateEnemyAtlas();
			
			assetManager.loadQueue(function(ratio:Number):void
			{
				if (ratio == 1.0)
					startGame();
			});
		}
		
		private function startGame():void
		{
			var halfSize:Number = GlobalState.mapSize / 2;
			
			var top:TopHUD = new TopHUD();
			
			var map:Map = new Map();
			map.y = GlobalState.tileSize;
			map.generateMap();
			
			GlobalState.currentMap = map;
			
			var ui:Interface = new Interface();
			GlobalState.ui = ui;
			
			var base:Base = new Base();
			GlobalState.base = base;
			var baseX:int = Main.randomBetween(0, GlobalState.mapSize - 1);
			var baseY:int = Main.randomBetween(0, halfSize * .4);
			map.insertOccupier(base, baseX, halfSize * 1.3 + baseY);
			
			var gateX:int = (0, GlobalState.mapSize - 1);
			
			var obstacle:Obstacle;
			var randX:int;
			var randY:int;
			
			for(var i:int=0; i<12; i++)
			{
				randX = Main.randomBetween(0, GlobalState.mapSize - 1);
				randY = Main.randomBetween(0, GlobalState.mapSize - 1);
				
				if (((randX == gateX) && (randY == 0)) || (map.getTile(randX, randY).isOccupied()))
				{
					i--;
				}
				else				
				{
					obstacle = new Obstacle();
					map.insertOccupier(obstacle, randX, randY);
				}
			}

			var gate:Gate = new Gate(base);
			map.insertGate(gate, gateX, 0);
			map.addLayer();
			
			addChild(top);
			addChild(map);
			addChild(ui);
			
			var bgm:SoundChannel = assetManager.playSound("bgm", 0, int.MAX_VALUE);
			
			// Start the first round with 5 waves and with power multiplier as 1.
			gate.start(5, 1, onRoundEnd);
			GlobalState.roundBreak = false;
		}
		
		private function onRoundEnd():void
		{
			GlobalState.roundBreak = true;
		}
	}
}
