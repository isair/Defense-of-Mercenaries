package model
{
	import flash.geom.Point;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;

	public class Tile extends Sprite
	{
		private static var borderSize:int = 1;
		
		private var position:Point;
		//var occupier:Occupier;
		
		public function Tile(position:Point)
		{
			super();
			
			this.position = position;
			
			x = (position.x) * Main.tileSize;
			y = (position.y) * Main.tileSize;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event):void
		{
			var outerSquare:Quad = new Quad(Main.tileSize, Main.tileSize, 0x000000, true);
			var innerSquare:Quad = new Quad(Main.tileSize - borderSize * 2, Main.tileSize - borderSize * 2, 0xcc0000, true);
			
			innerSquare.x = borderSize;
			innerSquare.y = borderSize;
			
			addChild(outerSquare);
			addChild(innerSquare);
		}
		/*
		public function isOccupied()
		{
			if(occupier == null)
			{
				return false;
			}
			else
			{
				return true;
			}
		}*/
	}
}