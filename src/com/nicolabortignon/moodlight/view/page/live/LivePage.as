package com.nicolabortignon.moodlight.view.page.live
{
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.nicolabortignon.colourlib.Colours;
	import com.nicolabortignon.moodlight.Facade;
	import com.nicolabortignon.moodlight.controller.DeviceProperties;
	import com.nicolabortignon.moodlight.view.page.Page;
	import com.nicolabortignon.moodlight.view.page.dashboard.HueColorMatrixFilter;
	
	import fl.motion.Color;
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	import flash.ui.Mouse;
	
	
	public class LivePage extends Page
	{
		public var circleGridMovieClip:MovieClip;
		
		public var wheelCursor:MovieClip;
		public var distanceFromCenter:int = 226;
		public var triangle:MovieClip;
		
		public var hueColorMatrix:HueColorMatrixFilter;
		public var nextButton:MovieClip;
		public var backButton:MovieClip;
		
		public var warmLight:MovieClip;
		public var pureLight:MovieClip;
		public var coldLight:MovieClip;
		
		public var shotButton:MovieClip;
		public var syncButton:MovieClip;
		
		public var _liveActive:Boolean;
		
		
		public var _angle:int;
		public var _coordinates:Point;
		public var _color:uint;
		
		public var _currentHue:int;
		public var _currentSaturation:Number;
		public var _currentLuminance:Number;
		
		var s:Shape = new Shape();
		public function LivePage()
		{
			super();
			
			circleGridMovieClip.buttonMode = true;
			circleGridMovieClip.mouseChildren = false;
			circleGridMovieClip.useHandCursor = true;
			
			circleGridMovieClip.addEventListener(MouseEvent.MOUSE_MOVE, angleCoordinates);
			hueColorMatrix = new HueColorMatrixFilter();
			hueColorMatrix.Hue = 140;
			
			triangle.filters = [hueColorMatrix.Filter];
			
			// INITIALIZE TO A COLOR
			gotoColor(-9,new Point(252,146));
			_currentHue = 277;
			_currentSaturation = 1;
			_currentLuminance = 0.4693;
			
			
			triangle.hiddenTriangle.addEventListener(MouseEvent.MOUSE_MOVE, movePicker);
			
			warmLight.addEventListener(MouseEvent.CLICK, warmLightHandler);
			pureLight.addEventListener(MouseEvent.CLICK, pureLightHandler);
			coldLight.addEventListener(MouseEvent.CLICK, coldLightHandler);	
			
			_liveActive = true;
			
			for(var i:int = 0 ; i<15; i++){
				var livebtn:MovieClip = new LiveButton();
				livebtn.x = 50+(115*(i%5));
				livebtn.y = 600+80*int(i/5);
				livebtn.buttonOn.visible = false;
				livebtn.buttonOn.gotoAndStop(i+1);
				livebtn.buttonOff.gotoAndStop(i+1);
				livebtn.mouseChildren = false;
				
				addChild(livebtn);
				
				livebtn.addEventListener(MouseEvent.CLICK, clickedHandler);
				
			}
		}
		
		
		private function clickedHandler(e:MouseEvent):void{
			if((e.target as MovieClip).buttonOff.visible){
				e.target.buttonOn.visible = true;
				e.target.buttonOff.visible = false;
			} else {
				e.target.buttonOn.visible = false;
				e.target.buttonOff.visible = true;
			}
		}
		private function shotButtonHandlerUp(e:MouseEvent):void{
			shotButton.gotoAndStop(1);
		}
	
		private function liveButtonHandler(e:MouseEvent):void{
			if(_liveActive == false){
				_liveActive = true;
				syncButton.gotoAndStop(2);
			}else{
				_liveActive = false;
				syncButton.gotoAndStop(1);
			}
		}
		
		private function warmLightHandler(e:MouseEvent):void{
			var o:Object = Colours.getHSL(0xfaecce);
			_currentHue = o.h;
			_currentLuminance = o.l/100;
			_currentSaturation = o.s/100;
			trace(o.h,o.l,o.s);
			gotoColor(-150,new Point(45,265));
			
		}
		private function pureLightHandler(e:MouseEvent):void{
			var o:Object = Colours.getHSL(0xffffff);
			_currentHue = o.h;
			_currentLuminance = o.l/100;
			_currentSaturation = o.s/100;
			
			gotoColor(168,new Point(8,288));
		}
		private function coldLightHandler(e:MouseEvent):void{
			var o:Object = Colours.getHSL(0xe7f5fb);
			_currentHue = o.h;
			_currentLuminance = o.l/100;
			_currentSaturation = o.s/100;
			gotoColor(72,new Point(39,268));
		}
		
		private function gotoColor(angle:int, pickerPosition:Point):void{
			triangle.picker.x = pickerPosition.x-90;
			triangle.picker.y = pickerPosition.y-150;
			
			_coordinates = new Point(pickerPosition.x,pickerPosition.y);
			
			TweenMax.to(triangle.picker, .5, {colorMatrixFilter:{saturation:(pickerPosition.x/255),brightness:0+(pickerPosition.y/100)}});
			
			var rotationAngle:int = angle;
			var angleInDegrees:int = -angle;
			var currentCenter:Point = new Point(circleGridMovieClip.x,circleGridMovieClip.y);
			var centralPoint:Point = new Point(currentCenter.x+circleGridMovieClip.width/2, currentCenter.y + circleGridMovieClip.height/2);
			
			
			if(angleInDegrees<50 && angleInDegrees>0){
				angleInDegrees = 50-angleInDegrees;
			}else if(angleInDegrees <= 0){
				angleInDegrees = -angleInDegrees+50;
			} else if(angleInDegrees > 128){
				angleInDegrees = 230 + (180-angleInDegrees);
			}
			var hueAngle:int = (280-angleInDegrees)/280*340;
			wheelCursor.rotation = -angle-15;
			var angleInRadians = - (angle+17) * (Math.PI/180);
			
			wheelCursor.x = (centralPoint.x-19) + distanceFromCenter*Math.cos(angleInRadians);
			wheelCursor.y = (centralPoint.y+9)+ distanceFromCenter*Math.sin(angleInRadians);
			
			
			_angle = angle; 
			TweenMax.to(triangle.picker, .5,{shortRotation:{rotationZ:angle+15}});
			TweenMax.to(triangle, .5, {shortRotation:{rotationZ:-angle-15},colorMatrixFilter:{hue:hueAngle}});
		}
		
		private function movePicker(e:MouseEvent):void{
			//	trace(e.target.mouseX,e.target.mouseY);
			triangle.picker.x = e.target.mouseX-90;
			triangle.picker.y = e.target.mouseY-150;
			_coordinates = new Point( e.target.mouseX, e.target.mouseY);
			
			_currentSaturation = e.target.mouseX/255;
			if(_currentSaturation > 1) _currentSaturation = 1;
			_currentLuminance = e.target.mouseY/300;
			
			TweenMax.to(triangle.picker, .5, {colorMatrixFilter:{saturation:(e.target.mouseX/255),brightness:0+(e.target.mouseY/100)}});
		}
		private function nextButtonHandler(e:MouseEvent):void{
			Facade.dispatchAnEvent("NEXT_FROM_COLOR_PAGE");
		}
		private function backButtonHandler(e:MouseEvent):void{
			Facade.dispatchAnEvent("BACK_FROM_COLOR_PAGE");
		}
		private function angleCoordinates(e:MouseEvent):void{
			
			/*			s.graphics.clear();
			s.graphics.beginFill(0xff0000); */
			
			
			var currentCenter:Point = new Point(circleGridMovieClip.x,circleGridMovieClip.y);
			var centralPoint:Point = new Point(-20+currentCenter.x+circleGridMovieClip.width/2, currentCenter.y + circleGridMovieClip.height/2);
			
			var distanceX = (stage.mouseX/DeviceProperties.alphaRatio) - centralPoint.x;
			var distanceY = (stage.mouseY/DeviceProperties.alphaRatio) - centralPoint.y; 
			/*
			s.graphics.drawCircle(centralPoint.x,centralPoint.y,15);
			s.graphics.drawCircle(stage.mouseX/DeviceProperties.alphaRatio,stage.mouseY/DeviceProperties.alphaRatio,15);
			*/	
			var angleInRadians:Number = Math.atan2(distanceY, distanceX);
			var angleInDegrees:Number = -angleInRadians * (180 / Math.PI);
			//	trace(angleInDegrees,Math.cos(angleInRadians),Math.sin(angleInRadians));
			
			wheelCursor.rotation = -angleInDegrees;
			
			wheelCursor.x = (centralPoint.x) + distanceFromCenter*Math.cos(angleInRadians);
			wheelCursor.y = (centralPoint.y+9)+ distanceFromCenter*Math.sin(angleInRadians);
			
			// SHAME ON ME FOR THE FOLLOWING CODE!		
			var rotationAngle:int = angleInDegrees;
			angleInDegrees = -angleInDegrees;
			if(angleInDegrees<50 && angleInDegrees>0){
				angleInDegrees = 50-angleInDegrees;
			}else if(angleInDegrees <= 0){
				angleInDegrees = -angleInDegrees+50;
			} else if(angleInDegrees > 128){
				angleInDegrees = 230 + (180-angleInDegrees);
			}
			var hueAngle:int = (280-angleInDegrees)/280*340;
			// rotation should be in the range of 0 - 360 ! 
			_angle = rotationAngle-18;
			_currentHue = hueAngle;
			
			TweenMax.to(triangle.picker, .5,{shortRotation:{rotationZ:rotationAngle}});
			TweenMax.to(triangle, .5, {shortRotation:{rotationZ:-rotationAngle},colorMatrixFilter:{hue:hueAngle}});
			// angle in 0 - 280
			
			//trace(stage.mouseX,"-",centralPoint.x," | ", stage.mouseY,"-",centralPoint.y);
		}
	}
}
