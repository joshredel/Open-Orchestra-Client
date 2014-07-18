package org.cim.vo {
	import mx.collections.ArrayCollection;
	
	[RemoteClass(alias="org.cim.Role")]
	[Bindable]
	/**
	 * A role defines what a user is and what it can do in the system.
	 */
	public class Role {
		/**************************************
		 * Instance Variables (Table Fields)
		 **************************************/
		/**
		 * The unique ID of the role.
		 */
		public var id:uint;
		
		/**
		 * The name of the role.
		 */
		public var roleName:String;
		
		/**
		 * The collection of strings representing constants 
		 * that dictate usage privileges in the system.
		 */
		private var _permissions:ArrayCollection;
		
		/**
		 * The collection of strings representing constants 
		 * that dictate usage privileges in the system.
		 * 
		 * @internal
		 * Simply returns the private value.
		 */
		public function get permissions():ArrayCollection {
			return _permissions;
		}
		
		/**
		 * @private
		 * Sets the collection of permissions.
		 * Converts a comma separated list from the server if 
		 * the passed value is a string, otherwise simply stores 
		 * the permissions.
		 */
		public function set permissions(newPermissions:*):void {
			if(newPermissions is Array) {
				// it's an array... convert to array collection
				_permissions = new ArrayCollection(newPermissions);
			} else if(newPermissions is ArrayCollection) {
				// it's an array collection... just store it
				_permissions = newPermissions;
			} else if(newPermissions is String) {
				// it's a comma separated list (hopefully)
				// break it into an array
				_permissions = new ArrayCollection(newPermissions.split(","));
			}
		}
		
		/**************************************
		 * Other Doctrine-created Attributes
		 **************************************/
		public var __isInitialized__:Boolean;
	}
}