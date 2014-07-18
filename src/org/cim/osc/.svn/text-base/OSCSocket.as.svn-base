package org.cim.osc {
	
	import flash.net.DatagramSocket;
	import flash.utils.ByteArray;
	
	/**
	 * Based on flosc.
	 * A UDP socket extended to simplify what need be sent.
	 */
	public class OSCSocket extends DatagramSocket {
		
		/**
		 * Constructor.
		 */
		public function OSCSocket() {
			super();
		}
		
		public function sendOSC(oscPacket:OSCPacket):void {
			// get the byte array from the packet we want to send
			var byteArray:ByteArray = oscPacket.getByteArray();
			
			// send it!
			//send(byteArray, 0, byteArray.length, oscPacket.address, oscPacket.port);
			send(byteArray, 0, byteArray.length);
		} 
	}
}