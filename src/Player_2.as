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
				_rotation = 1;
			}
			else if (e.keyCode == Keyboard.W) 
			{
				_rotation = -1;
			}
			trace("p2: " + _rotation);
		}
		
		override protected function checkBounds():void 
		{
			if (x <= stage.stageWidth / 2)
			{
				// UP
				if (_rotation == 1 && _rotationSpeed < _maxspeed)
				{
					_rotationSpeed += 1;
				}
				// DOWN
				if (_rotation == -1 && _rotationSpeed > -_maxspeed)
				{
					_rotationSpeed -= 1;
				}
			} 
			else
			{
				_rotationSpeed = Math.abs(_rotationSpeed) / _rotationSpeed;
				_rotationSpeed = _rotationSpeed - _rotationSpeed * 2;
				
				// check if it's above or below the origin
				if (y >= stage.stageHeight / 2) 
				{
					_rotationSpeed *= -_rotationSpeed;
				} else
				{
					_rotationSpeed *= _rotationSpeed;
				}
			}
		}
		
	}

}