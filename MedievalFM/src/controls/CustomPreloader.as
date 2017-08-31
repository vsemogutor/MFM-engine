package controls
{
    import CPMStar.AdLoader;
    
    import flash.display.DisplayObject;
    import flash.display.GradientType;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.MouseEvent;
    import flash.events.ProgressEvent;
    import flash.events.TimerEvent;
    import flash.filters.GlowFilter;
    import flash.geom.Matrix;
    import flash.net.LocalConnection;
    import flash.net.URLRequest;
    import flash.net.navigateToURL;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.utils.Timer;
    
    import mx.core.Application;
    import mx.core.BitmapAsset;
    import mx.events.FlexEvent;
    import mx.preloaders.IPreloaderDisplay;

    public class CustomPreloader extends Sprite implements IPreloaderDisplay
    {
        private var logo:DisplayObject;
    	
        // Implementation variables, used to make everything work properly
        private var _IsInitComplete:Boolean = false;
        private var _IsDownloadComplete:Boolean = false;       
        private var _timer:Timer;                 // we have a timer for animation
        private var _bytesLoaded:uint = 0;
        private var _bytesExpected:uint = 1;      // we start at 1 to avoid division by zero errors.
        private var _fractionLoaded:Number = 0;   // 0-1
        private var _currlen:Number=0;
        private var _preloader:Sprite;
        private var _adEnabled:Boolean;
        private var _adAdded:Boolean; 

		private var pBar:Sprite= new Sprite();
		private var maskBar:Sprite= new Sprite();
		private var playButton:Sprite= new Sprite();				
		private var txtBox:TextField = new TextField();
		private var glow:GlowFilter = new GlowFilter(0xFFFFFF, 0.1);
		private var ad:DisplayObject;
        private const MAX_LENGTH:int = 500; 
        private const ADD_WIDTH:int = 300;
        private const ADD_HEIGHT:int = 250; 
        
/*          [Embed(source="../assets/branding/std as3.0 cs3.png")] 
		private static var _imageSponsorClass:Class; 
		private static var _imageSponsor:BitmapAsset = new _imageSponsorClass();   */       
        
        public function CustomPreloader() 
        {
            super();
        }
         
        virtual public function initialize():void 
        {
        	_stageHeight = 640;
        	_stageWidth = 640;
        	
            _timer = new Timer(3);
            _timer.addEventListener(TimerEvent.TIMER, timerHandler);
            _timer.start(); 
            
            //creates all visual elements
            createAssets();
        }
             
        private function createAssets():void 
        {
        	var lc:LocalConnection = new LocalConnection();
		    var dom:String = lc.domain.toLowerCase();
		    _adEnabled = false;
		    
        	pBar.addChild(maskBar);			
            var centerX:Number= (stageWidth - MAX_LENGTH)/2;
            var centerY:Number;
            
            if (_adEnabled)
            	centerY = (stageHeight - ADD_HEIGHT)/2 + ADD_HEIGHT + 30;
			else
				centerY = (stageHeight)/2 + 100;
            
            pBar.x = centerX;
            pBar.y = centerY;	       						
			this.addChild(pBar);
			
			this.addChild(txtBox);
			txtBox.textColor = 0xffffff;
			txtBox.width = 130;
        	txtBox.text = "Loading Aeon Defense...";
        	txtBox.setTextFormat(new TextFormat("Arial", 12, 0xffffff, true));
        	txtBox.x = (stageWidth - txtBox.width)/2;
			txtBox.y = centerY;
			txtBox.selectable = false;
			
/*              var sponsorY:Number;
			if (_adEnabled)
            	sponsorY = (stageHeight - _imageSponsor.height)/2;
			else
				sponsorY = 100; 
				
 			var sponsorSprite:Sprite = new Sprite();
			sponsorSprite.x	= (stageWidth - _imageSponsor.width)/2;
			sponsorSprite.y = sponsorY;
			sponsorSprite.addChild(_imageSponsor);
			sponsorSprite.useHandCursor = true;
			sponsorSprite.buttonMode = true;
			sponsorSprite.addEventListener(MouseEvent.CLICK, 
				function(event:Event):void {
					navigateToURL(new URLRequest("http://www.andkon.com/arcade/"));
				}); 
			this.addChild(sponsorSprite); */
        }
         
        // This function is called whenever the state of the preloader changes.  
        // Use the _fractionLoaded variable to draw your progress bar.
        virtual protected function draw():void 
        {
			_currlen = _fractionLoaded * 5;
			glow.alpha = (0.5/MAX_LENGTH)*_currlen;
			txtBox.filters = [glow];

			var borderThickness:Number = 2;
			var cornerRadius:Number = 7;
			var width:Number = _currlen;
			var height:Number = 20;
			var borderColorGradient1:uint = 0xFFFF52;
			var borderColorGradient2:uint = 0x5A3400;			
				
			var matrix:Matrix = new Matrix();
			maskBar.graphics.clear();			
			maskBar.graphics.lineStyle(borderThickness);
			matrix.createGradientBox(MAX_LENGTH, height, 90/(180/Math.PI), 0, 0);
			maskBar.graphics.lineGradientStyle(GradientType.LINEAR, [borderColorGradient1, borderColorGradient2, borderColorGradient2], [1,1,1], [10, 10, 255], matrix);
			maskBar.graphics.drawRoundRectComplex(-1,-1,MAX_LENGTH+2,height+2, cornerRadius, cornerRadius, cornerRadius, cornerRadius);
		
			
			var barAlpha:Number = 1;
			var colorGradient1:uint = 0xFFFFA5;
			var colorGradient2:uint = 0x292400;
			var colorGradient3:uint = 0x734D00;			
				
			matrix = new Matrix();
			maskBar.graphics.lineStyle();			
			matrix.createGradientBox(width, height, 90/(180/Math.PI), 0, 0);
			maskBar.graphics.beginGradientFill(GradientType.LINEAR, [colorGradient1, colorGradient2, colorGradient3], [barAlpha,barAlpha,barAlpha], [0, 138, 255], matrix);
			maskBar.graphics.drawRoundRectComplex(0,0,width,height, cornerRadius, cornerRadius, cornerRadius, cornerRadius);
			maskBar.graphics.endFill();
		}
    
        /**
         * The Preloader class passes in a reference to itself to the display class
         * so that it can listen for events from the preloader.
         * This code comes from DownloadProgressBar.  I have modified it to remove some unused event handlers.
         */
        virtual public function set preloader(value:Sprite):void 
        {
            _preloader = value;
        
            value.addEventListener(ProgressEvent.PROGRESS, progressHandler);    
            value.addEventListener(Event.COMPLETE, completeHandler);
            value.addEventListener(FlexEvent.INIT_PROGRESS, initProgressHandler);
            value.addEventListener(FlexEvent.INIT_COMPLETE, initCompleteHandler);
            value.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);           
        }

        virtual public function set backgroundAlpha(alpha:Number):void{}
        virtual public function get backgroundAlpha():Number { return 1; }
        
        protected var _backgroundColor:uint = 0xffffffff;
        virtual public function set backgroundColor(color:uint):void { _backgroundColor = color; }
        virtual public function get backgroundColor():uint { return _backgroundColor; }
        
        virtual public function set backgroundImage(image:Object):void {}
        virtual public function get backgroundImage():Object { return null; }
        
        virtual public function set backgroundSize(size:String):void {}
        virtual public function get backgroundSize():String { return "auto"; }
        
        protected var _stageHeight:Number = 640;
        virtual public function set stageHeight(height:Number):void { _stageHeight = height; }
        virtual public function get stageHeight():Number { return _stageHeight; }

        protected var _stageWidth:Number = 640;
        virtual public function set stageWidth(width:Number):void { _stageWidth = width; }
        virtual public function get stageWidth():Number { return _stageWidth; }
        
        // Called from time to time as the download progresses.
        virtual protected function progressHandler(event:ProgressEvent):void 
        {
            _bytesLoaded = event.bytesLoaded;
            _bytesExpected = event.bytesTotal;
            _fractionLoaded = Number(_bytesLoaded) / Number(_bytesExpected) * 100;
            
            draw();
            
            if (_adEnabled && !_adAdded)
		    {
		    	_adAdded = true;	
				ad = AdLoader.LoadAd();
				
				ad.x = 60;
				ad.y = (stageHeight - ADD_HEIGHT) /2;
				
				this.addChild(ad);
		    }
        }
        
        // Called when the download is complete, but initialization might not be done yet.  (I *think*)
        // Note that there are two phases- download, and init
        virtual protected function completeHandler(event:Event):void {
        	_IsDownloadComplete = true;
        }
    
        
        // Called from time to time as the initialization continues.        
        virtual protected function initProgressHandler(event:Event):void {
            draw();
        }
    
        // Called when both download and initialization are complete    
        virtual protected function initCompleteHandler(event:Event):void 
        {
            _IsInitComplete = true;
        }
        
        virtual protected function ioErrorHandler(event:IOErrorEvent):void
        {
        	trace(event.text);
        }

        virtual protected function timerHandler(event:Event):void 
        {
            if (_IsInitComplete && _IsDownloadComplete) {    
                // We're done!
                _timer.removeEventListener(TimerEvent.TIMER, timerHandler);
                _timer.stop();  
                
                if (_adEnabled)
                {
                	var centerX:Number = (20 + ADD_WIDTH)/2 + (stageWidth - 100)/2;
		            var centerY:Number = (stageHeight)/2;
		            var bwidth:int = 100;
		            var bheight:int = 20;  
		            
	                playButton.x = centerX;
	                playButton.y = centerY;
	                
	                this.addChild(playButton); 
	                
					var borderThickness:Number = 2;
					var cornerRadius:Number = 3;
					var borderColorGradient1:uint = 0xFFFF70;
					var borderColorGradient2:uint = 0x5A3422;			
						
					var matrix:Matrix = new Matrix();
					playButton.graphics.clear();			
					playButton.graphics.lineStyle(borderThickness);
					matrix.createGradientBox(bwidth, bheight, 90/(180/Math.PI), 0, 0);
					playButton.graphics.lineGradientStyle(GradientType.LINEAR, [borderColorGradient1, borderColorGradient2, borderColorGradient2], [1,1,1], [10, 10, 255], matrix);
					playButton.graphics.drawRoundRectComplex(-1,-1,bwidth+2,bheight+2, cornerRadius, cornerRadius, cornerRadius, cornerRadius);
				
					
					var barAlpha:Number = 1;
					var colorGradient1:uint = 0xFFFFA7;
					var colorGradient2:uint = 0x292401;
					var colorGradient3:uint = 0x734D01;			
						
					matrix = new Matrix();
					playButton.graphics.lineStyle();			
					matrix.createGradientBox(bwidth, bheight, 90/(180/Math.PI), 0, 0);
					playButton.graphics.beginGradientFill(GradientType.LINEAR, [colorGradient1, colorGradient2, colorGradient3], [barAlpha,barAlpha,barAlpha], [0, 138, 255], matrix);
					playButton.graphics.drawRoundRectComplex(0,0,bwidth,bheight, cornerRadius, cornerRadius, cornerRadius, cornerRadius);
					playButton.graphics.endFill();
					
					playButton.filters = [ glow ];
					
					playButton.addEventListener(MouseEvent.CLICK, onStartClick);
					playButton.useHandCursor = true;
					playButton.buttonMode = true;
					
					var playText:TextField = new TextField();
					playText.textColor = 0xffffff;
					playText.width = 30;
		        	playText.text = "Play";
		        	playText.setTextFormat(new TextFormat("Arial", 12, 0xffffff, true));
		        	playText.x = 35;
					playText.selectable = false;
					playText.mouseEnabled = false;
					playButton.addChild(playText);
					
					playText.addEventListener(MouseEvent.CLICK, onStartClick);
                }
				else
				{
                	dispatchEvent(new Event(Event.COMPLETE));
                	Application.application.dispatchEvent(new Event(Event.COMPLETE));
				}
            } else {
                draw();
            }
        }
        
        private function onStartClick(event:Event):void
        {
       		this.removeChild(ad);
            dispatchEvent(new Event(Event.COMPLETE));
            Application.application.dispatchEvent(new Event(Event.COMPLETE));
        }
        
    }
    
}