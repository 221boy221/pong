package  
{
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	/**
	 * ...
	 * @author Boy Voesten
	 */
	public class Player_2 extends Player 
	{
		
		public function Player_2() 
		{
			super();
			
			_paddleArt = new PaddleArt01();
		}
		
		override protected function keyPressed(e:KeyboardEvent):void 
		{
			super.keyPressed(e);
			
			if (e.keyCode == Keyboard.S)
			{
				_rotation = -1;
			}
			else if (e.keyCode == Keyboard.W) 
			{
				_rotation = 1;
			}
			else
			{
				_rotation = 0;
			}
		}
		
		override protected function keyReleased(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.W || e.keyCode == Keyboard.S) 
			{
				_rotation = 0;
			}
		}
		
		override protected function checkBounds():void 
		{
			if (x >= stage.stageWidth / 2)
			{
				outOfBounds = false;
			} 
			else
			{
				outOfBounds = true;
			}
		}
		
	}

}