package engine;

import massive.munit.Assert;
import dropecho.rulesEngine.*;

class RuleResultTest {
	var rule:Rule;
	var blackboard:Blackboard;
	var int_condition:Condition;
	var bool_condition:Condition;

	@BeforeClass
	public function suiteSetup() {
		blackboard = new Blackboard();
		blackboard.set("test_int", 1);
		blackboard.set("test_bool", true);
		blackboard.set("test_string", "fact");
	}

	@Before
	public function setup() {
		rule = new Rule();

		int_condition = new Condition("test_int", Operator.EQ, 1);
		bool_condition = new Condition("test_bool", Operator.EQ, true);
	}

	@Test
	public function canInstantiate() {
		Assert.isNotNull(rule);
	}

	@Test
	public function match_int() {
		rule.addCondition(int_condition);

		var result = rule.result(blackboard);
		Assert.isTrue(result.matches);
	}

	@Test
	public function match_int_fail() {
		int_condition = new Condition("test_int", Operator.EQ, 2);

		rule.addCondition(int_condition);

		var result = rule.result(blackboard);
		Assert.isFalse(result.matches);
		Assert.areEqual("test_int should be EQ 2", result.reason);
	}

	@Test
	public function match_2_conditions() {
		rule.addCondition(int_condition);
		rule.addCondition(bool_condition);

		var result = rule.result(blackboard);
		Assert.isTrue(result.matches);
	}

	@Test
	public function match_2_conditions_first_fails() {
		int_condition = new Condition("test_int", Operator.EQ, 2);
		rule.addCondition(int_condition);
		rule.addCondition(bool_condition);

		var result = rule.result(blackboard);
		Assert.isFalse(result.matches);
		Assert.areEqual("test_int should be EQ 2", result.reason);
	}

	@Test
	public function match_2_conditions_second_fails() {
		rule.addCondition(int_condition);
		bool_condition = new Condition("test_bool", Operator.EQ, false);
		rule.addCondition(bool_condition);

		var result = rule.result(blackboard);
		Assert.isFalse(result.matches);
	}
}
