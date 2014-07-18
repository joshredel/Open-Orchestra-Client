package org.cim.events {
	import flash.events.Event;
	
	public class ScoreEvent extends Event {
		
		/**
		 * Constants for different kinds of events.
		 */
		public static const LOADING_COMPLETE:String = "loadingComplete";
		
		/**
		 * Constructor.
		 * Sets the information for the call to the event constructor.
		 */
		public function ScoreEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
	}
}