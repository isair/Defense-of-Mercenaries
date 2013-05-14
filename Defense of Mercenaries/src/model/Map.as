package model
{
	import flash.geom.Point;
	
	import model.tile.Tile;
	import model.tile.Grass;
	import model.tower.Tower;
	import model.enemy.Enemy;
	import model.projectile.Projectile;
	
	import starling.display.Sprite;
	
	public class Map extends Sprite implements GameObject
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
			
			for (var column:uint = 0; column < GlobalState.mapSize; column++)
			{
				tiles[column] = new Vector.<Tile>();
				
				for (var row:uint = 0; row < GlobalState.mapSize; row++)
				{
					tiles[column][row] = new Grass(new Point(column, row));
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
			var tileX:int = x / GlobalState.tileSize;
			var tileY:int = y / GlobalState.tileSize;
			
			if( (tileX >= 0) && (tileX < 16) && (tileY >= 0) && (tileY < 16))
				return getTile(tileX, tileY);
			else
				return null;
		}
		
		public function getSnapCoordinates(x:Number, y:Number):Array
		{
			var snapCoordinates:Array = new Array(2);
			
			var tileX:int = x / GlobalState.tileSize;
			var tileY:int = y / GlobalState.tileSize;
			
			snapCoordinates[0] = tileX * GlobalState.tileSize;
			snapCoordinates[1] = tileY * GlobalState.tileSize;
			
			return snapCoordinates;
		}
		
		public function getTile(column:int, row:int):Tile
		{
			return tiles[column][row];
		}
		
		public function update(deltaTime:Number):void
		{
			this.sortChildren(function sortByY(a:Object, b:Object):int{
				if((a is Projectile) && (b is Projectile))
				{
					return 0;
				}
				else if (a is Projectile)
				{
					return 1;
				}
				else if (b is Projectile)
				{
					return -1;
				}
				else if((a is Enemy) && (b is Enemy))
				{
					if(a.y > b.y)
						return 1;
					else if(a.y < b.y)
						return -1;
					else
						return 0;
				}
				else if(a is Enemy)
				{
					return 1;
				}
				else if(b is Enemy)
				{
					return -1;
				}
				else
				{
					return 0;
				}
			});
		}
	}
}