package model.projectile
{
	import model.GameObject;
	
	import starling.display.Sprite;
	import starling.display.Shape;
	import starling.events.Event;
	
	public class CannonBlast extends Sprite implements GameObject
	{
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
		
		public function update(deltaTime:Number):void
		{
			timer += deltaTime;
			alpha -= deltaTime / 1000;
			height -= GlobalState.tileSize / 100;
			width -= GlobalState.tileSize / 100;
			
			if (timer >= 750)
			{
				this.removeFromParent(true);
			}
		}
	}
}