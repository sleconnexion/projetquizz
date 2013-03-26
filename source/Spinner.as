package{
	
	import flash.display.MovieClip;
	import fl.transitions.Tween;
	import fl.transitions.easing.Regular;
	import fl.transitions.TweenEvent;
	
	public class Spinner extends MovieClip {
		
		public var index:int;
		public var symbol:int;
		
		function Spinner(i:int):void {
			this.index = i;
		}
		public function spinOpen():void{
			trace("spin open ", this.symbol);
			var openTween:Tween = new Tween(this, "scaleX", Regular.easeIn, 1, 0, .1, true);
			openTween.addEventListener(TweenEvent.MOTION_FINISH, finishOpen);
			
		}
		private function finishOpen(evt:TweenEvent):void{
			trace("finish open ", this.symbol);
			this.gotoAndStop(this.symbol);
			var openFinishTween:Tween = new Tween(this, "scaleX", Regular.easeIn, 0, 1, .1, true);
		}
		public function spinClose():void{
			trace("spin closed ", this.symbol);
			var closeTween:Tween = new Tween(this, "scaleX", Regular.easeIn, 1, 0, .1, true);
			closeTween.addEventListener(TweenEvent.MOTION_FINISH, finishClose);
			
		}
		private function finishClose(evt:TweenEvent):void{
			trace("finished closed ", this.symbol);
			this.gotoAndStop(1);
			var closeFinishTween:Tween = new Tween(this, "scaleX", Regular.easeIn, 0, 1, .1, true);
		}
	}
	
}