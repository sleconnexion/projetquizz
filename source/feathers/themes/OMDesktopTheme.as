package feathers.themes
{
	import com.noomiz.objects.Labelcompteur;
	import com.noomiz.objects.Labelquestion;
	
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.PickerList;
	import feathers.controls.renderers.BaseDefaultItemRenderer;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.display.Scale9Image;
	import feathers.skins.Scale9ImageStateValueSelector;
	import feathers.textures.Scale9Textures;
	
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.textures.Texture;
	
	public class OMDesktopTheme extends AeonDesktopTheme
	{
		[Embed(	source="/../assets/fonts/mafont2.swf",
				fontName="Casual",				
				fontWeight="normal", 
				fontStyle="normal")]		
		protected static const CPX_FONT:Class;

		[Embed(	source="/../assets/fonts/GillSansBold.ttf",
				fontName="GillSans Bold",				
				fontWeight="bold")]
		protected static const CPX_FONTGSB:Class;

		
		public static const ALTERNATE_NAME_MY_CUSTOM_BUTTON:String = "my-custom-button";
		public static const ALTERNATE_NAME_MY_CUSTOM_BUTTON_TEST:String = "my-custom-button-test";
		public static const ALTERNATE_NAME_MY_CUSTOM_BUTTON_MAIN_CHOOSE:String = "my-custom-button-main-choose";
		public static const ALTERNATE_NAME_OM_CUSTOM_LIST:String = "om-custom-list";
		public static const ALTERNATE_NAME_OM_CUSTOM_BIGLABEL:String = "om-custom-biglabel";
		public static const ALTERNATE_NAME_OM_CUSTOM_MAIN_MIDDLE:String = "om-custom-main-middle";
		public static const ALTERNATE_NAME_OM_CUSTOM_GAMESOLO_MIDDLE:String = "om-custom-gamesolo-middle";

		public static const ALTERNATE_NAME_MY_CUSTOM_BUTTON_FERMER:String = "my-custom-button-fermer";
		public static const ALTERNATE_NAME_MY_CUSTOM_BUTTON_QUESTION:String = "my-custom-button-question";
		public static const ALTERNATE_NAME_MY_CUSTOM_BUTTON_BONNEQUESTION:String = "my-custom-button-bonnequestion";
		public static const ALTERNATE_NAME_MY_CUSTOM_BUTTON_MAUVAISEQUESTION:String = "my-custom-button-mauvaisequestion";

		public static const ALTERNATE_NAME_MY_CUSTOM_BUTTON_REPONSE:String = "my-custom-button-reponse";
		public static const ALTERNATE_NAME_MY_CUSTOM_BUTTON_BONNEREPONSE:String = "my-custom-button-bonnereponse";
		public static const ALTERNATE_NAME_MY_CUSTOM_BUTTON_MAUVAISEREPONSE:String = "my-custom-button-mauvaisereponse";

		
		public static const ALTERNATE_NAME_OM_CUSTOM_QUIZZPTS:String = "om-custom-quizzpts";
		public static const ALTERNATE_NAME_OM_CUSTOM_QUIZZPTSC:String = "om-custom-quizzptsc";
		public static const ALTERNATE_NAME_OM_CUSTOM_QUIZZTITRE:String = "om-custom-quizztitre";
		public static const ALTERNATE_NAME_OM_CUSTOM_QUIZZTITRE2:String = "om-custom-quizztitre2";
		public static const ALTERNATE_NAME_OM_CUSTOM_QUIZZQUESTION:String = "om-custom-quizzquestion";
		public static const ALTERNATE_NAME_OM_CUSTOM_QUIZZQUESTIONHDR:String = "om-custom-quizzquestionhdr";
		
		
				
		public function OMDesktopTheme(root:DisplayObjectContainer)
		{
			super(root);
		}
		override protected function initialize():void
		{
			super.initialize();
			
			// set new initializers here
			this.setInitializerForClass( Button, myCustomButtonInitializer, ALTERNATE_NAME_MY_CUSTOM_BUTTON );
			this.setInitializerForClass( Button, myCustomButtonInitializertest, ALTERNATE_NAME_MY_CUSTOM_BUTTON_TEST );
			this.setInitializerForClass( Button, myCustomButtonInitializerfermer, ALTERNATE_NAME_MY_CUSTOM_BUTTON_FERMER);
			this.setInitializerForClass( Button, myCustomButtonMainInitializerQuestion, ALTERNATE_NAME_MY_CUSTOM_BUTTON_QUESTION);
			this.setInitializerForClass( Button, myCustomButtonMainInitializerBonneQuestion, ALTERNATE_NAME_MY_CUSTOM_BUTTON_BONNEQUESTION);
			this.setInitializerForClass( Button, myCustomButtonMainInitializerMauvaiseQuestion, ALTERNATE_NAME_MY_CUSTOM_BUTTON_MAUVAISEQUESTION);

			this.setInitializerForClass( Button, myCustomButtonMainInitializerReponse, ALTERNATE_NAME_MY_CUSTOM_BUTTON_REPONSE);
			this.setInitializerForClass( Button, myCustomButtonMainInitializerBonneReponse, ALTERNATE_NAME_MY_CUSTOM_BUTTON_BONNEREPONSE);
			this.setInitializerForClass( Button, myCustomButtonMainInitializerMauvaiseReponse, ALTERNATE_NAME_MY_CUSTOM_BUTTON_MAUVAISEREPONSE);

			this.setInitializerForClass( Button, myCustomButtonMainInitializer, ALTERNATE_NAME_MY_CUSTOM_BUTTON_MAIN_CHOOSE);
//			this.setInitializerForClass( Label, myCustomLabelInitializer, "MONLABEL");
//			this.setInitializerForClass(CustomListRenderer, omCustomitemRendererInitializer);
			this.setInitializerForClass(Label, myCustomLabelInitializer, ALTERNATE_NAME_OM_CUSTOM_BIGLABEL);
			this.setInitializerForClass(Label, myCustomLabelMiddleInitializer, ALTERNATE_NAME_OM_CUSTOM_MAIN_MIDDLE);
			this.setInitializerForClass(Label, myCustomLabelgamesoloInitializer, ALTERNATE_NAME_OM_CUSTOM_GAMESOLO_MIDDLE);
			this.setInitializerForClass(Label, myCustomLabelquizzptsInitializer, ALTERNATE_NAME_OM_CUSTOM_QUIZZPTS);

			this.setInitializerForClass(Labelcompteur, myCustomLabelquizzptsInitializerc);
			this.setInitializerForClass(Labelquestion, myCustomLabelquizzptsInitializercl);
			
			
			this.setInitializerForClass(Label, myCustomLabelquizztitreInitializer, ALTERNATE_NAME_OM_CUSTOM_QUIZZTITRE);
			this.setInitializerForClass(Label, myCustomLabelquizztitre2Initializer, ALTERNATE_NAME_OM_CUSTOM_QUIZZTITRE2);

			this.setInitializerForClass(Label, myCustomLabelquizzquestionInitializer, ALTERNATE_NAME_OM_CUSTOM_QUIZZQUESTION);
			this.setInitializerForClass(Label, myCustomLabelquizzquestionhdrInitializer, ALTERNATE_NAME_OM_CUSTOM_QUIZZQUESTIONHDR);
			
		}
		
		private function myCustomButtonInitializer( button:Button ):void
		{
//			button.defaultSkin = new Image( upTexture );
//			button.downSkin = new Image( downTexture );
//			button.hoverSkin = new Image( hoverTexture );
//			button.defaultSkin = new Image( PowerUpFactory.getTxt("x1"));
//			button.hoverSkin = new Image( PowerUpFactory.getTxt("x2"));
			/*			button.downSkin = new Image( downTexture );
			button.hoverSkin = new Image( hoverTexture );
			*/			
//			button.defaultLabelProperties.textFormat = this.smallUIDarkTextFormat;
			super.buttonInitializer(button);
			button.height=20;
//			button.disabledLabelProperties.textFormat = this.smallUIDisabledTextFormat;
//			button.selectedDisabledLabelProperties.textFormat = this.smallUIDisabledTextFormat;
			button.defaultLabelProperties.textFormat = new TextFormat( "Arial", 18, 0x1100ff );

		}
		private function myCustomButtonMainInitializer( button:Button ):void
		{
//			var buttonUpSkinTextures:Scale9Textures = new Scale9Textures(this.atlas.getTexture("button-up-skin"), BUTTON_SCALE_9_GRID);
//			this.buttonHoverSkinTextures = new Scale9Textures(this.atlas.getTexture("button-hover-skin"), BUTTON_SCALE_9_GRID);
			super.buttonInitializer(button);
			
			button.defaultSkin = new Scale9Image(buttonSelectedUpSkinTextures2);// new Image( buttonSelectedDownSkinTextures );
			button.hoverSkin = new Scale9Image(buttonSelectedUpSkinTextures22);// new Image( buttonSelectedDownSkinTextures );
			//			button.downSkin = new Image( downTexture );
			//			button.hoverSkin = new Image( hoverTexture );
			//			button.defaultSkin = new Image( PowerUpFactory.getTxt("x1"));
			//			button.hoverSkin = new Image( PowerUpFactory.getTxt("x2"));
			/*			button.downSkin = new Image( downTexture );
			button.hoverSkin = new Image( hoverTexture );
			*/			
			//			button.defaultLabelProperties.textFormat = this.smallUIDarkTextFormat;
			//			button.disabledLabelProperties.textFormat = this.smallUIDisabledTextFormat;
			//			button.selectedDisabledLabelProperties.textFormat = this.smallUIDisabledTextFormat;
			button.defaultLabelProperties.textFormat = new TextFormat( "Arial", 20, 0x000000 );
			
		}
		private function myCustomButtonMainInitializerQuestion( button:Button ):void
		{
			super.buttonInitializer(button);
			
			button.defaultSkin = new Scale9Image(buttonSelectedUpSkinTexturesQuestion);// new Image( buttonSelectedDownSkinTextures );
			button.disabledSkin= new Scale9Image(buttonSelectedUpSkinTexturesBonneQuestion);// new Image( buttonSelectedDownSkinTextures );
			button.hoverSkin=new Scale9Image(buttonSelectedUpSkinTexturesBonneQuestion);// new Image( buttonSelectedDownSkinTextures );
			button.defaultLabelProperties.textFormat = new TextFormat( "Arial", 20, 0x000000 );			
		}
		private function myCustomButtonMainInitializerBonneQuestion( button:Button ):void
		{
			super.buttonInitializer(button);			
			button.defaultSkin = new Scale9Image(buttonSelectedUpSkinTexturesBonneQuestion);// new Image( buttonSelectedDownSkinTextures );
			button.defaultLabelProperties.textFormat = new TextFormat( "Arial", 20, 0x000000,true );			
		}
		private function myCustomButtonMainInitializerMauvaiseQuestion( button:Button ):void
		{
			super.buttonInitializer(button);			
			button.defaultSkin = new Scale9Image(buttonSelectedUpSkinTexturesMauvaiseQuestion);// new Image( buttonSelectedDownSkinTextures );
			button.defaultLabelProperties.textFormat = new TextFormat( "Arial", 20, 0x000000,true );			
		}
		private function myCustomButtonMainInitializerReponse( button:Button ):void
		{
			super.buttonInitializer(button);			
			button.defaultSkin = new Scale9Image(buttonSelectedUpSkinTexturesReponse);// new Image( buttonSelectedDownSkinTextures );
			button.defaultLabelProperties.textFormat = new TextFormat( "Arial", 20, 0x000000,true );			
		}
		private function myCustomButtonMainInitializerBonneReponse( button:Button ):void
		{
			super.buttonInitializer(button);			
			button.defaultSkin = new Scale9Image(buttonSelectedUpSkinTexturesBonneReponse);// new Image( buttonSelectedDownSkinTextures );
			button.defaultLabelProperties.textFormat = new TextFormat( "Arial", 20, 0x000000,true );			
		}
		private function myCustomButtonMainInitializerMauvaiseReponse( button:Button ):void
		{
			super.buttonInitializer(button);			
			button.defaultSkin = new Scale9Image(buttonSelectedUpSkinTexturesMauvaiseReponse);// new Image( buttonSelectedDownSkinTextures );
			button.defaultLabelProperties.textFormat = new TextFormat( "Arial", 20, 0x000000,true );			
		}

		
		
		
		private function myCustomLabelInitializer( label:Label):void
		{
			//			button.defaultSkin = new Image( upTexture );
			//			button.downSkin = new Image( downTexture );
			//			button.hoverSkin = new Image( hoverTexture );
			//			button.defaultSkin = new Image( PowerUpFactory.getTxt("x1"));
			//			button.hoverSkin = new Image( PowerUpFactory.getTxt("x2"));
			/*			button.downSkin = new Image( downTexture );
			button.hoverSkin = new Image( hoverTexture );
			*/			
			//			button.defaultLabelProperties.textFormat = this.smallUIDarkTextFormat;
			super.labelInitializer(label);
			label.textRendererProperties.textFormat = new TextFormat( "Casual", 24, 0x11FFff );
			
		}
		private function myCustomLabelMiddleInitializer( label:Label):void
		{
			//			button.defaultSkin = new Image( upTexture );
			//			button.downSkin = new Image( downTexture );
			//			button.hoverSkin = new Image( hoverTexture );
			//			button.defaultSkin = new Image( PowerUpFactory.getTxt("x1"));
			//			button.hoverSkin = new Image( PowerUpFactory.getTxt("x2"));
			/*			button.downSkin = new Image( downTexture );
			button.hoverSkin = new Image( hoverTexture );
			*/
			//			button.defaultLabelProperties.textFormat = this.smallUIDarkTextFormat;
			super.labelInitializer(label);
			label.textRendererProperties.textFormat = new TextFormat( "Casual", 16, 0x11FF11 );

		}
		private function myCustomLabelgamesoloInitializer( label:Label):void
		{
			super.labelInitializer(label);
			var zz:TextFormat=new TextFormat( "Casual", 16, 0x11FF11 );
			zz.align=TextFormatAlign.CENTER;
			label.textRendererProperties.textFormat = zz;
			
		}
		private function myCustomLabelquizzptsInitializerc( label:Labelcompteur):void
		{
			super.labelInitializer(label);
			var zz:TextFormat=new TextFormat( "GillSans Bold", 36, 0xFFFFFF,true);
			zz.align=TextFormatAlign.RIGHT;
			label.textRendererProperties.textFormat = zz;
		}
		private function myCustomLabelquizzptsInitializercl( label:Labelquestion):void
		{
			super.labelInitializer(label);
			var zz:TextFormat=new TextFormat( "GillSans Bold", 16, 0x3D0B67,true);
			zz.align=TextFormatAlign.LEFT;
			//			zz.leftMargin=10;
			label.textRendererProperties.textFormat = zz;
		}
		private function myCustomLabelquizzptsInitializer( label:Label):void
		{
			super.labelInitializer(label);
			var zz:TextFormat=new TextFormat( "Casual", 16, 0xFFFFFF );
			zz.align=TextFormatAlign.RIGHT;
			label.textRendererProperties.textFormat = zz;
		}
		private function myCustomLabelquizztitreInitializer( label:Label):void
		{
			super.labelInitializer(label);
			var zz:TextFormat=new TextFormat( "GillSans Bold", 24, 0xFFFFFF,true);
			zz.align=TextFormatAlign.LEFT;		
			label.textRendererProperties.textFormat = zz;			
		}
		private function myCustomLabelquizztitre2Initializer( label:Label):void
		{
			super.labelInitializer(label);
			var zz:TextFormat=new TextFormat( "GillSans Bold", 30, 0xFFFFFF,true);
			zz.align=TextFormatAlign.CENTER;		
			label.textRendererProperties.textFormat = zz;			
		}

		
		
		private function myCustomLabelquizzquestionInitializer( label:Label):void
		{
			super.labelInitializer(label);
			var zz:TextFormat=new TextFormat( "GillSans Bold", 16, 0xFFFFFF );
			zz.align=TextFormatAlign.CENTER;
			label.textRendererProperties.textFormat = zz;
			label.textRendererProperties.wordWrap = true;
		}
		private function myCustomLabelquizzquestionhdrInitializer( label:Label):void
		{
			super.labelInitializer(label);
			var zz:TextFormat=new TextFormat( "GillSans Bold", 16, 0x3D0B67,true);
			zz.align=TextFormatAlign.LEFT;
//			zz.leftMargin=10;
			label.textRendererProperties.textFormat = zz;
		}
		private function myCustomButtonInitializertest( button:Button ):void
		{
			//			var buttonUpSkinTextures:Scale9Textures = new Scale9Textures(this.atlas.getTexture("button-up-skin"), BUTTON_SCALE_9_GRID);
			//			this.buttonHoverSkinTextures = new Scale9Textures(this.atlas.getTexture("button-hover-skin"), BUTTON_SCALE_9_GRID);
			super.buttonInitializer(button);
			
			button.defaultSkin = new Scale9Image(buttonSelectedDownSkinTextures);// new Image( buttonSelectedDownSkinTextures );
			button.hoverSkin = new Scale9Image(buttonSelectedDisabledSkinTextures);// new Image( buttonSelectedDownSkinTextures );
			//			button.defaultLabelProperties.textFormat = this.smallUIDarkTextFormat;
			//			button.disabledLabelProperties.textFormat = this.smallUIDisabledTextFormat;
			//			button.selectedDisabledLabelProperties.textFormat = this.smallUIDisabledTextFormat;
			button.defaultLabelProperties.textFormat = new TextFormat( "Arial", 20, 0x000000 );
			button.hoverLabelProperties.textFormat = new TextFormat( "Arial", 22, 0xFF0000 );
		}
		private function myCustomButtonInitializerfermer( button:Button ):void
		{
			//			var buttonUpSkinTextures:Scale9Textures = new Scale9Textures(this.atlas.getTexture("button-up-skin"), BUTTON_SCALE_9_GRID);
			//			this.buttonHoverSkinTextures = new Scale9Textures(this.atlas.getTexture("button-hover-skin"), BUTTON_SCALE_9_GRID);
			super.buttonInitializer(button);			
			button.defaultSkin = new Scale9Image(buttonSelectedDownSkinTexturesfermer);// new Image( buttonSelectedDownSkinTextures );
			button.hoverSkin = new Scale9Image(buttonSelectedDisabledSkinTextures);// new Image( buttonSelectedDownSkinTextures );
			//			button.defaultLabelProperties.textFormat = this.smallUIDarkTextFormat;
			//			button.disabledLabelProperties.textFormat = this.smallUIDisabledTextFormat;
			//			button.selectedDisabledLabelProperties.textFormat = this.smallUIDisabledTextFormat;
		//	button.defaultLabelProperties.textFormat = new TextFormat( "Arial", 20, 0x000000 );
		//	button.hoverLabelProperties.textFormat = new TextFormat( "Arial", 22, 0xFF0000 );			
		}
		
	}
}