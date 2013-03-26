package com.noomiz.screens
{
	import com.noomiz.objects.Particle;
	import com.noomiz.objects.Partie;
	import com.noomiz.sounds.MemoryHome;
	
	import flash.events.TimerEvent;
	import flash.media.SoundChannel;
	import flash.system.System;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import mx.managers.SystemManager;
	
	import feathers.controls.Button;
	import feathers.controls.Callout;
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.controls.TextInput;
	import feathers.display.TiledImage;
	import feathers.themes.OMDesktopTheme;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.deg2rad;
	
 
	[Event(name="complete",type="starling.events.Event")]
	
	public class QuizzScreen extends Screen
	{
				
		[Embed(source="/../assets/images/Fond-violet.png")]
		private static const FOND_VIOLET:Class;
		
		private var _button:Button;
		private var _buttonraccourci:Button;
		private var _header:Header;
		private var _backButton:Button;
		private var _input:TextInput;
		private var _label:Label;
		private var _label2:Label;
		private var _labeltimer:Label;
		
		private var _tick:Number=0;
		private var _snd:MemoryHome;
		private var _maclock:Timer = new Timer(1000,0);
		private var _maclockpts:Timer = new Timer(50,0);
		
		private var _quizz:Quizz;

		public var partie:Partie;

		private var _zz:uint;
		private var maParticlesToAnimate:Vector.<Particle>;

		public function QuizzScreen()
		{
			super();
		}
		
		override protected function initialize():void
		{
//			var txtviolet:Texture=Texture.fromBitmap(new FOND_VIOLET);			
	
			var xbg:Image=Image.fromBitmap(new FOND_VIOLET);
			addChild(xbg);

			var txtviolet:Texture=Texture.fromBitmap(new FOND_VIOLET);			
			var xx:TiledImage=new TiledImage(txtviolet);
			addChild(xx);
			
			var titre:Label=new Label();
			titre.nameList.add(OMDesktopTheme.ALTERNATE_NAME_OM_CUSTOM_QUIZZTITRE);
			titre.text="QUIZZ";
			titre.x=25;
			titre.y=15;
			addChild(titre);
			
			var btn_fermer:Button=new Button();
			btn_fermer.nameList.add(OMDesktopTheme.ALTERNATE_NAME_MY_CUSTOM_BUTTON_FERMER);
			btn_fermer.x=420;
			addChild(btn_fermer);

			
			
			
			this._maclock.addEventListener(TimerEvent.TIMER, fnticker);
			this._maclockpts.addEventListener(TimerEvent.TIMER, fnscore);
			maParticlesToAnimate=new Vector.<Particle>();
			
			this._snd=new MemoryHome();
			this._label = new Label();
			this._label2 = new Label();
			this._label2.nameList.add(OMDesktopTheme.ALTERNATE_NAME_OM_CUSTOM_GAMESOLO_MIDDLE);

			
			this._labeltimer = new Label();
			const fontNames:String = "Helvetica Neue,Helvetica,Roboto,Arial,_sans";
			this._label .text="";
			this._label .visible=false;
			this._label2.visible=false;
			this._labeltimer .text="";
			this._labeltimer .visible=false;

			//var _smallLightTextFormat:TextFormat = new TextFormat(fontNames, 48 * this.dpiScale, 0xe5e5e5);
			//var _smallLightTextFormat:TextFormat = new TextFormat(CPX_FONT, 48 * this.dpiScale, 0xe5e5e5);
			
			this.addChild(this._label);
			this.addChild(this._label2);
			this.addChild(this._labeltimer);
			this._labeltimer.visible=false;
			this._backButton = new Button();
			this._backButton.label = "Back";
			this._backButton.addEventListener(Event.TRIGGERED, backButton_triggeredHandler);

			this._buttonraccourci= new Button();
			this._buttonraccourci.label = "Raccourci"+partie.dataquizz.ok;
			this._buttonraccourci.addEventListener(Event.TRIGGERED, buttonraccourci_triggeredHandler);
			
	//		this._header = new Header();
//			this._header.title = "DEFI !";
//			this.addChild(this._header);
			// handles the back hardware key on android
//			this.backButtonHandler = this.onBackButton;
			
		}
		override protected function draw():void
		{
			var _smallLightTextFormat:TextFormat = new TextFormat("Casual", 120 * this.dpiScale, 0xFFFFFF);
			var _smallLightTextFormat2:TextFormat = new TextFormat("Casual", 20 * this.dpiScale, 0x000000);
			var _smallLightTextFormat12:TextFormat = new TextFormat("Casual", 20 * this.dpiScale, 0xFF00FF);
			
			this._label.textRendererProperties.textFormat = _smallLightTextFormat;
//			this._label2.textRendererProperties.textFormat = _smallLightTextFormat12;
			this._labeltimer.textRendererProperties.textFormat = _smallLightTextFormat2;
			
			this._label.validate();
			this._label2.validate();			
			this._labeltimer.validate();
			this._labeltimer.x = (this.actualWidth - this._labeltimer.width) / 2 ;
			this._labeltimer.y = 40;
			
//			var _smallLightTextFormat:TextFormat = new TextFormat("Casual", 48 * this.dpiScale, 0xff0000);
//			this._label.textRendererProperties.textFormat = _smallLightTextFormat;
			//this._label.scaleX=this._label.scaleY=1;
						
//			this._label.x = (this.actualWidth - this._input.width) / 2 - 50;
//			this._label.y = this._header.height +10;
			this._label.x = 150;
			this._label.y = 140;
			this._label.pivotX=this._label.width/2;
			this._label.pivotY=this._label.height/2;

			this._label2.x = 20;
			this._label2.y = 250;
			this._label2.pivotX=this._label.width/2;
			this._label2.pivotY=this._label.height/2;

			compterebours();
		}
		
		private function onBackButton():void
		{
			this.dispatchEventWith(Event.COMPLETE);
		}
		
		private function button_triggeredHandler(event:Event):void
		{
			trace("button triggered.")
			
		}
		
		private function backButton_triggeredHandler(event:Event):void
		{
			this.onBackButton();
		}		
		private function buttonraccourci_triggeredHandler(event:Event):void
		{
			afficheretoiles();
//			stopsucces();
		}		

		private function goxxButton_triggeredHandler(event:Event):void
		{
			// essai de twwen
			compterebours();
		}

		private function goButton1_triggeredHandler(event:Event):void
		{
			// essai de twwen 
			
			var tween:Tween = new Tween(this._input, 1, Transitions.EASE_IN_OUT);
			//tween.animate("x", mc.x + mc.width);
			tween.scaleTo(10);
			tween.fadeTo(0);
			var z:Array=new Array();
			var zz:Array=new Array();			
			zz.push(this._input);
			z.push(zz);
			tween.onCompleteArgs=z;
			tween.onComplete = function(zarray:Array):void {
				var letxt: TextInput =zarray[0] as TextInput;
				
				letxt.text="2";
				letxt.scaleX=1;
				letxt.scaleY=1;
				letxt.alpha=1;
				var tween2:Tween = new Tween(letxt, 1, Transitions.EASE_IN_OUT);
				tween2.scaleTo(10);
				tween2.fadeTo(0);				
				Starling.juggler.add(tween2);
///				tween2.onComplete = fintween2;
				
			};			
			Starling.juggler.add(tween);
		}	
		
		public function showEmbeddedFonts():void {
			trace("========Embedded Fonts========");
			var fonts:Array = Font.enumerateFonts();
			fonts.sortOn("fontName", Array.CASEINSENSITIVE);
			for (var i:int = 0; i < fonts.length; i++) {
					trace(fonts[i].fontName + ", " + fonts[i].fontStyle);
			}
		}

		private function compterebours():void{
			this._label .visible=true;
			this._label.text="3";
//			this._label.scaleX=this._label.scaleY=0.1;
			this._label.alpha=1;
			this._label.x=180;
			this._label.y=130;
			
			var tween:Tween = new Tween(this._label, 1, Transitions.EASE_IN_OUT);
			tween.scaleTo(3);
			tween.animate("y",30);
			tween.animate("x",100);
			tween.fadeTo(0);
			tween.onComplete = fintween3_2;
			tween.delay=0.5;
			Starling.juggler.add(tween);
		}
		private function fintween3_2():void{
			this._label.text="2";
			this._label.scaleX=this._label.scaleY=1;
			this._label.alpha=1;
			this._label.x=180;
			this._label.y=130;
			var tween:Tween = new Tween(this._label, 1, Transitions.EASE_IN_OUT);
			tween.scaleTo(3);
			tween.animate("y",30);
			tween.animate("x",100);
			tween.fadeTo(0);				
			Starling.juggler.add(tween);
			tween.onComplete = fintween2_1;			
		}
		private function fintween2_1():void{
			this._label.text="1";
			this._label.scaleX=this._label.scaleY=1;
			this._label.alpha=1;
			this._label.x=180;
			this._label.y=130;
			var tween:Tween = new Tween(this._label, 1, Transitions.EASE_IN_OUT);
			tween.scaleTo(3);
			tween.animate("y",30);
			tween.animate("x",100);
			tween.fadeTo(0);				
			Starling.juggler.add(tween);
			tween.onComplete = gomemo;			
		}
		
		private function gomemo():void{
			this._snd.play(200);
			this._label.visible=false;
			this._quizz= new Quizz();
			this._quizz.partie=partie;
//			this._quizz.x=0;
//			this._quizz.y=50;
			
			this._quizz.addEventListener("endofgamesuccess",endofgamesuccess);
//			this._game.defi=this;
			addChild(this._quizz);
			//_quizz.partie=partie;
			this._quizz.startgame();
/*
			this._labeltimer.visible=true;
			this._labeltimer.text="O s";
			this._maclock.start();
*/						
		}
		private function fnticker(evt:TimerEvent):void{
			this._tick++;
			this._labeltimer.text=this._tick+" s";
		}
		private function afficheresok():void{
			this._snd.play(200);
			this._label2.scaleX=this._label2.scaleY=0;
			this._label2.visible=true;
			this._label2.text="Tu as mis "+_maclock.currentCount+" s !";
			var tween:Tween = new Tween(this._label2, 1, Transitions.EASE_IN_OUT);
			tween.scaleTo(1);
			Starling.juggler.add(tween);
			afficheretoiles();
		}

		private function fnscore(evt:TimerEvent):void{
			if(parseInt(_label.text.substr(1))<100){
				_label.text="+"+(parseInt(_label.text.substr(1))+1);
				_label.validate();
			} else {
				this._maclockpts.stop();
				var tween:Tween=new Tween(_label,1,"easeInOutBack");
				tween.scaleTo(1.1*_label.scaleX);
				Starling.juggler.add(tween);
				tween.onComplete=newpoints;
			}		
		}

		private function newpoints():void{
			_label.visible=false;
//			_label2.width=350;
			_label2.text="Cool !!!  \n" +
				"Ces 10 100 points te permettent \n d’acheter un paquet de cartes \n et d’avancer ton album";
//			_label2.

		}
		
		private function affiche():void{
			if(parseInt(_label.text)<100){
				_label.text=""+(parseInt(_label.text)+1);
				_label.validate();
			} else {
				clearInterval(_zz);
			}		
		}
		private function afficherpluscent():void{
			_label.text="+0";
			_label.alpha=1;
			_label.visible=true;
			this._maclockpts.start();

//			_zz=setInterval(affiche,100);
		}
		private function afficheretoiles():void{
			var count:int=20;
			while (count>0){
				count--;
				var maParticle:Particle=new Particle();
				this.addChild(maParticle);
				maParticlesToAnimate.push(maParticle);
				maParticle.scaleX=maParticle.scaleY=1;
				maParticle.y=200+Math.random()*200-25;
				maParticle.x=300+Math.random()*200-20;
				maParticle.rotation=deg2rad(Math.random()*180-90);
				maParticle.alpha=1;
				
			}
			// on lance l animation !
			for(var i:uint=0;i<maParticlesToAnimate.length;i++){
				var maparticletotrack:Particle=maParticlesToAnimate[i];
				if(maparticletotrack){
					maparticletotrack.scaleX=maparticletotrack.scaleY=0;
					goanim(maparticletotrack);
				}
			}
			
//			var dem:Demo=new Demo();
//			addChild(dem);
			
		}
		private function goanim(unepart:Particle):void{
			var tween:Tween=new Tween(unepart,0.2,"easeOutElastic");
			tween.scaleTo(0.5);
			tween.delay=Math.random()*.02;
			var z:Array=new Array();
			var zz:Array=new Array();
			zz.push(unepart);
			z.push(zz);
			tween.onCompleteArgs=z;
			tween.onComplete = startanim1_2;
			Starling.juggler.add(tween);
		}
		
		private function startanim1_2(zarray:Array):void{
			var unepart: Particle=zarray[0] as Particle;
			//			var tween:Tween=new Tween(unepart,1,"easeOutElastic");
			var tween:Tween=new Tween(unepart,0.8,"linear");
			tween.animate("rotation",deg2rad(10*Math.random()*180));
			tween.scaleTo(1.5);
			var zy:int=	unepart.y+Math.random()*40-20;			
			var zx:int=unepart.x+Math.random()*40-20;
			tween.animate("x",zx);
			tween.animate("y",zy);

			var z:Array=new Array();
			var zz:Array=new Array();			
			zz.push(unepart);
			z.push(zz);
			tween.onCompleteArgs=z;
			tween.onComplete = startanim2_1;
			Starling.juggler.add(tween);
		}
		private function startanim2_1(zarray:Array):void{
			var unepart: Particle=zarray[0] as Particle;
			var tween:Tween=new Tween(unepart,0.8,"linear");
			tween.animate("rotation",deg2rad(10*Math.random()*180));
			tween.scaleTo(0.5);
			var zy:int=	unepart.y+Math.random()*40-20;			
			var zx:int=unepart.x+Math.random()*40-20;
			tween.animate("x",zx);
			tween.animate("y",zy);
			
			var z:Array=new Array();
			var zz:Array=new Array();			

			zz.push(unepart);
			z.push(zz);
			tween.onCompleteArgs=z;
			if(unepart.nbanim<=3){
				tween.onComplete = startanim1_2;
			} else {
				// on va vers 0 0 
				tween.animate("x",0);
				tween.animate("y",0);
				// faire les +100 pts
				afficherpluscent();
			}
			unepart.nbanim++;			
			Starling.juggler.add(tween);
		}
		
		public function endofgamesuccess(e:Event):void{
			this._maclock.stop();
			this._label.visible=true;
			
			this._label.text="YES !!";
			this._label.scaleX=this._label.scaleY=0;
			this._label.alpha=1;
			this._label.x=30;
			this._label.y=30;
			var tween:Tween = new Tween(this._label, 1, Transitions.EASE_IN_OUT);
			tween.scaleTo(1);
			tween.animate("y",80);
			tween.animate("x",30);
	
			var tween2:Tween = new Tween(this._quizz, 1);
			tween2.fadeTo(0);
			tween.delay=5;
			tween2.delay=5;
			Starling.juggler.add(tween);
			Starling.juggler.add(tween2);
			tween2.onComplete=afficheresok;
		}
		
	}
}