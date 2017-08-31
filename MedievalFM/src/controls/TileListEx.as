package controls
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.Sprite;

	import mx.controls.Button;
	import mx.controls.Image;
	import mx.controls.TileList;
	import mx.controls.listClasses.IListItemRenderer;
	
	public class TileListEx extends TileList
	{	
		private var _selectionAlpha:Number = 0;
		
		public function get selectionAlpha():Number {
			return _selectionAlpha;
		}

		public function set selectionAlpha(value:Number):void {
			_selectionAlpha = value;
		}
				
	   	override protected function drawSelectionIndicator(indicator:Sprite, x:Number,
	       y:Number, width:Number, height:Number, color:uint,
	       itemRenderer:IListItemRenderer):void
	   	{
	   		if (_selectionAlpha > 0)
	   		{
			   var g:Graphics = Sprite(indicator).graphics;
			   g.clear();
			   g.beginFill(color);
			   g.drawRoundRectComplex(0, 0, width, height, 4, 4, 4, 4);
			   g.endFill();
			       
			   indicator.x = x;
			   indicator.y = y;
			}
	   	}
	   
	   	override protected function drawCaretIndicator(indicator:Sprite, x:Number, y:Number,
	   		 width:Number, height:Number, color:uint, itemRenderer:IListItemRenderer):void
		{
			return;
		}
		
		public function getChildren():Array
		{
			var array:Array = [];
			getChildrenInternal(this, array);
			return array;
		}	
		
		private function getChildrenInternal(display:DisplayObjectContainer, array:Array) : void 
		{
		  	if(display) 
		  	{
			    for (var i : int = 0;i < display.numChildren; i++) 
			    {
			        var child:Object = display.getChildAt(i);
			        if ( (child is Image || child is Button) && child.data) array.push(child);
			        if (child is DisplayObjectContainer) 
			        {
			            getChildrenInternal(DisplayObjectContainer(child), array);
			        }
			    }
			}			
		}
	}
}