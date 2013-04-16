package model
{
	import flash.geom.Point;
	
	import model.Tile;
	import model.Tower;
	
	import starling.display.Sprite;

	public class Map extends Sprite
	{
		private var tiles:Array = null;
		
		public function Map()
		{
			super();
		}
		
		public function insertGate(gate:Gate, x:int, y:int):void
		{
			var tile:Tile = tiles[x + y * 16];
			gate.insert(tile);
			addChild(gate);
		}
		
		public function insertOccupier(occupier:Occupier, x:int, y:int):void
		{
			var tile:Tile = tiles[x + y * 16];
			tile.occupy(occupier);
			occupier.insert(tile);
			addChild(occupier);
		}
		
		public function generateMap():void
		{
			tiles = new Array(16 * 16);
			
			for (var i:int = 0; i < 16; i++)
			{
				for (var j:int = 0; j < 16; j++)
				{
					tiles[i + j * 16] = new Tile(new Point(i, j));
					addChild(tiles[i + j * 16]);
				}
			}
		}
	}
}