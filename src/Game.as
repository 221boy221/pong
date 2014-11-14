package  
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.text.AntiAliasType;
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
		// BGs
		private var _bgArt01 : BgArt01 = new BgArt01();
		private var _bgArt02 : BgArt02 = new BgArt02();
		private var _gameCurtain : GameCurtain = new GameCurtain();
		// Countdown
		private var _countdown01_Art : Countdown1 = new Countdown1();
		private var _countdown02_Art : Countdown2 = new Countdown2();
		private var _countdown03_Art : Countdown3 = new Countdown3();
		private var _countdown01_SFX : Countdown01_SFX = new Countdown01_SFX();
		private var _countdown02_SFX : Countdown02_SFX = new Countdown02_SFX();
		private var _countdownTimer	 : Timer;
		private var _move3	: Boolean = false;
		private var _move2	: Boolean = false;
		private var _move1	: Boolean = false;
		private var _speed1 : int;
		private var _speed2 : int;
		private var _speed3 : int;
		// Players, Balls, etc
		private var _players	: Array = [];
		private var _balls		: Array = [];
		private var _player01	: Player_1 = new Player_1();
		private var _player02	: Player_2 = new Player_2();
		private var _ball		: NormalBall = new NormalBall();
		private var _counter 	: int = 0;
		private var _respawnBallTimer : Timer = new Timer(500, 0);
		private var _destroyGameTimer : Timer = new Timer(6000);
		private var _roses01	: RoseArt01	= new RoseArt01();
		private var _roses02	: RoseArt02	= new RoseArt02();
		// UI
		private var _score01 : int = 0;
		private var _score02 : int = 0;
		private var _score01_SFX  : Score01_SFX = new Score01_SFX();
		private var _score02_SFX  : Score02_SFX = new Score02_SFX();
		private var _textFormat	  : TextFormat	= new TextFormat();
		private var _playerScore1 : TextField	= new TextField();
		private var _playerScore2 : TextField	= new TextField();
		private var _scoreBoard01 : ScoreBoard	= new ScoreBoard();
		private var _scoreBoard02 : ScoreBoard	= new ScoreBoard();
		private var _myFont : PristinaFont = new PristinaFont();
		// SFX
		private var _gameSC : SoundChannel;
		private var _gameMusic : IngameBG_SFX = new IngameBG_SFX();
		private var _cheering_SFX : Cheering_SFX = new Cheering_SFX();
		
		
		public function Game() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			// Positioning
			_countdown01_Art.x = _countdown02_Art.x = _countdown03_Art.x = stage.stageWidth / 2;
			_countdown01_Art.y = _countdown02_Art.y = _countdown03_Art.y = stage.stageHeight / 2;
			_player01.x = stage.stageWidth / 2;
			_player01.y = stage.stageHeight / 2
			_player02.rotation = 180;
			_scoreBoard01.x = stage.stageWidth / 8 * 7 -15;
			_scoreBoard02.x = stage.stageWidth / 8 +15;
			_scoreBoard01.y = _scoreBoard02.y = stage.stageHeight / 2 - 60;
			_textFormat.color = 0xffffff;
			_textFormat.size = 75;
			_textFormat.font = _myFont.fontName;
			_playerScore1.defaultTextFormat = _textFormat;
			_playerScore2.defaultTextFormat = _textFormat;
			_playerScore1.autoSize = TextFieldAutoSize.CENTER;
			_playerScore2.autoSize = TextFieldAutoSize.CENTER;
			_playerScore1.x = _scoreBoard01.x;
			_playerScore2.x = _scoreBoard02.x;
			_playerScore1.y = _playerScore2.y = _scoreBoard01.y + (_scoreBoard01.y / 2);
			_playerScore1.embedFonts = _playerScore2.embedFonts = true;
			_playerScore1.antiAliasType = _playerScore2.antiAliasType = AntiAliasType.ADVANCED;
			updateTextFields();
			
			// Adding
			addChild(_bgArt01);
			addChild(_player01);
			addChild(_player02);
			addChild(_countdown01_Art);
			addChild(_countdown02_Art);
			addChild(_countdown03_Art);
			addChild(_bgArt02);
			addChild(_scoreBoard01);
			addChild(_scoreBoard02);
			addChild(_playerScore1);
			addChild(_playerScore2);
			addChild(_gameCurtain);
			
			// Fill the array
			_players.push(_player01);
			_players.push(_player02);
			
			// Play and loop forever
			_gameSC = _gameMusic.play(0, int.MAX_VALUE); 
			_gameSC.addEventListener(Event.SOUND_COMPLETE, soundLoop);
			
			// CD
			_countdownTimer = new Timer(1000, 4);
			_countdownTimer.addEventListener(TimerEvent.TIMER, onCountDown);
			_countdownTimer.start();
			
			addEventListener(Event.ENTER_FRAME, countdown);
		}
		
		private function onCountDown(e:TimerEvent):void 
		{
			var t:Timer = e.target as Timer;
			switch(t.currentCount)
			{
				case 1:
					_move3 = true;
					_move2 = false;
					_move1 = false;
					_countdown01_SFX.play();
					break;
				case 2:
					_move3 = false;
					_move2 = true;
					_move1 = false;
					_countdown01_SFX.play();
					break;
				case 3:
					_move3 = false;
					_move2 = false;
					_move1 = true;
					_countdown02_SFX.play();
					break;			
				case 4:
					startGame();
					break;
			}
		}
		
		// Countdown
		private function countdown(e:Event):void 
		{
			// update the countdown art
			if (_move3)
			{
				_speed3 += 1;
				_countdown03_Art.y += _speed3 / 6;
			}
			else if (_move2)
			{
				_speed2 += 1;
				_countdown02_Art.y += _speed2 / 6;
			}
			else if (_move1)
			{
				_speed1 += 1;
				_countdown01_Art.y += _speed1 / 6;
			}
			
			// update the roses
			if (contains(_roses01))
			{
				_roses01.y += 5;
			} 
			else if (contains(_roses02))
			{
				_roses02.y += 5;
			}
		}
		
		
		private function startGame():void 
		{
			_countdownTimer.removeEventListener(TimerEvent.TIMER, onCountDown);
			addEventListener(Event.ENTER_FRAME, update);
			respawnBall(null);
		}

		private function update(e:Event):void 
		{
			var _playersLength	: uint = _players.length,
				_ballsLength 	: uint = _balls.length;
			
			// Loop through players
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
			// Loop through balls
			for (i = _ballsLength - 1; i >= 0; i--) 
			{
				_balls[i].update();
				checkBall();
			}
			
		}
		
		// Respawn the ball
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
		
		// Ball Position & Score
		private function checkBall():void 
		{
			if (_ball.location.length >= 300) 
			{
				if (_ball.x > stage.stageWidth / 2)
				{
					_score02 += 1;
					_score02_SFX.play();
					updateTextFields();
				} 
				else 
				{
					_score01 += 1;
					_score01_SFX.play();
					updateTextFields();
				}
				
				respawnBall(null);
				_respawnBallTimer.start();
				_respawnBallTimer.addEventListener(TimerEvent.TIMER, respawnBall);
			}
		}
		
		// Text & Win
		private function updateTextFields():void
		{
			_playerScore2.text = _score02.toString();
			_playerScore1.text = _score01.toString();
			
			if (_score01 >= 10)
			{
				win(1);
			}
			else if (_score02 >= 10)
			{
				win(2);
			}
		}
		
		private function win(winner:int):void
		{
			_cheering_SFX.play();
			removeEventListener(Event.ENTER_FRAME, update);
			switch (winner) 
			{
				case 1:
					addChild(_roses01);
					_roses01.x = stage.stageWidth / 4 * 3;
					_roses01.y = 0;
					break;
				case 2:
					addChild(_roses02);
					_roses02.x = stage.stageWidth / 4;
					_roses02.y = 0;
					break;
			}
			_destroyGameTimer.addEventListener(TimerEvent.TIMER, destroy);
			_destroyGameTimer.start();
		}
		
		// Loop the bg music
		private function soundLoop(e:Event):void 
		{ 
			_gameSC = _gameMusic.play(0, int.MAX_VALUE); 
		}
		
		// Clean up the mess
		private function destroy(e:TimerEvent):void
		{
			var l : uint = numChildren,
				current : DisplayObject;
				
			// Manually removing
			removeEventListener(Event.ENTER_FRAME, update);
			_respawnBallTimer.removeEventListener(TimerEvent.TIMER, respawnBall);
			_countdownTimer.removeEventListener(TimerEvent.TIMER, onCountDown);
			_destroyGameTimer.removeEventListener(TimerEvent.TIMER, destroy);
			_player01.destroy();
			_player02.destroy();
			_players = [];
			_balls = [];
			_gameSC.stop();
			
			// Automatically removing
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
			
			// Open Menu
			dispatchEvent(new Event(Main.OPENMENU, false));
		}
		
	}

}