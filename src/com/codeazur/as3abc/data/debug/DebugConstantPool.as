package com.codeazur.as3abc.data.debug
{
	import com.codeazur.as3abc.ABCData;
	import com.codeazur.as3abc.data.ConstantPool;
	import com.codeazur.as3abc.data.multinames.IMultiname;
	import com.codeazur.as3abc.factories.ABCMultinameFactory;
	
	public class DebugConstantPool extends ConstantPool
	{
		private var _intsPosition : Array = new Array ();
		private var _uintsPosition : Array = new Array ();
		private var _doublesPosition : Array = new Array ();
		private var _stringsPosition : Array = new Array ();
		private var _namespacesPosition : Array = new Array ();
		private var _namespaceSetsPosition : Array = new Array ();
		private var _multinamesPosition : Array = new Array ();
		
		public function DebugConstantPool()
		{
			super();
		}
		
		public function get Int () : Array {
			return _intsPosition;
		}
		
		public function get UInt () : Array {
			return _uintsPosition;
		}
		
		public function get Double () : Array {
			return _doublesPosition;
		}
		
		public function get String () : Array {
			return _stringsPosition;
		}
		
		public function get Namespace () : Array {
			return _namespacesPosition;
		}
		
		public function get NamespaceSet () : Array {
			return _namespaceSetsPosition;
		}
		
		public function get Multiname () : Array {
			return _multinamesPosition;
		}
		
		override protected function readInts(data:ABCData):void {
			_intsPosition[0] = data.position;
			super.readInts(data);
			_intsPosition[1] = data.position;
		}
		
		override protected function readUints(data:ABCData):void {
			_uintsPosition[0] = data.position;
			super.readUints(data);
			_uintsPosition[1] = data.position;
		}
		
		override protected function readDoubles(data:ABCData):void {
			_doublesPosition[0] = data.position;
			super.readDoubles(data);
			_doublesPosition[1] = data.position;
		}
		
		override protected function readStrings(data:ABCData):void {
			_stringsPosition[0] = data.position;
			super.readStrings(data);
			_stringsPosition[1] = data.position;
		}
		
		override protected function readNamespaces(data:ABCData):void {
			_namespacesPosition[0] = data.position;
			super.readNamespaces(data);
			_namespacesPosition[1] = data.position;
		}
		
		override protected function readNamespaceSets(data:ABCData):void {
			_namespaceSetsPosition[0] = data.position;
			super.readNamespaceSets(data);
			_namespaceSetsPosition[1] = data.position;
		}
		
		override protected function readMultinames(data:ABCData):void {
			_multinamesPosition[0] = data.position;
			super.readMultinames(data);
			_multinamesPosition[1] = data.position;
		}
		
		public function loadMultinames(data:ABCData):Vector.<IMultiname> {
			var i:uint, len:uint;
			var multiname:IMultiname;
			len = data.readU32();
			var _multinames : Vector.<IMultiname> = new Vector.<IMultiname> ();
			if (_multinames.length == 0)
				_multinames[0] = EMPTY_MULTINAME;
			
			for (i = 1; i < len; i++) {
				multiname = ABCMultinameFactory.create(data.readByte());
				multiname.parse(data, this);
				_multinames[i] = multiname;
			}
			
			return _multinames;
		}
	}
}