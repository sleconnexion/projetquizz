package feathers.themes
{
	import feathers.themes.MetalWorksMobileTheme;
	import starling.display.DisplayObjectContainer;
	import feathers.controls.Button;
	import flash.text.TextFormat;
	
	public class MetalWorksPslOverrides extends MetalWorksMobileTheme
	{
		public static const ALTERNATE_NAME_MY_CUSTOM_BUTTON:String = "my-custom-button";
		
		private const fontNames:String = "Helvetica Neue,Helvetica,Roboto,Arial,_sans";
		
		public function MetalWorksPslOverrides( root:DisplayObjectContainer, scaleToDPI:Boolean = true )
		{
			
			super( root, scaleToDPI );
		}
		
		override protected function initialize():void
		{
			
			super.initialize();
			
			this.setInitializerForClass( Button, myCustomButtonInitializer, ALTERNATE_NAME_MY_CUSTOM_BUTTON );
		}
		
		private function myCustomButtonInitializer( button:Button ):void
		{
			
			/*
			[Embed(source='/../assets/images/fonts/MSYHBD.ttf', embedAsCFF='false', fontName='MSYHBD')]
			public static var Msyhbd:Class;
			this.font = new Msyhbd();
			button.labelFactory = function():ITextRenderer{
			return new TextFieldTextRenderer();
			}
			this.button.defaultLabelProperties.textFormat = new TextFormat(font.fontName, 30, 0x000000);
			button.defaultLabelProperties.embedFonts = true;
			*/
			
			/*
			button.defaultSkin = new Image( upTexture );
			button.downSkin = new Image( downTexture );
			button.hoverSkin = new Image( hoverTexture );
			*/
			
			button.defaultLabelProperties.textFormat = new TextFormat(fontNames, 48 * this.scale, 0x000000);
			
			/*
			button.defaultLabelProperties.textFormat = this.smallUIDarkTextFormat;
			button.disabledLabelProperties.textFormat = this.smallUIDisabledTextFormat;
			button.selectedDisabledLabelProperties.textFormat = this.smallUIDisabledTextFormat;
			*/
		}
		
	}
}