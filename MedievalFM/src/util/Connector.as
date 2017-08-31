package util
{
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	public final class Connector
	{
		public static function getConnectorShape(connectFrom:Point, connectTo:Point): Shape
        {
            // Getting the center of the first square.
            var centerFrom : Point = new Point();
            centerFrom.x = connectFrom.x;
            centerFrom.y = connectFrom.y;

            // Getting the center of the second square.
            var centerTo : Point = new Point();
            centerTo.x = connectTo.x;
            centerTo.y = connectTo.y;

            // Getting the angle between those two.
            var angleTo : Number =
                Math.atan2(centerTo.x - centerFrom.x, centerTo.y - centerFrom.y);
            var angleFrom : Number =
                Math.atan2(centerFrom.x - centerTo.x, centerFrom.y - centerTo.y);

            // Getting the points on both borders.
            var pointFrom : Point = centerFrom;
            var pointTo : Point = centerTo;

            // Calculating arrow edges.
            var arrowSlope : Number = 30;
            var arrowHeadLength : Number = 10;
            var vector : Point =
                new Point(-(pointTo.x - pointFrom.x), -(pointTo.y - pointFrom.y));

            // First edge of the head...
            var edgeOneMatrix : Matrix = new Matrix();
            edgeOneMatrix.rotate(arrowSlope * Math.PI / 180);
            var edgeOneVector : Point = edgeOneMatrix.transformPoint(vector);
            edgeOneVector.normalize(arrowHeadLength);
            var edgeOne : Point = new Point();
            edgeOne.x = pointTo.x + edgeOneVector.x;
            edgeOne.y = pointTo.y + edgeOneVector.y;

            // And second edge of the head.
            var edgeTwoMatrix : Matrix = new Matrix();
            edgeTwoMatrix.rotate((0 - arrowSlope) * Math.PI / 180);
            var edgeTwoVector : Point = edgeTwoMatrix.transformPoint(vector);
            edgeTwoVector.normalize(arrowHeadLength);
            var edgeTwo : Point = new Point();
            edgeTwo.x = pointTo.x + edgeTwoVector.x;
            edgeTwo.y = pointTo.y + edgeTwoVector.y;

            // Drawing the arrow.
            var arrow : Shape = new Shape();
            with(arrow.graphics) {
                lineStyle(4, 0xF7D60D);
                
                // Drawing the line.
                moveTo(pointFrom.x, pointFrom.y);
                lineTo(pointTo.x, pointTo.y);

                // Drawing the arrow head.
                lineTo(edgeOne.x, edgeOne.y);
                moveTo(pointTo.x, pointTo.y);
                lineTo(edgeTwo.x, edgeTwo.y);
            }
            return arrow;
        }
	}
}