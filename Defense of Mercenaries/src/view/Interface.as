package view
{
	import starling.display.Sprite;

	public class Interface extends Sprite
	{
		private var hand:Hand;
		
		public function Interface()
		{
			super();
			
			hand = new Hand();
			addChild(hand);
		}
	}
}