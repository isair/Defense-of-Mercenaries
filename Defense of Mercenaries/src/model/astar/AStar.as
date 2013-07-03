package model.astar
{
	public class AStar
	{
		private var openHeap:AStarHeap;
		private var visitedNodes:Vector.<AStarNode>;
		private var nodes:Vector.<Vector.<AStarNode>>;
		
		public function AStar(nodes:Vector.<Vector.<AStarNode>>)
		{
			this.nodes = nodes;
		}
		
		public function findPath(startNode:AStarNode, endNode:AStarNode):Vector.<AStarNode>
		{
			// Reset previously visited node states and prepare for finding a new path.
			if (openHeap)
			{
				for (var i:int = visitedNodes.length - 1; i > -1; i--)
				{
					visitedNodes[i].f = 0;
					visitedNodes[i].g = 0;
					visitedNodes[i].h = 0;
					visitedNodes[i].closed = false;
					visitedNodes[i].visited = false;
					visitedNodes[i].parent = null;
				}
				openHeap.reset();
			}
			else
			{
				openHeap = new AStarHeap(function(node:AStarNode):Number{return node.f;});
			}
			
			visitedNodes = new Vector.<AStarNode>();
			
			openHeap.push(startNode);
			
			while (openHeap.getSize() > 0)
			{
				// Pop the node with the lowest score from our heap.
				var currentNode:AStarNode = openHeap.pop();
				
				// Check if goal is reached.
				if (currentNode.position.x == endNode.position.x && currentNode.position.y == endNode.position.y)
				{
					var node:AStarNode = currentNode;
					var path:Vector.<AStarNode> = new Vector.<AStarNode>();
					
					while (node.parent)
					{
						path.push(node);
						node = node.parent;
					}
					
					return path.reverse();
				}
				
				// Visit current node.
				currentNode.closed = true;
				visitedNodes.push(currentNode);
				
				// Get neighbors of our current node.
				var neighbors:Vector.<AStarNode> = getNeighbors(currentNode);
				
				// Iterate through neighbours.
				for (i = 0; i < neighbors.length; i++)
				{
					var neighbor:AStarNode = neighbors[i];
					
					if (neighbor.closed || neighbor.isWall) continue;
					
					var g:int = currentNode.g + 1;
					var visited:Boolean = neighbor.visited;
					
					if ( ! visited) visitedNodes.push(neighbor);
					
					if ( ! visited || g < neighbor.g)
					{
						neighbor.visited = true;
						neighbor.parent = currentNode;
						neighbor.h = neighbor.h || Math.abs(endNode.position.x - neighbor.position.x) + Math.abs(endNode.position.y - neighbor.position.y);
						neighbor.g = g;
						neighbor.f = neighbor.g + neighbor.h;
						
						if ( ! visited)
							openHeap.push(neighbor);
						else
							openHeap.rescoreElement(neighbor);
					}
				}
			}
			
			return new Vector.<AStarNode>();
		}
		
		private function getNeighbors(node:AStarNode):Vector.<AStarNode>
		{
			var neighbors:Vector.<AStarNode> = new Vector.<AStarNode>();
			var x:Number = node.position.x;
			var y:Number = node.position.y;
			
			// Left.
			try
			{
				if (nodes[x - 1] && nodes[x - 1][y])
					neighbors.push(nodes[x - 1][y]);
			} catch(e:ReferenceError) {} catch(e:RangeError) {}
			
			// Right.
			try
			{
				if (nodes[x + 1] && nodes[x + 1][y])
					neighbors.push(nodes[x + 1][y]);
			} catch(e:ReferenceError) {} catch(e:RangeError) {}
			
			// Up.
			try
			{
				if (nodes[x] && nodes[x][y - 1])
					neighbors.push(nodes[x][y - 1]);
			} catch(e:ReferenceError) {} catch(e:RangeError) {}
			
			// Down.
			try
			{
				if (nodes[x] && nodes[x][y + 1])
					neighbors.push(nodes[x][y + 1]);
			} catch(e:ReferenceError) {} catch(e:RangeError) {}
			
			return neighbors;
		}
	}
}