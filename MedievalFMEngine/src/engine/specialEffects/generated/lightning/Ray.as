/**
 * Lightning Class
 * AS3 Class to mimic a real lightning or electric discharge
 * 
 * @author		Pierluigi Pesenti
 * @version		0.5
 *
 */

/*
Licensed under the MIT License

Copyright (c) 2008 Pierluigi Pesenti

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

http://blog.oaxoa.com/
*/

package engine.specialEffects.generated.lightning 
{
	import engine.specialEffects.generated.GeneratedEffect;
	
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	public class Ray extends GeneratedEffect
	{
		private static const SMOOTH_COLOR:uint=0x808080;
		private static var glow:GlowFilter = new GlowFilter;

		private static var sbd:BitmapData;
		private static var bbd:BitmapData;
		
		private var soffs:Array;
		private var boffs:Array;

		public var len:Number;
		public var multi:Number;
		public var multi2:Number;

		public var _steps:uint;
		public var stepEvery:Number;
		private var seed1:uint;
		private var seed2:uint;
		
		public var smooth:Sprite;
		public var childrenSmooth:Sprite;
		public var childrenArray:Array=[];
		
		public var _smoothPercentage:uint=50;
		public var _childrenSmoothPercentage:uint;
		public var _color:uint;
				
		private var generation:uint;
		private var _childrenMaxGenerations:uint=3;
		private var _childrenProbability:Number=0.025;
		private var _childrenProbabilityDecay:Number=0;
		private var _childrenMaxCount:uint=4;
		private var _childrenMaxCountDecay:Number=.5;
		private var _childrenLengthDecay:Number=0;
		private var _childrenAngleVariation:Number=60;
		private var _childrenLifeSpanMin:Number=0;
		private var _childrenLifeSpanMax:Number=0;
		private var _childrenDetachedEnd:Boolean=false;
		
		private var _maxLength:Number=0;
		private var _maxLengthVary:Number=0;
		public var _isVisible:Boolean=true;
		public var _alphaFade:Boolean=true;
		public var parentInstance:Ray;
		private var _thickness:Number;
		private var _thicknessDecay:Number;
		private var initialized:Boolean=false;
		
		private var _wavelength:Number=.3;
		private var _amplitude:Number=.5;
		private var _speed:Number=1;
		
		private var calculatedWavelength:Number;
		private var calculatedSpeed:Number;
				
		public var alphaFadeType:String;
		public var thicknessFadeType:String;
		private var position:Number=0;
		private var absolutePosition:Number=1;
		
		private var dx:Number;
		private var dy:Number;
		
		private var soff:Number;
		private var soffx:Number;
		private var soffy:Number;
		private var boff:Number;
		private var boffx:Number;
		private var boffy:Number;
		private var angle:Number;
		private var tx:Number;
		private var ty:Number;
		public var alpha:Number = 1;

		public function Ray(pcolor:uint=0xffffff, pthickness:Number=2, psteps:int = 22, pgeneration:uint=0) 
		{
			_color = pcolor;
			_thickness=pthickness;
			_steps = psteps;
			
			glow.strength=2.8;
			glow.blurX=glow.blurY=8;
			
			alphaFadeType=LightningFadeType.NONE;
			thicknessFadeType=LightningFadeType.NONE;
			
			generation=pgeneration;
			if(generation==0) init();
		}
		
		private function init():void 
		{
			randomizeSeeds();
			
			multi2=.03;
			stepEvery=4;
			
			if (!sbd) sbd = new BitmapData(100, 1, false);
			if (!bbd) bbd = new BitmapData(100, 1, false);
			soffs=[new Point(0, 0), new Point(0, 0)];
			boffs=[new Point(0, 0), new Point(0, 0)];
			
			if(generation==0) 
			{
				smooth=new Sprite();
				childrenSmooth=new Sprite();
				smoothPercentage=50;
				childrenSmoothPercentage=50;
			} 
			else 
			{
				smooth=childrenSmooth=parentInstance.childrenSmooth;
			}
			
			childrenLengthDecay=.5;
			initialized=true;
		}
		
		private function randomizeSeeds():void 
		{
			seed1=Math.random()*100;
			seed2=Math.random()*100;
		}

		public override function kill():void 
		{
			killAllChildren();

			if(parentInstance) 
			{
				var count:uint=0;
				var par:Ray = parentInstance;
				for each(var obj:Object in par.childrenArray) {
					if(obj.instance==this) {
						par.childrenArray.splice(count, 1);
					}
					count++;
				}
			}
			
			delete this;
		}
		
		private function killAllChildren():void 
		{
			while(childrenArray.length>0) {
				var child:Ray=childrenArray[0].instance;
				child.kill();
			}
		}
		
		private function generateChild(n:uint=1, recursive:Boolean=false):void 
		{
			if(generation < _childrenMaxGenerations && childrenArray.length < _childrenMaxCount) {
				var targetChildSteps:uint = _steps*_childrenLengthDecay;
				if(targetChildSteps>=2) {
					for(var i:uint=0; i<n; i++) {
						var startStep:uint=Math.random()*_steps;
						var endStep:uint=Math.random()*_steps;
						while(endStep==startStep) endStep=Math.random()*_steps;
						var childAngle:Number=Math.random()*_childrenAngleVariation-_childrenAngleVariation/2;
						
						var child:Ray = new Ray(_color, _thickness, _steps*(1 - _childrenLengthDecay), generation+1);
						
						child.parentInstance = this;
						child.duration = Math.random()*(_childrenLifeSpanMax-_childrenLifeSpanMin)+_childrenLifeSpanMin;
						child.position = 1-startStep/_steps;
						child.absolutePosition = absolutePosition*child.position;
						child.alphaFadeType = alphaFadeType;
						child.thicknessFadeType = thicknessFadeType;
						
						if(alphaFadeType==LightningFadeType.GENERATION) child.alpha=1-(1/(_childrenMaxGenerations+1))*child.generation;
						if(thicknessFadeType==LightningFadeType.GENERATION) child.thickness= _thickness-(_thickness/(_childrenMaxGenerations+1))*child.generation;
						child.childrenMaxGenerations = _childrenMaxGenerations;
						child.childrenMaxCount = _childrenMaxCount*(1-_childrenMaxCountDecay);
						child.childrenProbability= _childrenProbability*(1-_childrenProbabilityDecay);
						child.childrenProbabilityDecay= _childrenProbabilityDecay;
						child.childrenLengthDecay= _childrenLengthDecay;
						child.childrenDetachedEnd=_childrenDetachedEnd;
						
						child.wavelength = _wavelength;
						child.amplitude = _amplitude;
						child.speed = _speed;
						
						child.init();
						
						childrenArray.push({instance:child, startStep:startStep, endStep:endStep, detachedEnd:_childrenDetachedEnd, childAngle:childAngle});
						
						if(recursive) child.generateChild(n, true);
					}
				}
			}
		}
		
		public override function update(shape:Shape, sdx:int, sdy:int):void 
		{
			if (initialized) 
			{
				if (generation == 0)
				{
					displayStartX = startX - startY - sdx;
					displayStartY = ( startX + startY )/2 - sdy;	
								
					displayEndX = endX - endY - sdx;
					displayEndY = ( endX + endY )/2 - sdy;
					
					glow.color = _color;	
					shape.filters=[glow];	
				}				

				dx=displayEndX-displayStartX;
				dy=displayEndY-displayStartY;
				
				len=Math.sqrt(dx*dx+dy*dy);
	
				soffs[0].x+=(_steps/100)*_speed;
				soffs[0].y+=(_steps/100)*_speed;
				sbd.perlinNoise(_steps/20, _steps/20, 1, seed1, false, true, 7, true, soffs);

				calculatedWavelength = steps*_wavelength;
				calculatedSpeed = (calculatedWavelength*.1)*_speed;
				boffs[0].x -= calculatedSpeed;
				boffs[0].y += calculatedSpeed;
				
				bbd.perlinNoise(calculatedWavelength, calculatedWavelength, 1, seed2, false, true, 7, true, boffs);
				
				if(_smoothPercentage>0) {
					var drawMatrix:Matrix=new Matrix();
					drawMatrix.scale(_steps/smooth.width,1);
					bbd.draw(smooth, drawMatrix);
				}
				
				if(parentInstance!=null) {
					_isVisible=parentInstance._isVisible;
				} else {
					if(_maxLength==0) {
						_isVisible=true;
					} else {
						var isVisibleProbability:Number;
						
						if(len<=_maxLength) {
							isVisibleProbability=1;
						} else if(len>_maxLength+_maxLengthVary) {
							isVisibleProbability=0;
						} else {
							isVisibleProbability=1-(len-_maxLength)/_maxLengthVary;
						}
						
						_isVisible=Math.random() < isVisibleProbability ? true : false;
					}
				}
				
				if (_childrenProbability)
				{
					var generateChildRandom:Number=Math.random();
					if(generateChildRandom < _childrenProbability) generateChild();
				}
				
				if(_isVisible) 
				{
					render(shape);
				}
				
				var childObject:Object;
 				for each (childObject in childrenArray) {
					childObject.instance.update(shape, sdx, sdy);
				} 
			}
		}
		
		private function render(shape:Shape):void 
		{
			if (generation == 0) shape.graphics.clear();
			shape.graphics.lineStyle(thickness, _color, alpha);

			angle=Math.atan2(displayEndY-displayStartY, displayEndX-displayStartX);
			
			var childObject:Object;
						
			for (var i:uint=0; i< _steps; i++) {
				var currentPosition:Number= 1/_steps*(_steps-i)
				var relAlpha:Number = 1;
				var relThickness:Number= _thickness;

				if(alphaFadeType==LightningFadeType.TIP_TO_END) {						
					relAlpha=absolutePosition*currentPosition;
				}
				if(thicknessFadeType==LightningFadeType.TIP_TO_END) {						
					relThickness=thickness*(absolutePosition*currentPosition);
				}
				
				if(alphaFadeType==LightningFadeType.TIP_TO_END || thicknessFadeType==LightningFadeType.TIP_TO_END) {
					shape.graphics.lineStyle(int(relThickness), _color, relAlpha);
				}
				soff=(sbd.getPixel(i, 0)-0x808080)/0xffffff*len*multi2;
				soffx=Math.sin(angle)*soff;
				soffy=Math.cos(angle)*soff;

				boff=(bbd.getPixel(i, 0)-0x808080)/0xffffff*len*_amplitude;
				boffx=Math.sin(angle)*boff;
				boffy=Math.cos(angle)*boff;

				tx=displayStartX+dx/(steps-1)*i+soffx+boffx;
				ty=displayStartY+dy/(steps-1)*i-soffy-boffy;				
				
				if (i==0) shape.graphics.moveTo(tx, ty);
				shape.graphics.lineTo(tx, ty);
				
				for each (childObject in childrenArray) {
					if(childObject.startStep==i) {
						childObject.instance.displayStartX=tx;
						childObject.instance.displayStartY=ty;
					}
					if(childObject.detachedEnd) {
						var arad:Number=angle+childObject.childAngle/180*Math.PI;
						
						var childLength:Number=len*_childrenLengthDecay;
						childObject.instance.displayEndX=childObject.instance.displayStartX+Math.cos(arad)*childLength;
						childObject.instance.displayEndY=childObject.instance.displayStartY+Math.sin(arad)*childLength;
					} else {
						if(childObject.endStep==i) {
							childObject.instance.displayEndX=tx;
							childObject.instance.displayEndY=ty;
						}
					}
					
					if (++childObject.lifeTime > childObject.duration)
					{
						childObject.instance.kill();
					}
				}
			}
		}
				
		private function killSurplus():void 
		{
			while(childrenArray.length>_childrenMaxCount) {
				var child:Ray=childrenArray[childrenArray.length-1].instance;
				child.kill();
			}
		}
		
		public override function clone():Object
		{
			var effect:Ray = new Ray(_color, _thickness, _steps, generation);
	
			effect.len = len;
			effect.multi = multi;
			effect.multi2 = multi2;
	
			effect.stepEvery = stepEvery;
			
			effect.smooth = smooth;
			effect.childrenSmooth = childrenSmooth;
			
			effect._smoothPercentage = _smoothPercentage;
			effect._childrenSmoothPercentage = _childrenSmoothPercentage;
			effect._color = _color;
					
			effect._childrenMaxGenerations = _childrenMaxGenerations;
			effect._childrenProbability = _childrenProbability;
			effect._childrenProbabilityDecay = _childrenProbabilityDecay;
			effect._childrenMaxCount = _childrenMaxCount;
			effect._childrenMaxCountDecay = _childrenMaxCountDecay;
			effect._childrenLengthDecay = _childrenLengthDecay;
			effect._childrenAngleVariation = _childrenAngleVariation;
			effect._childrenLifeSpanMin= _childrenLifeSpanMin;
			effect._childrenLifeSpanMax = _childrenLifeSpanMax;
			effect._childrenDetachedEnd = _childrenDetachedEnd;
			
			effect._maxLength = _maxLength;
			effect._maxLengthVary = _maxLengthVary;
			effect._isVisible = _isVisible;
			effect._alphaFade = _alphaFade;
			effect._thickness = _thickness;
			effect._thicknessDecay = _thicknessDecay;
			
			effect._wavelength = _wavelength;
			effect._amplitude = _amplitude;
			effect._speed = _speed;
			
			effect.calculatedWavelength = calculatedWavelength;
			effect.calculatedSpeed = calculatedSpeed;
					
			effect.alphaFadeType = alphaFadeType;
			effect.thicknessFadeType = thicknessFadeType;
			
			effect.position = position;
			effect.absolutePosition = absolutePosition;
			
			effect.soff = soff;
			effect.soffx = soffx;
			effect.soffy = soffy;
			effect.boff = boff;
			effect.boffx = boffx;
			effect.boffy = boffy;
			effect.angle = angle;
			
			effect.snapToStartObject = snapToStartObject;
			effect.snapToEndObject = snapToEndObject;			
			effect.duration = duration;
			effect.id = id;
			
			effect.alpha = alpha;
			
			return effect;
		}

		public function set steps(arg:uint):void {
			if(arg<2) arg=2;
			if(arg>2880) arg=2880;
			_steps=arg;
			if(generation==0) smoothPercentage = _smoothPercentage;
		}
		public function get steps():uint {
			return _steps;
		}
				
		public function set smoothPercentage(arg:Number):void 
		{
			if(smooth) {
				_smoothPercentage=arg;
				
				var smoothmatrix:Matrix=new Matrix();
				smoothmatrix.createGradientBox(steps, 1);
				var ratioOffset:uint=_smoothPercentage/100*128;			
				
				smooth.graphics.clear();
				smooth.graphics.beginGradientFill("linear", [SMOOTH_COLOR, SMOOTH_COLOR, SMOOTH_COLOR, SMOOTH_COLOR], [1,0,0,1], [0,ratioOffset,255-ratioOffset,255], smoothmatrix);
				smooth.graphics.drawRect(0, 0, steps, 1);
				smooth.graphics.endFill();
			}
		}
		public function set childrenSmoothPercentage(arg:Number):void {
			_childrenSmoothPercentage=arg;
			
			var smoothmatrix:Matrix=new Matrix();
			smoothmatrix.createGradientBox(_steps, 1);
			var ratioOffset:uint=_childrenSmoothPercentage/100*128;			
			
			childrenSmooth.graphics.clear();
			childrenSmooth.graphics.beginGradientFill("linear", [SMOOTH_COLOR, SMOOTH_COLOR, SMOOTH_COLOR, SMOOTH_COLOR], [1,0,0,1], [0,ratioOffset,255-ratioOffset,255], smoothmatrix);
			childrenSmooth.graphics.drawRect(0, 0, steps, 1);
			childrenSmooth.graphics.endFill();
		}
		public function get smoothPercentage():Number {
			return _smoothPercentage;
		}
		public function get childrenSmoothPercentage():Number {
			return _childrenSmoothPercentage;
		}
		public function set color(arg:uint):void {
			_color=arg;
			glow.color=arg;
			for each(var child:Object in childrenArray) child.instance.color=arg;
		}
		public function get color():uint {
			return _color;
		}
		public function set childrenProbability(arg:Number):void {
			if(arg>1) { arg=1 } else if(arg<0) arg=0;
			_childrenProbability=arg;
		}
		public function get childrenProbability():Number {
			return _childrenProbability;
		}
		public function set childrenProbabilityDecay(arg:Number):void {
			if(arg>1) { arg=1 } else if(arg<0) arg=0;
			_childrenProbabilityDecay=arg;
		}
		public function get childrenProbabilityDecay():Number {
			return _childrenProbabilityDecay;
		}
		public function set maxLength(arg:Number):void {
			_maxLength=arg;
		}
		public function get maxLength():Number {
			return _maxLength;
		}
		public function set maxLengthVary(arg:Number):void {
			_maxLengthVary=arg;
		}
		public function get maxLengthVary():Number {
			return _maxLengthVary;
		}
		public function set thickness(arg:Number):void {
			if(arg<0) arg=0;
			_thickness=arg;
		}
		public function get thickness():Number {
			return _thickness;
		}
		public function set thicknessDecay(arg:Number):void {
			if(arg>1) { arg=1 } else if(arg<0) arg=0;
			_thicknessDecay=arg;
		}
		public function get thicknessDecay():Number {
			return _thicknessDecay;
		}
		public function set childrenLengthDecay(arg:Number):void {
			if(arg>1) { arg=1 } else if(arg<0) arg=0;
			_childrenLengthDecay=arg;
		}
		public function get childrenLengthDecay():Number {
			return _childrenLengthDecay;
		}
		public function set childrenMaxGenerations(arg:uint):void {
			_childrenMaxGenerations=arg;
			killSurplus();
		}
		public function get childrenMaxGenerations():uint {
			return _childrenMaxGenerations;
		}
		
		public function set childrenMaxCount(arg:uint):void {
			_childrenMaxCount=arg;
			killSurplus();
		}
		public function get childrenMaxCount():uint {
			return _childrenMaxCount;
		}
		public function set childrenMaxCountDecay(arg:Number):void {
			if(arg>1) { arg=1 } else if(arg<0) arg=0;
			_childrenMaxCountDecay=arg;
		}
		public function get childrenMaxCountDecay():Number {
			return _childrenMaxCountDecay;
		}
		public function set childrenAngleVariation(arg:Number):void {
			_childrenAngleVariation=arg;
			for each(var o:Object in childrenArray) {
				o.childAngle=Math.random()*arg-arg/2;
				o.instance.childrenAngleVariation=arg;
			}
		}
		public function get childrenAngleVariation():Number {
			return _childrenAngleVariation;
		}
		public function set childrenLifeSpanMin(arg:Number):void {
			_childrenLifeSpanMin=arg;
		}
		public function get childrenLifeSpanMin():Number {
			return _childrenLifeSpanMin;
		}
		public function set childrenLifeSpanMax(arg:Number):void {
			_childrenLifeSpanMax=arg;
		}
		public function get childrenLifeSpanMax():Number {
			return _childrenLifeSpanMax;
		}
		public function set childrenDetachedEnd(arg:Boolean):void {
			_childrenDetachedEnd=arg;
		}
		public function get childrenDetachedEnd():Boolean {
			return _childrenDetachedEnd;
		}
		public function set wavelength(arg:Number):void {
			_wavelength=arg;
			for each(var o:Object in childrenArray) {
				o.instance.wavelength=arg;
			}
		}
		public function get wavelength():Number {
			return _wavelength;
		}
		public function set amplitude(arg:Number):void {
			_amplitude=arg;
			for each(var o:Object in childrenArray) {
				o.instance.amplitude=arg;
			}
		}
		public function get amplitude():Number {
			return _amplitude;
		}
		public function set speed(arg:Number):void {
			_speed=arg;
			for each(var o:Object in childrenArray) {
				o.instance.speed=arg;
			}
		}
		public function get speed():Number {
			return _speed;
		}
	}
}






