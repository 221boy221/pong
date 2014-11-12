package  
{
	import calculation.Vector2D;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Boy Voesten & Swan Chase
	 */
	public class BallBase extends Sprite
	{
		
		public var _ballArt : BallArt;
		private var _velocity : Vector2D = new Vector2D( -5, -5);
		
		public function BallBase() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		 
		private function init(e:Event):void
		{
			addEventListener(Event.ENTER_FRAME, update);
			
			addChild(_ballArt);
		}
		 
		private function update(e:Event):void
		{
			x += _velocity.x;
			y += _velocity.y;
		 		 
			// Switch it's X
			if (x <= _ballArt.width / 2)
			{
				x = _ballArt.width / 2;
				_velocity.x *= -1;
			} 
			else if (x >= stage.stageWidth - _ballArt.width / 2)
			{
				x = stage.stageWidth - _ballArt.width/2;
				_velocity.x *= -1;
			}
		 
			// Switch it's Y
			if (y <= _ballArt.height / 2)
			{
				y = _ballArt.height / 2;
				_velocity.y *= -1;
			} 
			else if (y >= stage.stageHeight - _ballArt.height / 2)
			{
				y = stage.stageHeight - _ballArt.height / 2;
				_velocity.y *= -1;
			}
			
		}
		
		public function get velocity():Vector2D 
		{
			return _velocity;
		}
		
		public function set velocity(value:Vector2D):void 
		{
			_velocity = value;
		}
		
	}

}