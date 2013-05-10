package view
{
	import model.Card;
	import model.tile.Tile;
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
					
					card.price.text = "dragging";
					
					// dragging
					card.addResetCounter();
					
					break;
				
				case TouchPhase.ENDED:
					
					// released
					
					constructTower(touch, card);
					card.addResetCounter();
					
					break;
			}

			//When construction completes -- deduct gold
		}
		
		public function constructTower(touch:Touch, card:Card):void
		{
			var currentTile:Tile = Settings.currentMap.getTileFromCoordinates(touch.globalX, touch.globalY);
			
			if(!currentTile.isOccupied())
			{
				switch(card.type)
				{
					case 1:
						var tower:Tower = new Tower();
						Settings.currentMap.insertOccupier(tower, currentTile);
						break;
					case 2:
						break;
					case 3:
						break;
				}
			}
		}
	}
}