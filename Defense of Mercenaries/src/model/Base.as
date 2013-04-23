package model
{
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import model.tile.Tile;
	
	public class Base extends Occupier
	{
		private var position:Tile;
				
		public function Base()
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
				
		public override function init(e:Event):void
		{
			var shape:Quad = new Quad(Settings.tileSize, Settings.tileSize, 0xFF55AA, true);
			
			addChild(shape);
		}
	}
}