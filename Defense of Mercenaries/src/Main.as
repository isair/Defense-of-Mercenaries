package
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	import model.GameObject;
	
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.events.Event;
	
	import state.Game;
	
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
		
		private function enterFrame(e:Event):void
		{
			nextFrameDate = new Date();
			deltaTime = (nextFrameDate.time - prevFrameDate.time) / 1000;
			
			recurseGameObjectUpdate(stage);
			
			prevFrameDate = nextFrameDate;
		}
		
		private function recurseGameObjectUpdate(container:Object):void
		{
			if ( ! container is flash.display.DisplayObjectContainer && 
				 ! container is starling.display.DisplayObjectContainer)
				return;
			
			for (var i:int = 0; i < container.numChildren; i++)
			{
				var child:Object = container.getChildAt(i);
				
				if (child is GameObject)
					child.update(deltaTime);
				
				if ((child is flash.display.DisplayObjectContainer ||
					 child is starling.display.DisplayObjectContainer) &&
					 child.numChildren > 0)
					recurseGameObjectUpdate(child);
			}
		}
	}
}