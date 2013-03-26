package com.noomiz.objects
{
	public class FBUserFactory
	{
		private static var _leuser:FBUser=null;
		public function FBUserFactory()
		{
		}
		public static function getUser():FBUser{
			if(!_leuser){
				_leuser=new FBUser();
			}
			return _leuser;
		}
	}
}