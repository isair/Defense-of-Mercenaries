package game.projectile
{
	import game.GameObject;
	
	import asset.EmbeddedGameAssets;
	
	import starling.display.Sprite;
	import starling.display.Shape;
	import starling.events.Event;
	import starling.utils.AssetManager;
	
	import flash.media.SoundChannel;
	
	public class CannonBlast extends Sprite implements GameObject
	{
		public static var assetManager:AssetManager = null;
		
		private var blastRadius:Number;
		private var shape:Shape;
		private var timer:Number = 0;
		
		public function CannonBlast(blastRadius:Number)
		{
			this.blastRadius = blastRadius;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event):void
		{
			assetManager = new AssetManager();
			
			assetManager.enqueue(EmbeddedGameAssets);
			
			assetManager.loadQueue(function(ratio:Number):void
			{
				if (ratio == 1.0) doSomething(); // this does nothing, needs better code
			});
			
			this.shape = new Shape();
			this.shape.graphics.beginFill(0xFFCC00, 1);
			this.shape.graphics.lineStyle(1, 0xFF6600, 0.5);
			this.shape.graphics.drawCircle(0, 0, this.blastRadius / 3);
			this.shape.graphics.beginFill(0xFF6600, 1);
			this.shape.graphics.lineStyle(1, 0xFF0000, 0.5);
			this.shape.graphics.drawCircle(0, 0, this.blastRadius / (3 / 2));
			this.shape.graphics.beginFill(0xFF0000, 1);
			this.shape.graphics.lineStyle(1, 0xFF0000, 0.5);
			this.shape.graphics.drawCircle(0, 0, this.blastRadius);
			this.shape.graphics.endFill();
			alpha = 0.6;
			addChild(this.shape);
			 
		}
		
		private function doSomething():void
		{
			// void function in place for asset enqueing
		}
		
		public function update(deltaTime:Number):void
		{
			timer += deltaTime;
			alpha -= deltaTime / 1000;
			height -= GlobalState.tileSize / 100;
			width -= GlobalState.tileSize / 100;
							
			if (timer >= 750)
			{
					var blast:SoundChannel = assetManager.playSound("explosionSound", 0, 0);

					this.removeFromParent(true);
			}
			
			
			
		}
	}
}