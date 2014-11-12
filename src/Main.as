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
		
		public static const STARTGAME : String = "startGame";
		public static const OPENMENU : String = "openMenu";
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
			
			// Start with menu
			OpenMenu(e = null);
		}
		
		private function OpenMenu(e:Event):void 
		{
			if (_game)
			{
				// REMOVE - GAME
				_game.removeEventListener(OPENMENU, OpenMenu);
				removeChild(_game);
				_game = null;
			}
			
			// ADD - MENU
			_menu = new Menu();
			addChild(_menu);
			_menu.addEventListener(STARTGAME, StartGame);
		}
		
		private function StartGame(e:Event):void 
		{
			if (_menu)
			{
				// REMOVE - MENU
				_menu.removeEventListener(STARTGAME, StartGame);
				removeChild(_menu);
				_menu = null;
			}
			
			// ADD - GAME
			_game = new Game();
			addChild(_game);
			_game.addEventListener(OPENMENU, OpenMenu);
		}
		
	}
	
}