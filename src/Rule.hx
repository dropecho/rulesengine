import Condition;

@expose
class RuleResult {
	public var rule:Rule;
	public var conditionResults:Array<ConditionResult> = new Array<ConditionResult>();
	public var matches:Bool;
	public var reason(get, set):String;

	public function new(rule:Rule, ?conditionResults:Array<ConditionResult>) {
		this.rule = rule;
		if (conditionResults != null) {
			this.conditionResults = conditionResults;
		}
	}

	public function get_reason() {
		if (this.matches == false) {
			return this.conditionResults.filter(x -> x.matches == false).map(x -> x.reason).join("\n");
		}
		return this.conditionResults.map(x -> x.reason).join("\n");
	}

	public function set_reason(val:String) {
		return get_reason();
	}
}

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
