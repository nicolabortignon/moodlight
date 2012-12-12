package com.nicolabortignon.moodlight.view.page.dashboard
{
	import com.nicolabortignon.moodlight.Facade;
	import com.nicolabortignon.moodlight.controller.DeviceProperties;
	import com.nicolabortignon.moodlight.view.page.Page;
	import com.nicolabortignon.moodlight.view.page.dashboard.switcher.Switcher;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class SwitchPage extends Page
	{
		
		public const XML_PATH:String = "";
		
		public var switchers:Vector.<Switcher>;
		public var addNewSwitchButton:MovieClip;
		
		private var _onPushCounter:Number = 0;
		private const keepPushConstant:Number = 1;  //in seconds;
		private var _id:int;
		
		private var _currentState:int;
		
		private const NORMAL_STATE:int = 0;
		private const DELETE_SWITCH_STATE:int = 1;
		
		public var logger:TextField;
		
		public function SwitchPage()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, debugStage);
			loadSwitchesInformation();
			renderSwitch();
			
			addNewSwitchButton.addEventListener(MouseEvent.CLICK, addNewSwitch);
			_currentState = NORMAL_STATE;
			
			
		}
		
		private function debugStage(e:Event):void{
			logger.text = "test 2";//DeviceProperties.retriveValues(this.stage);
		}
		
		public function addNewSwitch(e:MouseEvent):void{
			if(_currentState == NORMAL_STATE){
				// add new swtich
				Facade.dispatchAnEvent("AddNewSwitch");
			} else {
				// functionality inibited 
			}
			
		}
		public function get id():int
		{
			return _id;
		}

		public function set id(value:int):void
		{
			_id = value;
		}

		private function renderSwitch(){
			for(var i:int = 0 ; i < switchers.length; i++){
				
				addChild(switchers[i]);
				switchers[i].x = 35+200*(i%3);
				switchers[i].y = 100+ 180*int(i/3);
				switchers[i].addEventListener(MouseEvent.MOUSE_DOWN, downOnSwitch);
				switchers[i].id = i;
			}
		}
		
		private function downOnSwitch(e:MouseEvent):void{
			if(_currentState == NORMAL_STATE){
				_onPushCounter = 0 ;
				this.addEventListener(Event.ENTER_FRAME, count);
				this.stage.addEventListener(MouseEvent.MOUSE_UP, upOnSwitch);	
			} else {
				if( (e.target as Switcher).removeSwitch.hitTestPoint(mouseX,mouseY)){
					// remove switcher
					var switcher:Switcher =  switchers.splice(e.target.id,1)[0];
					
					switcher.parent.removeChild(switcher);
					switcher.removeEventListener(MouseEvent.MOUSE_DOWN, downOnSwitch);
					// moves switchers
					for(var i:int = 0 ; i < switchers.length; i++){
						switchers[i].id = i;
						switchers[i].x = 35+200*(i%3);
						switchers[i].y = 100+ 180*int(i/3);
					}
				}else{
					
					// remove the delete phase
					
					_currentState = NORMAL_STATE;
					for each(var s:Switcher in switchers){
						s.hideRemover();
					}
				}
				
			}
		}
		private function upOnSwitch(e:MouseEvent):void{
			trace("COUNTER");
			this.removeEventListener(Event.ENTER_FRAME, count);
			this.stage.removeEventListener(MouseEvent.MOUSE_UP, upOnSwitch);	
			(e.target as Switcher).switchOn();
		}
		private function count(e:Event):void{
			_onPushCounter += 1/this.stage.frameRate;
			trace(_onPushCounter);
			if(_onPushCounter > keepPushConstant){
				_currentState = DELETE_SWITCH_STATE;
				this.removeEventListener(Event.ENTER_FRAME, count);
				this.stage.removeEventListener(MouseEvent.MOUSE_UP, upOnSwitch);	
				for(var i:int = 0 ; i < switchers.length; i++){
					switchers[i].showRemover();
				}
			} 
		}
		private function loadSwitchesInformation():void{
			switchers = new Vector.<Switcher>();
			
			var s1:Switcher = new Switcher();
			var s2:Switcher = new Switcher();
			var s3:Switcher = new Switcher();
			
			s1.labelName = "Bed Room";
			s2.labelName = "Living Room Front";
			s3.labelName = "Living Tv";
			
			switchers.push(s1);
			switchers.push(s2);
			switchers.push(s3);
			
		}
		
		private function readSwitchesInformation():void{
			
		}
	}
}