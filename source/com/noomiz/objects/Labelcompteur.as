package com.noomiz.objects
{
	import feathers.controls.Label;
	import feathers.themes.OMDesktopTheme;
	
	public class Labelcompteur extends Label
	{
		private var _compteur:Number=0; 
		public function Labelcompteur()
		{
			super();
			this.nameList.add(OMDesktopTheme.ALTERNATE_NAME_OM_CUSTOM_QUIZZPTSC);
			initialize();
			//nameList.add(OMDesktopTheme.ALTERNATE_NAME_OM_CUSTOM_QUIZZPTS);
		}
		public function get compteur():Number
		{
			return _compteur;
		}
		
		public function set compteur(zvalue:Number):void
		{
			_compteur = zvalue;
			this.text=""+_compteur+" pts";
		}
	}
}