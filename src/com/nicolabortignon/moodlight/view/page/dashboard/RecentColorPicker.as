package com.nicolabortignon.moodlight.view.page.dashboard
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.geom.Point;

	public class RecentColorPicker extends MovieClip
	{
		private var _shape:Shape;
		public var hasAColor:Boolean = false;
		
		public var angle:int;
		public var coordinates:Point;
		public var theColor:uint;
		
		public function RecentColorPicker()
		{
			_shape = new Shape();
			addChild(_shape);
		
		}
		
		public function drawCircle(color:uint):void{
			theColor = color;
			hasAColor = true;
			_shape.graphics.clear();
			_shape.graphics.beginFill(color,.9);
			_shape.graphics.drawCircle(28.5,29,20);
		}
		
	}
}