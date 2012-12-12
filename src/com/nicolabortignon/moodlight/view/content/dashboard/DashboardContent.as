package com.nicolabortignon.moodlight.view.content.dashboard
{
	import com.greensock.TweenMax;
	import com.nicolabortignon.colourlib.Colours;
	import com.nicolabortignon.components.touchlist.renderers.ITouchListItemRenderer;
	import com.nicolabortignon.moodlight.Facade;
	import com.nicolabortignon.moodlight.controller.DeviceProperties;
	import com.nicolabortignon.moodlight.view.content.Content;
	import com.nicolabortignon.moodlight.view.page.Page;
	import com.nicolabortignon.moodlight.view.page.dashboard.ChooseColorPage;
	import com.nicolabortignon.moodlight.view.page.dashboard.ChooseIconPage;
	import com.nicolabortignon.moodlight.view.page.dashboard.ChooseLightPage;
	import com.nicolabortignon.moodlight.view.page.dashboard.SwitchPage;
	import com.nicolabortignon.moodlight.view.page.dashboard.switcher.Switcher;
	
	import flash.display.MovieClip;
	
	public class DashboardContent extends Content
	{
		private var switchPage:SwitchPage;
		private var chooseLightPage:ChooseLightPage;
		private var colourPage:ChooseColorPage;
		private var namePage:ChooseIconPage;
		private var contents:Vector.<Page>;
		
		private var switcher:Switcher;
	
		public function DashboardContent()
		{
			super();

			contents = new Vector.<Page>();
			
			render();
			registerEvents();
		}
		
		public function registerEvents():void{
			Facade.registerToAnEvent("AddNewSwitch",addNewSwitchHandler);
			
			Facade.registerToAnEvent("NEXT_FROM_LIGHT_LIST_PAGE",chooseColorHandler);
			Facade.registerToAnEvent("BACK_FROM_LIGHT_LIST_PAGE",moveBackFromLightListPage);

			Facade.registerToAnEvent("BACK_FROM_COLOR_PAGE",moveBackFromColorPage);
			Facade.registerToAnEvent("NEXT_FROM_COLOR_PAGE",moveNextFromColorPage);
			
			Facade.registerToAnEvent("BACK_FROM_NAME_PAGE",moveBackFromNamePage);
			Facade.registerToAnEvent("NEXT_FROM_NAME_PAGE",moveNextFromNamePage);
		}
		
		public function addNewSwitchHandler():void{	
			switcher = new Switcher();
			
			translateContent(0,1); 
		
		}
		private function moveBackFromLightListPage():void{ translateContent(1,0)};
		
		public function chooseColorHandler(){
			// PARSE LIGHTS
			
			switcher.lights = new Vector.<Boolean>(16);
			for(var i:int = 0; i< chooseLightPage.touchList.elements.length;i++){
				trace((chooseLightPage.touchList.elements[i] as ITouchListItemRenderer).isSelected)
				switcher.lights[i] = (chooseLightPage.touchList.elements[i] as ITouchListItemRenderer).isSelected;
			}
			
			translateContent(1,2);}
		
		private function moveBackFromColorPage():void{ translateContent(2,1)};
		private function moveNextFromColorPage():void{ translateContent(2,3)};

		private function moveBackFromNamePage():void{ translateContent(3,2)};
		private function moveNextFromNamePage():void{ trace("FINISHED");};
		
		
		public function render():void{
			switchPage = new SwitchPage()
			colourPage = new ChooseColorPage();
			chooseLightPage = new ChooseLightPage();
			namePage = new ChooseIconPage();
			
			
			
			
			colourPage.visible = false;
			chooseLightPage.visible = false;
			namePage.visible = false;
			
			contents.push(switchPage);
			contents.push(chooseLightPage);
			contents.push(colourPage);
			contents.push(namePage);
			
			addChild(colourPage);
			addChild(chooseLightPage);
			addChild(switchPage);
			addChild(namePage);
			
		}
		private function translateContent(currentPositionId:int,nextPositionId:int):void{
			trace(currentPositionId,nextPositionId);
			if(currentPositionId < nextPositionId){
				contents[nextPositionId].x = 640;
				contents[nextPositionId].visible = true;
				TweenMax.to(contents[nextPositionId],.5,{x:0});
				TweenMax.to(contents[currentPositionId],.5,{x:-640, onComplete:function(){contents[currentPositionId].hide();}});
			}
			else {
				contents[nextPositionId].x = -640;
				contents[nextPositionId].visible = true;
				TweenMax.to(contents[currentPositionId],.5,{x:640, onComplete:function(){contents[currentPositionId].hide();}});
				TweenMax.to(contents[nextPositionId],.5,{x:0});
			}
		}
		
		override public function hide(){
			
 		}
	}
}