package org.cim.osc {
	
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	
	/**
	 * A message to be sent to an OSC server.
	 */
	public class OSCMessage {
		
		private var name:String;
		private var types:ArrayCollection;
		private var args:ArrayCollection;
		
		/**
		 * Constructor for the OSCMessage.
		 *
		 * @param   name    the message name
		 */
		public function OSCMessage(name:String) {
			this.name = name;
			types = new ArrayCollection();
			args = new ArrayCollection();
		}
		
		/**
		 * Adds a type/argument pair to the list of arguments
		 *
		 * @param   type           the argument data type
		 * @param   argument       the argument value
		 */
		public function addArg(type:String, argument:Object):void {
			//types.addElement(type);
			types.addItem(type);
			//arguments.addElement(argument);
			args.addItem(argument);
		}
		
		/**
		 * Directly sets the type and arg Vectors
		 *
		 * @param   types    a list of types
		 * @param   args     a list of arguments matching the types
		 */
		public function setTypesAndArgs(types:ArrayCollection, args:ArrayCollection):void {
			this.types = types;
			this.args = args;
		}
		
//		/**
//		 * Returns an XML representation of the message
//		 *
//		 */
//		public String getXml() 
//		{
//			if (types == null)
//				return "ERROR: Types not set";
//			
//			String xml = "";
//			xml += "<MESSAGE NAME=\"" + name + "\">";
//			
//			Enumeration t = types.elements();
//			Enumeration a = arguments.elements();
//			
//			while (t.hasMoreElements()) 
//			{
//				char type = ( (Character)t.nextElement() ).charValue();
//				
//				if (type == '[')
//					xml += "<ARRAY>";
//				else if (type == ']')
//					xml += "</ARRAY>";
//				else 
//				{
//					xml += "<ARGUMENT TYPE=\"" + type + "\" ";
//					switch(type) 
//					{
//						case 'i':
//							xml += "VALUE=\"" + (Integer)a.nextElement() + "\" />";
//							break;
//						case 'f':
//							xml += "VALUE=\"" + (Float)a.nextElement() + "\" />";
//							break;
//						case 'h':
//							xml += "VALUE=\"" + (Long)a.nextElement() + "\" />";
//							break;
//						case 'd':
//							xml += "VALUE=\"" + (Double)a.nextElement() + "\" />";
//							break;
//						case 's':
//							xml += "VALUE=\"" + (String)a.nextElement() + "\" />";
//							break;
//						case 'T':
//						case 'F':
//						case 'N':
//						case 'I':
//							xml += " />";
//							break;
//					}
//				}
//			}
//			xml += "</MESSAGE>";
//			return xml;
//		}
		
		/**
		 * Returns a byte array representation of this message.
		 */
		public function getByteArray():ByteArray {
			// the byte stream we'll write to
			var stream:ByteArray = new ByteArray();
			
			// address (name)
			//stream.writeBytes(name);
			stream.writeUTFBytes(name)
			alignStream(stream);
			
			// type tags
			stream.writeByte(','.charCodeAt(0));  // comma indicates type tags
			for each(var tag:String in types) {
				var typeCode:Number = tag.charCodeAt(0);
				stream.writeByte(typeCode);
			}
			alignStream(stream);
			
			// values
			for(var i:int = 0; i < types.length; i++) {
				var type:String = types[i];
				var argument:* = args[i];
				
				switch(type.charAt(0)) {
					case 'i':
						stream.writeInt(argument);
						break;
					case 'f':
						stream.writeFloat(argument);
						break;
					case 'h':
						// write long
						break;
					case 'd': 
						stream.writeDouble(argument);
						break;
					case 's':
						stream.writeUTFBytes(argument);
						alignStream(stream);
						break;
				}
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

	}
}