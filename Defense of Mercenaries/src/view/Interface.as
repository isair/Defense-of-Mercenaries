package view
{
	import starling.display.Sprite;
	import starling.display.Quad;

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
	}
}