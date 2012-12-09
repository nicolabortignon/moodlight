package com.nicolabortignon.moodlight.view.content.dashboard
{
	import com.greensock.TweenMax;
	import com.nicolabortignon.colourlib.Colours;
	import com.nicolabortignon.moodlight.Facade;
	import com.nicolabortignon.moodlight.controller.DeviceProperties;
	import com.nicolabortignon.moodlight.view.content.Content;
	import com.nicolabortignon.moodlight.view.page.Page;
	import com.nicolabortignon.moodlight.view.page.dashboard.ChooseColorPage;
	import com.nicolabortignon.moodlight.view.page.dashboard.SwitchPage;
	import com.nicolabortignon.moodlight.view.page.dashboard.switcher.Switcher;
	
	import flash.display.MovieClip;
	
	public class DashboardContent extends Content
	{
		private var switchPage:SwitchPage;
		private var colourPage:ChooseColorPage;
		private var contents:Vector.<Page>;
		public function DashboardContent()
		{
			super();
			contents = new Vector.<Page>();
			
			render();
			registerEvents();
		}
		
		public function registerEvents():void{
			Facade.registerToAnEvent("BACK_FROM_COLOR_PAGE",moveBackFromColorPage);
			Facade.registerToAnEvent("AddNewSwitch",addNewSwitchHandler);
		}
		
		public function addNewSwitchHandler():void{
			
			TweenMax.to(switchPage,.7,{x:-DeviceProperties.screenWidth, onComplete: switchPage.hide});
			
			
			// GO TO COLOUR PAGE
			colourPage.x = DeviceProperties.screenWidth;
			colourPage.visible = true;
			TweenMax.to(colourPage,.7,{x:0});
			
			
		}
		
		public function render():void{
			switchPage = new SwitchPage()
			colourPage = new ChooseColorPage();
			
			
			colourPage.visible = false;
			contents.push(switchPage);
			contents.push(colourPage);
			
			addChild(colourPage);
			addChild(switchPage);
			
			
		}
		private function moveBackFromColorPage():void{ translateContent(1,0)};
		private function translateContent(currentPositionId:int,nextPositionId:int):void{
			trace(currentPositionId,nextPositionId);
			if(currentPositionId < nextPositionId){
				contents[nextPositionId].x = DeviceProperties.screenWidth;
				contents[nextPositionId].visible = true;
				TweenMax.to(contents[currentPositionId],.5,{x:-DeviceProperties.screenWidth, onComplete:function(){contents[currentPositionId].hide();}});
				TweenMax.to(contents[nextPositionId],.5,{x:0});
			}
			else {
				contents[nextPositionId].x = -DeviceProperties.screenWidth;
				contents[nextPositionId].visible = true;
				TweenMax.to(contents[currentPositionId],.5,{x:DeviceProperties.screenWidth, onComplete:function(){contents[currentPositionId].hide();}});
				TweenMax.to(contents[nextPositionId],.5,{x:0});
			}
		}
		
		override public function hide(){
			
 		}
	}
}