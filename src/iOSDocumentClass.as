package
{
	import com.nicolabortignon.moodlight.Facade;
	import com.nicolabortignon.moodlight.controller.DeviceProperties;
	import com.nicolabortignon.moodlight.view.ContentHolder;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	public class iOSDocumentClass extends Sprite
	{
		
		private var contentHolder:ContentHolder;
		
		public function iOSDocumentClass()
		{
			Facade.sharedInstance();
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			DeviceProperties.retriveValues();
			
			
			addView();
		}
		
		private function addView():void{
			contentHolder = new ContentHolder();
			this.addChild(contentHolder);
		}
	}
}