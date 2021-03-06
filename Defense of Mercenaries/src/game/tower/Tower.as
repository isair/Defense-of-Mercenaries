package game.tower
{
	import flash.geom.Point;
	
	import game.GameObject;
	import game.Occupier;
	import model.Path4D;
	import game.enemy.Enemy;
	import game.projectile.Projectile;
	import game.tile.Tile;
	import asset.EmbeddedGameAssets;
	import game.state.Game;

	import starling.textures.TextureAtlas;
	import starling.textures.Texture;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Shape;
	import starling.events.Event;
	import starling.display.Sprite;
	
	public class Tower extends Occupier implements GameObject
	{
		public var damage:int = 13;
		public var range:int = GlobalState.tileSize * 3.5;
		private var influenceRange:int;
		private static var occupiersAtlas:TextureAtlas = EmbeddedGameAssets.getOccupiersAtlas();
		private static var towerTexture:Texture = occupiersAtlas.getTexture("tower");
		private static var towerShape:Image = new Image(towerTexture);
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
			var towerImage:Image = new Image(towerTexture);
			towerImage.y = - GlobalState.tileSize / 2;
			
			addChild(towerImage);
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
			
			var targets:Sprite = GlobalState.currentMap.getEnemiesAndOccupiers();
			
			for (var i:int = 0; i < targets.numChildren; i++)
			{
				var child:Object = targets.getChildAt(i);
				
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
			
			if( (hyp - (GlobalState.tileSize / 4)) < range )
				return true;
			else
				return false;
		}
		
		public function shoot(enemy:Enemy):void
		{
			var bullet:Projectile = new Projectile(enemy, GlobalState.tileSize/4, damage, this);
			bullet.x = x + GlobalState.tileSize / 2;
			bullet.y = y;
			GlobalState.currentMap.addChild(bullet);
		}
		
		public static function getGhost():Array
		{
			var ghostArray:Array = new Array(2);
			
			var shape:Shape = new Shape();
			shape.graphics.beginFill(0xFF0000, 0.3);
			shape.graphics.lineStyle(1, 0xFF0000, 0.7);
			shape.graphics.drawCircle(GlobalState.tileSize / 2, GlobalState.tileSize / 2, GlobalState.tileSize * 3.5);
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
		
		public static function fetchImage():void
		{
			occupiersAtlas = EmbeddedGameAssets.getOccupiersAtlas();
			towerTexture = occupiersAtlas.getTexture("tower");
			towerShape = new Image(towerTexture);
		}
	}
}