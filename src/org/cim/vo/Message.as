package org.cim.vo {
	import org.cim.AMFService;
	
	[RemoteClass(alias="org.cim.Message")]
	[Bindable]
	/**
	 * A message is content sent between users that is similar to 
	 * an email and has typed, written, audio, video, and graphic content.
	 */
	public class Message {
		/**************************************
		 * Instance Variables (Table Fields)
		 **************************************/
		/**
		 * The unique ID of the message.
		 */
		public var id:uint;
		
		/**
		 * The subject of the message.
		 */
		public var subject:String;
		
		/**
		 * Whether or not the message has been opened.
		 */
		private var _hasBeenRead:Boolean;
		
		/**
		 * Whether or not the message has been opened.
		 * 
		 * @internal
		 * Simply returns the private value.
		 */
		public function get hasBeenRead():Boolean {
			return _hasBeenRead;
		}
		
		/**
		 * @private
		 * Sets whether or not the message has been opened.
		 * Translates a string number into a boolean.
		 */
		public function set hasBeenRead(newValue:*):void {
			if(newValue is Boolean) {
				_hasBeenRead = newValue;
			} else {
				if(newValue == "0") {
					_hasBeenRead = false;
				} else {
					_hasBeenRead = true;
				}
			}
		}
		
		/**
		 * The date the message was sent to the receiver.
		 */
		private var _sentDate:Date;
		
		/**
		 * The date the message was sent to the receiver.
		 * 
		 * @internal
		 * Simply returns the private value.
		 */
		public function get sentDate():Date {
			return _sentDate;
		}
		
		/**
		 * @private
		 * Sets the date the message was sent to the receiver.
		 * Converts the date from a string if it is coming from 
		 * the database via AMF remoting.
		 */
		public function set sentDate(newDate:*):void {
			_sentDate = AMFService.convertDateTimeToDate(newDate);	
		}
		
		/**
		 * The date the message was first read by the receiver.
		 */
		private var _openDate:Date;
		
		/**
		 * The date the message was first read by the receiver.
		 * 
		 * @internal
		 * Simply returns the private value.
		 */
		public function get openDate():Date {
			return _openDate;
		}
		
		/**
		 * @private
		 * Sets the date the message was first read by the receiver.
		 * Converts the date from a string if it is coming from 
		 * the database via AMF remoting.
		 */
		public function set openDate(newDate:*):void {
			_openDate = AMFService.convertDateTimeToDate(newDate);
		}
		
		/**
		 * The full name of the sender that is filled in if the sender 
		 * user is deleted from the system.
		 */
		public var deletedSenderFullName:String;
		
		/**********************************************
		 * Instance Variables (Joined Fields/Tables)
		 **********************************************/
		/**
		 * The settings the message suggests using.
		 */
		public var setting:Setting;
		
		/**
		 * The user sending the message.
		 */
		public var senderUser:User;
		
		/**
		 * The user meant to receive the message.
		 */
		public var receiverUser:User;
		
		/**
		 * The parent message used in threaded messages.
		 */
		public var parentMessage:Message;
		
		/**
		 * The content of the message.
		 */
		public var content:Content;
		
		/**************************************
		 * Other Doctrine-created Attributes
		 **************************************/
		public var __isInitialized__:Boolean;
	}
}