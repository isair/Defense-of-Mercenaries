package model
{
	public interface Occupier
	{		
		function getPosition():Tile;
		function insert(position:Tile):void;
	}
}