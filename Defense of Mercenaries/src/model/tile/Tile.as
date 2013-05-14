package model.tile
{
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	import model.Occupier;
	
	import starling.display.Quad;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	import state.Game;

	public class Tile extends Sprite
	{
		private static var borderSize:int = 1;
		
		private var position:Point;
		private var occupier:Occupier;
		private var isRoad:Boolean;
		
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
			var texture:Texture = Game.assetManager.getTexture("roadTexture");
			
			if (texture)
			{
				var shape:Shape = new Shape();
				addChild(shape);
				
				var scaleMatrix:Matrix = new Matrix();
				scaleMatrix.scale(texture.width / size, texture.height / size);
				
				shape.graphics.beginTextureFill(texture, scaleMatrix);
				shape.graphics.drawRect(0, 0, size, size);
				shape.graphics.endFill();
			}
			else // Draw a simple quad if texture fails to load.
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
		
		public function setIsRoad(isRoad:Boolean):void
		{
			if (this.isRoad == isRoad) return;
			
			this.isRoad = isRoad;
			
			removeChildren();
			init(null);
		}
	}
}