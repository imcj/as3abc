package com.codeazur.as3abc.data.multinames
{
	import com.codeazur.as3abc.ABCData;
	import com.codeazur.as3abc.data.ABCNamespace;
	import com.codeazur.as3abc.data.ConstantPool;
	
	public class ABCQName extends AbstractMultiname
	{
		public var abcNamespace:ABCNamespace;
		public var name:String;
		
		private var _abcNamespaceIndex : int;
		private var _abcNameIndex : int;
		
		public function ABCQName()
		{
			super();
		}

		override public function parse(data:ABCData, constantPool:ConstantPool):void
		{
			// TODO: Trap errors dereferencing from bad constant pool indices
			_abcNamespaceIndex = data.readU32 ();
			_abcNameIndex = data.readU32 ();
			abcNamespace = constantPool.namespaces[_abcNamespaceIndex];
			name = constantPool.strings[_abcNameIndex];
		}
		
		override public function publish ( data : ABCData ) : void {
			data.writeU32 ( _abcNamespaceIndex );
			data.writeU32 ( _abcNameIndex );
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