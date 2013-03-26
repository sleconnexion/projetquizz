package com.noomiz.sounds
{
	import flash.media.Sound;
	import flash.media.SoundLoaderContext;
	import flash.net.URLRequest;
	
	[Embed (source="/../assets/sons/beep1_tr17230.mp3")]
	public class Clickbtn1 extends Sound
	{
		public function Clickbtn1(stream:URLRequest=null, context:SoundLoaderContext=null)
		{
			super(stream, context);
		}
	}
}