package org.cim {
	import mx.collections.ArrayCollection;
	import mx.events.FlexEvent;
	
	import org.cim.components.PopupMenu;
	
	[Bindable]
	/**
	 * DataShop provides singleton access to all data
	 * and services used throughout the system.
	 */
	public final class PopupManager {
		/**************************
		 * Singleton enforcement
		 **************************/
		/**
		 * The reference to the single instance of this class.
		 */
		private static const _instance:PopupManager = new PopupManager(SingletonEnforcer);
		
		/**
		 * The single instance of this class.
		 * 
		 * @internal
		 * Returns the instance if it has been created, otherwise 
		 * it creates the instance.
		 */
		public static function get instance():PopupManager {
			// return the single instance
			return _instance;
		}
		
		/**
		 * The list of popups we are managing.
		 */
		private var popups:ArrayCollection;
		
		/**
		 * Constructor.
		 * Ensures the singleton is enforced.
		 */
		public function PopupManager(access:Class) {
			// require the passing of a SingletonEnforcer
			// because no outside class can use it, so only here 
			// can an instance be created and we can manage it
			if(access != SingletonEnforcer) {
				throw new Error("Singleton enforcement failed.  Use PopupManager.instance");
			}
			
			popups = new ArrayCollection();
		}
		
		/**
		 * Adds a popup to the collection and prepares it to be managed here.
		 */
		public function addPopup(newPopup:PopupMenu):void {
			// store it
			popups.addItem(newPopup);
			
			// add show/hide event listeners
			newPopup.addEventListener(FlexEvent.SHOW, handlePopupVisible);
		}
		
		/**
		 * Closes all popups
		 */
		public function closeAllPopups():void {
			for each(var popup:PopupMenu in popups) {
				popup.close();
			}
		}
		
		/**
		 * Handles a popup becoming visible.
		 * Hides any open popups.
		 */
		private function handlePopupVisible(event:FlexEvent):void {
			for each(var popup:PopupMenu in popups) {
				if(popup.visible && popup != event.target) {
					popup.close();
				}
			}
		}
	}
}

// by using a class here, no outide class can create
// a new PopupManager because it is required in the constructor
class SingletonEnforcer {}