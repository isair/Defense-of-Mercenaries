package model.tile
{
	import asset.EmbeddedGameAssets;
	
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	import starling.display.Quad;
	import starling.display.Shape;
	import starling.textures.Texture;
	
	import state.Game;

	public class Grass extends Tile
	{
		public function Grass(position:Point)
		{
			super(position);
		}
		
		public override function draw():void
		{
			var size:Number = Settings.tileSize;
			var texture:Texture = Game.assetManager.getTexture("grassTexture");
			
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
				addChild(new Quad(size, size, 0x57c023, true));
			}
		}
	}
}