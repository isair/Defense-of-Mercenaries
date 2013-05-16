package model.tile
{
	import asset.EmbeddedGameAssets;
	
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Shape;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	import state.Game;

	public class Grass extends Tile
	{
		private var grassAtlas:TextureAtlas = EmbeddedGameAssets.getGrassAtlas();

		public function Grass(position:Point)
		{
			super(position);
		}
		
		public override function draw():void
		{
			var size:Number = GlobalState.tileSize;
			var texture:Texture = grassAtlas.getTexture("grass");
			
			if (texture)
			{
				//var shape:Shape = new Shape();
				//addChild(shape);
				
				var image:Image = new Image(texture);
				addChild(image);
				
				/*var scaleMatrix:Matrix = new Matrix();
				scaleMatrix.scale(texture.width / size, texture.height / size);
				
				shape.graphics.beginTextureFill(texture, scaleMatrix);
				shape.graphics.drawRect(0, 0, size, size);
				shape.graphics.endFill();*/
			}
			else // Draw a simple quad if texture fails to load.
			{
				addChild(new Quad(size, size, 0x57c023, true));
			}
		}
	}
}