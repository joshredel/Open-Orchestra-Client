package org.cim.components.xmloverlay {
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	import mx.core.UIComponent;
	
	import spark.components.Label;
	
	[Bindable]
	/**
	 * A measure represents the final overlay for a measure of music.
	 */
	public final class Measure extends UIComponent {
		/**
		 * The measure number.
		 */
		public var number:int;
		
		/**
		 * The time the measure represents in the recordings (in seconds).
		 */
		public var time:int = number * 5;
		
		/**
		 * The measure width.
		 */
		public var measureWidth:int;
		
		/**
		 * Whether or not this measure should start a new system.
		 */
		public var newSystem:Boolean = false;
		
		/**
		 * Whether or not this measure should start a new page.
		 */
		public var newPage:Boolean = false;
		
		/**
		 * Stores information in XML regarding margins and such about this measure.
		 * Should carry forward until the next change.
		 */
		public var systemLayout:XML;
		
		/**
		 * The number of staffs in this measure.
		 */
		public var staffCount:int = 1;
		
		/**
		 * Whether or not the measure starts a long period of rest.
		 */
		public var startsRest:Boolean = false;
		
		/**
		 * How many measures, including this measure, the long rest lasts.
		 */
		public var longRestCount:int = 0;
	}
}
