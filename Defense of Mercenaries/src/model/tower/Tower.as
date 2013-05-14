package model.tower
{
	import flash.geom.Point;
	
	import model.GameObject;
	import model.Occupier;
	import model.Path;
	import model.enemy.Enemy;
	import model.projectile.Projectile;
	import model.tile.Tile;
	
	import starling.display.Quad;
	import starling.display.Shape;
	import starling.events.Event;
	
	public class Tower extends Occupier implements GameObject
	{
		private var position:Tile;
		private var damage:int = 20;
		public var range:int = Settings.tileSize * 5;
		private var influenceRange:int;
		private static var towerShape:Quad = new Quad(Settings.tileSize, Settings.tileSize, 0x7A4F2C, true);
		private var shape:Quad;
		public var attackInterval:int = 1500;
		public var currentInterval:int = attackInterval - 1;
		private var previousInterval:Number = 0;
		private var boosted:Boolean = false;
		
		public function Tower()
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public override function init(e:Event):void
		{			
			this.shape = new Quad(Settings.tileSize, Settings.tileSize, 0x7A4F2C, true);
			addChild(shape);
		}
		
		public function update(deltaTime:Number):void
		{
			currentInterval += deltaTime;
			
			if (currentInterval > attackInterval)
			{	
				if (findFirstEnemy())
					currentInterval -= attackInterval;
				else
					currentInterval = attackInterval - 1;
			}
		}
		
		public function findFirstEnemy():Boolean
		{
			var firstEnemy:Enemy = null;
			var currentLeast:int = 9999;
			
			for (var i:int = 0; i < Settings.currentMap.numChildren; i++)
			{
				var child:Object = Settings.currentMap.getChildAt(i);
				
				if (child is Enemy)
				{					
					if (inRange(child as Enemy))
					{
						if ((child as Enemy).id < currentLeast)
						{
							firstEnemy = (child as Enemy);
							currentLeast = (child as Enemy).id;
						}
					}
				}
			}
			
			if (firstEnemy != null)
			{
				shoot(firstEnemy);
				return true;
			}
			else
				return false;
		}
		
		public function inRange(enemy:Enemy):Boolean
		{
			var deltaX:Number = Math.abs(this.x - enemy.x);
			var deltaY:Number = Math.abs(this.y - enemy.y);
			
			var hyp:Number = Math.sqrt( deltaX * deltaX + deltaY * deltaY );
			
			if( (hyp - (Settings.tileSize / 4)) < range )
				return true;
			else
				return false;
		}
		
		public function shoot(enemy:Enemy):void
		{
			var bullet:Projectile = new Projectile(enemy, Settings.tileSize/4, damage, this);
			bullet.x = x + Settings.tileSize / 2;
			bullet.y = y + Settings.tileSize / 2;
			Settings.currentMap.addChild(bullet);
		}
		
		public static function getGhost():Array
		{
			var ghostArray:Array = new Array(2);
			
			var shape:Shape = new Shape();
			shape.graphics.beginFill(0xFF0000, 0.3);
			shape.graphics.lineStyle(1, 0xFF0000, 0.7);
			shape.graphics.drawCircle(Settings.tileSize / 2, Settings.tileSize / 2, Settings.tileSize * 5);
			shape.graphics.endFill();
			ghostArray[0] = shape;
			
			var ghost:Quad = towerShape;
			ghost.alpha = 0.3;
			ghostArray[1] = ghost;
			
			return ghostArray;
		}
		
		public function boostAttackSpeed():void
		{
			this.previousInterval = this.attackInterval;
			this.attackInterval = this.attackInterval / 2 ;
			this.boosted = true; 
		}
		
		public function revertAttackSpeed():void
		{
			if ( boosted )
			{
				this.attackInterval = this.previousInterval;
				this.boosted = false;
			}
		}
	}
}