package com.codeazur.as3abc.data.multinames
{
	import __AS3__.vec.Vector;
	
	import com.codeazur.as3abc.ABCData;
	import com.codeazur.as3abc.data.ConstantPool;
	
	// This multiname type doesn't appear to be documented in Adobe's
	// ActionScript Virtual Machine 2 (AVM2) Overview PDF file.  It is,
	// however, described in the Tamarin sources and also in Joa Ebert's
	// Apparat source code.  This is needed to properly handle generic
	// vectors in FP10.
	
	public class TypeName extends AbstractMultiname
	{
		public var qname:ABCQName;
		public var parameters:Vector.<IMultiname>;
		public var constantPool:ConstantPool;
		
		private var _qnameIndex : int;
		
		public function TypeName():void
		{

		}

		override public function parse(data:ABCData, constantPool:ConstantPool):void
		{
			var i:int, len:int;
			this.constantPool = constantPool;
			// TODO: Trap errors dereferencing from bad constant pool indices
			_qnameIndex = data.readU32();
			qname = ABCQName(constantPool.multinames[_qnameIndex]);
			
			parameters = new Vector.<IMultiname>();
			
			len = data.readU32();
			for (i = 0; i < len; i++) {
				parameters[0] = constantPool.multinames[data.readU32()];
			}
		}
		
		override public function publish ( data : ABCData ) : void {
			function find ( multiname : IMultiname ) : int {
				var i : int = constantPool.multinames.length, found : int;
				while ( i-- ) {
					if ( multiname == constantPool.multinames[i] )
						found = i;
				}
				
				return i;
			}
			var len : int = parameters.length;
			data.writeU32 ( _qnameIndex );
			data.writeU32 ( parameters.length );
			
			for ( var i : int = 0; i < len; i++ ) {
				data.writeU32 ( find ( parameters[i] ) );
			}
		}
		
		override public function toString():String
		{
			var i:int, len:int = parameters.length, param:IMultiname;
			var str:String = qname.toString() + ".<";
			for (i = 0; i < len; ++i) {
				param = parameters[i];
				str += (param != null) ? param.toString() : "* ";
			}
			str += ">";
			return str;
		}
	}
}