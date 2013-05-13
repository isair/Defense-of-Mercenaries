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
		
		public function insertOccupierToTile(occupier:Occupier, tile:Tile):void
		{
			tile.occupy(occupier);
			occupier.insert(tile);
			addChild(occupier);
		}
				
		public function insertOccupier(occupier:Occupier, column:int, row:int):void
		{
			var tile:Tile = tiles[column][row];
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
			var tileX:int = x / Settings.tileSize;
			var tileY:int = y / Settings.tileSize;
			
			if( (tileX >= 0) && (tileX < 16) && (tileY >= 0) && (tileY < 16))
				return getTile(tileX, tileY);
			else
				return null;
		}
		
		public function getSnapCoordinates(x:Number, y:Number):Array
		{
			var snapCoordinates:Array = new Array(2);
			
			var tileX:int = x / Settings.tileSize;
			var tileY:int = y / Settings.tileSize;

			snapCoordinates[0] = tileX * Settings.tileSize;
			snapCoordinates[1] = tileY * Settings.tileSize;
			
			return snapCoordinates;
		}
		
		public function getTile(column:int, row:int):Tile
		{
			return tiles[column][row];
		}
	}
}