package org.cim.vo {
	import mx.collections.ArrayCollection;
	
	[RemoteClass(alias="org.cim.Instrument")]
	[Bindable]
	/**
	 * An instrument is a simple system stored name of 
	 * an instrument.
	 */
	public class Instrument {
		/**
		 * A constant for the "all instruments" name.
		 */
		public static const ALL_INSTRUMENTS:String = "All Instruments";
		
		/**************************************
		 * Instance Variables (Table Fields)
		 **************************************/
		/**
		 * The unique ID of the instrument.
		 */
		public var id:uint;
		
		/**
		 * The name of the instrument.
		 */
		public var instrumentName:String;
		
		/**********************************************
		 * Instance Variables (Joined Fields/Tables)
		 **********************************************/
		/**
		 * The parent instrument used for grouping.
		 */
		public var parentInstrument:Instrument;
		
		/**
		 * A parent instrument's child instruments.
		 */
		public var childInstruments:ArrayCollection;
		
		/**************************************
		 * Other Doctrine-created Attributes
		 **************************************/
		public var __isInitialized__:Boolean;
	}
}