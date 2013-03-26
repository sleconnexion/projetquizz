package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import starling.core.Starling;
	
	[SWF(width="600", height="400", frameRate="60", backgroundColor="#00FF00")]
	public class Montest extends Sprite
	{
		private var mStarling:Starling;
		
		public function Montest()
		{
			// These settings are recommended to avoid problems with touch handling
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			// Create a Starling instance that will run the "Game" class
			mStarling = new Starling(Game, stage);
			mStarling.start();
			
		}	
	
	}
}