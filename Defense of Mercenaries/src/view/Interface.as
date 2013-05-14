package view
{
	import model.BonusCard;
	import model.Card;
	import model.GameObject;
	import model.enemy.Enemy;
	import model.tile.Tile;
	import model.tower.CannonTower;
	import model.tower.FastTower;
	import model.tower.SlowTower;
	import model.tower.Tower;
	
	import starling.display.Quad;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class Interface extends Sprite implements GameObject
	{
		private var hand:Hand;
		private var hud:HUD;
		private var ghostArray:Array = new Array(2);
		
		public function Interface()
		{
			super();
			
			hand = new Hand();
			hand.y = Settings.tileSize * 16;
			
			hud = new HUD();
			hud.y = Settings.tileSize * 19.5;
			
			addChild(hand);	
			addChild(hud);
		}
		
		public function handleTouch(card:Card, touch:Touch):void
		{
			switch(touch.phase)
			{				
				case TouchPhase.MOVED:
					
					drawGhost(touch, card);
					// dragging
					
					break;
				
				case TouchPhase.ENDED:
					
					// released
					removeGhost();
					constructTower(touch, card);
					
					break;
			}
			
			//When construction completes -- deduct gold
		}
		
		public function handleBonusTouch(bonusCard:BonusCard, touch:Touch):void 
		{
			if (bonusCard.type == 5) {
				boostTowers();
			}
			else if (bonusCard.type == 6) {
				freezeEnemies();
			}
			
			Settings.currentGold -= bonusCard.cost;
		}
		
		public function freezeEnemies():void
		{
			for (var i:int = 0; i < Settings.currentMap.numChildren; i++)
			{
				var child:Object = Settings.currentMap.getChildAt(i);
				
				if (child is Enemy)
				{
					(child as Enemy).freeze();
				}
			}
			
			Settings.freezeTimer = 2000;
			Settings.freezeActive = true;
		}
		
		public function unfreezeEnemies():void
		{
			for (var i:int = 0; i < Settings.currentMap.numChildren; i++)
			{
				var child:Object = Settings.currentMap.getChildAt(i);
				
				if (child is Enemy)
				{
					(child as Enemy).unfreeze();
				}
			}
			
			Settings.freezeActive = false;
		}
		
		public function boostTowers():void
		{
			for (var i:int = 0; i < Settings.currentMap.numChildren; i++)
			{
				var child:Object = Settings.currentMap.getChildAt(i);
				
				if (child is Tower)
				{
					(child as Tower).boostAttackSpeed();
				}
			}
			
			Settings.boostTimer = 3000;
			Settings.boostActive = true;
		}
		
		public function revertBoost():void
		{
			for (var i:int = 0; i < Settings.currentMap.numChildren; i++)
			{
				var child:Object = Settings.currentMap.getChildAt(i);
				
				if (child is Tower)
				{
					(child as Tower).revertAttackSpeed();
				}
			}
			
			Settings.boostActive = false;
		}
		
		public function constructTower(touch:Touch, card:Card):void
		{
			var currentTile:Tile = Settings.currentMap.getTileFromCoordinates(touch.globalX, touch.globalY);
			
			if(! (currentTile.isOccupied() || currentTile.hasRoad()))
			{
				switch(card.type)
				{
					case 1:
						var tower:Tower = new Tower();
						Settings.currentMap.insertOccupierToTile(tower, currentTile);
						Settings.currentGold -= card.cost;
						break;
					case 2:
						var slowTower:SlowTower = new SlowTower();
						Settings.currentMap.insertOccupierToTile(slowTower, currentTile);
						Settings.currentGold -= card.cost;
						break;
					case 3:
						var fastTower:FastTower = new FastTower();
						Settings.currentMap.insertOccupierToTile(fastTower, currentTile);
						Settings.currentGold -= card.cost;
						break;
					case 4:
						var cannonTower:CannonTower = new CannonTower();
						Settings.currentMap.insertOccupierToTile(cannonTower, currentTile);
						Settings.currentGold -= card.cost;
						break;
				}
			}
		}
		
		public function drawGhost(touch:Touch, card:Card):void
		{
			removeGhost();
			
			var snapCoordinates:Array = Settings.currentMap.getSnapCoordinates(touch.globalX, touch.globalY);
			var currentTile:Tile = Settings.currentMap.getTileFromCoordinates(touch.globalX, touch.globalY);
			
			if (currentTile != null)
			{
				if( snapCoordinates[1] <= (15 * Settings.tileSize))
				{
					if(! (currentTile.isOccupied() || currentTile.hasRoad()))
					{
						switch(card.type)
						{
							case 1:
								ghostArray = Tower.getGhost();
								break;
							case 2:
								ghostArray = SlowTower.getGhost();
								break;
							case 3:
								ghostArray = FastTower.getGhost();
								break;
							case 4:
								ghostArray = CannonTower.getGhost();
								break;
						}
						
						addSnapCoords(snapCoordinates);
						addGhost();
					}
				}
			}
		}
		
		public function addGhost():void
		{
			for each(var q:Object in ghostArray)
			{
				if(q != null)
				{
					if(q is Shape)
						Settings.currentMap.addChild(q as Shape);
					if(q is Quad)
						Settings.currentMap.addChild(q as Quad);
				}
			}
		}
		
		public function removeGhost():void
		{
			for each(var q:Object in ghostArray)
			{
				if(q != null)
				{
					if(q is Shape)
						Settings.currentMap.removeChild(q as Shape);
					if(q is Quad)
						Settings.currentMap.removeChild(q as Quad);
				}
			}
		}
		
		public function addSnapCoords(snapCoords:Array):void
		{
			for each(var q:Object in ghostArray)
			{
				if( q!= null)
				{
					if(q is Shape)
					{
						(q as Shape).x = snapCoords[0];
						(q as Shape).y = snapCoords[1];
					}
					
					if(q is Quad)
					{
						(q as Quad).x = snapCoords[0];
						(q as Quad).y = snapCoords[1];
					}
				}
			}
		}
		
		public function update(deltaTime:Number):void
		{
			if ( Settings.boostActive )
			{
				Settings.boostTimer -= deltaTime;
				
				if ( Settings.boostTimer <= 0 )
				{
					revertBoost();
				}
			}
			
			if ( Settings.freezeActive )
			{
				Settings.freezeTimer -= deltaTime;
				
				if ( Settings.freezeTimer <= 0 )
				{
					unfreezeEnemies();
				}
			}
		}
	}
}