package
{
	import flash.display.CapsStyle;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author sergio.sanches
	 */
	public class Main extends Sprite
	{
		static public const MIN_LINE_THICKNESS:Number = 50;
		static public const MAX_LINE_THICKNESS:Number = 300;
		
		static public const MIN_NUM_LINES:Number = 2;
		static public const MAX_NUM_LINES:Number = 50;
		
		private var max_width:Number;
		private var max_height:Number;
		
		private var listOfLines:Array;
		
		/**
		 * Constructor.
		 */
		public function Main()
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		/**
		 * Class initialization.
		 * @param	e
		 */
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			// entry point
			max_width = stage.stageWidth;
			max_height = stage.stageHeight;
			
			listOfLines = new Array();
			
			generateRandomLines(null);
			
			stage.addEventListener(MouseEvent.CLICK, this.generateRandomLines);
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, this.clearAllLines);
		}
		
		private function clearAllLines(e:MouseEvent):void
		{
			trace("number of lines in array: " + listOfLines.length);
			trace("numChildren: " + this.numChildren);
			
			for (var n:Number = listOfLines.length; n > 0; n--)
			{
				this.removeChild(listOfLines.pop());
			}
		}
		
		/**
		 * Generates a random number of lines and draws them on the stage.
		 * @param	e
		 */
		private function generateRandomLines(e:MouseEvent):void
		{
			var n:Number = Math.random() * (MAX_NUM_LINES - MIN_NUM_LINES) + MIN_NUM_LINES;
			for (var i:Number = 0; i < n; i++) {
				drawLine();
			}
		}
		
		/**
		 * Draws a random line inside the stage.
		 */
		private function drawLine():void
		{
			var pointA:Point = genPoint();
			var pointB:Point = genPoint();
			
			var line:Shape = new Shape();
			line.graphics.lineStyle(genLineThickness(), genColor(), Math.random(), true, null, CapsStyle.NONE);
			line.graphics.moveTo(pointA.x, pointA.y);
			line.graphics.lineTo(pointB.x, pointB.y);
			
			listOfLines.push(this.addChild(line));
		}
		
		/**
		 * Generates a point inside the stage dimensions.
		 * @return	Random point.
		 */
		private function genPoint():Point
		{
			return new Point(Math.random() * (max_width - 1) + 1, Math.random() * (max_height - 1) + 1);
		}
		
		/**
		 * Generates line thickness for drawing lines, up to a thickness of MAX_LINE_THICKNESS.
		 * @return	Line thickness between 1 and MAX_LINE_THICKNESS.
		 */
		private function genLineThickness():Number
		{
			return Math.random() * (MAX_LINE_THICKNESS - MIN_LINE_THICKNESS) + MIN_LINE_THICKNESS;
		}
		
		/**
		 * Generates a random color between black and white.
		 * @return	Random color between black and white.
		 */
		private function genColor():uint
		{
			return Math.random() * 0xFFFFFF;
		}
		
	}
	
}
