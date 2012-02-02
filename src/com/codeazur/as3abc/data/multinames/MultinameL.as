package com.codeazur.as3abc.data.multinames
{
	import __AS3__.vec.Vector;

	import com.codeazur.as3abc.ABCData;	
	import com.codeazur.as3abc.data.ABCNamespace;
	import com.codeazur.as3abc.data.ConstantPool;
	
	public class MultinameL extends AbstractMultiname
	{		
		public var namespaceSet:Vector.<ABCNamespace>;
		private var _namespaceSetIndex : int;
		
		public function MultinameL()
		{
			super();
		}
		
		override public function parse(data:ABCData, constantPool:ConstantPool):void
		{
			// TODO: Trap errors dereferencing from bad constant pool indices
			_namespaceSetIndex = data.readU32 ();
			namespaceSet = constantPool.namespaceSets[_namespaceSetIndex];
		}		
		
		override public function publish ( data : ABCData ) : void {
			data.writeU32 ( _namespaceSetIndex );
		}
	}
}