package com.noomiz.screens
{
	import com.noomiz.objects.FBUserFactory;
	import com.noomiz.objects.Partie;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.controls.ScrollContainer;
	import feathers.display.Scale3Image;
	import feathers.display.Scale9Image;
	import feathers.display.TiledImage;
	import feathers.layout.VerticalLayout;
	import feathers.textures.Scale9Textures;
	import feathers.themes.OMDesktopTheme;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	
	[Event(name="quizzscreen",type="starling.events.Event")]
	
	public class MainScreen extends Screen
	{
		[Embed(source="/../assets/images/skull.png")]
		private static const SKULL_ICON:Class;
		public static const QUIZZ_SCREEN:String = "quizzscreen";

		[Embed(source="/../assets/images/Fond-violet.png")]
		private static const FOND_VIOLET:Class;

		
		
		
		private var _button:Button;
		private var _header:Header;
		private var _vla:VerticalLayout;
		private var _icon:Scale3Image;

		private var labelhaut:Label;
		
		private var _dataquizz:Object;
		
		public var partie:Partie;
		public function MainScreen()
		{
			super();
			
//			ExternalInterface.addCallback("flexFunction2", flexFunction2);
		}
		
		protected function onComplete(event:flash.events.Event):void
		{
			
			trace("onComplete");
			
			var loadedBitmap:Bitmap = event.currentTarget.loader.content as Bitmap;
			
			var image:Image= new Image(Texture.fromBitmap(loadedBitmap));
	//		addChild(image);
			
			
			
			var txt:Texture=Texture.fromBitmap(loadedBitmap);
			var tim:TiledImage=new TiledImage(txt,1);
						tim.setSize(330,500);
			//addChild(tim);
			
			var txt9:Scale9Textures=new Scale9Textures(txt,new Rectangle(50,50,50,50));
			var imgs:Scale9Image=new Scale9Image(txt9);
//			addChild(imgs);
			//imgs.width=500;
			//imgs.height=50;
			
			
		}
		
		override protected function initialize():void
		{
//			var loader:Loader= new Loader();
//			loader.load ( new URLRequest ("https://noomiz.s3.amazonaws.com/nzdata/meta/lafouine/ticket/img/ticket-surprise.png") );
//			loader.contentLoaderInfo.addEventListener (flash.events.Event.COMPLETE, onComplete );
		
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
			
//			var id= FlexGlobals.topLevelApplication.parameters.monid;
			if (ExternalInterface.available) {
				ExternalInterface.call("flexready", "zz");					
			//	this._header.title = "ok appel de fleex";
			} else {
				trace("ExternalInterface was not available!");
			//	this._header.title = "pb sur extranel";
			}
			labelhaut=new Label();
			labelhaut.text="Connais tu vraiment \nMoussier Tombola ?";
			labelhaut.y=-120;
			labelhaut.x=29;
			labelhaut.width=400;
			labelhaut.nameList.add(OMDesktopTheme.ALTERNATE_NAME_OM_CUSTOM_QUIZZTITRE2);
			labelhaut.alpha=0;

			this._button = new Button();
			this._button.nameList.add(OMDesktopTheme.ALTERNATE_NAME_MY_CUSTOM_BUTTON_MAIN_CHOOSE);
			this._button.label = "JOUER";
			this._button.useHandCursor=true;
			
			this._button.height = 80;
			this._button.width= 260;
			this._button.scaleX= 0;
			this._button.scaleY= 0;
			this._button.pivotX=130;
			this._button.pivotY=40;
			this._button.x=230;
			this._button.y=300;
			
			this.addChild(_button);
			this._button.addEventListener(starling.events.Event.TRIGGERED, btnjouerButton_triggeredHandler);

			this.addChild( labelhaut );
			// on charge c est sur retour qu on met le btn
			// start loading of questions
			var xloader:URLLoader = new URLLoader();
			xloader.addEventListener(flash.events.Event.COMPLETE, xmlLoaded);
			var zurl:URLRequest=new URLRequest("http://www9.noomiz.com/om/jsongetquizz/fbid/"+FBUserFactory.getUser().idfb);
//			zurl.
			xloader.load (zurl);
			var tween1:Tween=new Tween(labelhaut,1,"easeOutElastic");
			tween1.animate("y",120);
			tween1.fadeTo(1);
			Starling.juggler.add(tween1);				

			
		}
		// questions loaded
		public function xmlLoaded(event:flash.events.Event):void {
			var loader:URLLoader = URLLoader(event.target);
//			JSON.p
			this._dataquizz=JSON.parse(loader.data);
			partie.dataquizz=this._dataquizz;
			if(this._dataquizz.ok==1){
				var tween1:Tween=new Tween(_button,2,"easeOutElastic");
				//tween1.animate("x",200);
				tween1.animate("alpha",1);
				tween1.scaleTo(1);
				tween1.delay=1;
				Starling.juggler.add(tween1);				
			}
			//Starling.juggler.add(tween2);
/*
			
			dataXML = selectQuestions(tempXML,10);
			gameSprite.removeChild(messageField);
			messageField = createText("Get ready for the first question!",questionFormat,gameSprite,0,60,550);
			showGameButton("GO!");
*/		}

		
		override protected function draw():void
		{
//			this._header.width = this.actualWidth;
			this._button.validate();
		}
		
		private function btnjouerButton_triggeredHandler(event:starling.events.Event):void
		{
			// passer les données
			this.dispatchEventWith(QUIZZ_SCREEN);
		}		
	}
}