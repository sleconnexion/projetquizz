package com.noomiz.sounds
{
	import flash.media.Sound;
	import flash.media.SoundLoaderContext;
	import flash.net.URLRequest;
	
//	[Embed (source="/../assets/sons/Electrical_Sweep-Sweeper-1760111493.mp3")]
	[Embed (source="/../assets/sons/magic-wand-1.mp3")]	
	public class MemoryHome extends Sound
	{
		public function MemoryHome(stream:URLRequest=null, context:SoundLoaderContext=null)
		{
			super(stream, context);
		}
	}
}