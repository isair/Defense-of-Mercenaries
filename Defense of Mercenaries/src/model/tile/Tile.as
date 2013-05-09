package model.tile
{
	import flash.geom.Point;
	
	import model.Occupier;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;

	public class Tile extends Sprite
	{
		private static var borderSize:int = 1;
		
		private var position:Point;
		private var occupier:Occupier;
		
		public function Tile(position:Point)
		{
			super();
			
			this.position = position;
			
			x = (position.x) * Settings.tileSize;
			y = (position.y) * Settings.tileSize;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event):void
		{
			var outerSquare:Quad = new Quad(Settings.tileSize, Settings.tileSize, 0x000000, true);
			var innerSquare:Quad = new Quad(Settings.tileSize - borderSize * 2, Settings.tileSize - borderSize * 2, 0xB3956D, true);
			
			innerSquare.x = borderSize;
			innerSquare.y = borderSize;
			
			addChild(outerSquare);
			addChild(innerSquare);
		}
		
		public function getX():int
		{
			return (position.x) * Settings.tileSize;
		}
		
		public function getY():int
		{
			return (position.y) * Settings.tileSize;
		}
		
		public function occupy(occupier:Occupier):void
		{
			this.occupier = occupier;
		}
		
		public function isOccupied():Boolean
		{
			if(occupier == null)
			{
				return false;
			}
			else
			{
				return true;
			}
		}
		
		public function getOccupier():Occupier
		{
			return occupier;
		}
		
		public function getCenterX():int
		{
			return (this.x + (Settings.tileSize / 2));
		}
		
		public function getCenterY():int
		{
			return (this.y + (Settings.tileSize / 2));
		}
	}
}