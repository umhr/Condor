package 
{
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	/**
	 * ...
	 * @author umhr
	 */
	public class Points extends Sprite 
	{
		private var _mcList:Array = [];
		private var _ptList:Array = [];
		private var _lineMC:Sprite;
		public function Points() 
		{
			init();
		}
		private function init():void 
		{
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}

		private function onInit(event:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			// entry point
			graphics.beginFill(0x222233);
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			graphics.endFill();
			
			var i:int;
			var pair_array:Array = new Array();
			var _array:Array = new Array();
			var pave:Point = new Point();
			var nAveX:Number = new Number(0);
			var nAveY:Number = new Number(0);
			var count:Number = new Number(0);
			var pointcount:Number = new Number(10);
			var pt0:Point = new Point();
			var pt1:Point = new Point();
			var pt2:Point = new Point();
			var pt3:Point = new Point();
			var pt4:Point = new Point();
			var pt5:Point = new Point();
			var pt6:Point = new Point();
			var pt7:Point = new Point();
			var pt8:Point = new Point();
			var pt9:Point = new Point();
			for (i = 0; i < pointcount; i++) {
				var pt:Point = new Point();
				pt.x = 465 * Math.random();
				pt.y = 465 * Math.random();
				_ptList.push(pt);
			}
			pair_array[0] = [true, true, true, false, false, false, false, false, false, false];
			pair_array[1] = [true, true, true, false, false, false, false, false, false, false];
			pair_array[2] = [true, true, true, true, false, false, false, false, false, false];
			pair_array[3] = [false, false, true, true, true, true, false, false, false, false];
			pair_array[4] = [false, false, false, true, true, true, false, false, false, false];
			pair_array[5] = [false, false, false, true, true, true, false, false, false, false];
			///
			pair_array[6] = [false, false, false, false, false, true, false, false, false, false];
			pair_array[7] = [false, false, false, false, false, true, false, false, false, false];
			pair_array[8] = [false, false, false, false, false, true, false, false, false, false];
			pair_array[9] = [false, false, false, false, false, true, false, false, false, false];
			var weight_array:Array = new Array(pointcount);
			for (i = 0; i<pointcount; i++) {
				weight_array[i] = 0;
				for (var j:Number = 0; j<pointcount; j++) {
					if (pair_array[i][j]) {
						weight_array[i]++;
					}
				}
			}
			function fn_move(hoge:Event = null):void {
				var i:int;
				var j:int;
				nAveX = 0;
				nAveY = 0;
				for (i = 0; i<pointcount; i++) {
					nAveX += (_ptList[i].x-232)/pointcount;
					nAveY += (_ptList[i].y-232)/pointcount;
				}
				for (i = 0; i<pointcount; i++) {
					_ptList[i].x -= nAveX/10;
					_ptList[i].y -= nAveY/10;
				}
				///////
				var d:Number = new Number();
				for (i = 0; i<pointcount; i++) {
					var truelength:Number = new Number();
					for (j = 0; j<pointcount; j++) {
						if (i == j) {
							continue;
						}
						d = Point.distance(_ptList[i], _ptList[j]);
						if (!pair_array[i][j]) {
							//this["pt"+i] = Point.interpolate(this["pt"+i], this["pt"+j], 1+(weight_array[i])*0.01/d);
							_ptList[i] = Point.interpolate(_ptList[i], _ptList[j], 1+0.2/(weight_array[i]*d));
						}
						if (pair_array[i][j]) {
							if (d>80) {
								_ptList[i] = Point.interpolate(_ptList[i], _ptList[j], 1-0.0001*d);
							} else {
								_ptList[i] = Point.interpolate(_ptList[i], _ptList[j], 1+0.5/d);
							}
						}
					}
				}
				for (i = 0; i<pointcount; i++) {
					if (_ptList[i].x>465) {
						_ptList[i].x = 465;
					}
					if (_ptList[i].x<0) {
						_ptList[i].x = 0;
					}
					if (_ptList[i].y>465) {
						_ptList[i].y = 465;
					}
					if (_ptList[i].y<0) {
						_ptList[i].y = 0;
					}
				}
				if (!_lineMC) {
					_lineMC = new Sprite();
					addChild(_lineMC);
				}
				_lineMC.graphics.clear();
				for (i = 0; i<pointcount; i++) {
					for (j = 0; j<pointcount; j++) {
						if (i == j || !pair_array[i][j]) {
							continue;
						}
						_lineMC.graphics.lineStyle(1, 0x33ff33, 1);
						_lineMC.graphics.moveTo(_ptList[i].x, _ptList[i].y);
						_lineMC.graphics.lineTo(_ptList[j].x, _ptList[j].y);
						
					}
				}
				for (i = 0; i<pointcount; i++) {
					_mcList[i].x = _ptList[i].x;
					_mcList[i].y = _ptList[i].y;
				}
			}
			for (i = 0; i<pointcount; i++) {
				var _mc:MovieClip = new MovieClip();
				_mc.graphics.lineStyle(3, 0xFF0000);
				_mc.graphics.beginFill(0xFF6666);
				_mc.graphics.drawCircle(0, 0, 10);
				_mc.graphics.endFill();
				addChild(_mc);
				_mcList.push(_mc);
			}
			addEventListener(Event.ENTER_FRAME, fn_move);
			addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			
			function mouseMove(e:MouseEvent):void 
			{
				if (e.buttonDown) {
					var objectList:Array/*Object*/ = stage.getObjectsUnderPoint(new Point(stage.mouseX, stage.mouseY));
					var n:int = objectList.length;
					for (var k:int = 0; k < n; k++) 
					{
						if (objectList[k].toString() == "[object MovieClip]") {
							var mc:MovieClip = objectList[k];
							mc.x = stage.mouseX;
							mc.y = stage.mouseY;
							
							var m:int = _mcList.length;
							for (i = 0; i < m; i++) {
								if (_mcList[i] == mc) {
									_ptList[i].x = _mcList[i].x;
									_ptList[i].y = _mcList[i].y;
								}
							}
							
							
						}
					}
				}
			}
		}
		
	}
	
}