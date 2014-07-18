package org.cim.vo {
	
	[RemoteClass(alias="org.cim.Annotation")]
	[Bindable]
	/**
	 * An annotation is a writing made on a score.
	 */
	public class Annotation {
		/**************************************
		 * Instance Variables (Table Fields)
		 **************************************/
		/**
		 * The unique ID of the annotation.
		 */
		public var id:uint;
		
		/**
		 * The object containing information regarding 
		 * the actual drawing of the annotation on the score.
		 */
		public var data:Object;
		
		/**********************************************
		 * Instance Variables (Joined Fields/Tables)
		 **********************************************/
		/**
		 * The practice session during which the annotation was made.
		 */
		public var practiceSession:PracticeSession;
		
		/**************************************
		 * Other Doctrine-created Attributes
		 **************************************/
		public var __isInitialized__:Boolean;
	}
}