package model
{
	import flash.geom.Point;
	
	import model.tile.Tile;
	import model.tower.Tower;
	
	import starling.display.Sprite;
	
	public class Map extends Sprite
	{
		private var tiles:Vector.<Vector.<Tile>>;
		
		public function Map()
		{
			super();
		}
		
		public function insertGate(gate:Gate, column:int, row:int):void
		{
			var tile:Tile = tiles[column][row];
			gate.insert(tile);
			addChild(gate);
		}
				
		public function insertOccupier(occupier:Occupier, column:int = null, row:int = null, tile:Tile = null):void
		{
			if( tile == null )
			{
				tile:Tile = tiles[column][row];
			}
			
			tile.occupy(occupier);
			occupier.insert(tile);
			addChild(occupier);
		}
		
		public function generateMap():void
		{
			tiles = new Vector.<Vector.<Tile>>();
			
			for (var column:uint = 0; column < Settings.mapSize; column++)
			{
				tiles[column] = new Vector.<Tile>();
				
				for (var row:uint = 0; row < Settings.mapSize; row++)
				{
					tiles[column][row] = new Tile(new Point(column, row));
					addChild(tiles[column][row]);
				}
			}
		}
		
		public function getTiles():Vector.<Vector.<Tile>>
		{
			return tiles;
		}
		
		public function getTileFromCoordinates(x:Number, y:Number):Tile
		{
			var tileX:int = (Settings.tileSize * 16) / x;
			var tileY:int = (Settings.tileSize * 16) / y;
			
			return getTile(tileX, tileY);
		}
		
		public function getTile(column:int, row:int):Tile
		{
			return tiles[column][row];
		}
	}
}