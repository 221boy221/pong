package  
{
	import flash.display.DisplayObject;
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
		// ART
		private var _menuCurtain : MenuCurtain;
		private var _gameCurtain : GameCurtain;
		private var _startButton : StartButton;
		private var _menuBoard : MenuBoard;
		private var _bgArt01 : BgArt01;
		private var _bgArt02 : BgArt02;
		// SFX
		private var _menuSC : SoundChannel;
		private var _menuMusic : MenuBG_SFX = new MenuBG_SFX();
		private var _menuClick : MenuClick_SFX = new MenuClick_SFX();
		// Etc
		private var _speed : int;
		private var _clickedStart : Boolean = false;
		
		
		public function Menu() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			
			// Play and loop forever
			_menuSC = _menuMusic.play(0, int.MAX_VALUE); 
			_menuSC.addEventListener(Event.SOUND_COMPLETE, soundLoop);
			
			_menuCurtain = new MenuCurtain();
			_gameCurtain = new GameCurtain();
			_startButton = new StartButton();
			_menuBoard = new MenuBoard();
			_bgArt01 = new BgArt01();
			_bgArt02 = new BgArt02();
			
			// Positioning
			_menuBoard.x = 75;
			_menuBoard.y = 395;
			_startButton.x = _menuBoard.x + 190;
			_startButton.y = _menuBoard.y + 150;
			
			// Adding
			addChild(_bgArt01);
			addChild(_bgArt02);
			addChild(_menuCurtain);
			addChild(_gameCurtain);
			addChild(_menuBoard);
			addChild(_startButton);
		}
		
		private function update(e:Event):void 
		{
			if (_clickedStart)
			{
				_speed += 1;
				_menuBoard.y += _speed / 10;
				_startButton.y += _speed / 10;
				
				_menuCurtain.y -= _speed / 10;
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
				_menuClick.play(200);
				_clickedStart = true;
			}
		}
		
		private function soundLoop(e:Event):void 
		{ 
			_menuSC = _menuMusic.play(0, int.MAX_VALUE); 
		}
		
		private function destroy():void 
		{
			var l : uint = numChildren,
				current : DisplayObject;
			
			// Manually removing
			removeEventListener(Event.ENTER_FRAME, update);
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			_menuSC.removeEventListener(Event.SOUND_COMPLETE, soundLoop);
			_menuSC.stop();
			
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
			
			// Start Game
			dispatchEvent(new Event(Main.STARTGAME, false));
		}
	}

}