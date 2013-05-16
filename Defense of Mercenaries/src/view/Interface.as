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
	import model.Obstacle;
	import state.Game;
	
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
			hand.y = GlobalState.tileSize * 17;
			
			hud = new HUD();
			hud.y = GlobalState.tileSize * 20.5;
			
			addChild(hand);	
			addChild(hud);
		}
		
		public function handleTouch(card:Card, touch:Touch):void
		{
			switch (touch.phase)
			{				
				case TouchPhase.MOVED:
					drawGhost(touch, card); // dragging
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
			if (bonusCard.type == 5)
				boostTowers();
			else if (bonusCard.type == 6)
				freezeEnemies();
			
			GlobalState.currentGold -= bonusCard.cost;
		}
		
		public function freezeEnemies():void
		{
			var targets:Sprite = GlobalState.currentMap.getEnemiesAndOccupiers();
			
			for (var i:int = 0; i < targets.numChildren; i++)
			{
				var child:Object = targets.getChildAt(i);
				
				if (child is Enemy)
				{
					(child as Enemy).freeze();
				}
			}
			
			GlobalState.freezeTimer = 2000;
			GlobalState.freezeActive = true;
		}
		
		public function unfreezeEnemies():void
		{
			var targets:Sprite = GlobalState.currentMap.getEnemiesAndOccupiers();
			
			for (var i:int = 0; i < targets.numChildren; i++)
			{
				var child:Object = targets.getChildAt(i);
				
				if (child is Enemy)
				{
					(child as Enemy).unfreeze();
				}
			}
			
			GlobalState.freezeActive = false;
		}
		
		public function boostTowers():void
		{
			var targets:Sprite = GlobalState.currentMap.getEnemiesAndOccupiers();
			
			for (var i:int = 0; i < targets.numChildren; i++)
			{
				var child:Object = targets.getChildAt(i);
				
				if (child is Tower)
				{
					(child as Tower).boostAttackSpeed();
				}
			}
			
			GlobalState.boostTimer = 3000;
			GlobalState.boostActive = true;
		}
		
		public function revertBoost():void
		{
			var targets:Sprite = GlobalState.currentMap.getEnemiesAndOccupiers();
			
			for (var i:int = 0; i < targets.numChildren; i++)
			{
				var child:Object = targets.getChildAt(i);
				
				if (child is Tower)
				{
					(child as Tower).revertAttackSpeed();
				}
			}
			
			GlobalState.boostActive = false;
		}
		
		public function constructTower(touch:Touch, card:Card):void
		{
			var currentTile:Tile = GlobalState.currentMap.getTileFromCoordinates(touch.globalX, touch.globalY);
			var tower:Tower = null;
			var temp:Obstacle = new Obstacle();
			
			if ( ! (currentTile.isOccupied()))
			{
				if ( GlobalState.roundBreak || !currentTile.hasRoad() )
				{
					switch (card.type)
					{
						case 1:							
							if( currentTile.hasRoad() )
							{
								GlobalState.currentMap.insertOccupierToTile(temp, currentTile);
								if(Game.gate.calculatePath())
								{
									tower = new Tower();
								}
								GlobalState.currentMap.removeOccupierFromTile(temp, currentTile);
							}
							else
							{
								tower = new Tower();
							}
							break;
						case 2:
							if( currentTile.hasRoad() )
							{
								GlobalState.currentMap.insertOccupierToTile(temp, currentTile);
								if(Game.gate.calculatePath())
								{
									tower = new SlowTower();
								}
								GlobalState.currentMap.removeOccupierFromTile(temp, currentTile);
							}
							else
							{
								tower = new SlowTower();
							}
							break;
						case 3:
							if( currentTile.hasRoad() )
							{
								GlobalState.currentMap.insertOccupierToTile(temp, currentTile);
								if(Game.gate.calculatePath())
								{
									tower = new FastTower();
								}
								GlobalState.currentMap.removeOccupierFromTile(temp, currentTile);
							}
							else
							{
								tower = new FastTower();
							}
							break;
						case 4:
							if( currentTile.hasRoad() )
							{
								GlobalState.currentMap.insertOccupierToTile(temp, currentTile);
								if(Game.gate.calculatePath())
								{
									tower = new CannonTower();
								}
								GlobalState.currentMap.removeOccupierFromTile(temp, currentTile);
							}
							else
							{
								tower = new CannonTower();
							}
							break;
					}
					
					if (tower != null)
					{
						GlobalState.currentGold -= card.cost;
						GlobalState.currentMap.insertOccupierToTile(tower, currentTile);
						GlobalState.currentMap.childrenSort();
					}
				}
			}
		}
		
		public function drawGhost(touch:Touch, card:Card):void
		{
			removeGhost();
			
			var snapCoordinates:Array = GlobalState.currentMap.getSnapCoordinates(touch.globalX, touch.globalY);
			var currentTile:Tile = GlobalState.currentMap.getTileFromCoordinates(touch.globalX, touch.globalY);
			
			if (currentTile != null)
			{
				if (snapCoordinates[1] <= (15 * GlobalState.tileSize))
				{
					if ( ! (currentTile.isOccupied()))
					{
						if ( GlobalState.roundBreak || !currentTile.hasRoad() )
						{
							switch (card.type)
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
		}
		
		public function addGhost():void
		{
			for each (var q:Object in ghostArray)
			{
				if (q != null)
				{
					if(q is Shape)
						GlobalState.currentMap.addChild(q as Shape);
					if(q is Quad)
						GlobalState.currentMap.addChild(q as Quad);
				}
			}
		}
		
		public function removeGhost():void
		{
			for each (var q:Object in ghostArray)
			{
				if (q != null)
				{
					if(q is Shape)
						GlobalState.currentMap.removeChild(q as Shape);
					if(q is Quad)
						GlobalState.currentMap.removeChild(q as Quad);
				}
			}
		}
		
		public function addSnapCoords(snapCoords:Array):void
		{
			for each (var q:Object in ghostArray)
			{
				if (q!= null)
				{
					if (q is Shape)
					{
						(q as Shape).x = snapCoords[0];
						(q as Shape).y = snapCoords[1];
					}
					
					if (q is Quad)
					{
						(q as Quad).x = snapCoords[0];
						(q as Quad).y = snapCoords[1] - GlobalState.tileSize / 2;
					}
				}
			}
		}
		
		public function update(deltaTime:Number):void
		{
			if (GlobalState.boostActive)
			{
				GlobalState.boostTimer -= deltaTime;
				
				if (GlobalState.boostTimer <= 0)
					revertBoost();
			}
			
			if (GlobalState.freezeActive)
			{
				GlobalState.freezeTimer -= deltaTime;
				
				if (GlobalState.freezeTimer <= 0)
					unfreezeEnemies();
			}
		}
	}
}