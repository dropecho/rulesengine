package engine;

import massive.munit.Assert;
import dropecho.rulesEngine.*;

class EngineTest {
	var engine:Engine;
	var first_rule:Rule;
	var second_rule:Rule;
	var int_condition:Condition;

	@Before
	public function setup() {
		engine = new Engine();
		first_rule = new Rule();
		int_condition = new Condition("test_int", Operator.EQ, 1);

		first_rule.addCondition(int_condition);

		second_rule = new Rule();
		second_rule.addCondition(int_condition);
	}

	@Test
	public function can_instantiate() {
		Assert.isNotNull(engine);
	}

	@Test
	public function engine_with_no_rules_runs() {
		Assert.areEqual(0, engine.run().length);
	}

	@Test
	public function engine_with_single_rule_runs() {
		engine.blackboard.set("test_int", 1);
		engine.addRule(first_rule, {type: "test_int_is_1"});

		var events = engine.run();
		Assert.areEqual(1, events.length);
		Assert.areEqual("test_int_is_1", events[0].type);
	}

	@Test
	public function engine_with_single_rule_runs_with_runtime_fact() {
		engine.addRule(first_rule, {type: "test_int_is_1"});

		var runtimeFacts = new Blackboard();
		runtimeFacts.set("test_int", 1);
		var events = engine.run(runtimeFacts);

		Assert.areEqual(1, events.length);
		Assert.areEqual("test_int_is_1", events[0].type);
	}

	@Test
	public function engine_with_two_rules_runs() {
		engine.blackboard.set("test_int", 1);
		engine.addRule(first_rule);
		engine.addRule(second_rule);
		Assert.areEqual(0, engine.run().length);
	}
}
