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
		
		private var _player01 : Player_1 = new Player_1();
		private var _player02 : Player_2 = new Player_2();
		private var _ball : NormalBall = new NormalBall();
		
		public function Game() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.ENTER_FRAME, update);
			// entry point
			trace("game loaded");
			
			addChild(_player01);
			_player01.x = stage.stageWidth / 2;
			_player01.y = stage.stageHeight / 2;
			trace("player 1 added");
			
			addChild(_player02);
			_player02.x = stage.stageWidth / 2;
			_player02.y = stage.stageHeight / 2;
			trace("player 2 added");
			
			addChild(_ball);
			trace("ball added");
		}
		
		private function update(e:Event):void 
		{
			if (_player01.hitTestObject(_ball)) {
				trace("HIT");
				
			}
		}
		
		
		
	}

}