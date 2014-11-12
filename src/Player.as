package  
{
	import calculation.Calculate;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Boy Voesten
	 */
	public class Player extends Sprite
	{
		
		protected var _paddleArt : PaddleArt01;
		protected var _rotation :	Number = 0;
		protected var outOfBounds : Boolean = false;
		private var _offSet	: Point =  new Point();
		private var _rotationSpeed : Number = 0;
		private var _maxspeed : Number = 6;
		private var _acceleration : Number = .1;
		
		
		public function Player() 
		{
			if(stage) init(null);
            else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			addEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyReleased);
			
			addChild(_paddleArt);
		}
		
		private function update(e:Event):void 
		{
			checkBounds();
			movement();
		}
		
		

		private function movement():void 
		{
			// CIRCLE OF MOVEMENT
			_offSet = Calculate.calculateOffset(this.rotation);
			this.x = _offSet.x + stage.stageWidth / 2;
			this.y = _offSet.y + stage.stageHeight / 2;
			
			rotation -= _rotationSpeed;
			
			if (outOfBounds)
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
			else
			{
				// right
				if (_rotation == 1 && _rotationSpeed < _maxspeed) 
				{
					_rotationSpeed += 1;			// if right is pressed and speed didn't hit the limit, increase speed.
				}
				// left
				if (_rotation == -1 && _rotationSpeed > -_maxspeed) 
				{
					_rotationSpeed -= 1;			// if left is pressed and speed didn't hit the limit, increase speed (the other way).
				}
			}
		}
		
		// override it
		protected function checkBounds():void 
		{
			
		}
		
		// override it
		protected function keyPressed(e:KeyboardEvent):void 
		{
			_offSet = Calculate.calculateOffset(rotation);
		}
		
		// override it
		protected function keyReleased(e:KeyboardEvent):void 
		{
			
		}
		
		public function destroy():void 
		{
			removeEventListener(Event.ENTER_FRAME, update);
			removeEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
			removeEventListener(KeyboardEvent.KEY_UP, keyReleased);
		}
		
	}

}