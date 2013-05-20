package game.ui
{
	import game.state.Game;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.display.Image;
	import starling.textures.Texture;
	
	public class TopHUD extends Sprite
	{
		public function TopHUD()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event):void
		{
			var texture:Texture = Game.assetManager.getTexture("wallTexture");
			var wall:Image = new Image(texture);
			
			addChild(wall);
		}
	}
}