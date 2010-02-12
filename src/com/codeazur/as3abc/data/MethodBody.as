package com.codeazur.as3abc.data
{
	import __AS3__.vec.Vector;
	
	import com.codeazur.as3abc.ABCData;
	import com.codeazur.as3abc.data.traits.AbstractTraitOwner;
	
	import flash.utils.ByteArray;
	
	public class MethodBody extends AbstractTraitOwner
	{
		public var methodIndex:int;
		public var method:Method;
		public var maxStack:int;
		public var localCount:int;
		public var initScopeDepth:int;
		public var maxScopeDepth:int;
		public var code:ByteArray;		// For now...
		public var exceptions:Vector.<ExceptionHandler>;
		
		public function parse(data:ABCData):void
		{			
			methodIndex = data.readU32();
			
			method = abc.methods[methodIndex];
			method.body = this;
			
			maxStack = data.readU32();
			localCount = data.readU32();
			initScopeDepth = data.readU32();
			maxScopeDepth = data.readU32();
			
			readOpCodes(data);
			readExceptions(data);
			readTraits(data);
		}
		
		public function readOpCodes(data:ABCData):void
		{
			var codeLength:int;
			codeLength = data.readU32();
					
			// TODO: Parse the actual opcodes rather than just a raw copy.
			code = new ByteArray();
			data.readBytes(code, 0, codeLength);		
		}
		
		public function readExceptions(data:ABCData):void
		{
			var i:int, exceptionCount:int;
			var exceptionHandler:ExceptionHandler;
			
			exceptions = new Vector.<ExceptionHandler>();
			exceptionCount = data.readU32();
			for (i = 0; i < exceptionCount; i++) {
				exceptionHandler = new ExceptionHandler();
				exceptionHandler.from   = data.readU32();
				exceptionHandler.to     = data.readU32();
				exceptionHandler.target = data.readU32();
				exceptionHandler.exceptionType = abc.constantPool.multinames[data.readU32()];
				exceptionHandler.variableName = abc.constantPool.strings[data.readU32()];
				exceptions[i] = exceptionHandler;
			}			
		}
	}
}