package com.codeazur.as3abc.data.multinames
{
	import com.codeazur.as3abc.ABCData;
	import com.codeazur.as3abc.data.ConstantPool;

	public class AbstractMultiname implements IMultiname
	{
		public function AbstractMultiname()
		{
		
		}

		public function parse(data:ABCData, constantPool:ConstantPool):void
		{
			throw new Error("AbstractMultiname's parse method must be overridden.");
		}
		
		public function publish ( data : ABCData ) : void {
			throw new Error ( "AbstractMultiname's publish method must be overridden. 照抄上面的。" );
		}

		public function toString():String {
			return "[AbstractMultiname]";
		}
	}
}