package dropecho.rulesEngine;

@:expose
class Rule {
	var _conditions:Array<Condition> = new Array<Condition>();

	public function new() {}

	public function addCondition(condition:Condition) {
		_conditions.push(condition);
	}

	public function removeCondition(condition:Condition) {
		_conditions.remove(condition);
	}

	public function matches(bb:Blackboard):Bool {
		for (con in _conditions) {
			if (con.matches(bb) == false) {
				return false;
			}
		}

		return true;
	}

	public function result(bb:Blackboard):RuleResult {
		var result = new RuleResult(this);
		result.matches = true;
		for (con in _conditions) {
			var conRes = con.result(bb);
			result.conditionResults.push(conRes);
			if (conRes.matches == false) {
				result.matches = false;
			}
		}

		return result;
	}
}
