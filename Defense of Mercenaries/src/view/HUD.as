package view
{
	import model.GameObject;
	import state.Game;
	
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.events.Event;
	import starling.display.Image;
	import starling.textures.Texture;
	
	public class HUD extends Sprite implements GameObject
	{
		private var roundText:TextField;
		private var waveText:TextField;
		
		private var round:int = 1;
		private var wave:int = 0;
		
		public function HUD()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event):void
		{
			generateBackground();
			generateText();
		}
		
		public function update(deltaTime:Number):void
		{
			if( (round - 1) != GlobalState.currentRound)
			{
				round = GlobalState.currentRound + 1;
				roundText.text = "Current Round: " + round + " / 5";
			}
			
			if( wave != GlobalState.currentWave)
			{
				var maxWave:int = 3 + GlobalState.currentRound * 0.5;
				wave = GlobalState.currentWave - GlobalState.currentRound * 2;
				waveText.text = "Waves Spawned: " + wave + " / " + maxWave;
			}
		}
		
		public function generateBackground():void
		{
			var texture:Texture = Game.assetManager.getTexture("hudTexture");
			var wall:Image = new Image(texture);
			addChild(wall);
		}
		
		public function generateText():void
		{
			roundText = new TextField(GlobalState.tileSize * 8, GlobalState.tileSize * 0.9, "Current Round: 1 / 5", "Aharoni", 18, 0x000000);
			roundText.x = GlobalState.tileSize * 8;
			addChild(roundText);
			
			waveText = new TextField(GlobalState.tileSize * 8, GlobalState.tileSize * 0.9, "Waves Spawned: 0 / 3", "Aharoni", 18, 0x000000);
			addChild(waveText);
		}
	}
}
