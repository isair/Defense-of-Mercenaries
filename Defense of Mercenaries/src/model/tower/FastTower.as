package model.tower
{
	import starling.display.Quad;
	import starling.display.Shape;
	import starling.events.Event;
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	import state.Game;
	import asset.EmbeddedGameAssets;
	
	public class FastTower extends Tower
	{
		private static var occupiersAtlas:TextureAtlas = EmbeddedGameAssets.getOccupiersAtlas();
		private static var fastTowerTexture:Texture = occupiersAtlas.getTexture("fasttower");
		private static var fastTowerShape:Image = new Image(fastTowerTexture);
		
		public function FastTower()
		{
			super();
			
			super.attackInterval = 800;
			super.damage = 20;
			super.currentInterval = super.attackInterval - 1;
			super.range = GlobalState.tileSize * 2.5;
		}
		
		public override function init(e:Event):void
		{
			var fastTowerShape:Image = new Image(fastTowerTexture);
			fastTowerShape.y = - GlobalState.tileSize / 2;
			addChild(fastTowerShape);
		}
		
		public static function getGhost():Array
		{
			var ghostArray:Array = new Array(2);
			
			var shape:Shape = new Shape();
			shape.graphics.beginFill(0xFF0000, 0.3);
			shape.graphics.lineStyle(1, 0xFF0000, 0.7);
			shape.graphics.drawCircle(GlobalState.tileSize / 2, GlobalState.tileSize / 2, GlobalState.tileSize * 2.5);
			shape.graphics.endFill();
			ghostArray[0] = shape;
			
			var ghost:Quad = fastTowerShape;
			ghost.alpha = 0.3;
			ghostArray[1] = ghost;
			
			return ghostArray;
		}
	}
}