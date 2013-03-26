package
{
	import com.noomiz.objects.FBUserFactory;
	
	import flash.display.MovieClip;
	import flash.external.ExternalInterface;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import flash.system.Security;
	import flash.system.SecurityDomain;
	import flash.ui.ContextMenu;
	
	import mx.core.FlexGlobals;
	
	import starling.core.Starling;
	import starling.events.Event;

	[Event(name="choosescreen",type="starling.events.Event")]
//	[SWF(width="320",height="480",frameRate="60",backgroundColor="#ffffff")]
	[SWF(width="458",height="476",frameRate="60",backgroundColor="#ff11ff")]
	public class HelloFeathersStartup extends MovieClip
	{
		public var foo:String="foo";
		var st:Starling ;
		public function HelloFeathersStartup()
		{
			var displaySize:Rectangle= new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			
			// If ExternalInterface is supported, export flexFunction()
			// so it can be called by javascript.
			//SecurityDomain.
//			Security.allowDomain("*"):
			
			Security.allowInsecureDomain("*");			
			if (ExternalInterface.available) {
				trace("Alllllright");
				ExternalInterface.addCallback("flexFunction", flexFunction);
				ExternalInterface.addCallback("setFBID", setFBID);
			} else {
				trace("External inteface unavailable. Couldn't add callback!");
			}
			var menu:ContextMenu = new ContextMenu();
			menu.hideBuiltInItems();
			this.contextMenu = menu;
			Starling.handleLostContext = true;
			Starling.multitouchEnabled = true;
			st = new Starling(HelloFeathers, this.stage,displaySize);
			st.simulateMultitouch = true;
			st.enableErrorChecking = Capabilities.isDebugger;
			st.start();

			st.addEventListener(Event.CONTEXT3D_CREATE, function(e:Event):void
			{
//				st.stage.stageWidth = 120;//320;
//				st.stage.stageHeight = 480;
			});
			
			//			var id:String=Application.application.flashvars.monid;
			
//			var id:String= FlexGlobals.topLevelApplication.parameters.monid;
//trace("IDDDDDD"+id);
	//		st.showStats = true;
		}
		
		public function flexFunction(message:String):String
		{
			try {
				Starling.current.dispatchEventWith("choosescreen",true);
//				dispatchEventWith("choosescreen");
			trace("message:"+message);
			return "flexFunction received: " + message;
			}catch (error:Error){
				return error.message;
			}
			return "";
		}
		public function setFBID(idfromjs:Number):String
		{
			try {
				FBUserFactory.getUser().idfb=idfromjs;
				ExternalInterface.call("flexreadygo", FBUserFactory.getUser().idfb);
				// appel de readygo
			}catch (error:Error){
				return error.message;
			}
			return "";
		}
		
		
	}
}