package com.nicolabortignon.moodlight.view.page.dashboard
{
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.nicolabortignon.colourlib.Colours;
	import com.nicolabortignon.moodlight.Facade;
	import com.nicolabortignon.moodlight.controller.DeviceProperties;
	import com.nicolabortignon.moodlight.view.page.Page;
	
	import fl.motion.Color;
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	import flash.ui.Mouse;
	
	
	public class ChooseColorPage extends Page
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
		
		public var recentColor4:RecentColorPicker;
		public var recentColor3:RecentColorPicker;
		public var recentColor2:RecentColorPicker;
		public var recentColor1:RecentColorPicker;
		
		public var _angle:int;
		public var _coordinates:Point;
		public var _color:uint;
		
		public var _currentHue:int;
		public var _currentSaturation:Number;
		public var _currentLuminance:Number;
		
		var s:Shape = new Shape();
		public function ChooseColorPage()
		{
			super();
			syncButton.buttonMode = shotButton.buttonMode = nextButton.buttonMode = backButton.buttonMode = true;
			syncButton.mouseChildren = shotButton.mouseChildren = nextButton.mouseChildren = backButton.buttonMode = false;
			syncButton.useHandCursor = shotButton.useHandCursor = nextButton.useHandCursor = backButton.useHandCursor = true;
			
			circleGridMovieClip.buttonMode = true;
			circleGridMovieClip.mouseChildren = false;
			circleGridMovieClip.useHandCursor = true;
			
			circleGridMovieClip.addEventListener(MouseEvent.MOUSE_MOVE, angleCoordinates);
			hueColorMatrix = new HueColorMatrixFilter();
			hueColorMatrix.Hue = 140;
			
			triangle.filters = [hueColorMatrix.Filter];
			gotoColor(-9,new Point(252,146));
			
			nextButton.addEventListener(MouseEvent.CLICK, nextButtonHandler);
			backButton.addEventListener(MouseEvent.CLICK, backButtonHandler);
			
			triangle.hiddenTriangle.addEventListener(MouseEvent.MOUSE_MOVE, movePicker);
			
			warmLight.addEventListener(MouseEvent.CLICK, warmLightHandler);
			pureLight.addEventListener(MouseEvent.CLICK, pureLightHandler);
			coldLight.addEventListener(MouseEvent.CLICK, coldLightHandler);	
			
			_liveActive = false;
			syncButton.addEventListener(MouseEvent.CLICK, liveButtonHandler);
			shotButton.addEventListener(MouseEvent.MOUSE_DOWN, shotButtonHandler);
			shotButton.addEventListener(MouseEvent.MOUSE_UP, shotButtonHandlerUp);
			
			recentColor4.buttonMode = recentColor3.buttonMode = recentColor2.buttonMode = recentColor1.buttonMode = true;
			recentColor4.useHandCursor = recentColor3.useHandCursor = recentColor2.useHandCursor = recentColor1.useHandCursor = true;
			recentColor4.mouseChildren = recentColor3.mouseChildren = recentColor2.mouseChildren = recentColor1.mouseChildren = false;
			
			recentColor1.addEventListener(MouseEvent.CLICK, selectRecentColor);
			recentColor2.addEventListener(MouseEvent.CLICK, selectRecentColor);
			recentColor3.addEventListener(MouseEvent.CLICK, selectRecentColor);
			recentColor4.addEventListener(MouseEvent.CLICK, selectRecentColor);
			addChild(s);
		}
				
		private function selectRecentColor(e:MouseEvent):void{
			var recentColor:RecentColorPicker = e.target as RecentColorPicker;
			if(recentColor.hasAColor){
				gotoColor(recentColor.angle,recentColor.coordinates);
				var oHSL:Object = Colours.getHSL(recentColor.theColor);
				trace(oHSL.h,oHSL.l,oHSL.s);
				_currentHue = oHSL.h;
				_currentLuminance = oHSL.l/100;
				_currentSaturation = oHSL.s/100;
				
			}
		}
		private function shotButtonHandlerUp(e:MouseEvent):void{
			shotButton.gotoAndStop(1);
		}
		private function shotButtonHandler(e:MouseEvent):void{
			shotButton.gotoAndStop(2);
			if(_liveActive == true){
				_liveActive = false;
				syncButton.gotoAndStop(1);
			}
				
				if(recentColor3.hasAColor){
					recentColor4.angle = recentColor3.angle;
					recentColor4.coordinates = recentColor3.coordinates;
					recentColor4.drawCircle(recentColor3.theColor);
				}
				if(recentColor2.hasAColor){
					recentColor3.angle = recentColor2.angle;
					recentColor3.coordinates = recentColor2.coordinates;
					recentColor3.drawCircle(recentColor2.theColor);
				}
				if(recentColor1.hasAColor){
					recentColor2.angle = recentColor1.angle;
					recentColor2.coordinates = recentColor1.coordinates;
					recentColor2.drawCircle(recentColor1.theColor);
				}
				recentColor1.angle = _angle;
				recentColor1.coordinates = _coordinates;

				var oRGB:Object = Colours.hslToRgb({h:_currentHue,s:(_currentSaturation*100),l:(_currentLuminance*100)});
			
				recentColor1.drawCircle(Colours.getHex(oRGB.r,oRGB.g,oRGB.b));
				
			
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
			trace(_currentSaturation,_currentLuminance);
			
			TweenMax.to(triangle.picker, .5, {colorMatrixFilter:{saturation:(e.target.mouseX/255),brightness:0+(e.target.mouseY/100)}});
		}
		private function nextButtonHandler(e:MouseEvent):void{
			Facade.dispatchAnEvent("NEXT_FROM_COLOR_PAGE");
		}
		private function backButtonHandler(e:MouseEvent):void{
			Facade.dispatchAnEvent("BACK_FROM_COLOR_PAGE");
		}
		private function angleCoordinates(e:MouseEvent):void{
			
			s.graphics.clear();
			s.graphics.beginFill(0xff0000);
			trace(stage.mouseX,e.target.mouseX,stage.mouseY);
			var currentCenter:Point = new Point(circleGridMovieClip.x,circleGridMovieClip.y);
			var centralPoint:Point = new Point(-20+currentCenter.x+circleGridMovieClip.width/2, currentCenter.y + circleGridMovieClip.height/2);
			
			var distanceX = (stage.mouseX/DeviceProperties.alphaRatio) - centralPoint.x;
			var distanceY = (stage.mouseY/DeviceProperties.alphaRatio) - centralPoint.y; 

			s.graphics.drawCircle(centralPoint.x,centralPoint.y,15);
			s.graphics.drawCircle(stage.mouseX/DeviceProperties.alphaRatio,stage.mouseY/DeviceProperties.alphaRatio,15);
			
			var angleInRadians:Number = Math.atan2(distanceY, distanceX);
			var angleInDegrees:Number = -angleInRadians * (180 / Math.PI);
			trace(">>>>>>>>>>>>>>>>>>>>>>",angleInDegrees);
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