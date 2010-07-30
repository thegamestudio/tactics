package 
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Zachary Weston Lewis
	 */
	public class Main extends Engine
	{
		
		public function Main():void 
		{
			super(640, 480);
			FP.screen.scale = 1;
			FP.world = new GameWorld;
		}
		
		override public function init():void 
		{
			super.init();
		}
	}
	
}