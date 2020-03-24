package vantreeseba.rulesEngine;

@:expose
class Rule {
	public var conditions:Array<Condition> = new Array<Condition>();

	public function new() {}

	public function matches(bb:Blackboard):Bool {
		for (con in conditions) {
			if (con.matches(bb) == false) {
				return false;
			}
		}

		return true;
	}

	public function result(bb:Blackboard):RuleResult {
		var result = new RuleResult(this);
		result.matches = true;
		for (con in conditions) {
			var conRes = con.result(bb);
			result.conditionResults.push(conRes);
			if (conRes.matches == false) {
				result.matches = false;
			}
		}

		return result;
	}
}
