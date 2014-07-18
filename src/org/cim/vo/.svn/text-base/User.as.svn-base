package org.cim.vo {
	import mx.collections.ArrayCollection;
	
	import org.cim.AMFService;
	
	[RemoteClass(alias="org.cim.User")]
	[Bindable]
	/**
	 * The User class defines a user that is the main unit of the 
	 * system.
	 */
	public class User {
		/**************************************
		 * Instance Variables (Table Fields)
		 **************************************/
		/**
		 * Unique ID of the user.
		 */
		public var id:uint;
		
		/**
		 * First name of the user.
		 */
		public var firstName:String;
		
		/**
		 * Last name of the user
		 */
		public var lastName:String;
		
		/**
		 * SHA1 hashed password for the user.
		 */
		public var password:String;
		
		/**
		 * Institution the user is associated with.
		 */
		public var institution:String;
		
		/**
		 * Biographical information of the user.
		 */
		public var bio:String;
		
		/**
		 * Email address of the user.
		 */
		public var email:String;
		
		/**
		 * The date the user was created.
		 */
		private var _createdDate:Date;
		
		/**
		 * The date the user was created.
		 * 
		 * @internal
		 * Simply returns the private value.
		 */
		public function get createdDate():Date {
			return _createdDate;
		}
		
		/**
		 * @private
		 * Sets the date the user was created.
		 * Converts the date from a string if it is coming from
		 * the database via AMF remoting.
		 */
		public function set createdDate(newDate:*):void {
			_createdDate = AMFService.convertDateTimeToDate(newDate);
		}
		
		/**
		 * The date the user last logged in.
		 */
		private var _lastLoginDate:Date;
		
		/**
		 * The date the user last logged in.
		 * 
		 * @internal
		 * Simply returns the date the user last logged in.
		 */
		public function get lastLoginDate():Date {
			return _lastLoginDate;
		}
		
		/**
		 * @private
		 * Sets the date the user last logged in.
		 * Converts the date from a string if it is coming from 
		 * the database via AMF remoting.
		 */
		public function set lastLoginDate(newDate:*):void {
			_lastLoginDate = AMFService.convertDateTimeToDate(newDate);
		}
		
		/**********************************************
		 * Instance Variables (Joined Fields/Tables)
		 **********************************************/
		/**
		 * The instrument the user plays.
		 */
		public var instruments:ArrayCollection;
		//public var instrument:Instrument;
		
		/**
		 * The practice sessiond the user has participated in.
		 */
		public var practiceSessions:ArrayCollection;
		
		/**
		 * The roles that the user has that determine their 
		 * interaction capabiities with the system.
		 */
		public var roles:ArrayCollection;
		
		/**************************************
		 * Other Doctrine-created Attributes
		 **************************************/
		public var __isInitialized__:Boolean;
	}
}

