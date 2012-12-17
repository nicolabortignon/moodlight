package com.nicolabortignon.moodlight.controller
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.utils.getTimer;
	
	public class SocketConnection extends MovieClip
	{
		public var socket:Socket = new Socket();
		private static var _instance:SocketConnection=null;
		private static var _lastError:uint;
		private static var queue:Vector.<String>;
		public function SocketConnection()
		{
			trace("new socket");
			
		}
		public static function getInstance():SocketConnection{
			if(_instance==null){
				queue = new Vector.<String>();
				_instance=new SocketConnection();
				_instance.socket.addEventListener(Event.CLOSE, closeHandler);
				_instance.socket.addEventListener(Event.CONNECT, connectHandler);
				_instance.socket.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
				_instance.socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
				_instance.socket.addEventListener(ProgressEvent.SOCKET_DATA, socketDataHandler);
				_instance.socket.connect("192.168.1.177",1111);
			}
			return _instance;
		}
		public static function sendColor(r:int,g:int,b:int){
			if(r < 5) r = 0;
			if(g < 5) g = 0;
			if(b < 5) b = 0;
			
			var s:String = fillzero(r.toString())+fillzero(g.toString())+fillzero(b.toString());
			trace(s);
			if(_instance.socket.connected){
				_instance.socket.writeUTF(s);
				_instance.socket.flush();
			} else {
				if(queue.length > 100){
					queue.shift();
				} 
					queue.push(s);
				trace(queue.length);
			}
		}
		public static function connectHandler(e:Event):void{
			
			trace("flush out coda");
		}
		public static function fillzero(i:String):String{
			if(i.length == 1){
				return "00"+i;
			} else if (i.length == 2){
				return "0"+i;
			} else {
				return i;
			}
		}
		
		public static function readResponse():void {
			//var str:String = _instance.socket.readUTFBytes(socket.bytesAvailable);
			//trace(str);
		}
		
		public static function closeHandler(event:Event):void {
			trace("closeHandler: " + event);
		
		}
		
		public static function ioErrorHandler(event:IOErrorEvent):void {
			trace("ioErrorHandler: " + event);
			_lastError = getTimer();
			_instance.addEventListener(Event.ENTER_FRAME, retryConnecting);
			
		}
		
		private static function retryConnecting(e:Event):void{
			if((getTimer()-_lastError) > 5000){
				_instance.removeEventListener(Event.ENTER_FRAME, retryConnecting);
				_instance.socket.connect("192.168.1.177",1111);
				trace("RIPROVO LA CONNESSIONE");
			} else {
				
			}
		}
		public static function securityErrorHandler(event:SecurityErrorEvent):void {
			trace("securityErrorHandler: " + event);
		}
		
		public static function socketDataHandler(event:ProgressEvent):void {
			trace("socketDataHandler: " + event);
			readResponse();
		}
		
	}
}
