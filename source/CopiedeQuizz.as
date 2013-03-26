package
{
	import com.noomiz.objects.FBUserFactory;
	import com.noomiz.objects.Partie;
	import com.noomiz.sounds.MemoryHome;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.ui.MouseCursor;
	import flash.utils.Timer;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.ScrollContainer;
	import feathers.display.Scale9Image;
	import feathers.events.FeathersEventType;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	import feathers.textures.Scale9Textures;
	import feathers.themes.OMDesktopTheme;
	
	import org.osmf.layout.HorizontalAlign;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;

	public class Quizz extends Sprite
	{
		public var partie:Partie;
		
		private var _sp1:Sprite;
		private var _sp2:Sprite;
		private var _sp3:Sprite;
		
		private var _q1:starling.display.Image;
		private var _q2:starling.display.Image;
		private var _q3:starling.display.Image;
		private var _qtxt1:Label;
		private var _qtxt2:Label;
		private var _qtxt3:Label;

		private var _labelpts:Label;
		private var _labelbien:Label;
		private var _pts:uint;
		private var _score:uint;
		private var _nbok:uint;
		
		
		private var _currentquestion:Label;
		private var _btn1:Button;
		private var _btn2:Button;
		private var _btn3:Button;
		private var _btn4:Button;
		
		private var _btnok:Button;
		private var _btnko:Button;
		
		
		private var _xcurrentquestion:Number;
		private var _xbtn1:Number;
		private var _xbtn2:Number;
		private var _xbtn3:Number;
		private var _xbtn4:Number;
		
		private var _currentindexquestion;
		
		private var _maclock:Timer = new Timer(1000,0);
		private var _maclocknettoyeur:Timer = new Timer(1000,1);

		private var _tickserveur:Number=0;
		private var _clockretardserveur:Timer = new Timer(1000,0);
		private var _responseserveur:uint=2;
		private var _nbptsfb:uint=0;
		private var _scanim:ScrollContainer;
		private var _zztaff:uint;
		public function Quizz()
		{
			trace("Game constructor");
			// afficahge de la première question
			
			_pts=100;
			_score=0;
			_nbok=0;
			_responseserveur=2;
			var _sc:ScrollContainer=new ScrollContainer();
			_sc.width=500;
			
			this._clockretardserveur.addEventListener(TimerEvent.TIMER, fntickerserveur);
			
			
			var vlay:VerticalLayout=new VerticalLayout();
			vlay.horizontalAlign=HorizontalAlign.CENTER
			vlay.gap=20;
			_sc.layout=vlay;			
			addChild(_sc);
			
			// premiere ligne en horieontale
			var scligne1:ScrollContainer=new ScrollContainer();
			var scligne1lay:HorizontalLayout=new HorizontalLayout();
			scligne1lay.horizontalAlign=HorizontalAlign.CENTER;
			scligne1lay.gap=20;
			scligne1.layout=scligne1lay;
			_sc.addChild(scligne1);
			
			// en hdr les 3 questions
			_sp1=new Sprite();
			_sp2=new Sprite();
			_sp3=new Sprite();
			
			var matexture2:Texture=PowerUpFactory.getTxt("Bouton-question en cours");
			_q1=new Image( matexture2);
			
			_qtxt1=new Label();
			_qtxt1.text="QUESTION 1";
			_qtxt1.nameList.add(OMDesktopTheme.ALTERNATE_NAME_OM_CUSTOM_QUIZZQUESTIONHDR);
			_qtxt1.x=10;
			_qtxt1.y=12;
			scligne1.addChild(_sp1);
			_sp1.visible=false;
			
			_sp1.addChild(_q1);
			_sp1.addChild(_qtxt1);
			_q2=new Image(matexture2);
			//			_q2.width=100;
			_qtxt2=new Label();
			scligne1.addChild(_sp2);
			_sp2.visible=false;
			
			
			_sp2.addChild(_q2);
			_sp2.addChild(_qtxt2);
			_q3=new Image(matexture2);
			_qtxt3=new Label();
			//			_q3.width=100;
			scligne1.addChild(_sp3);
			_sp3.addChild(_q3);
			_sp3.addChild(_qtxt3);
			_sp3.visible=false;
			
			// ligne 2 les points
			_labelpts=new Label();
			_labelpts.nameList.add(OMDesktopTheme.ALTERNATE_NAME_OM_CUSTOM_QUIZZPTS);
			_labelpts.width=400;
			_labelpts.text=""+_pts+" pts";
			_sc.addChild(_labelpts);
			
			// ligne 3 current question
			_currentindexquestion=0;
			_currentquestion=new Label();
			_currentquestion.nameList.add(OMDesktopTheme.ALTERNATE_NAME_OM_CUSTOM_QUIZZQUESTION);
			_currentquestion.width=400;
			//			_currentquestion.textRendererProperties.wordWrap = true;
			_sc.addChild(_currentquestion);
			
			// ligne 4 deux rep
			var scligne41:ScrollContainer=new ScrollContainer();
			var scligne41lay:HorizontalLayout=new HorizontalLayout();
			scligne41lay.horizontalAlign=HorizontalAlign.CENTER;
			scligne41lay.gap=20;
			scligne41.layout=scligne41lay;			
			_sc.addChild(scligne41);
			_btn1=new Button();
			_btn1.name="1";
			_btn2=new Button();
			_btn2.name="2";
			scligne41.addChild(_btn1);
			scligne41.addChild(_btn2);
			
			// ligne 4 deux rep bas
			var scligne42:ScrollContainer=new ScrollContainer();
			var scligne42lay:HorizontalLayout=new HorizontalLayout();
			scligne42lay.horizontalAlign=HorizontalAlign.CENTER;
			scligne42lay.gap=20;
			scligne42.layout=scligne42lay;
			_sc.addChild(scligne42);
			_btn3=new Button();
			_btn3.name="3";
			_btn4=new Button();
			_btn4.name="4";
			scligne42.addChild(_btn3);
			scligne42.addChild(_btn4);
			
			_btn1.width=_btn2.width=_btn3.width=_btn4.width=120;
			_btn1.height=_btn2.height=_btn3.height=_btn4.height=60;
			
			_btn1.addEventListener(starling.events.Event.TRIGGERED, btn_triggeredHandler);				
			_btn2.addEventListener(starling.events.Event.TRIGGERED, btn_triggeredHandler);				
			_btn3.addEventListener(starling.events.Event.TRIGGERED, btn_triggeredHandler);				
			_btn4.addEventListener(starling.events.Event.TRIGGERED, btn_triggeredHandler);				
			// lct timer
			this._maclock.addEventListener(TimerEvent.TIMER, fnticker);
			
			_scanim=new ScrollContainer();
			this._maclocknettoyeur.addEventListener(TimerEvent.TIMER, fntickernettoyeur);
			
			// bien joue
			_labelbien=new Label();
			_labelbien.nameList.add(OMDesktopTheme.ALTERNATE_NAME_OM_CUSTOM_QUIZZPTS);
			_labelbien.text="Bien joué!";
			_labelbien.x=150;
			_labelbien.y=250;
			
			_btnok=new Button();
			_btnok.nameList.add(OMDesktopTheme.ALTERNATE_NAME_MY_CUSTOM_BUTTON_BONNEQUESTION);
			_btnok.visible=false;
			_btnok.label="BRAVO !!";
			addChild(_btnok);
//			trace(_xbtn1+" "+_btn1.x+ " "+ _btn1.y + " "+_btn3.x+" "+_btn3.y);
		}
		public function startgame():void{
			// lct de la premiere question			
			_pts=100;
			_btnok.visible=false;
			_labelpts.text=""+_pts+" pts";
			_maclock.start();
			
			_xcurrentquestion=_currentquestion.y;
			_xbtn1=_btn1.x;
			_xbtn2=_btn2.x;
			_xbtn3=_btn3.x;
			_xbtn4=_btn4.x;
			
//			_currentquestion.y=_xcurrentquestion-40;

			
			var tween1:Tween=new Tween(_currentquestion,10.3);
			
			tween1.animate("y",_xcurrentquestion-40);
			tween1.fadeTo(0);
			tween1.onComplete=finnewquestion;
			Starling.juggler.add(tween1);
			var tweenbtn1:Tween=new Tween(_btn1,10.2);
			tweenbtn1.animate("x",-500);
			Starling.juggler.add(tweenbtn1);
			var tweenbtn2:Tween=new Tween(_btn2,10.2);
			tweenbtn2.animate("x",500);
			Starling.juggler.add(tweenbtn2);
			var tweenbtn3:Tween=new Tween(_btn3,10.2);
			tweenbtn3.animate("x",-500);
			Starling.juggler.add(tweenbtn3);
			var tweenbtn4:Tween=new Tween(_btn4,10.2);
			tweenbtn4.animate("x",500);
			Starling.juggler.add(tweenbtn4);
			
			
		}
		private function fnticker(evt:TimerEvent):void{
			if(this._pts<=10){
				_maclock.stop();
				this._pts=10;
			} else {
				this._pts-=5;
			}
			_labelpts.text=""+this._pts+" pts";
		}
		private function btn_triggeredHandler(event:starling.events.Event):void
		{
			var target:Button=event.currentTarget as Button;
			_maclock.stop();
			if(partie.dataquizz.questions[_currentindexquestion].REPONSEGAGNANTE==target.name){
				var zz1:Point=new Point(target.width/2,target.height/2);
				var ptglobal1:Point=target.localToGlobal(zz1);
				target.label="YES :"+target.name;
				// on met à jour les points
				_score+=_pts;
				_nbok++;
				switch(_currentindexquestion){
					case 0:
						_q1.texture=PowerUpFactory.getTxt("Bouton-bonne-question");
						_qtxt1.text=""+_pts+" pts";
						break;
					case 1:
						_q2.texture=PowerUpFactory.getTxt("Bouton-bonne-question");
						_qtxt2.text=""+_pts+" pts";
						break;
					case 2:
						_q3.texture=PowerUpFactory.getTxt("Bouton-bonne-question");
						_qtxt3.text=""+_pts+" pts";
						break;
				}
				var oldx:Point=target.localToGlobal(new Point(0,0));
				trace(oldx);
				trace(target.height);
				_btnok.x=oldx.x;
				_btnok.y=oldx.y-target.height;
				_btnok.width=target.width;
				_btnok.height=target.height;
				_btnok.visible=true;				
				animeretoiles(ptglobal1.x,ptglobal1.y);					
			} else {
				// mauvaise reponse
				target.label="WRONG:"+target.name;
				switch(_currentindexquestion){
					case 0:
						_q1.texture=PowerUpFactory.getTxt("Bouton-mauvaise-question");
						_qtxt1.text="0 pts";
						break;
					case 1:
						_q2.texture=PowerUpFactory.getTxt("Bouton-mauvaise-question");
						_qtxt2.text="0 pts";
						break;
					case 2:
						_q3.texture=PowerUpFactory.getTxt("Bouton-mauvaise-question");
						_qtxt3.text="0 pts";
						break;
				}
				
			}
			
		}		
		private function fntickernettoyeur(evt:TimerEvent):void{
			_maclocknettoyeur.stop();
			removeChild(_labelbien);
			_labelbien.x=150;
			_labelbien.y=250;
			_scanim.removeChildren(0,_scanim.numChildren-1);			
			removeChild(_scanim);
			// on lance une autre question pour voir
			newquestion();
		}
		
		private function newquestion():void{
			// stockage des x 
			_pts=100;
			_btnok.visible=false;
			_labelpts.text=""+_pts+" pts";
			_maclock.start();
			
			_xcurrentquestion=_currentquestion.y;
			_xbtn1=_btn1.x;
			_xbtn2=_btn2.x;
			_xbtn3=_btn3.x;
			_xbtn4=_btn4.x;
			
			//			tween1.onComplete=finnewquestion;

			
			var tween1:Tween=new Tween(_currentquestion,0.5);
			tween1.animate("y",_xcurrentquestion-40);
			tween1.fadeTo(0);
			tween1.onComplete=finnewquestion;

			var tweenbtn1:Tween=new Tween(_btn1,0.5);
			tweenbtn1.animate("x",-500);
			Starling.juggler.add(tweenbtn1);

			var tweenbtn2:Tween=new Tween(_btn2,0.5);
			tweenbtn2.animate("x",500);
			Starling.juggler.add(tweenbtn2);

			var tweenbtn3:Tween=new Tween(_btn3,0.5);
			tweenbtn3.animate("x",-500);
			Starling.juggler.add(tweenbtn3);

			var tweenbtn4:Tween=new Tween(_btn4,0.5);
			tweenbtn4.animate("x",500);
			Starling.juggler.add(tweenbtn4);

			Starling.juggler.add(tween1);				
			
		}
		private function finnewquestion():void{
			// chgt des question
			trace("_currentindexquestion:"+_currentindexquestion);
			if(_currentindexquestion<=1) {
				//var yy:Number=_currentquestion.localToGlobal(new Point(0,0)).y;
				switch (_currentindexquestion){
					case 0:
						var _sp1x:Number=_sp1.x;
						_sp1.x=-500;
						_sp1.visible=true;
						var tween10:Tween=new Tween(_sp1,0.5);
						tween10.animate("x",_sp1x);
						Starling.juggler.add(tween10);						
						break;
					case 1:
						var _sp2x:Number=_sp2.x;
						_sp2.x=-500;
						_sp2.visible=true;
						var tween11:Tween=new Tween(_sp2,0.5);
						tween11.animate("x",_sp2x);
						Starling.juggler.add(tween11);
						// faire apparaitre les questions
						
						break;
					case 2:
						var _sp3x:Number=_sp3.x;
						_sp3.x=-500;
						_sp3.visible=true;
						var tween13:Tween=new Tween(_sp3,0.5);
						tween13.animate("x",_sp3x);
						Starling.juggler.add(tween13);
						break;
				}
				
				_currentquestion.text=partie.dataquizz.questions[_currentindexquestion].TITREQUESTION;
		//		_currentquestion.alpha=0;
	//			_currentquestion.y=1000;

				var tween11:Tween=new Tween(_currentquestion,0.5);
				tween11.delay=0.6;
				tween11.animate("y",_xcurrentquestion);
				tween11.fadeTo(1);
				Starling.juggler.add(tween11);
				
				_btn1.label=partie.dataquizz.questions[_currentindexquestion].REPONSE1;
				_btn2.label=partie.dataquizz.questions[_currentindexquestion].REPONSE2;
				_btn3.label=partie.dataquizz.questions[_currentindexquestion].REPONSE3;
				_btn4.label=partie.dataquizz.questions[_currentindexquestion].REPONSE3;
				// affichage
				//_currentquestion.y=_xcurrentquestion;
				var tweenbtn1:Tween=new Tween(_btn1,0.5);
				tweenbtn1.delay=1.1;
				tweenbtn1.animate("x",_xbtn1-10);
				Starling.juggler.add(tweenbtn1);

				var tweenbtn2:Tween=new Tween(_btn2,0.5);
				tweenbtn2.delay=1.1;
				tweenbtn2.animate("x",_xbtn2);
				Starling.juggler.add(tweenbtn2);

				var tweenbtn3:Tween=new Tween(_btn3,0.5);
				tweenbtn3.delay=1.1;
				tweenbtn3.animate("x",_xbtn3-10);
				Starling.juggler.add(tweenbtn3);
				
				var tweenbtn4:Tween=new Tween(_btn4,0.5);
				tweenbtn4.delay=1.1;
				tweenbtn4.animate("x",_xbtn4);
				Starling.juggler.add(tweenbtn4);
				_currentindexquestion++;

			} else {
				// on a eu trois question c la fin on envoit les resultats au server
				// affichage ecran de resultat				
				_labelpts.visible=false;
				
				_currentquestion.text="Nombre de points gagnés :"+_score;
				if(_nbok==3){
					// affichage bonus
					_currentquestion.text="Nombre de points gagnés :"+_score+" BONUS x 3 !!!";
				}
				_currentquestion.y=_xcurrentquestion;
				// envoie les datas et pose d un timer pr évoter d aller trop vite				
				// on avertit le serveur onlance un timer et on attend un peu qd meme avant
				_clockretardserveur.start();
				var loader2:URLLoader = new URLLoader();
				loader2.addEventListener (flash.events.Event.COMPLETE, onLoaderendofgameComplete);			
				// si je suis acteur ou si j ai été défie deux url diff
				var zurl:URLRequest=new URLRequest ("http://www9.noomiz.com/om/jsonendofquizz");	
				zurl.method = URLRequestMethod.POST;
				var zdata:URLVariables=new URLVariables();
				zdata.fbid = FBUserFactory.getUser().idfb;
				zdata.idpartie= partie.dataquizz.idpartie;
				// tokeniser le code
				zdata.score=_score;
				zurl.data=zdata;
				loader2.load (zurl);
				// c est le retour du serveur qui indiquera l action				
			}
		}
		private function onLoaderendofgameComplete(e:flash.events.Event):void{ 

			var loader:URLLoader = URLLoader(e.target);
			var zz:Object=JSON.parse(loader.data);
			// check le resultat
			// remettre à jour la partie et aller vers le bon ecran
			_responseserveur=zz.ok;
			// recup info partie depuis le serveur si besoin ?
			// => nb de points par exemple
			_nbptsfb=zz.points;
		}	
		
		private function fntickerserveur(evt:TimerEvent):void{
			_tickserveur++;
			if(_tickserveur>10){
				// pb serveur on revient au depart
				_clockretardserveur.stop();
				dispatchEventWith("complete");
			} else if(_tickserveur>3){
				switch (_responseserveur) {
					case 1:
						// ok tt est ok on va faire la page de resultat
						_clockretardserveur.stop();
						_currentquestion.text="Tu as sur ton compte :"+_nbptsfb+" Points";		
						_zztaff=setInterval(afficherbtnha,1000);
						break;
					case 0:
					default:
						// on a un un soucis serveur
						_clockretardserveur.stop();
						_currentquestion.text="Tu as sur ton compte :"+_nbptsfb+" Points";
						_zztaff=setInterval(afficherbtnha,1000);
						break;
				}
			} // on enchaine suir l ecran d achat apres un petit temps ?
			//cool ces xx pts te mermettent de ...
			
			
		}

		private function afficherbtnha():void{
			clearInterval(_zztaff);
//			animeretoiles(200,200);
			var _btnrejouer:Button=new Button();
			_btnrejouer.label="REJOUER";
			_btnrejouer.scaleX=_btnrejouer.scaleY=0;
			_btnrejouer.width=100;
			_btnrejouer.height=50;
			
			addChild(_btnrejouer);
			var tween1:Tween=new Tween(_btnrejouer,0.8);
			//tween1.animate("x",200);
			tween1.scaleTo(1);
			tween1.moveTo(50,250);
			Starling.juggler.add(tween1);				

			var _btnrecup:Button=new Button();
			_btnrecup.width=100;
			_btnrecup.height=50;
			_btnrecup.label="REcupérer \nmes cartes !";
			_btnrecup.scaleX=_btnrecup.scaleY=0;
			addChild(_btnrecup);
			var tween2:Tween=new Tween(_btnrecup,0.8);
			//tween1.animate("x",200);
			tween2.scaleTo(1);
			tween2.moveTo(250,250);
			Starling.juggler.add(tween2);			
		}
		
		private function animeretoiles(zx:uint,zy:uint):void{
			_maclocknettoyeur.start();
			addChild(_scanim);
			for (var i:uint=0;i<80;i++){
				var _imgchrono:starling.display.Image;
				var matexture2:Texture=PowerUpFactory.getTxt("eco");			
				_imgchrono=new Image(matexture2);
				_imgchrono.width=50;
				_imgchrono.x=zx;
				_imgchrono.y=zy;
				_imgchrono.scaleX=1*Math.random()+1;
				_imgchrono.scaleY=_imgchrono.scaleX;
				_scanim.addChild(_imgchrono);				
				var tween1:Tween=new Tween(_imgchrono,0.8);
				//tween1.animate("x",200);
				tween1.animate("alpha",0);
				tween1.scaleTo(0);
				tween1.moveTo(500*Math.random(),500*Math.random());
				Starling.juggler.add(tween1);				
			}
			addChild(_labelbien);
			var tweenb:Tween=new Tween(_labelbien,1);
			//tween1.animate("x",200);
			tweenb.animate("y",200);
			Starling.juggler.add(tweenb);				
			// petit tween d anim sur le bien joué
			
			// a la fin remove
		}

	}
}