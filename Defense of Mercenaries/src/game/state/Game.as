package game.state
{
	import asset.EmbeddedGameAssets;
	
	import flash.media.SoundChannel;
	
	import game.Base;
	import game.Gate;
	import game.Map;
	import game.Obstacle;
	import game.tower.CannonTower;
	import game.tower.FastTower;
	import game.tower.SlowTower;
	import game.tower.Tower;
	import game.ui.Interface;
	import game.ui.TopHUD;
	
	import starling.events.Event;
	import starling.utils.AssetManager;
	
	public class Game extends GameState
	{
		public static var assetManager:AssetManager = null;
		public static var gate:Gate = null;
		
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
				{
					Tower.fetchImage();
					SlowTower.fetchImage();
					FastTower.fetchImage();
					CannonTower.fetchImage();
					startGame();
				}
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
			
			var gateX:int = Main.randomBetween(0, GlobalState.mapSize - 1);
			
			var obstacle:Obstacle;
			var randX:int;
			var randY:int;
			
			for(var i:int=0; i<24; i++)
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
			
			gate = new Gate(base);
			map.insertGate(gate, gateX, 0);
			map.addLayer();
			
			addChild(top);
			addChild(map);
			addChild(ui);
			
			var bgm:SoundChannel = assetManager.playSound("bgm", 0, int.MAX_VALUE);
			
			gate.calculatePath();
		}
		
		public static function newRound():void
		{
			if ( ! GlobalState.roundBreak) return;
			
			gate.start(2 * GlobalState.currentRound, 3 + GlobalState.currentRound * 0.5, 1 + GlobalState.currentRound, onRoundEnd);
			GlobalState.roundBreak = false;
		}
		
		public static function onRoundEnd():void
		{
			if (GlobalState.currentRound == 4)
			{
				Main.getInstance().setState(VictoryScreen);
			}
			
			GlobalState.roundBreak = true;
			GlobalState.currentRound++;
		}
	}
}
