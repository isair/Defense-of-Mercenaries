package model
{	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.display.Quad;
	import model.tile.Tile;


	public class Occupier extends Sprite
	{		
		private var position:Tile;
		
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
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event):void
		{
		}
	}
}