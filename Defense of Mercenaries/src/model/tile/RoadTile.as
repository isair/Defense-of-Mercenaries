package model.tile
{
	import flash.geom.Point;
	
	import starling.display.Quad;
	import starling.events.Event;
	
	public class RoadTile extends Tile
	{
		public function RoadTile(position:Point)
		{
			super(position);
		}
		
		public override function init(e:Event):void
		{
			var graph:Quad = new Quad(Main.tileSize, Main.tileSize, 0x61380b, true);
			addChild(graph);
		}
	}
}