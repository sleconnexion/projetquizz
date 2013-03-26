package feathers.themes
{
	import flash.text.TextFormat;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.PickerList;
	import feathers.controls.renderers.BaseDefaultItemRenderer;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.skins.Scale9ImageStateValueSelector;
	
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	
	public class OMMobileTheme extends MetalWorksMobileTheme
	{
		public static const ALTERNATE_NAME_MY_CUSTOM_BUTTON:String = "my-custom-button";
		public static const ALTERNATE_NAME_OM_CUSTOM_LIST:String = "om-custom-list";
		
		
		public function OMMobileTheme(root:DisplayObjectContainer, scaleToDPI:Boolean=true)
		{
			super(root, scaleToDPI);
		}
		override protected function initialize():void
		{
			super.initialize();
			
			// set new initializers here
			this.setInitializerForClass( Button, myCustomButtonInitializer, ALTERNATE_NAME_MY_CUSTOM_BUTTON );
//			this.setInitializerForClass( Label, myCustomLabelInitializer, "MONLABEL");
			this.setInitializerForClass(CustomListRenderer, omCustomitemRendererInitializer);
		}
		
		protected function omCustomitemRendererInitializer(renderer:BaseDefaultItemRenderer):void
		{
			//return;
			itemRendererInitializer(renderer);
			//return;
			const skinSelector:Scale9ImageStateValueSelector = new Scale9ImageStateValueSelector();
			skinSelector.defaultValue = this.itemRendererUpSkinTextures;
			skinSelector.defaultSelectedValue = this.itemRendererSelectedSkinTextures;
			skinSelector.setValueForState(this.itemRendererSelectedSkinTextures, Button.STATE_DOWN, false);
			skinSelector.imageProperties =
				{
						width: 44 * this.scale,
						height:  22* this.scale,
						textureScale: this.scale
				};
			renderer.stateToSkinFunction = skinSelector.updateValue;
			
			renderer.defaultLabelProperties.textFormat = new TextFormat( "Arial", 12, 0x1100ff );//this.smallLightTextFormat;// largeLightTextFormat;
	//		renderer.downLabelProperties.textFormat = this.largeDarkTextFormat;
	//		renderer.defaultSelectedLabelProperties.textFormat = this.largeDarkTextFormat;
			renderer.height=20*this.scale;
			
			renderer.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
			renderer.paddingTop = renderer.paddingBottom = 8 * this.scale;
			renderer.paddingLeft = 32 * this.scale;
			renderer.paddingRight = 24 * this.scale;
			renderer.gap = 10 * this.scale;
			renderer.iconPosition = Button.ICON_POSITION_LEFT;
			renderer.accessoryGap = Number.POSITIVE_INFINITY;
			renderer.accessoryPosition = BaseDefaultItemRenderer.ACCESSORY_POSITION_RIGHT;
			renderer.minWidth = renderer.minHeight = 88 * this.scale;
			renderer.minTouchWidth = renderer.minTouchHeight = 88 * this.scale;
			
			renderer.accessoryLoaderFactory = this.imageLoaderFactory;
			renderer.iconLoaderFactory = this.imageLoaderFactory;
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
			button.disabledLabelProperties.textFormat = this.smallUIDisabledTextFormat;
			button.selectedDisabledLabelProperties.textFormat = this.smallUIDisabledTextFormat;
			button.defaultLabelProperties.textFormat = new TextFormat( "Arial", 18, 0x1100ff );

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
			label.textRendererProperties.textFormat = new TextFormat( "Arial", 18, 0x11FFff );
			
		}
		
	}
}