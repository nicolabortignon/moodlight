package com.nicolabortignon.moodlight
{
	public class Facade
	{
		
		private static var _instance:Facade = null;
		
		
		private static var registeredEvent:Array;
		
		public function Facade()
		{
			
			registeredEvent = new Array();
		}
		public static function sharedInstance():Facade {
			if (_instance == null) {
				_instance = new Facade();
			}
			return _instance;
		}
		
		
		public static function registerToAnEvent(eventName:String,callbackFunction:Function):void{
			var obj:Object = {name:eventName,callback:callbackFunction};
			
			registeredEvent.push(obj);
		}
		public static function dispatchAnEvent(eventName:String):void{
			for(var i:int = 0; i< registeredEvent.length; i++){
				if(registeredEvent[i].name == eventName)
					registeredEvent[i].callback();
				
			}
		}
	}
	
}