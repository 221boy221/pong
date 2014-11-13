package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	/**
	 * ...
	 * @author Boy Voesten & Swan Chase
	 */
	public class Menu extends Sprite 
	{
		/*
		//SFX
		private var _menuMusic : Sound = new StartMusic();
		private var _menuSC : SoundChannel;
		*/
		
		private var _menuCurtain : MenuCurtain;
		private var _gameCurtain : GameCurtain;
		private var _startButton : StartButton;
		private var _menuBoard : MenuBoard;
		private var _bgArt01 : BgArt01;
		private var _bgArt02 : BgArt02;
		
		private var speed : int;
		private var clickedStart : Boolean = false;
		
		public function Menu() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.ENTER_FRAME, update);
			
			/*
			// Play and loop forever
			_menuSC = _menuMusic.play(0, int.MAX_VALUE); 
			_menuSC.addEventListener(Event.SOUND_COMPLETE, loop);
			*/
			
			_menuCurtain = new MenuCurtain();
			_gameCurtain = new GameCurtain();
			_startButton = new StartButton();
			_menuBoard = new MenuBoard();
			_bgArt01 = new BgArt01();
			_bgArt02 = new BgArt02();
			
			_menuBoard.x = 75;
			_menuBoard.y = 395;
			
			_startButton.x = _menuBoard.x + 165;
			_startButton.y = _menuBoard.y + 80;
			
			addChild(_bgArt01);
			addChild(_bgArt02);
			addChild(_menuCurtain);
			addChild(_gameCurtain);
			addChild(_menuBoard);
			addChild(_startButton);
			
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
		}
		
		private function update(e:Event):void 
		{
			if (clickedStart)
			{
				speed += 1;
				_menuBoard.y += speed / 10;
				_startButton.y += speed / 10;
				
				_menuCurtain.y -= speed / 10;
				if (_menuCurtain.y < -stage.stageHeight) 
				{
					destroy();
				}
			}
		}
		
		private function mouseDown(e:MouseEvent):void 
		{
			if (e.target == _startButton)
			{
				clickedStart = true;
			}
			
		}
		/*
		private function loop(e:Event):void 
		{ 
			_menuSC = _menuMusic.play(0, int.MAX_VALUE); 
		}
		*/
		
		private function destroy():void 
		{
			removeChild(_menuCurtain);
			removeChild(_gameCurtain);
			removeChild(_startButton);
			removeChild(_menuBoard);
			removeChild(_bgArt01);
			removeChild(_bgArt02);
			removeEventListener(Event.ENTER_FRAME, update);
			dispatchEvent(new Event(Main.STARTGAME, false));
		}
	}

}