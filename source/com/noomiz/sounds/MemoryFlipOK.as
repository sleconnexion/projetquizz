package com.noomiz.sounds
{
	import flash.media.Sound;
	import flash.media.SoundLoaderContext;
	import flash.net.URLRequest;
	
	[Embed (source="/../assets/sons/montest.mp3")]
	public class MemoryFlipOK extends Sound
	{
		public function MemoryFlipOK(stream:URLRequest=null, context:SoundLoaderContext=null)
		{
			super(stream, context);
		}
	}
}