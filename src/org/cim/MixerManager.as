package org.cim {
	import flash.events.NetStatusEvent;
	import flash.events.TimerEvent;
	import flash.net.NetConnection;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	import mx.binding.utils.ChangeWatcher;
	import mx.collections.ArrayCollection;
	import mx.controls.sliderClasses.Slider;
	import mx.events.CollectionEvent;
	
	import org.cim.components.MixerSlider;
	import org.cim.events.MixerEvent;
	
	[Bindable]
	/**
	 * A mixer manager handles a collection of mixer sliders.  It manages 
	 * events triggered from actions on their interface and reflects 
	 * certain changes onto the other mixers.
	 */  
	public final class MixerManager {
		/**************************
		 * Singleton enforcement
		 **************************/
		/**
		 * The reference to the single instance of this class.
		 */
		private static const _instance:MixerManager = new MixerManager(SingletonEnforcer);
		
		/**
		 * The single instance of this class.
		 * 
		 * @internal
		 * Returns the instance if it has been created, otherwise 
		 * it creates the instance.
		 */
		public static function get instance():MixerManager {
			// return the single instance
			return _instance;
		}
		
		/**
		 * The app's data shop.
		 */
		private var dataShop:DataShop = DataShop.instance;
		
		/**
		 * A dictionary of muted values.
		 * When a mixer is muted, it's value is stored here so it
		 * can be recovered on unmute.
		 */
		private var originalVolumes:Dictionary;
		
		/**
		 * A collection of functions waiting to be called.
		 */
		private var callsOnHold:ArrayCollection;
		
		/**
		 * The collection of mixer sliders.
		 */
		private var _mixerSliders:ArrayCollection;
		
		/**
		 * Sets the collection of mixer sliders.
		 */
		public function set mixerSliders(newSliders:ArrayCollection):void {
			// store the new collection
			_mixerSliders = newSliders;
			
			// mark that the mixers are clean
			isDirty = false;
			
			// go through each item and add a listener for a certain event
			for each(var slider:MixerSlider in _mixerSliders) {
				slider.addEventListener(MixerEvent.LEVEL_CHANGED, changeLevel);
				slider.addEventListener(MixerEvent.TOGGLE_MUTE, toggleMute);
				slider.addEventListener(MixerEvent.TOGGLE_SOLO, toggleSolo);
			}
		}
		
		/**
		 * Gets the collection of mixer sliders.
		 */
		public function get mixerSliders():ArrayCollection {
			return _mixerSliders;
		}
		
		/**
		 * The NetConnection being used to communicate with the 
		 * server for RTSP information and mixer control.
		 */
		public var serverConnection:NetConnection;
		
		/**
		 * Whether the video is currently playing.
		 */
		public var isPlaying:Boolean;// = true; //false; // false is used when preplaying is enabled
		
		/**
		 * Whether the conductor stream is currently playing (managed externally).
		 */
		public var isConductorViewPlaying:Boolean = false;
		
		/**
		 * Whether or not a component is loading itself or other mixers.
		 */
		public var loading:Boolean = false;
		
		/**
		 * Whether or not the mixers have been touched.
		 */
		public var isDirty:Boolean = false;
		
		/**
		 * Constructor.
		 * Enforces singleton instantiation.
		 */
		public function MixerManager(access:Class) {
			// require the passing of a SingletonEnforcer
			// because no outside class can use it, so only here 
			// can an instance be created and we can manage it
			if(access != SingletonEnforcer) {
				throw new Error("Singleton enforcement failed.  Use MixerManager.instance");
			}
			
			// watch for the server connection to be assigned a value
			ChangeWatcher.watch(this, "serverConnection", watchForConnection);
		}
		
		/**
		 * Handles the server connection being assigned a value.
		 * Listens for net status events on the server connection
		 */
		private function watchForConnection(event:Event):void {
			// add a successful connection listener
			if(serverConnection) {
				serverConnection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			}
		}
		
		/**
		 * Handles net status events on the server connection.
		 * Calls the queue of awaiting server calls once a connection 
		 * has been made.
		 */
		private function netStatusHandler(e:NetStatusEvent):void {
			// determine what we want to do
			switch(e.info.code) {
				case "NetConnection.Connect.Success":
					// connection successful... call the queue of functions waiting after one second has elapsed
					// a timer is used so that the server has time to be able to catch the calls
					var waitTimer:Timer = new Timer(1000, 1);
					waitTimer.addEventListener(TimerEvent.TIMER_COMPLETE, function (event:TimerEvent):void {
						if(callsOnHold) {
							// loop through each call on hold and call it
							for each(var call:Object in callsOnHold) {
								// double check that we have a connection to prevent infinite looping
								if(serverConnection.connected) {
									// there is one, go ahead and call
									sendCommand(call.command, call.elementName, call.value, call.wasLoading);
								} else {
									// there is for some reason no longer a connection, so cancel the calling
									break;
								}
							}
							
							// empty the array
							callsOnHold.removeAll();
							callsOnHold = null;
						}
					});
					waitTimer.start();
					
					break;
				
				default:
					trace("MixerManager.serverConnection: " + e.info.code); 
			}
		}
		
		/**
		 * Handles a change of value on the level slider.
		 * Sends the new level to the server
		 */
		private function changeLevel(event:MixerEvent):void {
			// send the message to the server
			sendCommand("volume", event.mixer.channelName, dbToPercent(event.value));
		}
		
		/**
		 * Helper method.
		 * Converts the decibel-based entry of the slider to 
		 * the percentage-based value required by the server.
		 */
		private function dbToPercent(value:Number):Number {
			return Math.pow(10, value / 20);
		}
		
		/**
		 * Handles a toggle solo event
		 * Sends a solo command to the server based on 
		 * the toggled value of the current solo setting.
		 */
		private function toggleSolo(event:MixerEvent):void {
			// get the target mixer slider
			var slider:MixerSlider = event.target as MixerSlider;
			
			// branch for different soloing situations.
			if(slider.soloingState == MixerSlider.SOLOING_OFF) {
				// there is nothing soloing, and this is the first one to start soloing
				// set it's state to soloing on, soloing
				slider.soloingState = MixerSlider.SOLOING_ON_SOLOING;
				
				// set all the others to soloing on, not soloing, and mute (but mark the button as unmuted if it was already muted0
				for each(var otherSlider:MixerSlider in mixerSliders) {
					if(otherSlider != slider) {
						// set its state
						otherSlider.soloingState = MixerSlider.SOLOING_ON_NOT_SOLOING;
						
						if(otherSlider.isMuted && !otherSlider.data.isReferenceInstrument) {
							// unmute the mute button if it was already muted if it is not the reference instrument
							otherSlider.isMuted = false;
							otherSlider.muteButton.selected = false;
						} else {
							// mute its volume if it wasn't already muted
							muteMixer(otherSlider);
						}
					}
				}
			} else if(slider.soloingState == MixerSlider.SOLOING_ON_NOT_SOLOING) {
				// there are instruments soloing, and this is another one to start soloing
				// set its state to soloing on, soloing
				slider.soloingState = MixerSlider.SOLOING_ON_SOLOING;
				
				// unmute its volume
				unmuteMixer(slider);
			} else {
				// this one should be turned off
				// determine if it is the last one left, or if others will remain soloing
				var lastOneSoloing:Boolean = true;
				for each(var sliders:MixerSlider in mixerSliders) {
					if(sliders != slider && sliders.soloingState == MixerSlider.SOLOING_ON_SOLOING) {
						lastOneSoloing = false;
						break;
					}
				}
				
				if(lastOneSoloing) {
					// it is the only one remaining soloing
					// set all mixers to soloing off and unmute
					for each(var mixerSlider:MixerSlider in mixerSliders) {
						// set its state
						mixerSlider.soloingState = MixerSlider.SOLOING_OFF;
						
						if(mixerSlider != slider && !mixerSlider.data.isReferenceInstrument) {
							// unmute if it is not the reference instrument
							unmuteMixer(mixerSlider);
						}
					}
				} else {
					// there are others that are still soloing
					// set its state to soloing on, not soloing, and mute it
					slider.soloingState = MixerSlider.SOLOING_ON_NOT_SOLOING;
					muteMixer(slider);
				}
			}
		}
		
		/**
		 * Handles a toggle mute event
		 * Sends a mute command to the server based on 
		 * the toggled value of the current mute setting.
		 */
		private function toggleMute(event:MixerEvent):void {
			// get the target mixer slider
			var slider:MixerSlider = event.target as MixerSlider;
			
			// toggle the mute
			slider.isMuted = !slider.isMuted;
			
			// store the volume level and set to zero, or restore the value
			if(slider.isMuted) {
				// mute it
				muteMixer(slider);
			} else {
				// unmute it
				unmuteMixer(slider);
			}
		}
		
		/**
		 * Toggles the video between playing and pausing.
		 */
		public function togglePause():void {
			if(isPlaying) {
				// send the pause message
				sendCommand("play", "nav", "false");
			} else {
				// send the play message
				sendCommand("play", "nav", "true");
			}
			
			// toggle isPlaying
			isPlaying = !isPlaying;
		}
		
		/**
		 * Seeks the video to the desired position in seconds.
		 */
		public function seek(seconds:int):void {
			sendCommand("cur-time", "nav", seconds);
		}
		
		/**
		 * Helper function.
		 * Sends a command to server via the server connection.
		 */
		private function sendCommand(command:String, elementName:String, value:*, wasLoading:Boolean = false):void {
			// send a command if we have created the connection and it is actually connected
			if(serverConnection && serverConnection.connected) {
				trace("Sending " + elementName + " the command '" + command + "' with value " + value);
				serverConnection.call("doSomething", null, elementName, command, new String(value));
				if(command == "volume" && !(loading || wasLoading) && !isDirty) {
					isDirty = true;
				}
			} else {
				trace("The server connection has not been established.\nSending of " + elementName + " the command '" + command + "' with value " + value + " failed.");
				
				// make an object to store the parameters to be called later
				var laterParams:Object = new Object();
				laterParams.command = command;
				laterParams.elementName = elementName;
				laterParams.value = value;
				laterParams.wasLoading = loading;
				
				// add it to the queue
				if(!callsOnHold) {
					callsOnHold = new ArrayCollection();
				}
				callsOnHold.addItem(laterParams);
			}
		}
		
		/**
		 * Helper function.
		 * Mutes a mixer slider by storing its volume for unmuting and 
		 * sending a value of zero to the server to actually mute it.
		 */
		private function muteMixer(slider:MixerSlider):void {
			// store the value
			if(!originalVolumes) {
				originalVolumes = new Dictionary();
			}
			originalVolumes[slider] = dbToPercent(slider.levelSlider.value);
			
			// send a "mute" command (i.e. send 0% to the server)
			sendCommand("volume", slider.data.channelName, 0);
		}
		
		/**
		 * Helper function.
		 * Unmutes a mixer slider by restoring its stored value 
		 * and sending that value to the server.
		 */
		private function unmuteMixer(slider:MixerSlider):void {
			// restore the volume (send the original value to the server)
			sendCommand("volume", slider.data.channelName, originalVolumes[slider]);
			
			// delete the dictionary entry
			delete originalVolumes[slider];
		}
	}
}

// by using a class here, no outide class can create
// a new DataShop because it is required in the constructor
class SingletonEnforcer {}