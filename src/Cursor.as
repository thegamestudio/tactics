package  
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Zachary Weston Lewis
	 */
	public class Cursor extends Entity
	{
		private var _loc:Point;
		public function Cursor() 
		{
			graphic = new Image(GP.BIG, new Rectangle(0 * GP.TILE_SIZE, 2 * GP.TILE_SIZE, GP.TILE_SIZE, GP.TILE_SIZE));
			layer = -11;
			FP.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			_loc = new Point;
			width = GP.TILE_SIZE;
			height = GP.TILE_SIZE;
		}
		
		override public function update():void 
		{
			var input:Point = new Point;
			if (Input.pressed(Key.LEFT)) input.x--;
			if (Input.pressed(Key.RIGHT)) input.x++;
			if (Input.pressed(Key.UP)) input.y--;
			if (Input.pressed(Key.DOWN)) input.y++;
			_loc = _loc.add(input);
			input.normalize(GP.TILE_SIZE)
			FP.camera = FP.camera.add(input);
			this.x = GP.TILE_SIZE * _loc.x;
			this.y = GP.TILE_SIZE * _loc.y;
			GameWorld.t.x = FP.camera.x;
			GameWorld.t.y = FP.camera.y + FP.screen.height - 20;
			GameWorld.b.x = FP.camera.x;
			GameWorld.b.y = FP.camera.y + FP.screen.height - 16;
			if (Input.pressed(Key.SPACE) || Input.mousePressed) select();
			if (!input.equals(new Point)) hover();
			super.update();
		}
		
		private function mouseMoveHandler(e:Event):void
		{
			_loc.x = Math.floor(FP.world.mouseX / GP.TILE_SIZE);
			_loc.y = Math.floor(FP.world.mouseY / GP.TILE_SIZE);
			hover();
		}
		
		private function hover():void
		{
			if (FP.world is GameWorld)
			{
				var gw:GameWorld = GameWorld(FP.world);
				var u:Unit = Unit(collide("unit", x, y));
				if (u is Unit)
				{
					if (u.Team == 1) gw.texts.text = "Ally—";
					else gw.texts.text = "Enemy—";
					gw.texts.text += "Speed " + u.Speed;
				}
				else
				{
					if (GP.InBounds(_loc, GameWorld.map.Data))
					{
						switch(GameWorld.map.Data[_loc.x][_loc.y])
						{
							case 1:
								gw.texts.text = "Field—Standard Terrain";
								break;
							
							case 2:
								gw.texts.text = "Rubble—Difficult Terrain";
								break;
							
							case 0:
								gw.texts.text = "Water—Impassable Terrain";
								break;
								
							default:
								break;
						}
					}
					else gw.texts.text = "";
				}
			}
		}
		
		private function select():void
		{
			GameWorld.map.clearOverlay();
			var u:Unit = Unit(collide("unit", x, y));
			if (u is Unit)
			{
				u.select();
			}
		}
		
	}

}