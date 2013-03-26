package
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import starling.animation.Juggler;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.utils.Color;
	
	public class Game extends Sprite
	{
		
		var numSymbols:int = 9;
		var numRows:int = 3;
		var numColumns:int = 6;
		var hSpace:int = 95;
		var vSpace:int = 95;
		var clicks:int = 0;
		var firstClick:int;
		var secondClick:int;
		
		var tries:int;
		var correct:int;
		
		var aSpinners:Array = new Array();
		var aSymbols:Array = new Array();
		var aShuffle:Array = new Array();
		var delay:Timer = new Timer(1000,0);		
		var painter:Timer = new Timer(20,(numSymbols*2));

		function noMatch(evt:TimerEvent):void
		{
			aSpinners[firstClick].spinClose();
			aSpinners[secondClick].spinClose();
			//buzz.play();
			delay.stop();
			trace("nope");
		}
		
		function clickSpinner(evt:TouchEvent):void
		{
			//trace("click");
			//trace(evt.getTouch(this));
			var mc:MovieClip=evt.currentTarget as MovieClip;
			
			if(evt.getTouch(this,"ended")){
				trace("vrai click!!!");
//				mc.x += mc.width/2;
				//trace(getObjectFromArt(evt.currentTarget));

				//				mc.pivotY = mc.height / 2;
				//mc.scaleX = -1; // flip horizontally;
				
//				mc.scaleX=-1;
				/*
				var mc:MovieClip=evt.target
				evt.target.scaleX=-1;*/
				
				var tween:Tween = new Tween(mc, 0.1, Transitions.EASE_IN_OUT);
				var tween2:Tween = new Tween(mc, 0.1, Transitions.EASE_IN_OUT);
				var tween3:Tween = new Tween(mc, 0.1, Transitions.EASE_IN_OUT);
				//tween.animate("x", mc.x + mc.width);
				tween.animate("scaleX",0);
//				tween.animate("rotation", mc.rotation-Math.PI/2);
//				mc.texture=PowerUpFactory.getTxt("x2");
				tween.onComplete = function(zarray:Array):void { 
					trace("tween complete!"); 
					trace(zarray);
					trace(zarray.length);
					trace(zarray[0]);
				var lemc:MovieClip = zarray[0] as MovieClip;
				lemc.texture=PowerUpFactory.getTxt(PowerUpFactory.IMGOFF);
				
				};
				var z:Array=new Array();
				var zz:Array=new Array();
				
				zz.push(mc);
				z.push(zz);
				tween.onCompleteArgs=z;
				//tween.animate("x", mc.x + 50);
				tween2.animate("scaleX", 1);
				
				//tween.animate("rotation", Math.PI/4);
	//			tween.fadeTo(0);    // equivalent to 'animate("alpha", 0)'
	//			tween2.fadeTo(1);    // equivalent to 'animate("alpha", 0)'

				
				tween.nextTween=tween2;
		//		tween2.nextTween=tween3;
				
				tween3.moveTo(0, 20); // animating "x" and "y"
				tween3.scaleTo(2);    // animating "scaleX" and "scaleY"
				tween3.fadeTo(0);     //
				
				
				Starling.juggler.add(tween);
				
				
			} else {
				/*
				var tween:Tween = new Tween(mc, 0.1, Transitions.EASE_OUT_BOUNCE);
				var tween2:Tween = new Tween(mc, 0.1, Transitions.EASE_IN_OUT);
//tween.animate("rotation",Math.PI/10);
								tween.scaleTo(1.1);
//				tween2.scaleTo(1);
//tween2.animate("rotation",0);

//tween.nextTween=tween2;
				
				Starling.juggler.add(tween);
				*/
				
			}
		
			return;
//			evt.target.spinOpen();
			if (clicks == 0)
			{
				firstClick = evt.target.index;
				clicks = 1;
			}
			else
			{
				if (evt.target.index != firstClick)
				{
					tries += 1;
					tTries.text = String(tries);
					secondClick = evt.target.index;
					if (evt.target.symbol == aSpinners[firstClick].symbol)
					{
						trace("match");
						ding.play();
						applause.play();
						correct += 1;
						tCorrect.text = String(correct);
						if (correct == numSymbols)
						{
							mWin.visible = true;
							bStart.visible = true;
						}
					}
					else
					{
						trace("no match");
						delay.start();
						
					}
					clicks = 0;
				}
			}
		}
		
		
		function paintNewSymbol(evt:TimerEvent):void
		{
			
			trace("new", painter.currentCount);
			var i = painter.currentCount - 1;
			var currentRow:int = Math.floor(i/numColumns);
			var currentColumn:int = i - (currentRow * numColumns);
			PowerUpFactory.getRandom();
			//aSpinners[i] = new Spinner(i);
			aSpinners[i] = PowerUpFactory.getRandom();
			//var x:flash.display.MovieClip;
			
			addChild(aSpinners[i]);
			aSpinners[i].x = currentColumn *hSpace;
			aSpinners[i].y = currentRow * vSpace;
			//aSpinners[i].symbol = aShuffle[i];
			aSpinners[i].addEventListener(TouchEvent.TOUCH, clickSpinner);
		}
		
		function setUpSymbols():void
		{
			aShuffle = [];
			for (var i:int = 0; i<numSymbols*2; i++)
			{
				if ( i < numSymbols)
				{
					aSymbols[i] = i +10;
				}
				else
				{
					aSymbols[i] = i+1;
				}
			}
			
			for (var j:int = 0; j<numSymbols*2; j++)
			{
				var index:int = Math.floor(Math.random()*aSymbols.length);
				aShuffle.push(aSymbols[index]);
				aSymbols.splice(index,1);
			}
			
		}
		
		function drawSymbols():void
		{
			trace("symbols to remove");
			var numToRemove:int = numChildren;
			
			for (var index:int = 0; index<numToRemove; index++)
			{
				trace("remove", index);
				removeChildAt(0);
			}			
		}
		
		
		
		public function Game()
		{
			trace("Game constructor");
			var quad:Quad = new Quad(200, 200, Color.RED);
			quad.x = 100;
			quad.y = 50;
			addChild(quad);

			setUpSymbols();
			drawSymbols();
			delay.addEventListener(TimerEvent.TIMER, noMatch);
			painter.addEventListener(TimerEvent.TIMER, paintNewSymbol);
			tries = 0;
			correct = 0;
			painter.start();
//			tTries.text = String(tries);
//			tCorrect.text  = String(correct);
//			mWin.visible = false;
//			bStart.visible = false;			
			
			
			
			return;
			trace("123");
			var mc:MovieClip=PowerUpFactory.getRandom();
			addChild(mc);
			for (var i:uint=0;i<4;i++){
				var mc:MovieClip=PowerUpFactory.getRandom();
				
				mc.x=100*i;
				addChild(mc);
				
			}
		//	var monbt:Button=new Button(PowerUpFactory.getTxt("x1"));
		//	monbt.text="JOUER";
		//	monbt.x=350;
		//	monbt.y=20;
		//	monbt.addEventListener(Event.TRIGGERED,clickme);

		}
		function clickme(event:Event):void
		{
			trace("The button was triggered!");
		}
		
	}
}