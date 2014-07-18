package org.cim.events {
	import flash.events.Event;
	
	import org.cim.vo.Setting;
	
	public class SettingEvent extends Event {
		
		/**
		 * Constants for different kinds of events.
		 */
		public static const SETTING_SELECTED:String = "settingSelected";
		
		/**
		 * The setting which we are sending information about.
		 */
		public var setting:Setting;
		
		/**
		 * Constructor.
		 * Sets the information for the call to the event constructor.
		 */
		public function SettingEvent(type:String, setting:Setting, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			this.setting = setting;
		}
	}
}