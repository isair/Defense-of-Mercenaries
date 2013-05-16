package model
{
  	import flash.geom.Point;
  	
  	import model.astar.AStar;
  	import model.astar.AStarHeap;
  	import model.astar.AStarNode;
  	import model.enemy.Enemy;
  	import model.tile.Tile;
	import state.Game;
  	
  	import starling.display.Quad;
  	import starling.display.Sprite;
	import starling.events.Event;
	import starling.display.Image;
	import starling.textures.Texture;

  	public class Gate extends Sprite implements GameObject
  	{
		private var currentId:int = 0;
		
		private var position:Tile = null;
		private var target:Base = null;
		
		private var working:Boolean = false;
		
		private var hasPath:Boolean = false;
		private var path:Path = null;
		
		private var storedEnemies:int = 0;
		private var powerMultiplier:Number = 0;
		private var spawnTimePassed:Number = 0;
		
		private var waveCount:int = 0;
		private var waveInterval:int = 15000; // Waiting time between waves (in milliseconds).
		
		private var waitTime:Number = 0;
		
		private var callback:Function = null;
		
		public function Gate(target:Base)
		{
			super();
			setTarget(target);
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event):void
		{
			var texture:Texture = Game.assetManager.getTexture("gateTexture");
			var gate:Image = new Image(texture);
			gate.y = - GlobalState.tileSize;
			
			addChild(gate);
		}
		
		public function setTarget(target:Base):void
		{
			this.target = target;
		}
		
		public function insert(position:Tile):void
		{
			this.position = position;
			
			x = position.getX();
			y = position.getY();
		}
		
		// Calculate an optimal path from gate to base using A* algorithm.
		public function calculatePath():Boolean
		{
			if ( ! target) return false;
			
			var tiles:Vector.<Vector.<Tile>> = GlobalState.currentMap.getTiles();
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
					else if (tile.x == target.getPosition().x && tile.y == target.getPosition().y)
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
			
			return true;
		}
		
		public function start(waveCount:int, powerMultiplier:Number, callback:Function):void
		{
			hasPath = calculatePath();
			
			if ( ! hasPath) return;
			
			this.waveCount = waveCount;
			this.powerMultiplier = powerMultiplier;
			this.callback = callback;
			
			GlobalState.currentWave = 0;
			storedEnemies = 2;
			working = true;
		}
		
		public function pause():void
		{
			working = false;
		}
		
		public function resume():void
		{
			working = true;
		}
		
		public function stop():void
		{
			storedEnemies = 0;
			GlobalState.currentWave = 0;
			waveCount = 0;
			working = false;
		}
		
		public function update(deltaTime:Number):void
		{
			if ( ! hasPath || ! working) return;
			
			if (GlobalState.currentWave >= waveCount && callback != null)
			{
				stop();
				callback();
				return;
			}
			
			if (waitTime > 0)
			{
				waitTime -= deltaTime;
				
				if (waitTime > 0) return;
				deltaTime = 0 - waitTime;
			}
			
			if (storedEnemies > 0)
			{
				spawnTimePassed += deltaTime;
				
				if(spawnTimePassed >= 1500)
				{
					storedEnemies--;
					spawnEnemy();
					spawnTimePassed -= 1500;
				}
			}
			else
			{
				spawnTimePassed = 0;
				waitTime = waveInterval;
				GlobalState.currentWave++;
				storedEnemies = 2 + GlobalState.currentWave * 1.3;
			}
		}
		
		public function spawnEnemy():void
		{
			var enemy:Enemy = new Enemy(100 * powerMultiplier, 1 * powerMultiplier, new Point(x, y), (new Path()).copyPath(path), currentId);
			enemy.x = position.x + GlobalState.tileSize / 2;
			enemy.y = position.y + GlobalState.tileSize / 2;
			currentId++;
			
			GlobalState.currentMap.insertEnemy(enemy);
		}
	}
}
