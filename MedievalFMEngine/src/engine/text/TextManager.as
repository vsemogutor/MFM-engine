package engine.text
{
	import __AS3__.vec.Vector;
	
	import engine.core.fm_internal;
	import engine.game.Game;
	import engine.units.Unit;
	import engine.util.Constants;
	
	import flash.events.EventDispatcher;
	import flash.filters.GlowFilter;
	
	import mx.controls.Text;
	
	use namespace fm_internal;
		
	public final class TextManager extends EventDispatcher
	{
		private var _texts:Vector.<engine.text.Text> = new Vector.<engine.text.Text>();
		fm_internal var _inGameTexts:Vector.<engine.text.Text> = new Vector.<engine.text.Text>();		
		private var _shadowFilter:GlowFilter = new GlowFilter(0x12190C, 0.8, 3, 3, 4);
	
		public function addText(name:String, text:engine.text.Text):void
		{
			removeText(name);
			text.name = name;
			var label:mx.controls.Text = new mx.controls.Text();
			label.text = text.text;
			label.selectable = false;
			if (text.width) label.width = text.width;
			label.setStyle("color", text.color);
			label.setStyle("fontSize", text.size);
			if (text.bold) label.setStyle("fontWeight", "bold");
			if (text.shadow) label.filters = [_shadowFilter];
			label.buttonMode = false;
			text.label = label;
			label.visible = false;	
			label.includeInLayout = true;		
			Game.instance().sceneManager.view.parent.addChild(label);

			if (text.relativeX == Constants.UNDEFINED)
				text.label.x = text.x;
	
			if (text.relativeY == Constants.UNDEFINED)
				text.label.y = text.y;
						
			_texts.push(text);
		}	
		
		public function removeText(name:String):void
		{
			var len:int = _texts.length;
			for (var i:int = 0; i < len; ++i)
			{
				if (_texts[i].name == name)
				{
					Game.instance().sceneManager.view.parent.removeChild(_texts[i].label);
					_texts.splice(i, 1);
					break;
				}
			}
		}
		
		public function addTextOnUnit(unit:Unit, text:engine.text.Text):void
		{
			text.x = unit.x - unit.model.frameWidth/2;
			text.y = unit.y;
			text.width =  unit.model.frameWidth;
			text.height = unit.model.frameHeight;
			
			_inGameTexts.push(text);
		}
		
		public function processText():void
		{
			for (var i:int = 0; i < _texts.length; ++i)
			{
				var text:engine.text.Text = _texts[i];
				
				if (text.lifeTime >= text.time)
				{
					Game.instance().sceneManager.view.parent.removeChild(text.label);
					_texts.splice(i, 1); 
					continue;
				}
				else if (text.time - text.lifeTime <= Constants.FRAME_RATE)
				{
					if (text.fadeOut)
						text.label.alpha = (text.time - text.lifeTime)/Constants.FRAME_RATE;
				}
				else if (text.lifeTime <= Constants.FRAME_RATE)
				{
					if (text.fadeIn)
						text.label.alpha = text.lifeTime/Constants.FRAME_RATE;
				}

				text.label.visible = true;									
				if (text.relativeX != Constants.UNDEFINED)
				{
					text.x = text.label.x = calcTextPosX(text);
				}
				
				if (text.relativeY != Constants.UNDEFINED)
				{
					text.y = text.label.y = calcTextPosY(i, text);
				}			
				
				++text.lifeTime;
			}
			
			for (var i:int = 0; i < _inGameTexts.length; ++i)
			{
				var text:engine.text.Text = _inGameTexts[i];
				
				if (text.lifeTime >= text.time)
				{
					_inGameTexts.splice(i, 1); 
					continue;
				}
				else if (text.time - text.lifeTime <= Constants.FRAME_RATE)
				{
					text.alpha = (text.time - text.lifeTime)/Constants.FRAME_RATE;
				}
				
				if (text.lifeTime % 3 == 0)
				{
					text.x -= 2;
					text.y -= 2;	
				}		
				
				++text.lifeTime;
			}			
		}
		
		private function calcTextPosX(text:engine.text.Text):Number
		{
			var shift:Number = 0;
			if (text.relativeX == TextPosition.LEFT)
				shift = 10;
			else if (text.relativeX == TextPosition.RIGHT)
				shift = Game.instance().sceneManager.view.width - 10 - text.label.width;
			else if (text.relativeX == TextPosition.CENTER)
				shift = Game.instance().sceneManager.view.width/2 - text.label.width/2;
				
			return shift;
		}
		
		private function calcTextPosY(indx:int, text:engine.text.Text):Number
		{
			var shift:Number = 0;
			for (var i:int = 0; i < indx; ++i)
			{
				var cur:engine.text.Text = _texts[i];
				if (cur.relativeY != text.relativeY)
					continue;
				
				shift += cur.label.height;
			}
			
			if (text.relativeY == TextPosition.TOP)
			{
				shift += 10;
			}
			else if (text.relativeY == TextPosition.BOTTOM)
			{
				shift = -shift;
				shift += Game.instance().sceneManager.view.height - 50 - text.label.height;
			}
			else if (text.relativeY == TextPosition.CENTER)
			{
				shift = -shift;
				shift += Game.instance().sceneManager.view.height/2 - text.label.height;
			}
				
			return shift;
		}
		
		public function removeAllText():void
		{
			for (var i:int = _texts.length - 1; i >= 0 ; --i)
			{
				Game.instance().sceneManager.view.parent.removeChild(_texts[i].label);
				_texts.splice(i, 1);
			}
			
			_inGameTexts = new Vector.<engine.text.Text>();
		}
	}
}