package game
{
	import asset.EmbeddedGameAssets;
	
	import game.tile.Tile;
	import game.state.Game;
	import game.state.GameOver;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class Base extends Occupier
	{
		private var health:int = 10;
		private var healthBar:Quad;
		private var healthBarEmpty:Quad;
		private var text:TextField;
		private var occupiersAtlas:TextureAtlas = EmbeddedGameAssets.getOccupiersAtlas();
		
		public function Base()
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public override function init(e:Event):void
		{
			text = new TextField(GlobalState.tileSize * (3 / 2), GlobalState.tileSize / 2, health+"", "Aharoni", 20, 0x000000);
			healthBar = new Quad(GlobalState.tileSize * (3 / 2), GlobalState.tileSize / 3, 0x69E01F, true);
			healthBarEmpty = new Quad(GlobalState.tileSize * (3 / 2), GlobalState.tileSize / 3, 0xE33D3D, true);
			text.x = this.x - GlobalState.tileSize / 4;
			text.y = this.y + (GlobalState.tileSize as Number) * (9 / 8);
			healthBar.x = this.x - GlobalState.tileSize / 4;
			healthBarEmpty.x = this.x - GlobalState.tileSize / 4;
			healthBar.y = this.y + (GlobalState.tileSize as Number) * (7 / 6);
			healthBarEmpty.y = this.y + (GlobalState.tileSize as Number) * (7 / 6);
			
			var baseTexture:Texture = occupiersAtlas.getTexture("base");
			var baseImage:Image = new Image(baseTexture);
			
			addChild(baseImage);
			GlobalState.currentMap.addChild(healthBarEmpty);
			GlobalState.currentMap.addChild(healthBar);
			GlobalState.currentMap.addChild(text);
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