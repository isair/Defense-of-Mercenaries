package game
{	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.display.Quad;
	import game.tile.Tile;
	
	public class Occupier extends Sprite
	{		
		public var position:Tile;
		
		public function Occupier()
		{
			super();
		}
		
		public function getPosition():Tile
		{
			return this.position;
		}
		
		public function insert(position:Tile):void
		{
			this.position = position;
			
			x = position.getX();
			y = position.getY();
		}
		
		public function init(e:Event):void {}
	}
}