package model
{
	import model.tile.Tile;
	
	import starling.display.Quad;
	import starling.events.Event;
	
	public class Obstacle extends Occupier
	{
		
		private var position:Tile;
		private var shape:Quad;
		
		public function Obstacle()
		{
			super();
			
			this.shape = new Quad(Settings.tileSize / 2, Settings.tileSize / 2, 0x666666, true);
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public override function insert(position:Tile):void
		{
			this.position = position;
			
			x = position.getX() + Settings.tileSize / 4;
			y = position.getY() + Settings.tileSize / 4;
			
		}
		
		public override function init(e:Event):void
		{
			
			addChild(shape);
		}
	}
}