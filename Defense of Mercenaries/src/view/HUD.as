package view
{
	import model.GameObject;
	
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.events.Event;
	import starling.display.Quad;
	
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
				roundText.text = "Current Round: " + round;
			}
			
			if( wave != GlobalState.currentWave)
			{
				wave = GlobalState.currentWave;
				waveText.text = "Waves Spawned: " + wave;
			}
		}
		
		public function generateBackground():void
		{
			var hudBackground:Quad = new Quad(GlobalState.tileSize * 16, GlobalState.tileSize * 0.75, 0x8884CF, true);
			addChild(hudBackground);
		}
		
		public function generateText():void
		{
			roundText = new TextField(GlobalState.tileSize * 8, GlobalState.tileSize * 0.5, "Current Round: 1", "Arial", 13, 0x000000);
			roundText.x = GlobalState.tileSize * 8;
			addChild(roundText);
			
			waveText = new TextField(GlobalState.tileSize * 8, GlobalState.tileSize * 0.5, "Waves Spawned: 0", "Arial", 13, 0x000000);
			addChild(waveText);
		}
	}
}