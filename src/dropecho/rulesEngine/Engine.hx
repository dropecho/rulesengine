package dropecho.rulesEngine;

using Lambda;

@:struct
typedef Event = {
	type:String,
	?message:String
}

@:expose
class Engine {
	public var rules:Map<Rule, Event> = new Map<Rule, Event>();
	public var blackboard:Blackboard = new Blackboard();

	public function new() {}

	public function run(?runtimeFacts:Blackboard):Array<Event> {
		final merged = new Blackboard();
		for (k => v in blackboard) {
			merged.set(k, v);
		}
		if (runtimeFacts != null) {
			for (k => v in runtimeFacts) {
				merged.set(k, v);
			}
		}

		final events = new Array<Event>();
		for (rule => event in rules) {
			if (event != null && rule.matches(merged)) {
				events.push(event);
			}
		}

		return events;
	}

	public function addRule(rule:Rule, ?event:Event):Void {
		rules.set(rule, event);
	}
}
