package
{
	import com.nicolabortignon.moodlight.Facade;
	import com.nicolabortignon.moodlight.controller.DeviceProperties;
	import com.nicolabortignon.moodlight.view.ContentHolder;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.system.Capabilities;
	
	public class iOSDocumentClass extends Sprite
	{
		
		private var contentHolder:ContentHolder;
		
		public function iOSDocumentClass()
		{
			Facade.sharedInstance();
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			this.addEventListener(Event.ADDED_TO_STAGE, init);			
		}
		
		
		private function init(e:Event) :void {
 
			 DeviceProperties.retriveValues(this.stage);
			 
			 addView();
			// adjust the gui to fit the new device resolution
		}
		
		private function addView():void{
	//		DeviceProperties.screenWidth = 768;
		//	DeviceProperties.screenWidth = 480;//480;
		//	DeviceProperties.screenHeight = 838;
			var defaultRatio:Number = 960/640;
			var currentDeviceRatio:Number = DeviceProperties.screenHeight/DeviceProperties.screenWidth;
			// the ratio between the developed ratio and the device ratio
			var alpha = defaultRatio/currentDeviceRatio;
			// the % of scaling to applay to the stage
			var beta = DeviceProperties.screenWidth/640;
			var newHeight:int = DeviceProperties.screenHeight/beta;
			DeviceProperties.screenHeight = newHeight;
			DeviceProperties.alphaRatio = beta;
			
			
			contentHolder = new ContentHolder();
			this.addChild(contentHolder);
			contentHolder.init();
			// TEST
			contentHolder.scaleX = DeviceProperties.screenWidth/640;
			contentHolder.scaleY = contentHolder.scaleX;
	
		}
	}
}