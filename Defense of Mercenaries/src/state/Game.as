package state
{
	import flash.geom.Point;
	
	import model.Tile;
	import model.Map;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Game extends Sprite
	{
		public function Game()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAdd);
		}
		
		private function onAdd(event:Event):void
		{
			var map:Map = new Map();
			
			addChild(map);
			map.generateMap();
		}
	}
}