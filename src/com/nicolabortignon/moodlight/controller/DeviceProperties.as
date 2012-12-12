package com.nicolabortignon.moodlight.controller
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.system.Capabilities;
	
	public class DeviceProperties
	{
		
		
		/** Only one instance of the model locator **/
		
		private static var instance:DeviceProperties = new DeviceProperties();
		
		/** Bindable Data **/
		
		public static var screenHeight:int;
		public static var screenWidth:int;
		public static var screenDPI:int;
		public static var alphaRatio:Number;
		public function DeviceProperties()
		{
			if(instance)
			{
				throw new Error ("We cannot create a new instance Please use DeviceProperties.getInstance()");
			}
		}
		
		public static function getInstance():DeviceProperties
		{
			if(instance)
				instance = new DeviceProperties();
			return instance;
		}
		
		
		public static function retriveValues(s:Stage):String{
			screenHeight = Capabilities.screenResolutionY;
			screenWidth = Capabilities.screenResolutionX;
			screenDPI = Capabilities.screenDPI;
			
			
			// TODO:  FOR Testing purpose only
		/*	screenHeight = 900;
			screenWidth = 640;
			*/
			trace(""+screenWidth+"("+Capabilities.screenResolutionX+")"+"x"+screenHeight+"("+Capabilities.screenResolutionY+")"+"@"+screenDPI);
			return ""+screenWidth+"("+Capabilities.screenResolutionX+")"+"x"+screenHeight+"("+Capabilities.screenResolutionY+")"+"@"+screenDPI;
		}
	}
}
