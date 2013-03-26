package com.noomiz.objects
{
	import feathers.controls.Label;
	import feathers.themes.OMDesktopTheme;
	
	public class Labelquestion extends Label
	{
		private var _compteur:uint=0; 
		public function Labelquestion()
		{
			super();
			initialize();
			//nameList.add(OMDesktopTheme.ALTERNATE_NAME_OM_CUSTOM_QUIZZPTS);
		}
		public function get compteur():uint
		{
			return _compteur;
		}
		
		public function set compteur(zvalue:uint):void
		{
			_compteur = zvalue;
			this.text=" + "+_compteur+"";
		}
	}
}