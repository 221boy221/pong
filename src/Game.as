package  
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Boy Voesten & Swan Chase
	 */
	public class Game extends Sprite 
	{
		//BGs
		private var _bgArt01 : BgArt01 = new BgArt01();
		private var _bgArt02 : BgArt02 = new BgArt02();
		private var _gameCurtain : GameCurtain = new GameCurtain();
		private var _countdown1 : Countdown1 = new Countdown1();
		private var _countdown2 : Countdown2 = new Countdown2();
		private var _countdown3 : Countdown3 = new Countdown3();
		private var _speed1 : int;
		private var _speed2 : int;
		private var _speed3 : int;
		// Players and Balls
		private var _players	: Array = [];
		private var _player01	: Player_1 = new Player_1();
		private var _player02	: Player_2 = new Player_2();
		private var _balls		: Array = [];
		private var _ball		: NormalBall = new NormalBall();
		private var _counter 	: int = 0;
		private var _respawnBallTimer : Timer = new Timer(500, 0);
		// UI
		private var SCORE1 : int = 0;
		private var SCORE2 : int = 0;
		private var textFormat	 : TextFormat = new TextFormat;
		private var playerScore1 : TextField = new TextField();
		private var playerScore2 : TextField = new TextField();
		
		
		public function Game() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			// Positioning
			_countdown1.x = _countdown2.x = _countdown3.x = stage.stageWidth / 2;
			_countdown1.y = _countdown2.y = _countdown3.y = stage.stageHeight / 2;
			_player01.x = stage.stageWidth / 2;
			_player01.y = stage.stageHeight / 2;	
			_player02.rotation = 180;
			playerScore1.x = stage.stageWidth / 2 + 105;
			playerScore2.x = stage.stageWidth / 2 - 200;
			playerScore1.y = playerScore2.y = 10;
			textFormat.color = 0xffffff;
			textFormat.size = 15;
			playerScore1.defaultTextFormat = textFormat;
			playerScore2.defaultTextFormat = textFormat;
			playerScore1.autoSize = TextFieldAutoSize.CENTER;
			playerScore2.autoSize = TextFieldAutoSize.CENTER;
			updateTextFields();
			
			// Adding everything
			addChild(_bgArt01);
			addChild(_player01);
			addChild(_player02);
			addChild(_countdown1);
			addChild(_countdown2);
			addChild(_countdown3);
			addChild(_bgArt02);
			addChild(playerScore1);
			addChild(playerScore2);
			addChild(_gameCurtain);
			
			
			// Fill the array
			_players.push(_player01);
			_players.push(_player02);
			
			addEventListener(Event.ENTER_FRAME, tempLoop);
		}
		
		private function tempLoop(e:Event):void 
		{
			_speed3 += 1;
			_countdown3.y += _speed3 / 8;
			if (_countdown3.y > stage.stageHeight) 
			{
				_speed2 += 1;
				_countdown2.y += _speed2 / 7;
				if (_countdown2.y > stage.stageHeight) 
				{
					_speed1 += 1;
					_countdown1.y += _speed1 / 7;
					if (_countdown1.y > stage.stageHeight) 
					{
						startGame();
					}
				}
			}
		}
		
		private function startGame():void 
		{
			removeEventListener(Event.ENTER_FRAME, tempLoop);
			addEventListener(Event.ENTER_FRAME, update);
			respawnBall(null);
		}

		private function update(e:Event):void 
		{
			var _playersLength	: uint = _players.length,
				_ballsLength 	: uint = _balls.length;
				
			for (var i : int = _playersLength - 1; i >= 0; i--) 
			{
				if (_players[i].hitTestPoint(_ball.x,_ball.y,true)) 
				{
					_counter ++;
					if (_counter == 1)
					{
						_ball.hitPlatform();
					}
					else 
					{ 
						_counter = 0;
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
					SCORE2 += 1;
					updateTextFields();
				} 
				else 
				{
					SCORE1 += 1;
					updateTextFields();
				}
				
				respawnBall(null);
				_respawnBallTimer.start();
				_respawnBallTimer.addEventListener(TimerEvent.TIMER, respawnBall);
			}
		}
		
		private function respawnBall(e:TimerEvent):void 
		{
			_respawnBallTimer.reset();
			
			if (contains(_ball))
			{
				removeChild(_ball);
				_balls.splice(_ball);
			} 
			else if (stage)
			{
				_ball.x = stage.stageWidth / 2;
				_ball.y = stage.stageHeight / 2;
				addChild(_ball);
				_balls.push(_ball);
			}
		}
		
		private function updateTextFields():void
		{
			playerScore2.text = "Score:  " + SCORE2.toString();
			playerScore1.text = "Score:  " + SCORE1.toString();
			
			if (SCORE1 >= 10)
			{
				trace("Player 1 won");
				destroy();
			}
			else if (SCORE2 >= 10)
			{
				trace("Player 2 won");
				destroy();
			}
		}
		
		private function destroy():void
		{
			var l : uint = numChildren,
				current : DisplayObject;
				
			// Manually removing
			removeEventListener(Event.ENTER_FRAME, update);
			_respawnBallTimer.removeEventListener(TimerEvent.TIMER, respawnBall);
			_player01.destroy();
			_player02.destroy();
			_players = [];
			_balls = [];
			
			// Automatic removing
			for ( var i : int = l -1; i >= 0; i--) 
			{
				current = getChildAt(i);
				if (current is Sprite || current is DisplayObject)
				{
					removeChild(current);
				}
			}
			current = null;
			i = l = NaN;
			
			// Run menu
			dispatchEvent(new Event(Main.OPENMENU, false));
		}
		
	}

}