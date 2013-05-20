package model.astar
{
	import flash.geom.Point;
	
	import game.tile.Tile;

	public class AStarNode
	{
		public var h:int, f:int, g:int;
		public var visited:Boolean, closed:Boolean, isWall:Boolean;
		public var position:Point;
		public var parent:AStarNode, next:AStarNode;
		public var from:int;
		public var to:int;
		
		public function AStarNode() {}
	}
}