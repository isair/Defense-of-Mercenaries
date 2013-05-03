package model
{
	import model.tile.Tile;

	public class TileNode
	{
		private var h:int, f:int, g:int;
		private var visited:Boolean, closed:Boolean;
		private var tile:Tile, parent:Tile, next:Tile;
		
		public function TileNode(tile:Tile)
		{
			this.tile = tile;
		}
	}
}