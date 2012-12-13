package com.nicolabortignon.moodlight.view.page.dashboard
{
	import com.nicolabortignon.moodlight.Facade;
	import com.nicolabortignon.moodlight.view.page.Page;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class ChooseIconPage extends Page
	{
		public var nextButton:MovieClip;
		public var backButton:MovieClip;
		
		
		public var currentSelectedIcon:IconImage;
		public var nameTextField:TextField;
		
		public function ChooseIconPage()
		{
			super();
			
			nextButton.buttonMode = backButton.buttonMode = true;
			nextButton.mouseChildren = backButton.buttonMode = false;
			nextButton.useHandCursor = backButton.useHandCursor = true;
			
			
			nextButton.addEventListener(MouseEvent.CLICK, nextButtonHandler);
			backButton.addEventListener(MouseEvent.CLICK, backButtonHandler);
			
			placeIcons();
		}
		
		private function placeIcons():void{
			for(var i:int = 0; i< 30; i++){
				var icon:MovieClip = new IconImage();
				icon.x = 100+(110*(i%5));
				icon.y = 350+80*int(i/5);
				icon.gotoAndStop(1+i);
				icon.backgroundOff.visible = true;
				icon.backgroundOn.visible = false;
				icon.addEventListener(MouseEvent.CLICK, selectIcon);
				icon.mouseChildren = false;
				addChild(icon);
				
			}
		}
		private function selectIcon(e:MouseEvent):void{
			if(currentSelectedIcon != null){
				currentSelectedIcon.backgroundOff.visible = true;
				currentSelectedIcon.backgroundOn.visible = false;
			}
			currentSelectedIcon = e.target as IconImage;
			e.target.backgroundOn.visible = true;
			e.target.backgroundOff.visible = false;
		}
		private function nextButtonHandler(e:MouseEvent):void{
			Facade.dispatchAnEvent("NEXT_FROM_NAME_PAGE");
		}
		private function backButtonHandler(e:MouseEvent):void{
			Facade.dispatchAnEvent("BACK_FROM_NAME_PAGE");
		}
		
		
	}
}