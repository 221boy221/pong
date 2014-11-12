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
		private var _players : Array = [];
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
			_player02.rotation = 180;
			trace("player 2 added");
			
			_players.push(_player01);
			_players.push(_player02);
			
			addChild(_ball);
			trace("ball added");
		}

		private function update(e:Event):void 
		{
			for (var i :uint = 0; i < _players.length; i++) 
			{
				if (_players[i].hitTestObject(_ball)) 
				{
					var tempX : Number;
					var tempY : Number;
					tempX = _ball.velocity.x;
					tempY = _ball.velocity.y;
					
					_ball.velocity.x = tempY * -1;
					_ball.velocity.y = tempX * -1;
					_ball.x += _ball.velocity.x;
					_ball.y += _ball.velocity.y;
					break;
					
				}
			}
		}
		
		
		
	}

}