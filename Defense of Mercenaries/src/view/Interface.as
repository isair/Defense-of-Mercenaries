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
	
	public class Interface extends Sprite
	{
		private var hand:Hand;
		private var ghost:Quad = null;
		
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
					
					if(ghost != null)
						removeChild(ghost);
					
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
			if( ghost != null)
				removeChild(ghost);
			
			var snapCoordinates:Array = Settings.currentMap.getSnapCoordinates(touch.globalX, touch.globalY);

			switch(card.type)
			{
				case 1:
					ghost = Tower.getGhost();
					ghost.x = snapCoordinates[0];
					ghost.y = snapCoordinates[1];
					addChild(ghost);
					break;
				case 2:
					ghost = SlowTower.getGhost();
					ghost.x = snapCoordinates[0];
					ghost.y = snapCoordinates[1];
					addChild(ghost);
					break;
				case 3:
					break;
			}

		}
	}
}