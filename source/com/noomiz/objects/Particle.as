package com.noomiz.objects
{
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class Particle extends Sprite
	{
		private var _speedX:Number;
		private var _speedY:Number;
		private var _spin:Number;
		private var _nbanim:Number;
		
		private var _image:Image;
		
		public function Particle()
		{
			super();
			_image=new Image(PowerUpFactory.getTxt(PowerUpFactory.IMGSTAR32));
		//	_image.x=_image.width*0.5;
		//	_image.y=_image.height*0.5;
			_image.pivotX=_image.width*0.5;
			_image.pivotY=_image.height*0.5;
			_nbanim=0;
			this.addChild(_image);
			
		}
		public function get speedX():Number
		{
			return _speedX;
		}
		
		public function set speedX( unspeedx:Number):void
		{
			_speedX = unspeedx;
		}
		public function get speedY():Number
		{
			return _speedY;
		}		
		public function set speedY( unspeedy:Number):void
		{
			_speedY = unspeedy;
		}
		public function get spin():Number
		{
			return _spin;
		}
		
		public function set spin( unspin:Number):void
		{
			_spin = unspin;
		}
		public function get nbanim():Number
		{
			return _nbanim;
		}
		
		public function set nbanim( unnbanim:Number):void
		{
			_nbanim = unnbanim;
		}
		
	}
}