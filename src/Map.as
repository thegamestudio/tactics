package  
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import flash.geom.Rectangle;
	/**
	 * Describes the game map.
	 * @author Zachary Weston Lewis
	 */
	public class Map extends Entity
	{
		protected var _map:Array;
		protected var _overlay:Array;
		protected var _dim:Point;
		public function get Data():Array { return _map; }
		public function get Height():uint { return _dim.y; }
		public function get Width():uint { return _dim.x; }
		public function Map(width:uint, height:uint) 
		{
			x = 0;
			y = 0;
			graphic = new Image(GP.TILES, new Rectangle);
			var i:uint, j:uint;
			layer = -10;
			_dim = new Point(width, height);
			_map = new Array(_dim.x);
			_overlay = new Array(_dim.x);
			for (i = 0; i < _dim.x; i++)
			{
				_map[i] = new Array(_dim.y);
				_overlay[i] = new Array(_dim.y);
				for (j = 0; j < _dim.y; j++)
				{
					var r:Number = Math.random();
					//*
					if (r > 0.4) _map[i][j] = 1;
					else if (r > 0.05) _map[i][j] = 2;
					else _map[i][j] = 0;
					//*/
					//_map[i][j] = 1;
					_overlay[i][j] = 0;
				}
			}
		}
		
		override public function render():void 
		{
			var i:uint, j:uint;
			for (i = 0; i < _dim.x; i++)
			{
				for (j = 0; j < _dim.y; j++)
				{
					var im:Image = null, ovr:Image = null;
					if (_overlay[i][j] != 0) ovr = new Image(GP.ITEMS, new Rectangle(11 * GP.TILE_SIZE, 11 * GP.TILE_SIZE, GP.TILE_SIZE, GP.TILE_SIZE));
					if (_map[i][j] == 1)
					{
						im = new Image(GP.TILES, new Rectangle(8 * GP.TILE_SIZE, 4 * GP.TILE_SIZE, GP.TILE_SIZE, GP.TILE_SIZE))
					}
					else if (_map[i][j] == 2)
					{
						im = new Image(GP.TILES, new Rectangle(2 * GP.TILE_SIZE, 6 * GP.TILE_SIZE, GP.TILE_SIZE, GP.TILE_SIZE))
					}
					else
					{
						im = new Image(GP.TILES, new Rectangle(2 * GP.TILE_SIZE, 7 * GP.TILE_SIZE, GP.TILE_SIZE, GP.TILE_SIZE))
					}
					im.render(new Point(i * GP.TILE_SIZE, j * GP.TILE_SIZE), FP.camera);
					if(ovr) ovr.render(new Point(i * GP.TILE_SIZE, j * GP.TILE_SIZE), FP.camera);
				}
			}
			//super.render();
		}
		
		public function clearOverlay():void
		{
			var i:uint, j:uint;
			for (i = 0; i < _dim.x; i++)
			{
				for (j = 0; j < _dim.y; j++)
				{
					_overlay[i][j] = 0;
				}
			}
		}
		
		public function setOverlay(p:Point, i:uint):void
		{
			if(GP.InBounds(p,_overlay))	_overlay[p.x][p.y] = i;
		}
	}
}