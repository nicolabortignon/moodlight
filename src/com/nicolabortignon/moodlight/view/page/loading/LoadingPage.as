package com.nicolabortignon.moodlight.view.page.loading
{
	import com.nicolabortignon.moodlight.Facade;
	import com.nicolabortignon.moodlight.controller.DeviceProperties;
	import com.nicolabortignon.moodlight.view.page.Page;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	
	public class LoadingPage extends Page
	{
		public var loadingGlobe:MovieClip;
		public var statusAdvance:TextField;
		
		private var valueToReach:int;
		
		private var counter:int;
		public function LoadingPage()
		{
			super();
			
			
		}
		override public function renderPage():void{
			// center the globe
			
			loadingGlobe.x = (DeviceProperties.screenWidth-loadingGlobe.width)/2;
			loadingGlobe.y = (DeviceProperties.screenHeight)/2-(250);
			statusAdvance.x = (DeviceProperties.screenWidth-statusAdvance.width)/2;
			statusAdvance.y = (DeviceProperties.screenHeight-100);
			
			this.addEventListener(Event.ENTER_FRAME, update);
		}

		override public function hide():void{
			this.alpha = 0 ;
			this.visible = false;
		}
		
		private function update(e:Event):void{
			loadingGlobe.percentuage.text = counter+"%";
			if(counter == valueToReach){ 
				this.removeEventListener(Event.ENTER_FRAME, update);
			}
			counter++;
		}
		public function updatePercentuage(advancement:int,status:String=null):void{
			
			valueToReach = advancement;
			if(valueToReach > counter)
				addEventListener(Event.ENTER_FRAME, update);
		
			
			if(status != null){
				statusAdvance.text = status;
			}
			
		}
		
	}
}