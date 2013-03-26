package
{
	import flash.text.TextFormat;
	
	import feathers.controls.Check;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.renderers.BaseDefaultItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.layout.VerticalLayout;
	
	import starling.events.Event;
	
	public class CustomListRenderer extends BaseDefaultItemRenderer implements IListItemRenderer {
		
		private var _topLabel:Label= new Label();
		private var _bottomLabel:Label = new Label();
		private var _checkBox:Check= new Check();
		//private var _vGroup:VerticalLayout= new VerticalLayout();
//		private var _data:Object;
		private var _index:int = -1;
//		private var _isSelected:Boolean;
//		private var _owner:List;
		
		public function CustomListRenderer() {
			super();			
		}
		
		override public function get data():Object {
			return _data;
		}
		
		override public function set data(value:Object):void {
			if (_data == value) {
				return;
			}
			_data = value;
			invalidate(INVALIDATION_FLAG_DATA);
		}
		
		public function get index():int {
			return _index;
		}
		
		public function set index(value:int):void {
			if (_index == value) {
				return;
			}
			_index = value;
			invalidate(INVALIDATION_FLAG_DATA);
		}
		/*
		override public function get isSelected():Boolean {
			return false;
		}
		
		override public function set isSelected(value:Boolean):void {
			if (_isSelected == value) {
				return;
			}
			_isSelected = value;
			invalidate(INVALIDATION_FLAG_DATA);
		}
		*/
		public function get owner():List {
			return List(_owner);
		}
		
		public function set owner(value:List):void {
			if (_owner == value) {
				return;
			}
			if (_owner) {
				List(_owner).removeEventListener(Event.SCROLL, handleOwnerScrollEvent);
			}
			_owner = value;
			if (_owner) {
				const list:List = List(_owner);
				isToggle = list.isSelectable;
				list.addEventListener(Event.SCROLL, handleOwnerScrollEvent);
			}
			invalidate(INVALIDATION_FLAG_DATA);
		}
		
		private function handleCheckBoxTouchEvent(event:Event):void {
			_data.selected = _checkBox.isSelected ? true : false;
		}
		/*
		override protected function initialize():void {
			super.initialize();
			_checkBox.addEventListener(Event.TRIGGERED, handleCheckBoxTouchEvent);
			_topLabel.textRendererProperties.textFormat = new TextFormat( "Arial", 18, 0x11FFff );
//			addChild(_checkBox);
//			_vGroup.paddingLeft = 16;
//			_vGroup.paddingBottom = 2;
//			_vGroup.paddingTop = 2;
//			_vGroup.gap = 2;
			_topLabel.x=100;
//			_topLabel.
	///		addChild(_topLabel);
		//	addChild(_bottomLabel);
			//			_vGroup.
//			_vGroup.addLayoutItem(_topLabel);
//			_vGroup.addLayoutItem(_bottomLabel);
	//		_vGroup.addElement(_bottomLabel);
//			addChild(_vGroup);
		}
		
		override protected function draw():void {
			super.draw();
			const dataInvalid:Boolean = isInvalid(INVALIDATION_FLAG_DATA);
			if (dataInvalid) {
				if (_data) {
					setSizeInternal(320, 25, false);
					_topLabel.text = _data.label;

					_bottomLabel.text = _data.description;
					_checkBox.isSelected = _data.selected;
				}
			}
			_checkBox.x = actualWidth - _checkBox.width - 20;
			_checkBox.y = (actualHeight / 2) - (_checkBox.height / 2);
			_checkBox.validate();
		}
		*/
		protected function handleOwnerScrollEvent(event:Event):void {
			handleOwnerScroll();
		}
	}
}