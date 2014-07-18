package org.cim.vo {
	import mx.collections.ArrayCollection;
	
	import org.cim.AMFService;
	
	[RemoteClass(alias="org.cim.PracticeSession")]
	[Bindable]
	/**
	 * A practice session is a session in which recordings are made, 
	 * feedback is left, comments are made, and annotations are created.
	 */
	public class PracticeSession {
		/**************************************
		 * Instance Variables (Table Fields)
		 **************************************/
		/**
		 * Unique ID of the practice session.
		 */
		public var id:uint;
		
		/**
		 * The date the practice session was first started 
		 * and associated with a music piece.
		 */
		private var _createdDate:Date;
		
		/**
		 * The date the practice session was first started 
		 * and associated with a music piece.
		 * 
		 * @internal
		 * Simply returns the private value.
		 */
		public function get createdDate():Date {
			return _createdDate;
		}
		
		/**
		 * @private
		 * Sets the date the practice session was created.
		 * Converts the date from a string if it is coming from
		 * the database via AMF remoting.
		 */
		public function set createdDate(newDate:*):void {
			_createdDate = AMFService.convertDateTimeToDate(newDate);
		}
		
		/**
		 * The date the practice session was last accessed.
		 */
		private var _lastAccessDate:Date;
		
		/**
		 * The date the practice session was last accessed.
		 * 
		 * @internal
		 * Simply returns the private value.
		 */
		public function get lastAccessDate():Date {
			return _lastAccessDate;
		}
		
		/**
		 * @private
		 * Sets the date the practice session was last accessed.
		 * Converts the date from a string if it is coming from 
		 * the database via AMF remoting.
		 */
		public function set lastAccessDate(newDate:*):void {
			_lastAccessDate = AMFService.convertDateTimeToDate(newDate);
		}
		
		/**
		 * A number representing the stage at which the session 
		 * is in the lifecycle of the application.
		 */
		public var lifecycle:int;
		
		/**********************************************
		 * Instance Variables (Joined Fields/Tables)
		 **********************************************/
		/**
		 * The suer the practice session if owned/run by.
		 */
		public var user:User;
		
		/**
		 * The music piece the practice session uses/used.
		 */
		public var musicPiece:MusicPiece;
		
		/**
		 * The instrument the played during the session.
		 */
		public var instrument:Instrument;
		
		/**
		 * The settings that could be used for this practice session.
		 */
		public var settings:ArrayCollection = new ArrayCollection();
		
		/**
		 * The practice recordings made during this session.
		 */
		public var practiceRecordings:ArrayCollection = new ArrayCollection();
		
		/**
		 * The annotations made during this session.
		 */
		public var annotations:ArrayCollection = new ArrayCollection();
		
		/**************************************
		 * Other Doctrine-created Attributes
		 **************************************/
		public var __isInitialized__:Boolean;
	}
}