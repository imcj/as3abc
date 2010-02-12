package com.codeazur.as3abc.data
{
	import __AS3__.vec.Vector;
	
	import com.codeazur.as3abc.ABCData;
	import com.codeazur.as3abc.data.multinames.ABCQName;
	import com.codeazur.as3abc.data.multinames.IMultiname;
	import com.codeazur.as3abc.data.traits.AbstractTraitOwner;
	
	public class Instance extends AbstractTraitOwner
	{
		public var clazz:ABCClass;
		
		public var name:ABCQName;
		
		public var base:IMultiname;
		
		public var isSealed:Boolean;
		
		public var isFinal:Boolean;
		
		public var isInterface:Boolean;
		
		public var protectedNamespace:ABCNamespace;
		
		public var interfaces:Vector.<IMultiname>;
		
		public var instanceInitializerIndex:int;
		
		public var instanceInitializer:Method;
				
		public function Instance()
		{
		}

		public function parse(data:ABCData, constantPool:ConstantPool):void
		{
			var i:int, interfaceCount:int, traitCount:int;
			var index:int;
			var flags:int;
			
			if (!abc) {
				throw new Error("Property abc must already be defined.");
			}
			
			name = ABCQName(constantPool.multinames[data.readU32()]);
			base = constantPool.multinames[data.readU32()];
			
			flags = data.readByte();
			isSealed    = Boolean(flags & 0x01);
			isFinal     = Boolean(flags & 0x02);
			isInterface = Boolean(flags & 0x04);
			
			if (flags & 0x08) {
				protectedNamespace = constantPool.namespaces[data.readU32()];
			}
			
			interfaceCount = data.readU32();
			interfaces = new Vector.<IMultiname>();
			for (i = 0; i < interfaceCount; i++) {
				index = data.readU32();
				if (!index) {
					throw new Error("Index cannot be zero.");
				}
				interfaces[i] = constantPool.multinames[index];
			}
			
			instanceInitializerIndex = data.readU32();
			instanceInitializer = abc.methods[instanceInitializerIndex];
			
			readTraits(data);
		}
	}
}