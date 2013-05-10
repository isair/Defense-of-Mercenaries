package view
{
	import model.Card;
	import model.tile.Tile;
	import model.tower.SlowTower;
	import model.tower.Tower;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.display.Shape;
	
	public class Interface extends Sprite
	{
		private var hand:Hand;
		private var ghostArray:Array = new Array(2);
		
		public function Interface()
		{
			super();
			
			hand = new Hand();
			hand.y = 650;
			addChild(hand);
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
						break;
				}
			}
		}
		
		public function drawGhost(touch:Touch, card:Card):void
		{
			removeGhost();
			
			var snapCoordinates:Array = Settings.currentMap.getSnapCoordinates(touch.globalX, touch.globalY);
			var currentTile:Tile = Settings.currentMap.getTileFromCoordinates(touch.globalX, touch.globalY);
			
			if( snapCoordinates[1] <= (15 * Settings.tileSize))
			{
				if(! (currentTile.isOccupied() || currentTile.hasRoad()))
				{
					
					switch(card.type)
					{
						case 1:
							ghostArray = Tower.getGhost();
							addSnapCoords(snapCoordinates);
							addGhost();
							break;
						case 2:
							ghostArray = SlowTower.getGhost();
							addSnapCoords(snapCoordinates);
							addGhost();
							break;
						case 3:
							break;
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
						addChild(q as Shape);
					if(q is Quad)
						addChild(q as Quad);
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
						removeChild(q as Shape);
					if(q is Quad)
						removeChild(q as Quad);
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
	}
}