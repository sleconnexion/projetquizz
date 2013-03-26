package
{
	import com.noomiz.objects.FBUserFactory;
	import com.noomiz.objects.Labelcompteur;
	import com.noomiz.objects.Labelquestion;
	import com.noomiz.objects.Partie;
	import com.noomiz.sounds.Clickbtn1;
	import com.noomiz.sounds.Clickbtnko;
	import com.noomiz.sounds.MemoryHome;
	import com.noomiz.sounds.ScreenTrans;
	
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
		private var _qtxt1:Labelquestion;
		private var _qtxt2:Labelquestion;
		private var _qtxt3:Labelquestion;

		private var _labelpts:Labelcompteur;
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
		private var _xbtn1:Number=50;
		private var _xbtn2:Number=250;
		private var _xbtn3:Number=50;
		private var _xbtn4:Number=250;
		
		private var _currentindexquestion;
		
		private var _maclock:Timer = new Timer(1000,0);
		private var _maclocknettoyeur:Timer = new Timer(1000,1);

		private var _tickserveur:Number=0;
		private var _clockretardserveur:Timer = new Timer(1000,0);
		private var _responseserveur:uint=2;
		private var _nbptsfb:uint=0;
		private var _scanim:ScrollContainer;
		private var _zztaff:uint;
		private var _sndok:Clickbtn1=new Clickbtn1();
		private var _sndko:Clickbtnko=new Clickbtnko();
		
		public function Quizz()
		{
			trace("Game constructor");
			// afficahge de la première question			
			_pts=100;
			_score=0;
			_nbok=0;
			_responseserveur=2;
			this._clockretardserveur.addEventListener(TimerEvent.TIMER, fntickerserveur);
			// en hdr les 3 questions
			_sp1=new Sprite();
			_sp2=new Sprite();
			_sp3=new Sprite();			
			_sp1.x=12;
			_sp1.y=_sp2.y=_sp3.y=50;
			_sp2.x=160;
			_sp3.x=305;
							
			var matexture2:Texture=PowerUpFactory.getTxt("Bouton-question en cours");
			_q1=new Image( matexture2);			
			_qtxt1=new Labelquestion();
			_qtxt1.text="QUESTION 1";
//			_qtxt1.nameList.add(OMDesktopTheme.ALTERNATE_NAME_OM_CUSTOM_QUIZZQUESTIONHDR);
			_qtxt1.x=10;
			_qtxt1.y=12;
			addChild(_sp1);
			_sp1.visible=false;			
			_sp1.addChild(_q1);
			_sp1.addChild(_qtxt1);

			_q2=new Image(matexture2);
			//			_q2.width=100;
			_qtxt2=new Labelquestion();
			_qtxt2.text="QUESTION 2";
			_qtxt2.x=10;
			_qtxt2.y=12;
			addChild(_sp2);
			_sp2.visible=false;
			
			
			_sp2.addChild(_q2);
			_sp2.addChild(_qtxt2);
			_q3=new Image(matexture2);
			_qtxt3=new Labelquestion();
			_qtxt3.text="QUESTION 3";
			_qtxt3.x=10;
			_qtxt3.y=12;

			addChild(_sp3);
			_sp3.addChild(_q3);
			_sp3.addChild(_qtxt3);
			_sp3.visible=false;
			
			// ligne 2 les points
			_labelpts=new Labelcompteur();
			_labelpts.width=200;
//			_labelpts.text=""+_pts+" pts";
			_labelpts.x=200;
			_labelpts.y=120;
			_labelpts.alpha=0;
			addChild(_labelpts);
			_labelpts.compteur=100;
			// ligne 3 current question
			_currentindexquestion=-1;
			_currentquestion=new Label();
			_currentquestion.nameList.add(OMDesktopTheme.ALTERNATE_NAME_OM_CUSTOM_QUIZZQUESTION);
			_currentquestion.width=400;
			//			_currentquestion.textRendererProperties.wordWrap = true;
			addChild(_currentquestion);
			_currentquestion.x=20;
			_currentquestion.y=40;
			_currentquestion.alpha=0;
			
			_btn1=new Button();
			_btn1.nameList.add(OMDesktopTheme.ALTERNATE_NAME_MY_CUSTOM_BUTTON_REPONSE);
			_btn2=new Button();
			_btn2.nameList.add(OMDesktopTheme.ALTERNATE_NAME_MY_CUSTOM_BUTTON_REPONSE);
			_btn1.y=_btn2.y=250;
			_btn1.x=-500;
			_btn2.x=500;
			addChild(_btn1);
			addChild(_btn2);
			
			_btn3=new Button();
			_btn3.nameList.add(OMDesktopTheme.ALTERNATE_NAME_MY_CUSTOM_BUTTON_REPONSE);

			_btn4=new Button();
			_btn4.nameList.add(OMDesktopTheme.ALTERNATE_NAME_MY_CUSTOM_BUTTON_REPONSE);

			_btn3.y=_btn4.y=320;
			_btn3.x=-500;
			_btn4.x=500;

			addChild(_btn3);
			addChild(_btn4);
			
			_btn1.width=_btn2.width=_btn3.width=_btn4.width=180;
			_btn1.height=_btn2.height=_btn3.height=_btn4.height=70;
			
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
			_btnok.nameList.add(OMDesktopTheme.ALTERNATE_NAME_MY_CUSTOM_BUTTON_BONNEREPONSE);
			_btnok.visible=false;
			_btnok.label="BRAVO !!";
			addChild(_btnok);
			_btnko=new Button();
			_btnko.nameList.add(OMDesktopTheme.ALTERNATE_NAME_MY_CUSTOM_BUTTON_MAUVAISEREPONSE);
			_btnko.visible=false;
			_btnko.label="ARF !!";
			addChild(_btnko);

			//			trace(_xbtn1+" "+_btn1.x+ " "+ _btn1.y + " "+_btn3.x+" "+_btn3.y);
		}
		public function startgame():void{
			// lct de la premiere question
			_btnok.visible=false;
//			_labelpts.text=""+_pts+" pts";
			// lct de l animation
			finnewquestion();
		}
		private function fnticker(evt:TimerEvent):void{
			if(this._pts<=10){
				_maclock.stop();
				this._pts=10;
			} else {
				this._pts-=5;
			}
//			_labelpts.text=""+this._pts+" pts";
			_labelpts.compteur=_pts;
		}
		private function btn_triggeredHandler(event:starling.events.Event):void
		{
			var target:Button=event.currentTarget as Button;
			trace("btnclick:"+_currentindexquestion+target.name);
			_maclock.stop();
			if((partie.dataquizz.questions[_currentindexquestion].REPONSEGAGNANTE==1 && target==_btn1) ||
				(partie.dataquizz.questions[_currentindexquestion].REPONSEGAGNANTE==2 && target==_btn2) ||
				(partie.dataquizz.questions[_currentindexquestion].REPONSEGAGNANTE==3 && target==_btn3) ||
				(partie.dataquizz.questions[_currentindexquestion].REPONSEGAGNANTE==4 && target==_btn4)){
				_sndok.play(200);
				var zz1:Point=new Point(target.width/2,target.height/2);
				var ptglobal1:Point=target.localToGlobal(zz1);
				target.label="YES :"+target.name;
				// on met à jour les points
				_score+=_pts;
				_nbok++;
				var oldx:Point=target.localToGlobal(new Point(0,0));
				_btnok.x=oldx.x;
				_btnok.y=oldx.y-target.height;
				_btnok.width=target.width;
				_btnok.height=target.height;
				_btnok.visible=true;				
				animeretoiles(ptglobal1.x,ptglobal1.y);		

				switch(_currentindexquestion){
					case 0:
						_q1.texture=PowerUpFactory.getTxt("Bouton-bonne-question");
						// lancer un timer pr fair incrementer
						_qtxt1.x=30;
						var tw0:Tween=new Tween(_qtxt1,1);
						tw0.animate("compteur",_pts);
						var tw2:Tween=new Tween(_labelpts,0.5);
						tw2.moveTo(_sp1.x+20,_sp1.y+20);
						tw2.fadeTo(0);
						tw2.nextTween=tw0;
						Starling.juggler.add(tw2);
						
						break;
					case 1:
						_q2.texture=PowerUpFactory.getTxt("Bouton-bonne-question");
						_qtxt2.x=30;
						var tw02:Tween=new Tween(_qtxt2,1);
						tw02.animate("compteur",_pts);
						var tw22:Tween=new Tween(_labelpts,0.5);
						tw22.moveTo(_sp2.x+20,_sp2.y+20);
						tw22.fadeTo(0);
						tw22.nextTween=tw02;
						Starling.juggler.add(tw22);
						break;
					case 2:
						_q3.texture=PowerUpFactory.getTxt("Bouton-bonne-question");
						_qtxt3.x=30;
						var tw03:Tween=new Tween(_qtxt3,1);
						tw03.animate("compteur",_pts);
						var tw23:Tween=new Tween(_labelpts,0.5);
						tw23.moveTo(_sp3.x+20,_sp3.y+20);
						tw23.fadeTo(0);
						tw23.nextTween=tw03;
						Starling.juggler.add(tw23);

						
						break;
				}
			} else {
				// mauvaise reponse
				_sndko.play(200);
				target.label="WRONG:"+target.name;
				switch(_currentindexquestion){
					case 0:
						_q1.texture=PowerUpFactory.getTxt("Bouton-mauvaise-question");
						_qtxt1.text="0 pts";
						_qtxt1.x=40;
						break;
					case 1:
						_q2.texture=PowerUpFactory.getTxt("Bouton-mauvaise-question");
						_qtxt2.text="0 pts";
						_qtxt2.x=40;
						break;
					case 2:
						_q3.texture=PowerUpFactory.getTxt("Bouton-mauvaise-question");
						_qtxt3.text="0 pts";
						_qtxt3.x=40;
						break;
				}
				// on passe à la suivante direct:
				var tw23ko:Tween=new Tween(_labelpts,1);
				tw23ko.fadeTo(0);
				tw23ko.onComplete=removequestion;
				Starling.juggler.add(tw23ko);
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
			removequestion();
		}
		
		private function removequestion():void{
			// stockage des x 
			_btnok.visible=false;
			//_labelpts.text=""+_pts+" pts";			
			var tween1:Tween=new Tween(_currentquestion,0.5);
			tween1.animate("y",40);
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

			// lre remove lancera le bon ensuite
			Starling.juggler.add(tween1);				
			
		}
		private function finnewquestion():void{
			// chgt des question
			trace("_currentindexquestion:"+_currentindexquestion);
			if(_currentindexquestion<=1) {
				_currentindexquestion++;
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
				tween11.animate("y",170);
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
				tweenbtn1.animate("x",_xbtn1);
				Starling.juggler.add(tweenbtn1);

				var tweenbtn2:Tween=new Tween(_btn2,0.5);
				tweenbtn2.delay=1.1;
				tweenbtn2.animate("x",_xbtn2);
				Starling.juggler.add(tweenbtn2);

				var tweenbtn3:Tween=new Tween(_btn3,0.5);
				tweenbtn3.delay=1.1;
				tweenbtn3.animate("x",_xbtn3);
				Starling.juggler.add(tweenbtn3);
				
				var tweenbtn4:Tween=new Tween(_btn4,0.5);
				tweenbtn4.delay=1.1;
				tweenbtn4.animate("x",_xbtn4);
				Starling.juggler.add(tweenbtn4);
				// démarrage du timer
				tweenbtn4.onComplete=gotimer;

			} else {
				// on a eu trois question c la fin on envoit les resultats au server
				// affichage ecran de resultat				
				_labelpts.visible=false;
				// retracte les sprite
				var tweensppt:Tween=new Tween(_currentquestion,0.5);
				_currentquestion.text="Nombre de points gagnés :"+_score;
				if(_nbok==3){
					// affichage bonus
					_currentquestion.text="Nombre de points gagnés :"+_score+" BONUS x 3 !!!";
				}
				tweensppt.animate("y",120);
				tweensppt.fadeTo(1);
				
				var tweensp:Tween=new Tween(_sp1,0.5);
				tweensp.animate("x",-200);
				Starling.juggler.add(tweensp);
				var tweensp2:Tween=new Tween(_sp2,0.5);
				tweensp2.animate("x",-200);
				Starling.juggler.add(tweensp2);
				var tweensp3:Tween=new Tween(_sp3,0.5);
				tweensp3.animate("x",-200);
				Starling.juggler.add(tweensp3);
				
				tweensp3.nextTween=tweensppt;
				
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
		private function gotimer():void{
			_labelpts.compteur=100;
			_labelpts.x=200;
			_labelpts.y=120;
			_labelpts.alpha=1;			
			_maclock.start();
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
						_currentquestion.alpha=1;
						_currentquestion.y=120;
						_clockretardserveur.stop();
						_currentquestion.text="Tu as sur ton compte :"+_nbptsfb+" Points";		
						_zztaff=setInterval(afficherbtnha,1000);
						break;
					case 0:
					default:
						// on a un un soucis serveur
						_currentquestion.alpha=1;
						_currentquestion.y=120;
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
				var matexture2:Texture=PowerUpFactory.getTxt("etoile");			
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