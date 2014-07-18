package org.cim.vo {
	import mx.collections.ArrayCollection;
	
	import org.cim.AMFService;
	
	[RemoteClass(alias="org.cim.MusicPiece")]
	[Bindable]
	/**
	 * A music piece is a song or composition that 
	 * has several scores and audio and video streams 
	 * to complement it.
	 */
	public class MusicPiece {
		/**************************************
		 * Instance Variables (Table Fields)
		 **************************************/
		/**
		 * Unique ID of the music piece.
		 */
		public var id:uint;
		
		/**
		 * The name of the piece of music.
		 */
		public var pieceName:String;
		
		/**
		 * The composer of the music piece.
		 */
		public var composer:String;
		
		/**
		 * The ensemble who performed the music piece in the recording.
		 */
		public var performingEnsemble:String;
		
		/**
		 * The date the music piece was recorded.
		 */
		private var _recordedDate:Date;
		
		/**
		 * The date the music piece was recorded.
		 * 
		 * @internal
		 * Simply returns the private value.
		 */
		public function get recordedDate():Date {
			return _recordedDate;
		}
		
		/**
		 * @private
		 * Sets the date the date the music piece was recorded.
		 * Converts the date from a string if it is coming from 
		 * the database via AMF remoting.
		 */
		public function set recordedDate(newDate:*):void {
			_recordedDate = AMFService.convertDateTimeToDate(newDate);
		}
		
		/**
		 * The conductor who conducted the music piece.
		 */
		public var conductorName:String;
		
		/**
		 * A description of the music piece.
		 */
		public var description:String;
		
		/**
		 * A set of file names describing the thumbnail to display 
		 * for the music piece.
		 */
		public var thumbnailSet:String;
		
		/**
		 * The location of the conductor's view stream.
		 */
		public var conductorsViewStream:String;
		
		/**********************************************
		 * Instance Variables (Joined Fields/Tables)
		 **********************************************/
		/**
		 * The conductor of the music piece.
		 */
		public var conductorUser:User;
		
		/**
		 * The scores associated with this piece of music.
		 */
		public var scores:ArrayCollection;
		
		/**
		 * The genres associated with this piece of music.
		 */
		public var genres:ArrayCollection;
		
		/**************************************************
		 * Instance Variables (Service-Generated Fields)
		 **************************************************/
		/**
		 * The instruments that are used in by the scores of this music piece.
		 */
		public var scoreInstruments:ArrayCollection;
		
		/**************************************
		 * Other Doctrine-created Attributes
		 **************************************/
		public var __isInitialized__:Boolean;
	}
}