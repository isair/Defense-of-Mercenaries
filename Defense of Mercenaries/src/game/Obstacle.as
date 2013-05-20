package game
{	
	import game.tile.Tile;
	import game.state.Game;
	import asset.EmbeddedGameAssets;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class Obstacle extends Occupier
	{
		private var image:Image;
		private static var counter:int = 0;
		private var occupiersAtlas:TextureAtlas = EmbeddedGameAssets.getOccupiersAtlas();
		
		public function Obstacle()
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function getShape():Image
		{
			var result:Image;
			var texture:Texture;
			
			switch(counter)
			{
				case 0: texture = occupiersAtlas.getTexture("obs1");
					break; 
				case 1: texture = occupiersAtlas.getTexture("obs2");
					break;
				case 2: texture = occupiersAtlas.getTexture("obs3");
					break;
				default: 
					break;
			}
			
			result = new Image(texture);
			
			if (counter == 2)
				result.y = - GlobalState.tileSize / 2;
			else
				result.y = - GlobalState.tileSize / 8;
			
			counter = (counter + 1) % 3;
			
			return result;
		}
		
		public override function insert(position:Tile):void
		{
			this.position = position;
			
			x = position.getX();
			y = position.getY();
		}
		
		public override function init(e:Event):void
		{
			image = getShape();
			addChild(image);
		}
	}
}