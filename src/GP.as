package  
{
	import adobe.utils.CustomActions;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Zachary Weston Lewis
	 */
	public class GP
	{
		[Embed(source = "../assets/characters.png")] public static const CHARACTERS:Class;
		[Embed(source = "../assets/items.png")] public static const ITEMS:Class;
		[Embed(source = "../assets/tiles.png")] public static const TILES:Class;
		[Embed(source = "../assets/null.png")] public static const NULL:Class;
		
		public static const TILE_SIZE:uint = 8;
		
		public static function GetNeighbors(p:Point):Array
		{
			var a:Array = [new Point(1, 0), new Point( -1, 0), new Point(0, 1), new Point(0, -1)];
			for (var i:uint = 0; i < a.length; i++)
			{
				a[i] = p.add(a[i]);
			}
			return a;
		}
		
		public static function GetMoveCost(n:uint):uint
		{
			if (n == 1) return 1;
			if (n == 2) return 2;
			else return 100000;
		}
		
		public static function InBounds(p:Point, a:Array):Boolean
		{
			if (p.x >= 0 && p.x < a.length)
			{
				if (p.y >= 0 && p.y < a[p.x].length) return true;
			}
			return false;
		}
	}
}