package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Boy Voesten & Swan Chase
	 */
	public class Game extends Sprite 
	{
		
		private var _player01 : Player = new Player();
		
		public function Game() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			trace("game loaded");
			
			addChild(_player01);
			_player01.x = stage.stageWidth / 2;
			_player01.y = stage.stageHeight / 2;
			trace("player added");
		}
		
	}

}