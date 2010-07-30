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
			super(160, 120);
			FP.screen.scale = 4;
			FP.world = new GameWorld;
		}
		
		override public function init():void 
		{
			super.init();
		}
	}
	
}