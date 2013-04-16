package model
{
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Base extends Sprite implements Occupier
	{
		private var position:Tile;
				
		public function Base()
		{
			super();
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
			var shape:Quad = new Quad(Settings.tileSize, Settings.tileSize, 0xFF55AA, true);
			
			addChild(shape);
		}
		
		public function getPosition():Tile
		{
			return this.position;
		}
	}
}