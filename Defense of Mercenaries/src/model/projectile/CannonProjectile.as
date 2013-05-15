package model.projectile
{
	import model.enemy.Enemy;
	import model.tower.Tower;
	
	import starling.display.Shape;
	import starling.events.Event;
	import starling.text.TextField;
	
	public class CannonProjectile extends Projectile
	{
		private var blastRadius:Number;
		private var shape:Shape;
		private var target:Enemy;
		private var velocity:Number;
		private var strength:int;
		private var targetX:Number;
		private var targetY:Number;
		private var velocityX:Number;
		private var velocityY:Number;
		private var halfwayX:Number;
		private var halfwayY:Number;
		private var movedX:Number = 0;
		private var movedY:Number = 0;
		
		public function CannonProjectile(target:Enemy, velocity:Number, strength:int, owner:Tower, blastRadius:Number)
		{
			super(target, velocity, strength, owner);
			
			this.target = target;		
			this.velocity = velocity;
			this.strength = strength;
			this.blastRadius = blastRadius;
			
			this.targetX = target.x + GlobalState.tileSize / 2;
			this.targetY = target.y + GlobalState.tileSize / 2;
			
			var targetDeltaX:Number = targetX - (owner.x + GlobalState.tileSize / 2);
			var targetDeltaY:Number = targetY - (owner.y);
			
			var hyp:Number = Math.sqrt( targetDeltaX * targetDeltaX + targetDeltaY * targetDeltaY );
			
			this.velocityX = (targetDeltaX / hyp) * velocity;
			this.velocityY = (targetDeltaY / hyp) * velocity;
			
			this.halfwayX = Math.abs(targetDeltaX / 2);
			this.halfwayY = Math.abs(targetDeltaY / 2);
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init():void
		{
			this.shape = new Shape();
			this.shape.graphics.beginFill(0x222222, 1);
			this.shape.graphics.lineStyle(1, 0x000000, 0.7);
			this.shape.graphics.drawCircle(0, 0, GlobalState.tileSize / 5);
			this.shape.graphics.endFill();
			addChild(this.shape);
		}
		
		public override function update(deltaTime:Number):void
		{						
			var deltaX:Number = this.targetX - x;
			var deltaY:Number = this.targetY - y;
						
			var absX:Number = Math.abs(deltaX);
			var absY:Number = Math.abs(deltaY);
			
			if( (absX < ((GlobalState.tileSize as Number) / 8)) && (absY < ((GlobalState.tileSize as Number) / 8)))
			{				
				blast();
			}
			else
			{				
				var moveX:Number = (((GlobalState.tileSize as Number) * deltaTime * this.velocityX) / 1000);
				var moveY:Number = (((GlobalState.tileSize as Number) * deltaTime * this.velocityY) / 1000);
				
				x += moveX;
				y += moveY;
				
				if ((this.movedX < this.halfwayX) || (this.movedY < this.halfwayY))
				{
					height += (GlobalState.tileSize as Number) / 100;
					width += (GlobalState.tileSize as Number) / 100;
				}
				else
				{
					height -= (GlobalState.tileSize as Number) / 100;
					width -= (GlobalState.tileSize as Number) / 100;
				}
				
				this.movedX += Math.abs(moveX);
				this.movedY += Math.abs(moveY);
			}
		}
		
		public function blast():void
		{
			var deltaX:Number;
			var deltaY:Number;
			var hyp:Number;
			
			var cannonBlast:CannonBlast = new CannonBlast(blastRadius);
			cannonBlast.x = this.targetX;
			cannonBlast.y = this.targetY;
			GlobalState.currentMap.addChild(cannonBlast);
			
			for (var i:int = 0; i < GlobalState.currentMap.numChildren; i++)
			{
				var child:Object = GlobalState.currentMap.getChildAt(i);
				
				if (child is Enemy)
				{
					deltaX = Math.abs((child.x + GlobalState.tileSize / 2) - this.targetX);
					deltaY = Math.abs((child.y + GlobalState.tileSize / 2) - this.targetY);
					hyp = Math.sqrt( deltaX * deltaX + deltaY * deltaY );

					if ((hyp - (GlobalState.tileSize / 4)) <= blastRadius)
					{
						(child as Enemy).damage(this.strength);
					}
				}
			}
			
			this.removeFromParent(true);
		}
	}
}