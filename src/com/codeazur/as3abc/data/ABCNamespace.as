package com.codeazur.as3abc.data
{
	import com.codeazur.as3abc.ABCData;

	public class ABCNamespace
	{
		public static const NAMESPACE:int = 0x08;
		public static const PACKAGE_NAMESPACE:int = 0x16;
		public static const PACKAGE_INTERNAL_NAMESPACE:int = 0x17;
		public static const PROTECTED_NAMESPACE:int = 0x18;
		public static const EXPLICIT_NAMESPACE:int = 0x19;
		public static const STATIC_PROTECTED_NAMESPACE:int = 0x1A;
		public static const PRIVATE_NAMESPACE:int = 0x05;
				
		public var kind:int;
		public var name:String;
		
		private var _u32name : int;
		private var _data : ABCData;
		
		public function ABCNamespace(kind:int, name:String) 
		{
			_data = new ABCData ();
			this.kind = kind;
			this.name = name;
		}
		
		protected function get data () : ABCData {
			return _data;
		}
		
		static public function create ( data : ABCData, pool : ConstantPool ) : ABCNamespace {
			var ns : ABCNamespace;
			var kind : int, _u32name : int, name : String;
			var begin : int, end : int;
			begin = data.position;
			kind = data.readByte ();
			_u32name = data.readU32 ();
			end = data.position;
			name = pool.strings[_u32name];
			ns = new ABCNamespace ( kind, name );
			ns.data.writeBytes ( data, begin, end - begin );
			return ns;
		}
		
		public function publish ( data : ABCData ) : void {
			data.writeBytes ( _data );
		}

		public function toString():String {
			return name;
		}
	}
}