package {
  import flash.display.Bitmap;
  
  import starling.display.MovieClip;
  import starling.textures.Texture;
  import starling.textures.TextureAtlas;

  public class PowerUpFactory {

    [Embed(source = "/../assets/images/montest2.png")]
    private static const montest_imageSpriteSheet:Class;
    [Embed(source = "/../assets/images/montest2.xml", mimeType = "application/octet-stream")]
    private static const montest_atlas:Class;
    private static var montest_bitmap:Bitmap = Bitmap(new montest_imageSpriteSheet());

    private static var montest_textureAtlas:TextureAtlas = null;

    public static const IMG1:String = "x1";
	public static const IMG2:String = "x2";
	public static const IMG3:String = "x3";
	public static const IMG4:String = "x4";
	public static const IMG5:String = "x5";
	public static const IMG6:String = "x6";
	public static const IMG7:String = "x7";
	public static const IMG8:String = "x8";
	public static const IMG9:String = "x9";
	public static const IMGOFF:String="min-off";
	public static const IMGSTAR32:String="monstar32";
	
    public static const SHELL_GREY:String = "SHELL_GREY";
    public static const SHELL_GOLD:String = "SHELL_GOLD";
    public static const SHELL_ROCK:String = "SHELL_ROCK";

    public function PowerUpFactory() {
    }

    private static function init():void {
      if (!montest_textureAtlas) {
        montest_textureAtlas = new TextureAtlas(Texture.fromBitmap(montest_bitmap), XML(new montest_atlas()));
      }
    }

    public static function get(id:String):MovieClip {
		init();
      	var ret:MovieClip = new MovieClip(montest_textureAtlas.getTextures(id));
//	  	ret.width=ret.height=50;
//		ret.pivotX = ret.width  / 2;
//		ret.x=-ret.width  / 2;
      	return ret;
    }

	public static function getTxt(id:String):Texture {
		init();
		return montest_textureAtlas.getTexture(id);
	}
    public static function getRandom():MovieClip {
      var ids:Array = [IMG1, IMG2,IMG3,IMG4,IMG5,IMG6,IMG7,IMG8,IMG9];
      var randomId:String = ids[Math.floor(Math.random() * ids.length)];
      return get(randomId);
    }

  }
}
