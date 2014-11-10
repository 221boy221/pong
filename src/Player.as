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
		
		private var _paddleArt : PaddleArt01;
		private var _offSet	: Point =  new Point();
		private var _rotation :	Number = 0;
		private var _rotationSpeed:Number = 0;
		private var _maxspeed:Number = 6;
		private var _acceleration:Number = .2;
		private var outOfBounds:Boolean = false;
		
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
			
			_paddleArt = new PaddleArt01();
			addChild(_paddleArt);
		}
		
		private function update(e:Event):void 
		{
			if (x >= stage.stageWidth / 2)
			{
				//if(outOfBounds){
				//	_rotationSpeed = 0;
				//}
				outOfBounds = false;
			} 
			else
			{
				outOfBounds = true;
			}
			
			movement();
		}

		private function movement():void 
		{
			// CIRCLE OF MOVEMENT
			_offSet = Calculate.calculateOffset(this.rotation);
			this.x = _offSet.x + stage.stageWidth / 2;
			this.y = _offSet.y + stage.stageHeight / 2;
			
			rotation -= _rotationSpeed;
			
			//trace(outOfBounds);
			
			if (outOfBounds)
			{
				_rotationSpeed = Math.abs(_rotationSpeed) / _rotationSpeed;
				_rotationSpeed = _rotationSpeed - _rotationSpeed * 2;
				
				// check if it's above or below the origin
				if (y >= stage.stageHeight / 2) {
					_rotationSpeed *= _rotationSpeed;
				} else {
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
		
		private function keyPressed(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.LEFT || e.keyCode == Keyboard.A)
			{
				_rotation = -1;
			}
			else if (e.keyCode == Keyboard.RIGHT || e.keyCode == Keyboard.D) 
			{
				_rotation = 1;
			} 
			else 
			{
				_rotation = 0;
			}
			
			_offSet = Calculate.calculateOffset(this.rotation);
		}
		
		// override it pls
		private function keyReleased(e:KeyboardEvent):void {
			if (e.keyCode == Keyboard.LEFT || e.keyCode == Keyboard.A || e.keyCode == Keyboard.RIGHT || e.keyCode == Keyboard.D) {
				_rotation = 0;
			}
		}
		
		public function destroy():void 
		{
			removeEventListener(Event.ENTER_FRAME, update);
			removeEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
			removeEventListener(KeyboardEvent.KEY_UP, keyReleased);
		}
		
		
		
	}

}