package dropecho.rulesEngine;

import haxe.ds.StringMap;

@:expose
class Blackboard {
	public var facts:StringMap<Dynamic>;

	public function new() {
		facts = new StringMap<Dynamic>();
	}

	public function set(key:String, val:Dynamic) {
		facts.set(key, val);
	}

	public function get(key:String):Dynamic {
		return facts.get(key);
	}
}
