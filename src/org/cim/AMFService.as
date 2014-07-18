package org.cim {
	import mx.formatters.DateFormatter;
	
	public class AMFService {
		/**
		 * Converts a DateTime from PHP sent via AMF remoting 
		 * into a valid ActionScript Date.  If it is given a Date,
		 * it simply returns that date, and if it is given neither 
		 * a string nor a date, it returns null.
		 * Accepts the new value to convert.
		 */
		public static function convertDateTimeToDate(newDate:*):Date {
			// check the type we're given
			if(newDate is Date) {
				// it's a date, simply return it
				return newDate;
			} else if(newDate.hasOwnProperty('date')) {
				// it's a server-side DateTime object...
				// extract the date part (a string) and convert it
				// ... do we want to add the time zone to it as well?
				return DateFormatter.parseDateString(newDate.date);
			} else if(newDate is String) {
				// it's a string, so we need to convert it
				return DateFormatter.parseDateString(newDate);
			} else {
				// it's neither, return null
				return null;
			}
		}
		
		/**
		 * Converts an ActionScript Date into a string that 
		 * will be accepted by a DateTime field on the server side.
		 */
		public static function convertDateToDateTime(newDate:Date):String {
			// prepare a formatter with the DateTime style time
			var formatter:DateFormatter = new DateFormatter();
			formatter.formatString = "YYYY-MM-DD JJ:NN:SS";
			
			// format
			return formatter.format(newDate);
		}
	}
}