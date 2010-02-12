package com.codeazur.as3abc.data
{
	import com.codeazur.as3abc.ABC;
	import com.codeazur.as3abc.ABCData;
	import com.codeazur.as3abc.data.traits.AbstractTraitOwner;
	
	public class ABCClass extends AbstractTraitOwner
	{
		public var classInitializerIndex:int;

		public var classInitializer:Method;

		public var instance:Instance;

		public function parse(data:ABCData, constantPool:ConstantPool):void
		{
			classInitializerIndex = data.readU32();	
			classInitializer = abc.methods[classInitializerIndex];
			
			readTraits(data);
		}
			

	}
}