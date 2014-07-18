package org.cim.vo {
	import mx.collections.ArrayCollection;
	
	import org.cim.AMFService;
	
	[RemoteClass(alias="org.cim.PracticeRecording")]
	[Bindable]
	/**
	 * A practice recording is an audio recording made as the 
	 * plus one in a music minus one session.
	 */
	public class PracticeRecording {
		/**************************************
		 * Instance Variables (Table Fields)
		 **************************************/
		/**
		 * The unique ID of the practice recording.
		 */
		public var id:uint;
		
		/**
		 * The time, in milliseconds, in the music piece 
		 * when the practice recording starts.
		 */
		public var startLocation:Number;
		
		/**
		 * The time, in milliseconds, in the music piece
		 * when the practice recoring stops.
		 */
		public var stopLocation:Number;
		
		/**
		 * The name of the recording file to use.
		 */
		public var fileName:String;
		
		/**
		 * The date the practice recoring was made.
		 */
		private var _recordingDate:Date;
		
		/**
		 * The date the practice recording was made.
		 * 
		 * @internal
		 * Simply returns the private value.
		 */
		public function get recordingDate():Date {
			return _recordingDate;
		}
		
		/**
		 * @private
		 * Sets the date the practice recording was made.
		 * Converts the date from a string if it is coming from 
		 * the database via AMF remoting.
		 */
		public function set recordingDate(newDate:*):void {
			_recordingDate = AMFService.convertDateTimeToDate(newDate);	
		}
		
		/**
		 * The duration, in milliseconds, of the recording.
		 */
		public var duration:Number;
		
		/**
		 * Whether the recording file has been uploaded to the server.
		 */
		private var _isUploaded:Boolean;
		
		/**
		 * Whether the recording file has been uploaded to the server.
		 * 
		 * @internal
		 * Simply returns the private value.
		 */
		public function get isUploaded():Boolean {
			return _isUploaded;
		}
		
		/**
		 * @private
		 * Whether the recording file has been uploaded to the server.
		 * Translates a string number into a boolean if necessary
		 */
		public function set isUploaded(newValue:*):void {
			if(newValue is Boolean) {
				_isUploaded = newValue;
			} else {
				if(newValue == "0") {
					_isUploaded = false;
				} else {
					_isUploaded = true;
				}
			}
		}
		
		/**********************************************
		 * Instance Variables (Joined Fields/Tables)
		 **********************************************/
		/**
		 * The practice session the practice recoridng was 
		 * created during.
		 */
		public var practiceSession:PracticeSession;
		
		/**
		 * The temporal comments that were made on the
		 * practice recording.
		 */
		public var temporalComments:ArrayCollection;
		
		/**
		 * The feedbacks left on the practice recording.
		 */
		public var feedbacks:ArrayCollection;
	}
}