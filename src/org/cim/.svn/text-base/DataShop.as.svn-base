package org.cim {
	import mx.binding.utils.ChangeWatcher;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	import org.cim.vo.*;
	
	[Bindable]
	/**
	 * DataShop provides singleton access to all data
	 * and services used throughout the system.
	 */
	public final class DataShop {
		/**************************
		 * Singleton enforcement
		 **************************/
		/**
		 * The reference to the single instance of this class.
		 */
		private static const _instance:DataShop = new DataShop(SingletonEnforcer);
		
		/**
		 * The single instance of this class.
		 * 
		 * @internal
		 * Returns the instance if it has been created, otherwise 
		 * it creates the instance.
		 */
		public static function get instance():DataShop {
			// return the single instance
			return _instance;
		}
		
		/**
		 * Constructor.
		 * Loads all of the classes so they are typeable via AMF.
		 * Prepares all of the services.
		 */
		public function DataShop(access:Class) {
			// require the passing of a SingletonEnforcer
			// because no outside class can use it, so only here 
			// can an instance be created and we can manage it
			if(access != SingletonEnforcer) {
				throw new Error("Singleton enforcement failed.  Use DataShop.instance");
			}
			
			// fake create one of each of the VO classes
			// if we don't do this, the service will not translate the AMF
			// result into a type object (it will be a generic object)
			// TODO: fix this... we shoulnd't have to declare the type...
			var loader:* = new Annotation();
			loader = new Content();
			loader = new Feedback();
			loader = new Genre();
			loader = new Instrument();
			loader = new Message();
			loader = new Mixer();
			loader = new MusicPiece();
			loader = new PracticeRecording();
			loader = new PracticeSession();
			loader = new Role();
			loader = new Score();
			loader = new Setting();
			loader = new TemporalComment();
			loader = new User();
			
			// set up all the services
			annotationService = setUpService("AnnotationService");
			contentService = setUpService("ContentService");
			feedbackService = setUpService("FeedbackService");
			genreService = setUpService("GenreService");
			instrumentService = setUpService("InstrumentService");
			messageService = setUpService("MessageService");
			mixerService = setUpService("MixerService");
			musicPieceService = setUpService("MusicPieceService");
			practiceRecordingService = setUpService("PracticeRecordingService");
			practiceSessionService = setUpService("PracticeSessionService");
			roleService = setUpService("RoleService");
			scoreService = setUpService("ScoreService");
			settingService = setUpService("SettingService");
			temporalCommentService = setUpService("TemporalCommentService");
			userService = setUpService("UserService");
			
			// watch for changes to the logged in user
			ChangeWatcher.watch(this, "loggedInUser", handleUserChange);
		}
		
		/**
		 * Logs the current user out.
		 */
		public function logout():void {
			loggedInUser = null
		}
		
		/*********************
		 * Services offered
		 *********************/
		public var annotationService:RemoteObject;
		public var contentService:RemoteObject;
		public var feedbackService:RemoteObject;
		public var genreService:RemoteObject;
		public var instrumentService:RemoteObject;
		public var messageService:RemoteObject;
		public var mixerService:RemoteObject;
		public var musicPieceService:RemoteObject;
		public var practiceRecordingService:RemoteObject;
		public var practiceSessionService:RemoteObject;
		public var roleService:RemoteObject;
		public var scoreService:RemoteObject;
		public var settingService:RemoteObject;
		public var temporalCommentService:RemoteObject;
		public var userService:RemoteObject;
		
		/***************
		 * Properties
		 ***************/
		/**
		 * The width of the application (the main screen it is running in).
		 */
		public var appWidth:Number;
		
		/**
		 * The user currently logged in.
		 */
		public var loggedInUser:User;
		
		/**
		 * The current parent instrument that dictates the 
		 * view of panels, sheet music, etc.
		 */
		public var currentParentInstrument:Instrument;
		
		/**
		 * The current genre that dictates the 
		 * view of panels, sheet music, etc.
		 */
		public var currentGenre:Genre;
		
		/**
		 * The current pracitce session being used.
		 */
		public var currentPracticeSession:PracticeSession;
		
		/**
		 * The current score being viewed.
		 */
		public var currentScore:Score;
		
		/*********************
		 * Helper functions
		 *********************/
		/**
		 * Instantiates a service and sets the parameters as necessary.
		 */
		private function setUpService(source:String):RemoteObject {
			// instantiate the service and point it to the proper source
			var service:RemoteObject = new RemoteObject("amfphp");
			service.source = source;
			service.showBusyCursor = true;
			service.addEventListener(FaultEvent.FAULT, handleServiceFault);
			
			return service;
		}
		
		/**
		 * Handles a change in the logged in user.
		 * Records information about the current user.
		 */
		private function handleUserChange(event:Event):void {
			if(loggedInUser) {
				// record the current parent insturment
				try {
					currentParentInstrument = loggedInUser.instruments.getItemAt(0) as Instrument;
					//currentParentInstrument = loggedInUser.instrument;
				} catch(e:Error) {
					currentParentInstrument = this.instrumentService.getParentInstruments.lastResult[0];
				}
			} else {
				// erase information
				currentParentInstrument = null;
				currentPracticeSession = null;
			}
		}
		
		/**
		 * Prints a fault error to the debug terminal.
		 */
		private function handleServiceFault(event:FaultEvent):void {
			trace("-----\n" + event.toString() + "\n-----");
		}
		
		/**
		 * Prints a log message with time information.
		 */
		public function log(message:String):void {
			var now:Date = new Date();
			trace(now.getHours() + ":" + now.getMinutes() + "." + now.getSeconds() + "." + now.getMilliseconds() + ": " + message);
		}
	}
}

// by using a class here, no outide class can create
// a new DataShop because it is required in the constructor
class SingletonEnforcer {}