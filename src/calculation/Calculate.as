package calculation {
	import flash.geom.Point;
	/**
	 * ...
	 * @author Boy Voesten
	 */
	public class Calculate {
		
		static private var radiusCircle:Number = 250;
		
		public static function calculateOffset(angle:Number):Point {
			var offSet:Point = new Point();
			var r:Number = angle / 180 * Math.PI;
			offSet.x = radiusCircle * Math.cos(r);
			offSet.y = radiusCircle * Math.sin(r);
			
			return offSet;
		}
		
	}

}
