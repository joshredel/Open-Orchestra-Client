package org.cim.vo {
	import mx.collections.ArrayCollection;
	
	[RemoteClass(alias="org.cim.Mixer")]
	[Bindable]
	/**
	 * A mixer contains information about an audio track 
	 * used to control that track via OSC.
	 */
	public class Mixer {
		/**************************************
		 * Instance Variables (Table Fields)
		 **************************************/
		/**
		 * The unique ID of the mixer.
		 */
		public var id:uint;
		
		/**
		 * The name of the instrument section the mixer controls.
		 */
		public var sectionName:String;
		
		/**
		 * The name of the channel through which the mixer controls the audio.
		 */
		public var channelName:String;
		
		/**
		 * Whether or not the mixer is controlling the reference instrument
		 * (i.e. the removed instrument).
		 */
		private var _isReferenceInstrument:Boolean;
		
		/**
		 * Whether or not the mixer is controlling the reference instrument
		 * (i.e. the removed instrument).
		 * 
		 * @internal
		 * Simply returns the private value.
		 */
		public function get isReferenceInstrument():Boolean {
			return _isReferenceInstrument;
		}
		
		/**
		 * @private
		 * Sets whether or not the mixer is controlling the reference instrument
		 * (i.e. the removed instrument).
		 * Translates a string number into a boolean if necessary
		 */
		public function set isReferenceInstrument(newValue:*):void {
			if(newValue is Boolean) {
				_isReferenceInstrument = newValue;
			} else {
				if(newValue == "0") {
					_isReferenceInstrument = false;
				} else {
					_isReferenceInstrument = true;
				}
			}
		}
		
		/**
		 * The ordering weight of the mixer.
		 */
		public var ordering:int;
		
		/**********************************************
		 * Instance Variables (Joined Fields/Tables)
		 **********************************************/
		/**
		 * The score the mixer belongs to.
		 */
		public var score:Score;
		
		/**************************************
		 * Other Doctrine-created Attributes
		 **************************************/
		public var __isInitialized__:Boolean;
	}
}