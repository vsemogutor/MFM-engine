package skins
{
	import computers.utils.Utils;
	
	import flash.display.GradientType;
	import flash.geom.Matrix;
	
	import mx.skins.ProgrammaticSkin;
	
	public class RoundedBorderSkin extends ProgrammaticSkin
	{		
		public function RoundedBorderSkin()
		{
			super();
		}
		
		protected override function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			graphics.clear();
			
			var borderThickness:Number = getStyle("borderThickness");
			var cornerRadius:Number = getStyle("cornerRadius");
			var width:Number = unscaledWidth;
			var height:Number = unscaledHeight;
			var borderColorGradient1:uint = getStyle("borderColorGradient1");
			var borderColorGradient2:uint = getStyle("borderColorGradient2");			
				
			var matrix:Matrix = new Matrix();			
			graphics.lineStyle(borderThickness);
			matrix.createGradientBox(width, height, 90/Utils.DEGREE_PER_RAD, 0, 0);
			graphics.lineGradientStyle(GradientType.LINEAR, [borderColorGradient1, borderColorGradient2, borderColorGradient2], [1,1,1], [10, 10, 255], matrix);
			drawRoundRect(-1,-1,width+2,height+2, {tl: cornerRadius, tr: cornerRadius, bl: cornerRadius, br: cornerRadius});
		}
	}
}