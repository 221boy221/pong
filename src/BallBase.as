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
		private var _velocity : Vector2D;
		private var _newVelocity : Vector2D;
		private var _location : Vector2D;
		private var _newRot : int;
		private var _rotation : int;
		
		public function BallBase() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		 
		private function init(e:Event):void
		{
			addChild(_ballArt);
		}
		 
		public function update():void
		{
			rotation = _rotation;
			
			_velocity = new Vector2D(-3, -3);
			_newVelocity = new Vector2D(_velocity.x, _velocity.y);
		   
			_velocity.angle = (rotation) * Math.PI / 180;
			_newVelocity.angle = Math.atan2(_velocity.y, _velocity.x) - Math.atan2(_newVelocity.y, _newVelocity.x);
			
			x += _velocity.x;
			y += _velocity.y;
			
			_newRot = (_newVelocity.angle / Math.PI) * 180 + 180;
			_location = new Vector2D(stage.stageWidth / 2 - x, stage.stageHeight / 2 - y);
		}
		
		public function hitPlatform():void 
		{
			_rotation = _newRot;
		}
		
		public function get location():Vector2D 
		{
			return _location;
		}
		
	}

}