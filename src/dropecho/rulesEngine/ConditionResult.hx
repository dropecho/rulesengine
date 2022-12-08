package dropecho.rulesEngine;

@:expose
class ConditionResult {
	public var condition:Condition;
	public var matches:Bool;
	public var reason:String;

	public function new(con:Condition, res:Bool) {
		condition = con;
		matches = res;
		reason = con.fact + " should be " + con.op + " " + con.value;
	}
}
