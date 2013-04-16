package
{
	import flash.display.Sprite;
	
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.events.Event;
	
	import state.Game;
	
	import model.GameObject;
	
	[SWF(frameRate="60", width="640", height="960", backgroundColor="0x333333")]
	public class Main extends Sprite
	{
		public static var tileSize:int = 40;
		
		private var starling:Starling = null;
		
		private var deltaTime:Number = 0;
		private var prevFrameDate:Date = null;
		private var nextFrameDate:Date = null;
		
		public function Main()
		{
			starling = new Starling(Game, stage);
			starling.antiAliasing = 1;
			starling.start();
			
			prevFrameDate = new Date();
			this.addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private function enterFrame(e:Event)
		{
			nextFrameDate = new Date();
			deltaTime = (nextFrameDate.time - prevFrameDate.time) / 1000;
			
			recurseGameObjectUpdate(stage);
			
			prevFrameDate = nextFrameDate;
		}
		
		private function recurseGameObjectUpdate(container:DisplayObjectContainer)
		{
			for (var i = 0; i < container.numChildren; i++)
			{
				var child = container.getChildAt(i);
				
				if (child is GameObject)
					child.update(deltaTime);
				
				if (child is DisplayObjectContainer && child.numChildren > 0)
					recurseGameObjectUpdate(child);
			}
		}
	}
}