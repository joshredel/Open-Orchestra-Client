package org.cim.osc {
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	
	/**
	 * Based on flosc.
	 * A packet that compiles a OSC message to be sent to an OSC server.
	 */
	public class OSCPacket {
		
		public var time:Number;
		private var messages:ArrayCollection;
		
		public var address:String;
		public var port:int;
		
		/**
		 * Constructor for outgoing packets.
		 *
		 * @param  time    OSC time tag
		 * @param  address destination host
		 * @param  port    destination port
		 */
		public function OSCPacket(time:Number) {//, address:String, port:int) {
			this.time = time;
			messages = new ArrayCollection();
			//this.address = address;
			//this.port = port;
		}
		
		
		/**
		 * Adds a message to this packet.
		 *
		 * @param   message   the message to add
		 */
		public function addMessage(message:OSCMessage):void {
			//messages.addElement(message);
			messages.addItem(message);
		}
		
		/**
		 * Returns a byte array representation of this packet, suitable for
		 * sending to OSC client applications.
		 */
		public function getByteArray():ByteArray {
			var stream:ByteArray = new ByteArray();
			
			// bundle
			if(messages.length > 1) {
				stream.writeUTFBytes("#bundle");
				stream.writeByte(0);
				stream.writeFloat(0); // should be write long...
			}
			
			// messages
			for each(var message:OSCMessage in messages) {
				var byteArray:ByteArray = message.getByteArray();
				
				// bundles have message size tags
				if(messages.length > 1) {
					stream.writeInt(byteArray.length);
				}
				
				stream.writeBytes(byteArray);
			}
			
			return stream;
		}
		
		/**
		 * Make the stream end on a 4-byte boundary by padding it with
		 * null characters.
		 *
		 * @param stream The stream to align.
		 */
		private function alignStream(stream:ByteArray):void {
			var pad:int = 4 - (stream.length % 4);
			for(var i:int = 0; i < pad; i++) {
				//stream.write(0);
				stream.writeByte(0);
			}
		}
		
//		/**
//		 * Prints out a byte array in 4-byte lines, useful for debugging.
//		 *
//		 * @param byteArray The byte array
//		 */
//		public static void printBytes(byte[] byteArray) 
//		{
//			for (int i=0; i<byteArray.length; i++) 
//			{
//				System.out.print(byteArray[i] + " (" + (char)byteArray[i] + ")  ");
//				if ((i+1)%4 == 0)
//					System.out.print("\n");
//			}
//		}
	}
}