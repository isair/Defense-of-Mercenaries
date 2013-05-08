package model.astar
{
	import model.tile.Tile;

	public class AStarHeap
	{
		private var content:Vector.<AStarNode>;
		private var scoreFunction:Function;
		
		public function AStarHeap(scoreFunction:Function)
		{
			content = new Vector.<AStarNode>();
			this.scoreFunction = scoreFunction;
		}
		
		public function reset():void
		{
			content = new Vector.<AStarNode>();
		}
		
		public function getSize():int
		{
			return content.length;
		}
		
		public function get getContent():Vector.<AStarNode>
		{
			return content;
		}
		
		public function push(node:AStarNode):void
		{
			content.push(node);
			sinkDown(content.length - 1);
		}
		
		public function pop():AStarNode
		{
			var result:AStarNode = content[0];
			var end:AStarNode = content.pop();
			
			if (content.length > 0)
			{
				content[0] = end;
				bubbleUp(0);
			}
			
			return result;
		}
		
		public function remove(node:AStarNode):void
		{
			var i:int = content.indexOf(node);
			var end:AStarNode = content.pop();
			
			if (i != content.length - 1)
			{
				content[i] = end;
				
				if (scoreFunction(end) < scoreFunction(node))
					sinkDown(i);
				else
					bubbleUp(i);
			}
		}
		
		public function rescoreElement(node:AStarNode):void
		{
			sinkDown(content.indexOf(node));
		}
		
		private function sinkDown(i:int):void
		{
			var node:AStarNode = content[i];
			
			while (i > 0)
			{
				var parentIndex:int = content.indexOf(node.parent);
				
				if (parentIndex == -1) parentIndex = 0;
				
				var parent:AStarNode = content[parentIndex];
				
				if (scoreFunction(node) < scoreFunction(parent))
				{
					content[parentIndex] = node;
					content[i] = parent;
					i = parentIndex;
				}
				else break;
			}
		}
		
		private function bubbleUp(n:Number):void
		{
			var length:int = content.length;
			var node:AStarNode = content[n];
			var score:Number = scoreFunction(node);
			
			while (true)
			{
				var child2N:Number = (n + 1) << 1;
				var child1N:Number = child2N - 1;
				var child1Score:Number = scoreFunction(content[child1N]);
				var swap:* = null;
				
				if (child1N < length && child1Score < score)
					swap = child1N;
				
				if (child2N < length && scoreFunction(content[child2N]) < (swap == null ? score : child1Score))
					swap = child2N;
				
				if (swap != null)
				{
					content[n] = content[swap];
					content[swap] = node;
					n = swap;
				}
				else break;
			}
		}
	}
}