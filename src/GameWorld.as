package  
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Stamp;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Zachary Weston Lewis
	 */
	public class GameWorld extends World
	{
		public static var map:Map;
		private var _infoBottom:Image;
		public var texts:Text;
		public static var t:Entity, b:Entity;
		public function GameWorld() 
		{
			
		}
		
		override public function begin():void 
		{	
			//Let's throw down a base tile.
			texts = new Text("TEST", 0, 0, FP.screen.width, 8);
			var i:uint, j:uint;
			var nullSpace:Backdrop = new Backdrop(GP.NULL);
			nullSpace.scrollX = 0;
			nullSpace.scrollY = 0;
			add(new Entity(0,0,nullSpace));
			map = new Map(50, 50);
			add(map);
			add(new Cursor);
			for (i = 0; i < 200; i++)
			{
				var addLoc:Point = new Point(Math.floor(Math.random() * map.Width), Math.floor(Math.random() * map.Height));
				if (!collideRect("unit", addLoc.x * GP.TILE_SIZE, addLoc.y * GP.TILE_SIZE, GP.TILE_SIZE, GP.TILE_SIZE) && map.Data[addLoc.x][addLoc.y] != 0)
				{
					add(new Unit(addLoc.x, addLoc.y));
				}
			}
			
			_infoBottom = new Image(new BitmapData(FP.screen.width, 7, false, 0));
			t = add(new Entity(0, FP.screen.height - 9, texts));
			b = add(new Entity(0, FP.screen.height - 7, _infoBottom));
			Image(b.graphic).alpha = 0.8;
			t.layer = -31;
			b.layer = -30;
			
			super.begin();
		}
		
		override public function update():void 
		{
			super.update();
		}
		
		//public function 
	}

}