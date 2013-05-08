package state
{
	import model.GameObject;
	
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;

	public class GameState extends Sprite
	{	
		public function GameState()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAdd);
			this.addEventListener(Event.ENTER_FRAME, onFrameEnter);
		}
		
		public  function onAdd(e:Event):void {}
		
		private function onFrameEnter(e:EnterFrameEvent):void
		{
			recurseGameObjectUpdate(stage, e.passedTime * 1000);
		}
		
		private function recurseGameObjectUpdate(container:DisplayObjectContainer, deltaTime:Number):void
		{
			for (var i:int = 0; i < container.numChildren; i++)
			{
				var child:Object = container.getChildAt(i);
				
				if (child is GameObject)
					child.update(deltaTime);
				
				if (child is starling.display.DisplayObjectContainer && child.numChildren > 0)
					recurseGameObjectUpdate(child as DisplayObjectContainer, deltaTime);
			}
		}
	}
}