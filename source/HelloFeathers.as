package
{
	import com.noomiz.objects.Partie;
	import com.noomiz.screens.MainScreen;
	import com.noomiz.screens.QuizzScreen;
	import com.noomiz.sounds.ScreenTrans;
	
	import flash.system.Capabilities;
	
	import feathers.controls.Button;
	import feathers.controls.Callout;
	import feathers.controls.Label;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.events.FeathersEventType;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
	//import feathers.themes.MetalWorksMobileTheme;
	import feathers.themes.OMDesktopTheme;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class HelloFeathers extends Sprite
	{
		private static const MAIN_SCREEN:String = "mainscreen";
		private static const QUIZZ_SCREEN:String = "quizzscreen";
		private static const DEFI_SCREEN:String = "defiscreen";
		private static const TEST_SCREEN:String = "testscreen";
		
		public function HelloFeathers()
		{
			this.addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );

		}
		
//		protected var theme:MetalWorksMobileTheme;
//		protected var theme:AeonDesktopTheme;
//		protected var theme:OMMobileTheme;
		protected var theme:OMDesktopTheme;
		protected var button:Button;
		private var _navigator:ScreenNavigator;
		private var _transitionManager:ScreenSlidingStackTransitionManager;
		private var _snd=new ScreenTrans();
		
		protected function addedToStageHandler( event:Event ):void
		{
			
			
			/*
			DeviceCapabilities.dpi = 72;//326;//200;//326;
///			DeviceCapabilities.dpi = 180;
			
//x			DeviceCapabilities.screenPixelWidth = 480;//320;//600;
//x			DeviceCapabilities.screenPixelHeight = 320;//480;//400;
			DeviceCapabilities.screenPixelWidth = 450;//stage.stageWidth;
			DeviceCapabilities.screenPixelHeight = 600;//stage.stageHeight;
			/*
			public static const DIMX :Number = Capabilities.screenResolutionX;
			public static const DIMY :Number =Capabilities.screenResolutionY;
			
			var image:Image = new Image(getTexture(imgName));
			var scaleSixe:Number = (DIMX / image.width);
			image.scaleY = image.scaleX = scaleSixe;
			
			return immagine;
			*/
			trace("Capabilities.screenResolutionX:"+Capabilities.screenResolutionX);
			
//			this.theme = new MetalWorksMobileTheme( this.stage );
//			this.theme = new OMMobileTheme( this.stage );
			this.theme = new OMDesktopTheme( this.stage );
			// mon exemple						

			this._navigator = new ScreenNavigator();
			this.addChild(this._navigator);
//			this._navigator.addEventListener(FeathersEventType.TRANSITION_COMPLETE, owner_transitionCompleteHandler );
			this._navigator.addEventListener(FeathersEventType.TRANSITION_START, owner_transitionCompleteHandler );
			var partie:Partie=new Partie();
			
			this._navigator.addScreen(MAIN_SCREEN,new ScreenNavigatorItem(MainScreen,
				{
				quizzscreen:QUIZZ_SCREEN
				},
				{partie:partie}));
			
			this._navigator.addScreen(QUIZZ_SCREEN, new ScreenNavigatorItem(QuizzScreen,
				{
					complete: MAIN_SCREEN,
					defiscreen: DEFI_SCREEN
				},
				{partie:partie}));			
			
			this._navigator.showScreen(MAIN_SCREEN);
			
			this._transitionManager = new ScreenSlidingStackTransitionManager(this._navigator);
			this._transitionManager.duration = 0.4;
						
			this.button = new Button();
			this.button.label = "WELCOME !!";
//			this.button.nameList.add(MetalWorksPslOverrides.ALTERNATE_NAME_MY_CUSTOM_BUTTON);

			
			//			this.button.width=200;
//			this.button.height=80;
			
			
			//this.addChild( button );
			
			this.button.addEventListener( Event.TRIGGERED, button_triggeredHandler );
			
			this.button.validate();
			this.button.x = (this.stage.stageWidth - this.button.width) / 2;
			this.button.y = (this.stage.stageHeight - this.button.height) / 2;
			
			
		}
		private function owner_transitionCompleteHandler( event:Event ):void
		{
			this._snd.play();
			//this._navigator.removeEventListener( FeathersEventType.TRANSITION_COMPLETE, owner_transitionCompleteHandler );
			
			// finish initialization here
		}
		
		protected function button_triggeredHandler( event:Event ):void
		{
			const label:Label = new Label();
			label.text = "Hi, I'm Feathers!\nHave a nice day.";
			Callout.show(label, this.button);
			//this._navigator.showScreen(DEFI_SCREEN);
		}
	}
}