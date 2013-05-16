package model
{	
	import model.tile.Tile;
	import state.Game;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class Obstacle extends Occupier
	{
		private var image:Image;
		private static var counter:int = 0;
		
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
				case 0: texture = Game.assetManager.getTexture("obs1Texture");
					break; 
				case 1: texture = Game.assetManager.getTexture("obs2Texture");
					break;
				case 2: texture = Game.assetManager.getTexture("obs3Texture");
					break;
				default: 
					break;
			}
			
			// Filtered out dead-tree for now
			counter = (counter + 1) % 2;
			
			result = new Image(texture);
			
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
			image.y = - GlobalState.tileSize / 8;
			addChild(image);
		}
	}
}