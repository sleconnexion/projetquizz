package com.noomiz.objects
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class Carte extends Sprite
	{
		private var _numsymbol:Number;		
		private var _numposition:Number;		
		private var _imagerecto:Image;
		private var _imageverso:Image;
		private var _delay:Timer=new Timer(200,1);
		
		public function Carte(znum:Number,zpos:Number):void
		{
			super();
			//width=91;
			//height=91;
			_numsymbol=znum;
			_numposition=zpos;			
			trace("znum:"+znum);
			_imageverso=new Image(PowerUpFactory.getTxt("x"+znum));
			_imagerecto=new Image(PowerUpFactory.getTxt(PowerUpFactory.IMGOFF));
			_imageverso.visible=false;
			_imagerecto.visible=true;
//			_imagerecto.width=_imagerecto.height=50;
//			_imageverso.width=_imageverso.height=50;
			//	_image.x=_image.width*0.5;
		//	_image.y=_image.height*0.5;
//x			_imageverso.pivotX=_imageverso.width*0.5;
//x			_imageverso.pivotY=_imageverso.height*0.5;
//x			_imagerecto.pivotX=_imagerecto.width*0.5;
//x			_imagerecto.pivotY=_imagerecto.height*0.5;
			addChild(_imageverso);
			addChild(_imagerecto);
//			this.pivotX=20;
			//this.pivotY=45;
//			width=height=50;
			_delay.addEventListener(TimerEvent.TIMER, fermer);
			useHandCursor=true;
			
			
		}
		public function retourner():void{
			this._imagerecto.visible=false;
			this._imageverso.visible=true;			
		}

		private function fermerx():void{
			this._imagerecto.visible=true;
			this._imageverso.visible=false;					
		}
		public function demarrerfermer(){
			_delay.start();			
		}
		private function fermer(evt:TimerEvent):void{
			
			// ajout d un effet acec delai
			var tween:Tween = new Tween(this, 0.1, Transitions.EASE_IN_OUT);
			var tween2:Tween = new Tween(this, 0.05, Transitions.EASE_IN_OUT);
			var tween3:Tween = new Tween(this, 0.1, Transitions.EASE_IN_OUT);
			//tween.animate("x", mc.x + mc.width);
			tween.animate("scaleX",1);//0
			//				tween.animate("rotation", mc.rotation-Math.PI/2);
			//				mc.texture=PowerUpFactory.getTxt("x2");
			tween.onComplete=fermerx;

			tween2.animate("scaleX", 1);
			//tween2.onComplete=sonok;
			//tween.animate("rotation", Math.PI/4);
			//			tween.fadeTo(0);    // equivalent to 'animate("alpha", 0)'
			//			tween2.fadeTo(1);    // equivalent to 'animate("alpha", 0)'
			tween.nextTween=tween2;
			Starling.juggler.add(tween);
		}
		public function get numsymbol():Number
		{
			return _numsymbol;
		}
		
		public function set numsymbol( unnumsymbol:Number):void
		{
			_numsymbol = unnumsymbol;
		}
		public function get numposition():Number
		{
			return _numposition;
		}
		
		public function set numposition( unnumposition:Number):void
		{
			_numposition = unnumposition;
		}
		public function afficher():String{
			return "carte["+_numsymbol+","+_numposition+"]";
		}
	}
}