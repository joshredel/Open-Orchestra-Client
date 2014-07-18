package org.cim.vo {
	
	[RemoteClass(alias="org.cim.Setting")]
	[Bindable]
	/**
	 * A setting is a unit that dictates certain parameters to a practice 
	 * session.  These include where to start and start in terms of a
	 * score's bars and the mixer settings to use when playing back 
	 * the audio.
	 */
	public class Setting {
		/**************************************
		 * Instance Variables (Table Fields)
		 **************************************/
		/**
		 * The unique ID of the setting.
		 */
		public var id:uint;
		
		/**
		 * The name to identify the setting.
		 */
		public var settingName:String;
		
		/**
		 * The bar on which the user will start playing.
		 */
		public var startingPoint:Number;
		
		/**
		 * The bar on which the user will end playing.
		 */
		public var endingPoint:Number;
		
		/**
		 * The object containing information regarding the 
		 * volume and mixing information for different audio tracks.
		 */
		public var mixerData:String;
		
		/**********************************************
		 * Instance Variables (Joined Fields/Tables)
		 **********************************************/
		/**
		 * The practice session to which these settings are applied.
		 */
		public var practiceSession:PracticeSession;
		
		/**************************************
		 * Other Doctrine-created Attributes
		 **************************************/
		public var __isInitialized__:Boolean;
	}
}