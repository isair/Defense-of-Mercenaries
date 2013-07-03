package game.tile
{
	import asset.EmbeddedGameAssets;
	
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	import game.Occupier;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	import game.state.Game;
	
	public class Tile extends Sprite
	{
		private static var borderSize:int = 1;
		
		private var position:Point;
		private var occupier:Occupier;
		private var isRoad:Boolean;
		private var from:int;
		private var to:int;
		
		public function Tile(position:Point)
		{
			super();
			
			this.position = position;
			
			x = (position.x) * GlobalState.tileSize;
			y = (position.y) * GlobalState.tileSize;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event):void
		{
			if (isRoad)
				drawRoad();
			else
				draw();
		}
		
		private function drawRoad():void
		{
			var size:Number = GlobalState.tileSize;
			
			var textureAtlas:TextureAtlas = EmbeddedGameAssets.getRoadsAtlas();
			var texture:Texture;
			
			// NS
			if ( ( (from == 1) && (to == 3) ) || ( (from == 3) && (to == 1) ) )
			{
				texture = textureAtlas.getTexture("road_ns");
			}
				// WE
			else if ( ( (from == 2) && (to == 4) ) || ( (from == 4) && (to == 2) ) )
			{
				texture = textureAtlas.getTexture("road_we");
			}
				// NE
			else if ( ( (from == 1) && (to == 2) ) || ( (from == 2) && (to == 1) ) )
			{
				texture = textureAtlas.getTexture("road_ne");
			}
				// NW
			else if ( ( (from == 1) && (to == 4) ) || ( (from == 4) && (to == 1) ) )
			{
				texture = textureAtlas.getTexture("road_nw");
			}
				// SE
			else if ( ( (from == 2) && (to == 3) ) || ( (from == 3) && (to == 2) ) )
			{
				texture = textureAtlas.getTexture("road_se");
			}
				// SW
			else if ( ( (from == 3) && (to == 4) ) || ( (from == 4) && (to == 3) ) )
			{
				texture = textureAtlas.getTexture("road_sw");
			}
			
			if (texture)
			{
				
				var image:Image = new Image(texture);
				addChild(image);
			}
			else
			{
				addChild(new Quad(GlobalState.tileSize, GlobalState.tileSize, 0x61380b, true));
			}
		}
		
		// Override this method for different tiles.
		public function draw():void
		{
			var outerSquare:Quad = new Quad(GlobalState.tileSize, GlobalState.tileSize, 0x000000, true);
			var innerSquare:Quad = new Quad(GlobalState.tileSize - borderSize * 2, GlobalState.tileSize - borderSize * 2, 0xB3956D, true);
			
			innerSquare.x = borderSize;
			innerSquare.y = borderSize;
			
			addChild(outerSquare);
			addChild(innerSquare);
		}
		
		public function getX():int
		{
			return position.x * GlobalState.tileSize;
		}
		
		public function getY():int
		{
			return position.y * GlobalState.tileSize;
		}
		
		public function occupy(occupier:Occupier):void
		{
			this.occupier = occupier;
		}
		
		public function deoccupy():void
		{
			this.occupier = null;
		}
		
		public function isOccupied():Boolean
		{	
			return occupier != null;
		}
		
		public function hasRoad():Boolean
		{
			return isRoad;
		}
		
		public function getOccupier():Occupier
		{
			return occupier;
		}
		
		public function getCenterX():int
		{
			return x + GlobalState.tileSize / 2;
		}
		
		public function getCenterY():int
		{
			return y + GlobalState.tileSize / 2;
		}
		
		public function setFromTo(from:int, to:int):void
		{
			this.from = from;
			this.to = to;
		}
		
		public function setIsRoad(isRoad:Boolean):void
		{
			if (this.isRoad == isRoad) return;
			
			this.isRoad = isRoad;
			
			removeChildren();
			init(null);
		}
	}
}