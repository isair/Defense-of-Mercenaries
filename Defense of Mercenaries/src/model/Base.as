package model
{
	import model.tile.Tile;
	import state.Game;
	import state.GameOver;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.display.Image;
	import starling.textures.Texture;
	
	public class Base extends Occupier
	{
		private var position:Tile;
		private var health:int = 10;
		private var healthBar:Quad;
		private var healthBarEmpty:Quad;
		private var text:TextField;
		
		public function Base()
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public override function init(e:Event):void
		{
			text = new TextField(GlobalState.tileSize * (3 / 2), GlobalState.tileSize / 2, health+"", "Arial", 12, 0x000000);
			healthBar = new Quad(GlobalState.tileSize * (3 / 2), GlobalState.tileSize / 3, 0x69E01F, true);
			healthBarEmpty = new Quad(GlobalState.tileSize * (3 / 2), GlobalState.tileSize / 3, 0xE33D3D, true);
			text.x = - GlobalState.tileSize / 4;
			text.y = (GlobalState.tileSize as Number) * (9 / 8);
			healthBar.x = - GlobalState.tileSize / 4;
			healthBarEmpty.x = - GlobalState.tileSize / 4;
			healthBar.y = (GlobalState.tileSize as Number) * (7 / 6);
			healthBarEmpty.y = (GlobalState.tileSize as Number) * (7 / 6);
			
			var baseTexture:Texture = Game.assetManager.getTexture("baseTexture");
			var baseImage:Image = new Image(baseTexture);
			
			addChild(baseImage);
			addChild(healthBarEmpty);
			addChild(healthBar);
			addChild(text);
		}
		
		public function damage():void
		{
			this.health -= 1;
			healthBar.width = GlobalState.tileSize * (3/2) * (health / 10);
			
			text.text = health+"";
			
			if (health <= 0) {
				baseDeath();
			}
		}
		
		public function baseDeath():void
		{		
			Main.getInstance().setState(GameOver);
		}
	}
}