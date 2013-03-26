package com.noomiz.sounds
{
	import flash.media.Sound;
	import flash.media.SoundLoaderContext;
	import flash.net.URLRequest;
	
	[Embed (source="/../assets/sons/montest2.mp3")]
	public class ScreenTrans extends Sound
	{
		public function ScreenTrans(stream:URLRequest=null, context:SoundLoaderContext=null)
		{
			super(stream, context);
		}
	}
}