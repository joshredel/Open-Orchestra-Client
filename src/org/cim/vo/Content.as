package org.cim.vo {
	import org.cim.AMFService;
	
	[RemoteClass(alias="org.cim.Content")]
	[Bindable]
	/**
	 * Content is an embedded class that stores information about the 
	 * typed, written, audio, video and/or graphical information in messages.
	 */
	public class Content {
		/**************************************
		 * Instance Variables (Table Fields)
		 **************************************/
		/**
		 * The unique ID of the content.
		 */
		public var id:uint;
		
		/**
		 * The typed part of the content.
		 */
		public var body:String;
		
		/**
		 * The object containing the information regarding 
		 * the written aprt of the content.
		 */
		public var writing:Object;
		
		/**
		 * The raw audio part of the content.
		 */
		public var audio:Object;
		
		/**
		 * The raw audio/video part of the content.
		 */
		public var video:Object;
		
		/**
		 * The raw image part of the content.
		 */
		public var image:Object;
		
		/**
		 * The date the content was created.
		 */
		private var _creationDate:Date;
		
		/**
		 * The date the content was created.
		 * 
		 * @internal
		 * Simply returns the private value.
		 */
		public function get creationDate():Date {
			return _creationDate;
		}
		
		/**
		 * @private
		 * Sets the date the content was created.
		 * Converts the date from a string if it is coming from 
		 * the database via AMF remoting.
		 */
		public function set creationDate(newDate:*):void {
			_creationDate = AMFService.convertDateTimeToDate(newDate);	
		}
		
		/**************************************
		 * Other Doctrine-created Attributes
		 **************************************/
		public var __isInitialized__:Boolean;
	}
}