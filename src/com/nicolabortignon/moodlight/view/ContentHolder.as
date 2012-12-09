package com.nicolabortignon.moodlight.view
{
	import com.greensock.TweenMax;
	import com.nicolabortignon.moodlight.Facade;
	import com.nicolabortignon.moodlight.controller.DeviceProperties;
	import com.nicolabortignon.moodlight.view.content.Content;
	import com.nicolabortignon.moodlight.view.content.ContentButton;
	import com.nicolabortignon.moodlight.view.content.dashboard.DashboardContent;
	import com.nicolabortignon.moodlight.view.content.live.LiveContent;
	import com.nicolabortignon.moodlight.view.content.options.OptionsContent;
	import com.nicolabortignon.moodlight.view.page.Page;
	import com.nicolabortignon.moodlight.view.page.loading.LoadingPage;
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.system.Capabilities;
	
	public class ContentHolder extends MovieClip
	{
		
		public var loadingPage:LoadingPage;
		
		public var contents:Vector.<Content>;
		public var contentMenu:Vector.<CustomButton>;
		
		public var currentButtonSelected:CustomButton;
		public var currentContent:Content;
		public var backgroundContainer:MovieClip;
		public var menuBackground:MovieClip;
		
		public function ContentHolder()
		{
			super();	
			backgroundInitalization();
			addLoadingPage();   // CREATE THE LOADING PAGE
			
			
			Facade.registerToAnEvent("LoadedComplete",loadingCompleted);
			
			loadingPage.updatePercentuage(5,"Initializing Controler");
			contents = new  Vector.<Content>();
			contentMenu = new Vector.<CustomButton>();
			createContents();
			loadingPage.updatePercentuage(45,"Content Rendered");
			Facade.dispatchAnEvent("LoadedComplete");
			// MESSAGE THE CONTENT LOADER WAS INITIALIZED CORRECTLY 
		}
		
		
		
		private function loadingCompleted():void{
			
			// automaticly select the dashboard content
			contentMenu[1].select();
			currentButtonSelected = contentMenu[1];
			
			currentContent = contents[1];
			currentContent.x = 0;
			currentContent.visible = true;
			
			loadingPage.hide();
			
		}
		private function createContents():void{
			var dashboardContent:DashboardContent = new DashboardContent();
			var liveContent:LiveContent = new LiveContent();
			var optionsContent:OptionsContent = new OptionsContent();
			
			dashboardContent.visible = false;
			liveContent.visible = false;
			optionsContent.visible = false;
			
			var liveMenuButton:CustomButton = new LiveMenuButtonMovieClip();
			var dashboardMenuButton:CustomButton = new DashboardMenuButtonMovieClip();
			var optionsMenuButton:CustomButton = new OptionMenuButtonMovieClip();
			
			liveMenuButton.setCallBackFunction(liveSelected);
			dashboardMenuButton.setCallBackFunction(dashboardSelected);
			optionsMenuButton.setCallBackFunction(optionSelected);
			
			
			liveContent.id = liveMenuButton.id = 0;
			dashboardContent.id = dashboardMenuButton.id = 1;
			optionsContent.id = optionsMenuButton.id = 2;
			
			contents.push(liveContent);
			contents.push(dashboardContent);
			contents.push(optionsContent);
			// position is meaningfull
			contentMenu.push(liveMenuButton);
			contentMenu.push(dashboardMenuButton);
			contentMenu.push(optionsMenuButton);

			dashboardContent.visible = false;
			liveContent.visible = false;
			optionsContent.visible = false;
			
			optionsMenuButton.y = dashboardMenuButton.y = liveMenuButton.y = dashboardMenuButton.y = DeviceProperties.screenHeight-menuBackground.height;
			dashboardMenuButton.x = 2+(DeviceProperties.screenWidth-dashboardMenuButton.width)/2;
			liveMenuButton.x = 1+10;
			optionsMenuButton.x = -4+DeviceProperties.screenWidth-10-optionsMenuButton.width;
			
			
			
			addChild(liveContent);
			addChild(dashboardContent);
			addChild(optionsContent);
			
			addChild(optionsMenuButton);
			addChild(liveMenuButton);
			addChild(dashboardMenuButton);
		}
		
		
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
		private function liveSelected():void{
			var currentPositionId = currentButtonSelected.id;
			var nextPositionId = 0;
			
			translateContent(currentPositionId,nextPositionId);
			currentButtonSelected.deselect();
			currentButtonSelected = contentMenu[nextPositionId];
			
		}
		private function dashboardSelected():void{
			var currentPositionId = currentButtonSelected.id;
			var nextPositionId = 1;
			
			translateContent(currentPositionId,nextPositionId);
			currentButtonSelected.deselect();
			currentButtonSelected = contentMenu[nextPositionId];
		}
		private function optionSelected():void{
			var currentPositionId = currentButtonSelected.id;
			var nextPositionId = 2;
			
			translateContent(currentPositionId,nextPositionId);
			currentButtonSelected.deselect();
			currentButtonSelected = contentMenu[nextPositionId];
		}
	
		private function backgroundInitalization():void{
			var backgroundFilled:Sprite = new Sprite();
			backgroundContainer.addChild(backgroundFilled);
			var myBitmapData:BitmapData = new backgroundTiled();
			backgroundFilled.graphics.beginBitmapFill(myBitmapData);
			backgroundFilled.graphics.drawRect(0,0,DeviceProperties.screenWidth,DeviceProperties.screenHeight);
			backgroundFilled.graphics.endFill();
			menuBackground.y = DeviceProperties.screenHeight - menuBackground.height;
			menuBackground.x = 0;
		}
		
		private function addLoadingPage():void{
			loadingPage = new LoadingPage();
			addChild(loadingPage);
		}
	}
}