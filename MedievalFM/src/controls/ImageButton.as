package controls
{
	import images.Images;
	
	import mx.core.BitmapAsset;
	
	import skins.ImageButtonSkin;
	
	import sound.Sounds;

	public class ImageButton extends ClickButton
	{
		private const ActiveGlowColor:uint = 0xFFFF10;
		private const InactiveGlowColor:uint = 0x00AA00;				
		
		private static const defaultImage:BitmapAsset = Images.plusButtonImage;
		
		private var _progress:Number = 0;

		public function setProgress(value:Number):void
		{
			if (value != _progress)
			{
				_progress = value;
				for (var i:int = 0; i < this.numChildren; ++i)
				{
					var child:ImageButtonSkin = this.getChildAt(i) as ImageButtonSkin;
					if (child) child.progress = _progress;
				}
			}
		}
					
		[Bindable]
		public var image:BitmapAsset = new BitmapAsset(defaultImage.bitmapData);
		
		public function setImage(img:BitmapAsset):void
		{
			if (!img && image.bitmapData != defaultImage.bitmapData)
			{
				image = new BitmapAsset(defaultImage.bitmapData);
				for (var i:int = 0; i < this.numChildren; ++i)
				{
					var child:ImageButtonSkin = this.getChildAt(i) as ImageButtonSkin;
					if (child) child.validateNow();
				}				
			}
			else if (img && img.bitmapData != image.bitmapData)
			{
				image = new BitmapAsset(img.bitmapData);
				for (var i:int = 0; i < this.numChildren; ++i)
				{
					var child:ImageButtonSkin = this.getChildAt(i) as ImageButtonSkin;
					if (child) child.validateNow();
				}
			}
		}
		
		private var _active:Boolean;
		
		[Bindable]
		public function set active(value:Boolean):void{
			_active = value;
			for (var i:int = 0; i < this.numChildren; ++i)
			{
				var skin:ImageButtonSkin = this.getChildAt(i) as ImageButtonSkin;
				if (skin)
				{
					skin.glowColor = glowColor;
					skin.active = _active;
				}
			}
		}
		public function get active():Boolean{
			return _active;
		}
		
		public function ImageButton()
		{
			super();
		}
		
		private function get glowColor():uint
		{
			if (_active)
				return ActiveGlowColor;
			else
				return InactiveGlowColor;
		}
		
		protected override function initializationComplete():void
		{
			super.initializationComplete();
			this.setStyle("skin", ImageButtonSkin);	
			this.setStyle("padding-bottom", 0);	
			this.setStyle("padding-left", 0);	
			this.setStyle("padding-right", 0);	
			this.setStyle("padding-top", 0);
			this.setStyle("glowColor", glowColor);     
			    	
			clickSound = Sounds.mouseClick;
			
			if (!width && image)
				width = image.width;
				
			if (!height && image)
				height = image.height;
		} 
	}
}