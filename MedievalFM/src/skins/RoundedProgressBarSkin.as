package skins
{
	import computers.utils.Utils;
	
	import flash.display.GradientType;
	import flash.geom.Matrix;
	
	import mx.skins.ProgrammaticSkin;

	public class RoundedProgressBarSkin extends ProgrammaticSkin
	{		
		public function RoundedProgressBarSkin()
		{
			super();
		}
	
		protected override function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			var barAlpha:Number = getStyle("barAlpha") || 1;
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			var cornerRadius:Number = getStyle("cornerRadius");
			var width:Number = unscaledWidth;
			var height:Number = unscaledHeight;
			var colorGradient1:uint = getStyle("barColorGradient1");
			var colorGradient2:uint = getStyle("barColorGradient2");
			var colorGradient3:uint = getStyle("barColorGradient3");
						
			graphics.clear();			
				
			var matrix:Matrix = new Matrix();			
			matrix.createGradientBox(width, height, 90/Utils.DEGREE_PER_RAD, 0, 0);
			graphics.beginGradientFill(GradientType.LINEAR, [colorGradient1, colorGradient2, colorGradient3], [barAlpha,barAlpha,barAlpha], [0, 138, 255], matrix);
			drawRoundRect(0,0,width,height, {tl: cornerRadius, tr: cornerRadius, bl: cornerRadius, br: cornerRadius});
			graphics.endFill();
		}
	}
}