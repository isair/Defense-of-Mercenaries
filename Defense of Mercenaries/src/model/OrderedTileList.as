package model
{
	import model.tile.Tile;

	public class OrderedTileList
	{
		private var content:Vector.<Tile>;
		private var scoreFunction:Function;
		
		public function OrderedTileList(scoreFunction:Function)
		{
			content = new Vector.<Tile>();
			this.scoreFunction = scoreFunction;
		}
		
		public function reset():void
		{
			content = new Vector.<Tile>();
		}
		
		public function getSize():int
		{
			return content.length;
		}
		
		public function get getContent():Vector.<Tile>
		{
			return content;
		}
		
		public function push(tile:Tile):void
		{
			content.push(tile);
			sinkDown(content.length - 1);
		}
		
		public function pop():Tile
		{
			var result:Tile = content[0];
			var end:Tile = content.pop();
			
			if (content.length > 0)
			{
				content[0] = end;
				bubbleUp(0);
			}
			
			return result;
		}
		
		public function remove(tile:Tile):void
		{
			var i:int = content.indexOf(tile);
			var end:Tile = content.pop();
			
			if (i != content.length - 1)
			{
				content[i] = end;
				
				if (scoreFunction(end) < scoreFunction(tile))
					sinkDown(i);
				else
					bubbleUp(i);
			}
		}
		
		public function rescoreElement(tile:Tile):void
		{
			sinkDown(content.indexOf(tile));
		}
		
		private function sinkDown(n:int):void
		{
			var element:Tile = content[n];
			
			while (n > 0)
			{
				var parentIndex:int = content.indexOf(element.parent);
			}
		}
		
		private function bubbleUp(n:Number):void
		{
			
		}
	}
}