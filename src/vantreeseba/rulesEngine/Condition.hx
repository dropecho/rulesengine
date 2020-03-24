package vantreeseba.rulesEngine;

@:expose
class Condition {
	public var fact:String = "";
	public var op:Operator = Operator.EQ;
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
