package org.cim.vo {
	import org.cim.AMFService;
	
	[RemoteClass(alias="org.cim.TemporalComment")]
	[Bindable]
	/**
	 * A temporal comment is a comment left on a recording.  It is based on the 
	 * audio recording timing, not the score's bars, and it can be any form of 
	 * comment including, typing, writing, audio, video, and images.
	 */
	public class TemporalComment {
		/**************************************
		 * Instance Variables (Table Fields)
		 **************************************/
		/**
		 * The unique ID of the temporal comment.
		 */
		public var id:uint;
		
		/**
		 * The time, in milliseconds, in the temporal recording 
		 * when the practice recording starts.
		 */
		public var startLocation:Number;
		
		/**
		 * The time, in milliseconds, in the temporal recording
		 * when the practice recoring stops.
		 */
		public var stopLocation:Number;
		
		/**
		 * The date the temporal comment was created..
		 */
		private var _commentDate:Date;
		
		/**
		 * The date the temporal comment was created.
		 * 
		 * @internal
		 * Simply returns the private value.
		 */
		public function get commentDate():Date {
			return _commentDate;
		}
		
		/**
		 * @private
		 * Sets the date the temporal comment was created.
		 * Converts the date from a string if it is coming from 
		 * the database via AMF remoting.
		 */
		public function set commentDate(newDate:*):void {
			_commentDate = AMFService.convertDateTimeToDate(newDate);	
		}
		
		/**********************************************
		 * Instance Variables (Joined Fields/Tables)
		 **********************************************/
		/**
		 * The practice recording the temporal comment is 
		 * commenting on.
		 */
		public var practiceRecording:PracticeRecording;
		
		/**
		 * The content of the temporal comment.
		 */
		public var content:Content;
		
		/**************************************
		 * Other Doctrine-created Attributes
		 **************************************/
		public var __isInitialized__:Boolean;
	}
}