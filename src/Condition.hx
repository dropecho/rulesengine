enum OPERATOR {
	GT;
	GTE;
	LT;
	LTE;
	EQ;
	NEQ;
}

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

@:expose
class Condition {
	public var fact:String = "";
	public var op:OPERATOR = OPERATOR.EQ;
	public var value:Dynamic = null;

	public function new() {}

	public function matches(bb:Blackboard):Bool {
		var val = bb.facts.get(fact);

		switch (op) {
			case GT:
				return val > value;
			case GTE:
				return val >= value;
			case LT:
				return val < value;
			case LTE:
				return val <= value;
			case EQ:
				return val == value;
			case NEQ:
				return val != value;
			default:
				return false;
		}
	}

	public function result(bb:Blackboard):ConditionResult {
		return new ConditionResult(this, matches(bb));
	}
}
