package  
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Zachary Weston Lewis
	 */
	public class Unit extends Entity
	{
		protected var _character:Point;
		protected var _location:Point;
		protected var _speed:uint;
		protected var _team:uint;
		public function get Team():uint { return _team; }
		public function get Speed():uint { return _speed; };
		public function Unit(x:Number, y:Number) 
		{
			this._location = new Point(x, y);
			_team = Math.floor(Math.random() * 2);
			if (_team == 0) this.graphic = new Image(GP.BIG, new Rectangle(0 * GP.TILE_SIZE, 0 * GP.TILE_SIZE, GP.TILE_SIZE, GP.TILE_SIZE));
			else this.graphic = new Image(GP.BIG, new Rectangle(1 * GP.TILE_SIZE, 0 * GP.TILE_SIZE, GP.TILE_SIZE, GP.TILE_SIZE));
			this.x = _location.x*GP.TILE_SIZE;
			this.y = _location.y * GP.TILE_SIZE;
			type = "unit";
			layer = -12;
			width = GP.TILE_SIZE;
			height = GP.TILE_SIZE;
			_speed = Math.floor(Math.random() * 6 + 2);
			
			
		}
		
		public function select():void
		{
			//GameWorld.CenterCameraOn(this);
			highlightMoveRange();
			trace("T" + _team + " S" + _speed);
		}
		
		private function highlightMoveRange():void
		{
			var frontier:Array = new Array;
			var cost:Array = new Array(GameWorld.map.Width);
			
			var i:uint, j:uint;
			//create cost array
			for (i = 0; i < GameWorld.map.Width; i++)
			{
				cost[i] = new Array(GameWorld.map.Height);
				for (j = 0; j < GameWorld.map.Height; j++)
				{
					cost[i][j] = 5000;
				}
			}
			
			frontier.push(_location);
			cost[_location.x][_location.y] = 0;
			GameWorld.map.setOverlay(_location, 1);
			var values:Array = new Array(GameWorld.map.Width);
			while (frontier.length != 0)
			{
				var p:Point = Point(frontier.pop());
				var neighbors:Array = new Array;
				neighbors = GP.GetNeighbors(p);
				
				for each(var n:Point in neighbors)
				{
					if (GP.InBounds(n, cost))
					{
						
						var newCost:uint =  cost[p.x][p.y] + GP.GetMoveCost(GameWorld.map.Data[n.x][n.y]);
						var u:Unit = Unit(collide("unit", n.x * GP.TILE_SIZE, n.y * GP.TILE_SIZE));
						if (u && _team != u.Team) newCost = 5000;
						if (newCost <= _speed && cost[n.x][n.y] > newCost)
						{
							if(!u) GameWorld.map.setOverlay(n, 1);
							cost[n.x][n.y] = newCost;
							frontier.push(n);
						}
					}
				}
			}
			GameWorld.map.setOverlay(_location, 0);
			
		}
		
	}

}