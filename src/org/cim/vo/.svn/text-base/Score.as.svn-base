package org.cim.vo {
	import flash.net.NetConnection;
	
	import mx.collections.ArrayCollection;
	
	[RemoteClass(alias="org.cim.Score")]
	[Bindable]
	/**
	 * A score is the rendering of a MusicXML file that also containts metadata
	 * regarding the details of the piece.
	 */
	public class Score {
		/**************************************
		 * Instance Variables (Table Fields)
		 **************************************/
		/**
		 * The unique ID of the score.
		 */
		public var id:uint;
		
		/**
		 * The location of the images for the score.
		 */
		public var fileLocation:String;
		
		/**
		 * The location of the MusicXML for the score.
		 */
		public var xmlLocation:String;
		
		/**
		 * The location of the master server.
		 */
		public var masterServerLocation:String;
		
		/**
		 * The location of RTSP to RTMP conversion server.
		 */
		public var conversionServerLocation:String;
		
		/**
		 * The parameters of the video to be streamed for the score.
		 */
		public var stream:String;
		
		/**********************************************
		 * Instance Variables (Joined Fields/Tables)
		 **********************************************/
		/**
		 * The music piece this score represents.
		 */
		public var musicPiece:MusicPiece;
		
		/**
		 * The instrument this score is written for.
		 */
		public var instrument:Instrument;
		
		/**
		 * The default setting to use for the mixer.
		 */
		public var defaultSetting:Setting;
		
		/**
		 * The mixers that the music piece has audio for.
		 */
		public var mixers:ArrayCollection;
		
		/**************************************
		 * Other Doctrine-created Attributes
		 **************************************/
		public var __isInitialized__:Boolean;
		
		/**************
		 * Functions
		 **************/
		/**
		 * Returns the number of files represented in the file 
		 * location field.
		 */
		public function fileCount():int {
			return fileLocation.split(";").length;
		}
		
		/**
		 * Returns the file location specified as the 
		 * nth item in the list defined in the file location field.
		 */
		public function getFileLocation(n:int):String {
			var files:Array = fileLocation.split(";");
			
			return files[n];
		}
	}
}