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
		
		protected var _paddleArt : Sprite;
		protected var _rotation : Number = 0;
		protected var outOfBounds : Boolean = false;
		protected var _rotationSpeed : Number = 0;
		protected var _maxspeed : Number = 1.5;
		protected var _acceleration : Number = 0.2;
		private var _offSet	: Point =  new Point();
		
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
		
		protected function movement():void 
		{
			// CIRCLE OF MOVEMENT
			_offSet = Calculate.calculateOffset(rotation);
			x = _offSet.x + stage.stageWidth / 2;
			y = _offSet.y + stage.stageHeight / 2;
			
			rotation -= _rotationSpeed;
		}
		
		// override it
		protected function checkBounds():void 
		{
			
		}
		
		// override it
		protected function keyPressed(e:KeyboardEvent):void 
		{
			
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
			removeChild(_paddleArt);
		}
		
	}

}