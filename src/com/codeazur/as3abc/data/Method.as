package com.codeazur.as3abc.data
{
	import __AS3__.vec.Vector;
	
	import com.codeazur.as3abc.ABC;
	import com.codeazur.as3abc.ABCData;
	import com.codeazur.as3abc.data.multinames.IMultiname;
	import com.codeazur.utils.StringUtils;
	
	public class Method
	{
		public var abc:ABC;
		public var parameters:Vector.<Parameter>;
		public var returnType:IMultiname;
		public var name:String;
		public var flags : int;
		public var needsArguments:Boolean;
		public var needsActivation:Boolean;
		public var needsRest:Boolean;
		public var hasOptionalParameters:Boolean;
		public var setsDXNS:Boolean;
		public var hasParameterNames:Boolean;
		public var body:MethodBody;
		
		private var _parameterCount : int;
		private var _optionalCount  : int;
		private var _u32ReturnType : int;
		private var _u32Parameters : Array = new Array ();
		private var _u32Name : int;
		private var _u32ParameterNames : Array = new Array ();
		
				
		public function parse(data:ABCData, constantPool:ConstantPool):void
		{
			var i:int;
			var parameter:Parameter;
			var valueIndex:int;
			var u32param : int;
			var u32ParameterName : int;
			_parameterCount = data.readU32();
			_u32ReturnType = data.readU32();
			returnType = constantPool.multinames[_u32ReturnType];
			
			parameters = new Vector.<Parameter>();
			
			for (i = 0; i < _parameterCount; i++) {
				u32param = data.readU32();
				parameter = new Parameter();
				parameter.type = constantPool.multinames[u32param];
				parameters[i] = parameter;
				_u32Parameters[i] = u32param;
			}
			_u32Name = data.readU32();
			name = constantPool.strings[_u32Name];
			
			flags = data.readUnsignedByte();
			needsArguments =        Boolean(flags & 0x01);
			needsActivation =       Boolean(flags & 0x02);
			needsRest =             Boolean(flags & 0x04);
			hasOptionalParameters = Boolean(flags & 0x08);
			setsDXNS =              Boolean(flags & 0x40);
			hasParameterNames =     Boolean(flags & 0x80);
			
			if (hasOptionalParameters) {

				_optionalCount = data.readU32();
				
				if (_optionalCount > _parameterCount) {
					throw new Error("Optional parameter count is greater than formal parameter count.");
				}
				
				for (i = _parameterCount - _optionalCount; i < _parameterCount; ++i) {				
					parameter = parameters[i];
					parameter.isOptional = true;
					
					valueIndex = data.readU32();

					parameter.optionalType = data.readByte();					
					parameter.optionalValue = constantPool.getConstantValue(
						parameter.optionalType,
						valueIndex
					);
					parameter.u32Value = valueIndex;
				}	
			}
			
			if (hasParameterNames) {
				for (i = 0; i < _parameterCount; ++i) {
					u32ParameterName = data.readU32();
					parameters[i].name = constantPool.strings[u32ParameterName];
				}
			}
		}
		
		public function publish ( data : ABCData ) : void {
			data.writeU32 ( _parameterCount );
			data.writeU32 ( _u32ReturnType );
			var i : int, len : int = _parameterCount;
			for ( i; i < len; i++ )
				data.writeU32 ( _u32Parameters[i] );
			data.writeU32 ( _u32Name );
			data.writeByte ( flags );
			
			if ( hasOptionalParameters ) {
				data.writeU32 ( _optionalCount );
				
				for (i = _parameterCount - _optionalCount; i < _parameterCount; ++i) {
					parameters[i].publish ( data );
				}
			}
			
			if ( hasParameterNames )
				for ( i = 0; i < _parameterCount; i++ )
					data.writeU32 ( _u32ParameterNames[i] );
				
		}
		
		public function toString(indent:uint = 0):String {
			var str:String;
			var returnTypeStr:String = returnType.toString();
			str = StringUtils.repeat(indent) + (name ? name : "(anonymous)") +
				"(" + parameters.join(", ") + ")";
			if (returnTypeStr) {
				str += ":" + returnTypeStr;
			}				
				/*
				StringUtils.repeat(indent + 4) +				
				"NeedsArguments: " + needsArguments + ", " +
				"NeedsActivation: " + needsActivation + ", " +
				"NeedsRest: " + needsRest + ", " +
				"HasOptionalParameters: " + hasOptionalParameters + ", " +
				"SetsDXNS: " + setsDXNS + ", " +
				"HasParameterNames: " + hasParameterNames
				*/
			return str;
		}

	}
}