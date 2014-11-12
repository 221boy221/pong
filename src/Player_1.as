package  
{
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	/**
	 * ...
	 * @author Boy Voesten
	 */
	public class Player_1 extends Player 
	{
		
		public function Player_1() 
		{
			super();
			
			_paddleArt = new PaddleArt01();
		}
		
		override protected function keyPressed(e:KeyboardEvent):void 
		{
			super.keyPressed(e);
			
			if (e.keyCode == Keyboard.DOWN)
			{
				_rotation = -1;
			}
			else if (e.keyCode == Keyboard.UP) 
			{
				_rotation = 1;
			}
			trace("p1: " + _rotation);
		}
		
		override protected function keyReleased(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.DOWN || e.keyCode == Keyboard.UP)
			{
				_rotation = 0;
			}
		}
		
		override protected function checkBounds():void 
		{
			if (x >= stage.stageWidth / 2)
			{
				// MOVEMENT //
				if (_rotation == 1 && _rotationSpeed < _maxspeed) 
				{
					_rotationSpeed += 1;
				}
				else if (_rotation == -1 && _rotationSpeed > -_maxspeed) 
				{
					_rotationSpeed -= 1;
				}
				
				// ACCELERATION //
				if (_rotationSpeed > (0 + _acceleration))
				{
					_rotationSpeed -= _acceleration;
				}
				else if (_rotationSpeed < (0 - _acceleration))
				{
					_rotationSpeed += _acceleration;
				}
				else
				{
					_rotationSpeed = 0;
				}
			} 
			else
			{
				_rotationSpeed = Math.abs(_rotationSpeed) / _rotationSpeed;
				_rotationSpeed = _rotationSpeed - _rotationSpeed * 2;
				
				// check if it's above or below the origin
				if (y >= stage.stageHeight / 2) 
				{
					_rotationSpeed *= _rotationSpeed;
				} else
				{
					_rotationSpeed *= -_rotationSpeed;
				}
			}
		}
		
	}

}