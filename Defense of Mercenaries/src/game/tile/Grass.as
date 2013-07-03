package game.tile
{
	import asset.EmbeddedGameAssets;
	
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Shape;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	import game.state.Game;
	
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
				
				var image:Image = new Image(texture);
				addChild(image);
				
			}
			else // Draw a simple quad if texture fails to load
			{
				addChild(new Quad(size, size, 0x57c023, true));
			}
		}
	}
}