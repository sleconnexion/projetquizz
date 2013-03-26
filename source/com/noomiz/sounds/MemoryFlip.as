package com.noomiz.sounds
{
	import flash.media.Sound;
	import flash.media.SoundLoaderContext;
	import flash.net.URLRequest;
	
	[Embed (source="/../assets/sons/sound11.mp3")]
	public class MemoryFlip extends Sound
	{
		public function MemoryFlip(stream:URLRequest=null, context:SoundLoaderContext=null)
		{
			super(stream, context);
		}
	}
}