package com.codeazur.as3abc.data.multinames
{
	import com.codeazur.as3abc.ABCData;
	import com.codeazur.as3abc.data.ABCNamespace;
	import com.codeazur.as3abc.data.ConstantPool;
	
	public class ABCQName extends AbstractMultiname
	{
		public var abcNamespace:ABCNamespace;
		public var name:String;
		
		private var _data : ABCData = new ABCData ();
		
		public function ABCQName()
		{
			super();
		}
		
		protected function get data () : ABCData {
			return _data;
		}

		override public function parse(data:ABCData, constantPool:ConstantPool):void
		{
			// TODO: Trap errors dereferencing from bad constant pool indices
			var begin : int, end : int;
			var _abcNamespaceIndex : int;
			var _abcNameIndex : int;
			begin = data.position;
			_abcNamespaceIndex = data.readU32 ();
			_abcNameIndex = data.readU32 ();
			end= data.position;
			this.data.writeBytes ( data, begin, end - begin );
			abcNamespace = constantPool.namespaces[_abcNamespaceIndex];
			name = constantPool.strings[_abcNameIndex];
		}
		
		override public function publish ( data : ABCData ) : void {
			data.writeBytes ( this.data );
		}
		
		override public function toString():String
		{
			if (abcNamespace) {
				var namespaceStr:String = abcNamespace.toString();
				if (namespaceStr) {
					return abcNamespace + '::' + name;
				}
				else {
					return name;
				}
			}
			else {
				return "";
			}
		}		
	}
}