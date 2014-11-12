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
		
		private var startMenu : StartMenu;
		private var startButton : StartButton;
		
		public function Menu() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			trace("menu opened");
			
			startMenu = new StartMenu();
			startButton = new StartButton();
			
			startButton.x = stage.stageWidth / 2;
			startButton.y = stage.stageHeight / 2 + 50;
			
			addChild(startMenu);
			addChild(startButton);
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, start);
		}
		
		private function start(e:MouseEvent):void 
		{
			if (e.target==startButton)
			{
			trace("Clicked to start ze game");
			removeChild(startMenu)
			removeChild(startButton)
			dispatchEvent(new Event("startGame", false));
			}
		}
		
	}

}