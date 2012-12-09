package com.nicolabortignon.moodlight.view.content
{
	import flash.display.MovieClip;
	
	public class Content extends MovieClip
	{
		public var id:int;
		
		public function Content()
		{
			super();
		}
		public function hide(){
			this.visible = false;
		}
	}
}