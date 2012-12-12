/**
 * @author Nicola Bortignon
 * @blog http://www.nicolabortignon.com
 * @twitter nicolabortignon
 * Copyright (c) 2010
 
 * 
 * TouchListItemRendeer is the default item renderere, it implements ITouchListRenderer.  
 * You can make your own custom renderer by implementing ITouchListRenderer.
 * */
package com.nicolabortignon.components.touchlist.renderers
{
	import com.nicolabortignon.components.touchlist.events.ListItemEvent;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	public class TouchListItemRenderer extends MovieClip implements ITouchListItemRenderer
	{
		protected var _data:Object;
		protected var _index:Number = 0;
		protected var _itemWidth:Number = 0;
		public var _itemHeight:Number = 0;
		
		protected var initialized:Boolean = false;
		protected var textField:TextField;
		protected var shadowFilter:DropShadowFilter;
		
		public var _isSelected:Boolean = false;
		public var style:MovieClip;

		//-------- properites -----------
		public function get isSelected():Boolean{
			return _isSelected;
		}
		public function get itemWidth():Number
		{
			return _itemWidth;
		}
		public function set itemWidth(value:Number):void
		{
			_itemWidth = value;
			draw();
		}
		
		public function get itemHeight():Number
		{
			return _itemHeight;
		}
		public function set itemHeight(value:Number):void
		{
			_itemHeight = value;
			draw();
		}
		
		public function get data():Object
		{
			return _data;
		}
		public function set data(value:Object):void
		{
			_data = value;
			draw();
		}
		
		public function get index():Number
		{
			return _index;
		}
		public function set index(value:Number):void
		{
			_index = value;
		}
		
		public function TouchListItemRenderer()
		{
			addEventListener(Event.REMOVED, destroy);
			
			addEventListener(MouseEvent.MOUSE_DOWN, pressHandler);
			
			createChildren();
		}
		
		//-------- public methods -----------
		
		/**
		 * Show our item in default state.
		 * */
		public function unselectItem():void
		{
			removeEventListener(MouseEvent.MOUSE_UP, selectHandler);
		//	draw();
		}
		
		/**
		 * Show our item selected.
		 * */
		public function selectItem():void
		{
			addEventListener(MouseEvent.MOUSE_UP, selectHandler);
			var textFormat:TextFormat = new TextFormat();
			if(_isSelected){
				textFormat.size = 34;
				textFormat.color = 0x323232;
				style.gotoAndStop(1);
				_isSelected = false;
				textField.y = -12+itemHeight/2 - textField.textHeight/2;
				
				
			} else {
				textFormat.size = 30;
				textFormat.color = 0xdedede;
				style.gotoAndStop(2);	
				textField.y = -7+itemHeight/2 - textField.textHeight/2;
				
				
				_isSelected = true;
			}
			textFormat.font = "Miso"; 
			
	
			textField.defaultTextFormat = textFormat;
			textField.text = textField.text.toString();
		}
		
		//-------- protected methods -----------
		
		/**
		 * Install the DroidSans front from Google:
		 * http://code.google.com/webfonts/family?family=Droid+Sans
		 * */
		protected function createChildren():void
		{
			style = new listItemButton();
			addChild(style);
			
			if(!textField) {
				var textFormat:TextFormat = new TextFormat();
					textFormat.color = 0x323232;
					textFormat.size = 34;
					textFormat.font = "Miso"; 
					textFormat.align = TextFormatAlign.CENTER;
				textField = new TextField();
				textField.height = 34;
				textField.width = style.width;
				
				
				textField.mouseEnabled = false;
				textField.defaultTextFormat = textFormat;
				
				this.addChild(textField);
			}
			
			initialized = true;
			
			draw();
			
		}
		
		protected function draw():void
		{
			if(!initialized) return 
			style.gotoAndStop(1);
			var textFormat:TextFormat = new TextFormat();
			textFormat.color = 0x323232;
			textFormat.size = 34;
			textFormat.font = "Miso"; 
			textFormat.align = TextFormatAlign.CENTER;
			textField.defaultTextFormat = textFormat;
			
			textField.text = String(data).toUpperCase();
			textField.height = textField.textHeight;
			textField.width = itemWidth - 10;
			textField.y = -12+itemHeight/2 - textField.textHeight/2;
			
			
			
			this.filters = [];
		}
		
		/**
		 * Clean up item when removed from stage.
		 * */
		protected function destroy(e:Event):void
		{
			trace("destroy");
			
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			removeEventListener(MouseEvent.MOUSE_UP, selectHandler);
			
		
		}
		
		// ----- event handlers --------
		
		/**
		 * Dispatched when item is first pressed on tap or mouse down.
		 * */
		protected function pressHandler(e:Event):void
		{
			this.dispatchEvent( new ListItemEvent(ListItemEvent.ITEM_PRESS, this) );
		}
		
		/**
		 * Dispatched when item is selected, usually on touch end or mouse up.
		 * */
		protected function selectHandler(e:Event):void
		{
			this.dispatchEvent( new ListItemEvent(ListItemEvent.ITEM_SELECTED, this) );
		}
	}
}