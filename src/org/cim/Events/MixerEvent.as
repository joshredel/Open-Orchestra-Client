package org.cim.events {
	import flash.events.Event;
	
	import org.cim.vo.Mixer;
	
	public class MixerEvent extends Event {
		
		/**
		 * Constants for different kinds of events.
		 */
		public static const LEVEL_CHANGED:String = "levelChanged";
		public static const TOGGLE_SOLO:String = "toggleSolo";
		public static const TOGGLE_MUTE:String = "toggleMute";
		
		/**
		 * The mixer which we are sending information about.
		 */
		public var mixer:Mixer;
		
		/**
		 * The value we are sending.
		 */
		public var value:Number;
		
		/**
		 * Constructor.
		 * Sets the information for the call to the event constructor.
		 */
		public function MixerEvent(type:String, mixer:Mixer, value:Number = 0, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			this.mixer = mixer;
			this.value = value;
		}
	}
}