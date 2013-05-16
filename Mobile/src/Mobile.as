package
{
	import flash.display.Sprite;
	
	import starling.textures.TextureAtlas;
	
	public class Mobile extends Sprite
	{
		public function Mobile()
		{
			super();
			addChild(new Main());
		}
	}
}