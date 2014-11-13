package  
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Boy Voesten & Swan Chase
	 */
	public class Game extends Sprite 
	{
		private var _players : Array = [];
		private var _balls : Array = [];
		private var _player01 : Player_1 = new Player_1();
		private var _player02 : Player_2 = new Player_2();
		private var _ball : NormalBall = new NormalBall();
		private var _bgArt01 : BgArt01 = new BgArt01;
		private var _bgArt02 : BgArt02 = new BgArt02;
		private var counter : int = 0;
		
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
			
			_player01.x = stage.stageWidth / 2;
			_player01.y = stage.stageHeight / 2;	
			
			_player02.rotation = 180;
			
			addChild(_bgArt01);
			addChild(_player01);
			addChild(_player02);
			addChild(_bgArt02);
			
			_players.push(_player01);
			_players.push(_player02);
			
			respawnBall();
		}

		private function update(e:Event):void 
		{
			var _playersLength : uint = _players.length;
			var _ballsLength : uint = _balls.length;
			
			for (var i : int = _playersLength - 1; i >= 0; i--) 
			{
				if (_players[i].hitTestPoint(_ball.x,_ball.y,true)) 
				{
					counter ++;
					if (counter == 1)
					{
						_ball.hitPlatform();
					}
					else 
					{ 
						counter = 0;
					}
					
				}
			}
			
			for (i = _ballsLength - 1; i >= 0; i--) 
			{
				_balls[i].update();
				checkBall();
			}
			
		}
		
		private function checkBall():void 
		{
			// If the ball goes out of the circle
			if (_ball.location.length >= 300) 
			{
				// If the ball hits the RIGHT side of the circle
				if (_ball.x > stage.stageWidth / 2)
				{
					trace("Right side");
					// TODO: Give point to player 2
				} 
				else 
				{
					trace("Left side");
					// TODO: Give point to player 1
				}
				
				// TODO: Remove ball
				respawnBall();
				
			}
		}
		
		private function respawnBall():void 
		{
			if (contains(_ball))
			{
				removeChild(_ball);
				_balls.splice(_ball);
			} 
			else 
			{
				_ball.x = stage.stageWidth / 2;
				_ball.y = stage.stageHeight / 2;
				addChild(_ball);
				_balls.push(_ball);
			}
		}
		
		private function destroy():void
		{
			removeEventListener(Event.ENTER_FRAME, update);
			_players = [];
			_balls = [];
			
			var l : uint = numChildren;
			var current : DisplayObject;
			for ( var i : int = l -1; i >= 0; i--) 
			{
				current = getChildAt(i);
				if ( current is Sprite)
				{
					removeChild(current);
				}
			}
			current = null;
			i = l = NaN;
		}
		
	}

}