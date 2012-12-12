package com.nicolabortignon.moodlight.view.page.dashboard
{
	import com.nicolabortignon.moodlight.Facade;
	import com.nicolabortignon.moodlight.view.page.Page;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class ChooseIconPage extends Page
	{
		public var nextButton:MovieClip;
		public var backButton:MovieClip;
		
		
		public function ChooseIconPage()
		{
			super();
			
			nextButton.buttonMode = backButton.buttonMode = true;
			nextButton.mouseChildren = backButton.buttonMode = false;
			nextButton.useHandCursor = backButton.useHandCursor = true;
			
			
			nextButton.addEventListener(MouseEvent.CLICK, nextButtonHandler);
			backButton.addEventListener(MouseEvent.CLICK, backButtonHandler);
			
			
		}
		
		private function nextButtonHandler(e:MouseEvent):void{
			Facade.dispatchAnEvent("NEXT_FROM_NAME_PAGE");
		}
		private function backButtonHandler(e:MouseEvent):void{
			Facade.dispatchAnEvent("BACK_FROM_NAME_PAGE");
		}
		
		
	}
}