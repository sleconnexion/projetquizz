package com.noomiz.sounds
{
	import flash.media.Sound;
	import flash.media.SoundLoaderContext;
	import flash.net.URLRequest;
	
	[Embed (source="/../assets/sons/applause-6.mp3")]
	public class MemorySucceed extends Sound
	{
		public function MemorySucceed(stream:URLRequest=null, context:SoundLoaderContext=null)
		{
			super(stream, context);
		}
	}
}