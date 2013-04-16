package state
{
	import model.GameObject;
	
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import starling.events.Event;

	public class GameState extends Sprite
	{
		private var deltaTime:Number = 0;
		private var prevFrameDate:Date = null;
		private var nextFrameDate:Date = null;
		
		public function GameState()
		{
			super();
			
			prevFrameDate = new Date();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAdd);
			this.addEventListener(Event.ENTER_FRAME, onFrameEnter);
		}
		
		public  function onAdd(e:Event):void {}
		
		private function onFrameEnter(e:Event)
		{
			nextFrameDate = new Date();
			deltaTime = nextFrameDate.time - prevFrameDate.time;
			
			recurseGameObjectUpdate(stage);
			
			prevFrameDate = nextFrameDate;
		}
		
		private function recurseGameObjectUpdate(container:DisplayObjectContainer):void
		{
			for (var i:int = 0; i < container.numChildren; i++)
			{
				var child:Object = container.getChildAt(i);
				
				if (child is GameObject)
					child.update(deltaTime);
				
				if (child is starling.display.DisplayObjectContainer && child.numChildren > 0)
					recurseGameObjectUpdate(child as DisplayObjectContainer);
			}
		}
	}
}