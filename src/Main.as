package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Boy Voesten & Swan Chase
	 */
	public class Main extends Sprite 
	{
		
		private var _menu : Menu;
		private var _game : Game;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			// Start with ze menu
			OpenMenu(e = null);
		}
		
		private function OpenMenu(e:Event):void 
		{
			if (_game)
			{
				// REMOVE ZE GAME
				_game.removeEventListener("openMenu", OpenMenu);
				removeChild(_game);
				_game = null;
			}
			
			// ADD ZE MENU
			_menu = new Menu();
			addChild(_menu);
			_menu.addEventListener("startGame", StartGame);
		}
		
		private function StartGame(e:Event):void 
		{
			if (_menu)
			{
				// REMOVE ZE MENU
				_menu.removeEventListener("startGame", StartGame);
				removeChild(_menu);
				_menu = null;
			}
			
			// ADD ZE GAME
			_game = new Game();
			addChild(_game);
			_game.addEventListener("openMenu", OpenMenu);
		}
		
	}
	
}