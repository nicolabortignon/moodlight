package com.nicolabortignon.moodlight.view.page.dashboard.switcher
{
	import com.nicolabortignon.moodlight.controller.SocketConnection;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.net.Socket;
	import flash.text.TextField;
	
	public class Switcher extends MovieClip
	{
		private var _isOn:Boolean = false;
		private var _labelName:String;
		private var _icondId:int;
		
		public var removeSwitch:MovieClip;
		public var labelTextField:TextField;
		
		public var lights:Vector.<Boolean>;
		public var iconSwitch:MovieClip;
		public var r:int;
		public var g:int;
		public var b:int;
		
		public function Switcher()
		{
			super();
			this.buttonMode = true;
			this.mouseChildren = false;
			this.useHandCursor = true;
			
			removeSwitch.visible = false;
		}
		
		public function selectIcon(i:int):void{
			iconSwitch.gotoAndStop(i);
			iconSwitch.backgroundOff.visible = false;
		    iconSwitch.backgroundOn.visible = false;
		}
		public function get labelName():String
		{
			return _labelName;
		}

		public function showRemover():void{
			removeSwitch.visible = true;
			
		}
		public function hideRemover():void{
			removeSwitch.visible = false;
		}
		public function set labelName(value:String):void
		{
			labelTextField.text = value;
		}

		public function get isOn():Boolean
		{
			return _isOn;
		}

		public function set isOn(value:Boolean):void
		{
			_isOn = value;
		}

		public function get icondId():int
		{
			return _icondId;
		}

		public function set icondId(value:int):void
		{
			_icondId = value;
		}

		public function switchOn():void{
			if(_isOn){
				_isOn = false;
				if(lights[0] == true)
					SocketConnection.sendColor(0,0,0);
				this.gotoAndStop(1);
			} else {
				if(lights[0] == true)
					SocketConnection.sendColor(r,g,b);
				_isOn = true;
				this.gotoAndStop(2);
			}
		}
	}
}