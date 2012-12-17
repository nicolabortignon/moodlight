package com.nicolabortignon.moodlight.view.page.dashboard
{
	import com.nicolabortignon.components.touchlist.controls.TouchList;
	import com.nicolabortignon.components.touchlist.renderers.TouchListItemRenderer;
	import com.nicolabortignon.moodlight.Facade;
	import com.nicolabortignon.moodlight.controller.DeviceProperties;
	import com.nicolabortignon.moodlight.view.ContentHolder;
	import com.nicolabortignon.moodlight.view.content.Content;
	import com.nicolabortignon.moodlight.view.page.Page;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class ChooseLightPage extends Page
	{
		public var nextButton:MovieClip;
		public var backButton:MovieClip;
		
		public var touchList:TouchList;
		
		public function ChooseLightPage()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event):void{
			touchList = new TouchList(608,DeviceProperties.screenHeight-66-(this.parent.parent as ContentHolder).menuBackground.height);
			touchList.y = 61;
			touchList.x = 20;
			
			addChild(touchList);
			for(var i:int = 0; i < 1; i++) {
				var item:TouchListItemRenderer = new TouchListItemRenderer();
				item.index = i;
				item.data = "Light Number " + String(i+1);
				item.itemHeight = 97;
				
				touchList.addListItem(item);
			}
			nextButton.buttonMode = backButton.buttonMode = true;
			nextButton.mouseChildren = backButton.buttonMode = false;
			nextButton.useHandCursor = backButton.useHandCursor = true;
			
			
			nextButton.addEventListener(MouseEvent.CLICK, nextButtonHandler);
			backButton.addEventListener(MouseEvent.CLICK, backButtonHandler);
			
		}
		
		private function nextButtonHandler(e:MouseEvent):void{
			Facade.dispatchAnEvent("NEXT_FROM_LIGHT_LIST_PAGE");
		}
		private function backButtonHandler(e:MouseEvent):void{
			Facade.dispatchAnEvent("BACK_FROM_LIGHT_LIST_PAGE");
		}
		
		
	}
}