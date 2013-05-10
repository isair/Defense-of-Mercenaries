package model
{
  	import flash.geom.Point;
  	
  	import model.astar.AStar;
  	import model.astar.AStarHeap;
  	import model.astar.AStarNode;
  	import model.enemy.Enemy;
  	import model.tile.Tile;
  	
  	import starling.display.Quad;
  	import starling.display.Sprite;

  	public class Gate extends Sprite implements GameObject
  	{
		private var storedEnemies:int = 0;
		private var spawnTimePassed:Number = 0;
		
		private var position:Tile = null;
		
		private var hasPath:Boolean = false;
		private var path:Path = null;
		
		public function Gate()
		{
			super();
		}
		
		public function insert(position:Tile):void
		{
			this.position = position;
			this.storedEnemies = 3;
			
			x = position.getX();
			y = position.getY();
		}
		
		// Calculate an optimal path from gate to base using A* algorithm.
		public function calculatePath(base:Base):Boolean
		{
			var tiles:Vector.<Vector.<Tile>> = Settings.currentMap.getTiles();
			var nodes:Vector.<Vector.<AStarNode>> = new Vector.<Vector.<AStarNode>>();
			var startNode:AStarNode, endNode:AStarNode;
			
			// Make nodes out of tiles.
			var previousNode:AStarNode;
			
			for (var column:uint = 0; column < tiles.length; column++)
			{
				nodes[column] = new Vector.<AStarNode>();
				
				for (var row:uint = 0; row < tiles[column].length; row++)
				{
					var node:AStarNode = new AStarNode();
					var tile:Tile = tiles[column][row];
					
					node.next = previousNode;
					node.isWall = tile.isOccupied() && ! (tile.getOccupier() is Base);
					node.position = new Point(column, row);
					
					nodes[column][row] = node;
					
					// Set startNode and endNode.
					if (tile.x == position.x && tile.y == position.y)
						startNode = node;
					else if (tile.x == base.getPosition().x && tile.y == base.getPosition().y)
						endNode = node;
					
					previousNode = node;
				}
			}
			
			// Initialize A* path finder.
			var pathFinder:AStar = new AStar(nodes);
			
			// Find path nodes.
			var pathNodes:Vector.<AStarNode> = pathFinder.findPath(startNode, endNode);
			
			// Return false if unable to find a path.
			if (pathNodes.length == 0)
				return false;
				
			// Create path out of path nodes.
			var currentNode:AStarNode = startNode;
			var nextNode:AStarNode;
			
			path = new Path();
			
			for (var i:int = 0; i < pathNodes.length; i++)
			{
				nextNode = pathNodes[i];
				
				if (nextNode.position.x > currentNode.position.x && nextNode.position.y == currentNode.position.y)
					path.pushDirection(Path.RIGHT);
				else if (nextNode.position.x < currentNode.position.x && nextNode.position.y == currentNode.position.y)
					path.pushDirection(Path.LEFT);
				else if (nextNode.position.y > currentNode.position.y && nextNode.position.x == currentNode.position.x)
					path.pushDirection(Path.DOWN);
				else if (nextNode.position.y < currentNode.position.y && nextNode.position.x == currentNode.position.x)
					path.pushDirection(Path.UP);
				
				currentNode = nextNode;
			}
			
			// Reset road tiles.
			for (column = 0; column < tiles.length; column++)
				for (row = 0; row < tiles[column].length; row++)
					tiles[column][row].setIsRoad(false);
			
			// Set tiles on path as road tiles.
			tiles[startNode.position.x][startNode.position.y].setIsRoad(true);
			for (i = 0; i < pathNodes.length; i++)
				tiles[pathNodes[i].position.x][pathNodes[i].position.y].setIsRoad(true);
			
			hasPath = true;
			
			return true;
		}
		
		public function update(deltaTime:Number):void
		{
			if ( ! hasPath) return;
			
			spawnTimePassed += deltaTime;
			
			if (spawnTimePassed > 1500)
			{	
				if(storedEnemies > 0)
				{
					storedEnemies--;
					spawnEnemy();
				}
				
				spawnTimePassed -= 1500;
			}
		}
		
		public function spawnEnemy():void
		{
			Settings.currentMap.addChild(new Enemy(100, 1, new Point(position.getX(), position.getY()), (new Path()).copyPath(path)));
		}
	}
}
