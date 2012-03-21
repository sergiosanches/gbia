package
{
	import flash.display.CapsStyle;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author sergio.sanches
	 */
	public class Main extends Sprite
	{
		static private const MIN_LINE_THICKNESS:Number = 50;
		static private const MAX_LINE_THICKNESS:Number = 300;
		
		static private const MIN_NUM_LINES:Number = 2;
		static private const MAX_NUM_LINES:Number = 50;
		
		static private const HELP_TEXT:String = "Scroll wheel - Draw more random lines\nLeft mouse button - Clear lines\n";
		
		private var helpTextBox_tf:TextField;
		
		private var maxWidth:Number;
		private var maxHeight:Number;
		
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
			showHelp();
			
			maxWidth = stage.stageWidth;
			maxHeight = stage.stageHeight;
			
			listOfLines = new Array();
			
			generateRandomLines(null);
			
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, this.generateRandomLines);
			stage.addEventListener(MouseEvent.CLICK, this.clearAllLines);
		}
		
		/**
		 * Shows information about the objects and behaviour.
		 */
		private function showHelp():void
		{
			if (!helpTextBox_tf)
			{
				helpTextBox_tf = new TextField();
				helpTextBox_tf.autoSize = TextFieldAutoSize.LEFT;
				//helpTextBox_tf.width = 250;
				//helpTextBox_tf.height = 40;
				helpTextBox_tf.background = true;
				helpTextBox_tf.backgroundColor = 0x000000;
				helpTextBox_tf.text = HELP_TEXT;
				
				var helpText_tfmt:TextFormat = new TextFormat("Arial", 12, 0x00FF00);
				helpTextBox_tf.setTextFormat(helpText_tfmt);
				
				stage.addChild(helpTextBox_tf);
			}
			
			// TODO: switch visibility
		}
		
		/**
		 * Clears all lines in the stage.
		 * @param	e
		 */
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
			
			var i:Number = 0;
			while (listOfLines.length > MAX_NUM_LINES)
			{
				this.removeChild(listOfLines.shift());
				i++;
			}
			if (i) trace ("purged " + i + " lines...");
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
		 * Generates a random point inside the stage dimensions.
		 * @return	Point inside the stage.
		 */
		private function genPoint():Point
		{
			if (!maxHeight || !maxWidth)
			{
				return null;
			}
			
			return new Point(Math.random() * (maxWidth - 1) + 1, Math.random() * (maxHeight - 1) + 1);
		}
		
		/**
		 * Generates a random value for line thickness.
		 * @return	Line thickness between MIN_LINE_THICKNESS and MAX_LINE_THICKNESS.
		 */
		private function genLineThickness():Number
		{
			return Math.random() * (MAX_LINE_THICKNESS - MIN_LINE_THICKNESS) + MIN_LINE_THICKNESS;
		}
		
		/**
		 * Generates a random color.
		 * @return	Random color between black (0x000000) and white (0xFFFFFF).
		 */
		private function genColor():uint
		{
			return Math.random() * 0xFFFFFF;
		}
		
	}
	
}
