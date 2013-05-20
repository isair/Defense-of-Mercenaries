package game.projectile
{
	import game.enemy.Enemy;
	import game.tower.Tower;
	
	import starling.display.Quad;
	import starling.events.Event;
	
	public class SlowProjectile extends Projectile
	{
		private var slowAmount:Number;
		private var slowDuration:Number;
		private var shape:Quad;
		private var target:Enemy;
		private var strength:int;
		
		public function SlowProjectile(target:Enemy, velocity:Number, strength:int, owner:Tower, slowAmount:Number, slowDuration:Number)
		{
			super(target, velocity, strength, owner);
			
			this.target = target;			
			this.strength = strength;
			this.slowAmount = slowAmount;
			this.slowDuration = slowDuration;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init():void
		{
			this.shape = new Quad(5, 5, 0x58E1E8, true);
			addChild(this.shape);
		}
		
		public override function hit():void
		{		
			target.slow(slowAmount, slowDuration);
			target.damage(strength);
		}
	}
}