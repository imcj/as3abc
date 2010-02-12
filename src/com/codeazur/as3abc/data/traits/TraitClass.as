package com.codeazur.as3abc.data.traits
{
	import com.codeazur.as3abc.ABCData;
	import com.codeazur.as3abc.data.ABCClass;
	import com.codeazur.as3abc.data.ConstantPool;
	
	public class TraitClass extends AbstractTrait
	{
		public var slotIndex:int;
		public var classIndex:int;
		public var clazz:ABCClass;
		
		override public function parse(data:ABCData):void
		{
			slotIndex = data.readU32();
			classIndex = data.readU32();
		}
	}
}