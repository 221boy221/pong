package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Boy Voesten & Swan Chase
	 */
	public class Menu extends Sprite 
	{
				
		public function Menu() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			trace("menu opened");
			stage.addEventListener(MouseEvent.CLICK, start);
		}
		
		private function start(e:MouseEvent):void 
		{
			trace("Clicked to start ze game");
			dispatchEvent(new Event(Main.STARTGAME, false));
			
		}
		
	}

}