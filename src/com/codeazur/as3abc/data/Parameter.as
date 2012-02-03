package com.codeazur.as3abc.data
{
	import com.codeazur.as3abc.ABCData;
	import com.codeazur.as3abc.data.multinames.IMultiname;
	
	public class Parameter
	{
		public var type:IMultiname;
		public var name:String;				// What does this do?  Not completely sure it is correct.
		public var isOptional:Boolean;	
		
		// Only set if isOptional is true
		public var optionalType:int;
		
		// Only set if isOptional is true	
		public var optionalValue:Object;
		
		private var _u32Value : int;
	
		public function Parameter()
		{
		}
		
		public function set u32Value ( value : int ) : void {
			_u32Value = value;
		}
		
		public function publish ( data : ABCData ) : void {
			data.writeU32 ( _u32Value );
			data.writeU32 ( optionalType );
		}
		
		public function toString():String {
			var str:String = type.toString();
			if (isOptional) {
				str += " = ";
				if (optionalType == 0x01 && optionalValue == "") {
					str += "\"\"";
				}
				else {
					str += optionalValue;
				}
			}
			return str;
		}

	}
}