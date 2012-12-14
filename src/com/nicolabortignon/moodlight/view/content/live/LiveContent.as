package com.nicolabortignon.moodlight.view.content.live
{
	import com.nicolabortignon.moodlight.controller.DeviceProperties;
	import com.nicolabortignon.moodlight.view.content.Content;
	import com.nicolabortignon.moodlight.view.page.live.LivePage;
	
	public class LiveContent extends Content
	{
		private var livePage:LivePage;
		
		public function LiveContent()
		{
			super();
			livePage = new LivePage();
			livePage.y = ((DeviceProperties.screenHeight-100) - livePage.height)/2;
			addChild(livePage);
		}
	}
}