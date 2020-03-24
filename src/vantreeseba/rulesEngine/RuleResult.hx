package vantreeseba.rulesEngine;

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


