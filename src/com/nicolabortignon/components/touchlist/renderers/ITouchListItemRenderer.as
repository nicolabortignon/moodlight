/**
 * @author Nicola Bortignon
 * @blog http://www.nicolabortignon.com
 * @twitter nicolabortignon
 * Copyright (c) 2010
 * 
 * 
 * ITouchListItemRenderer must be implemented in any item renderer you want to use for the list.
 * */
package com.nicolabortignon.components.touchlist.renderers
{
	public interface ITouchListItemRenderer
	{
		function set data(value:Object):void;
		function get data():Object;
		function set index(value:Number):void;
		function get index():Number;
		function set itemWidth(value:Number):void;
		function get itemWidth():Number;
		function set itemHeight(value:Number):void;
		function get itemHeight():Number;
		function selectItem():void;
		function unselectItem():void;
		function get isSelected():Boolean;
	}
}