package model
{
	import model.tile.Tile;
	
	import starling.display.Quad;
	import starling.events.Event;
	
	public class Obstacle extends Occupier
	{
		private var position:Tile;
		private var shape:Quad;
		private static var counter:int = 0;
		
		public function Obstacle()
		{
			super();
			
			this.shape = getShape();
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function getShape():Quad
		{
			var result:Quad;
			
			switch(counter)
			{
				case 0: result = new Quad(GlobalState.tileSize / 2, GlobalState.tileSize / 2, 0x666666, true);
					break;
				case 1: result = new Quad(GlobalState.tileSize / 2, GlobalState.tileSize / 2, 0x333333, true);
					break;
				case 2: result = new Quad(GlobalState.tileSize / 2, GlobalState.tileSize / 2, 0x999999, true);
					break;
				default: result = new Quad(GlobalState.tileSize / 2, GlobalState.tileSize / 2, 0x666666, true);
					break;
			}
			
			counter++;
			
			return result;
		}
		
		public override function insert(position:Tile):void
		{
			this.position = position;
			
			x = position.getX() + GlobalState.tileSize / 4;
			y = position.getY() + GlobalState.tileSize / 4;
			
		}
		
		public override function init(e:Event):void
		{
			addChild(shape);
		}
	}
}