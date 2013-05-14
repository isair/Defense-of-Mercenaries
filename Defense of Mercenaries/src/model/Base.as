package model
{
	import model.tile.Tile;
		
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
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
			text = new TextField(Settings.tileSize * (3 / 2), Settings.tileSize / 2, health+"", "Arial", 12, 0x000000);
			healthBar = new Quad(Settings.tileSize * (3 / 2), Settings.tileSize / 3, 0x69E01F, true);
			healthBarEmpty = new Quad(Settings.tileSize * (3 / 2), Settings.tileSize / 3, 0xE33D3D, true);
			text.x = - Settings.tileSize / 4;
			text.y = (Settings.tileSize as Number) * (9 / 8);
			healthBar.x = - Settings.tileSize / 4;
			healthBarEmpty.x = - Settings.tileSize / 4;
			healthBar.y = (Settings.tileSize as Number) * (7 / 6);
			healthBarEmpty.y = (Settings.tileSize as Number) * (7 / 6);
			var shape:Quad = new Quad(Settings.tileSize, Settings.tileSize, 0xFF55AA, true);
			
			addChild(shape);
			addChild(healthBarEmpty);
			addChild(healthBar);
			addChild(text);
		}
		
		public function damage():void
		{
			this.health -= 1;
			healthBar.width = Settings.tileSize * (3/2) * (health / 10);
			
			text.text = health+"";
			
			if (health <= 0) {
				baseDeath();
			}
		}
		
		public function baseDeath():void
		{
			// GAME OVER
			text.text = "dead";
			healthBar.visible = false;
		}
	}
}