package vantreeseba.rulesEngine;

@:expose
class Blackboard {
	public var facts:Map<String, Dynamic> = new Map<String, Dynamic>();

	public function new() {}

  public function set(key:String, val:Dynamic) {
    facts.set(key, val);
  }
}
