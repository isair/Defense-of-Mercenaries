package model
{
  	import flash.geom.Point;
  	
  	import model.astar.AStar;
  	import model.astar.AStarHeap;
  	import model.astar.AStarNode;
  	import model.enemy.Enemy;
  	import model.tile.RoadTile;
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
		public function calculatePath(base:Base):void
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
					node.isWall = tile.isOccupied();
					node.position = new Point(column, row);
					
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
				
			// Create path out of path nodes.
			var nextNode:AStarNode = pathNodes.pop();
			var currentNode:AStarNode = null;
			
			path = new Path();
			
			for (var i:int = 0; i < pathNodes.length; i++)
			{
				currentNode = pathNodes.pop();
				
				if (nextNode.position.x > currentNode.position.x)
					path.pushDirection(Path.RIGHT);
				else if (nextNode.position.x < currentNode.position.x)
					path.pushDirection(Path.LEFT);
				else if (nextNode.position.y > currentNode.position.y)
					path.pushDirection(Path.DOWN);
				else
					path.pushDirection(Path.UP);
				
				nextNode = currentNode;
			}
			
			path.reverse();
			
			// Temporary fix.
			path = new Path();
			
			for (var i:int = 0; i < 5; i++)
				path.pushDirection(Path.RIGHT);
			
			for (var i:int = 0; i < 7; i++)
				path.pushDirection(Path.DOWN);
			
			path.pushDirection(Path.RIGHT);
			path.pushDirection(Path.RIGHT);
			path.pushDirection(Path.DOWN);
			path.pushDirection(Path.RIGHT);
			path.pushDirection(Path.DOWN);
			path.pushDirection(Path.DOWN);
			
			// Pave the path with road tiles.
			var roadPath:Path = new Path().copyPath(path);
			var nextDirection:int = roadPath.popNextDirection();
			var roadX:int = 0;
			var roadY:int = 0;
			
			while (nextDirection != Path.NONE)
			{
				var roadTile:Quad = new Quad(Settings.tileSize, Settings.tileSize, 0x61380b, true);
				
				roadTile.x = roadX;
				roadTile.y = roadY;
				
				addChild(roadTile);
				
				switch (nextDirection)
				{
					case Path.UP:
						roadY -= Settings.tileSize;
						break;
					
					case Path.RIGHT:
						roadX += Settings.tileSize;
						break;
					
					case Path.DOWN:
						roadY += Settings.tileSize;
						break;
					
					case Path.LEFT:
						roadX -= Settings.tileSize;
						break;
					
					default:
						break;
				}
				
				nextDirection = roadPath.popNextDirection();
			}
			
			hasPath = true;
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
