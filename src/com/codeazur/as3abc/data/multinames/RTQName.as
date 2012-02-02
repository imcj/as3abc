package com.codeazur.as3abc.data.multinames
{
	import com.codeazur.as3abc.ABCData;
	import com.codeazur.as3abc.data.ConstantPool;
	
	public class RTQName extends AbstractMultiname
	{
		public var name:String;
		private var _nameIndex : int;
		
		public function RTQName()
		{
			super();
		}

		override public function parse(data:ABCData, constantPool:ConstantPool):void
		{
			// TODO: Trap errors dereferencing from bad constant pool indices
			_nameIndex = data.readU32();
			name = constantPool.strings[_nameIndex];
		}
		
		override public function publish ( data : ABCData ) : void {
			data.writeU32 ( _nameIndex );
		}
	}
}