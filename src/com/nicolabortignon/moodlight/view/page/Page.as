package com.nicolabortignon.moodlight.view.page
{
	import flash.display.MovieClip;
	
	public class Page extends MovieClip
	{
		public function Page()
		{
			super();
			renderPage();
		}
		public function hide():void{this.visible=false;}
		public function renderPage():void{};
	}
}