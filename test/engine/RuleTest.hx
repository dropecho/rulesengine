package engine;

import massive.munit.Assert;
import dropecho.rulesEngine.*;

class RuleTest {
	public var rule:Rule;
	public var blackboard:Blackboard;
	public var int_condition:Condition;
	public var string_condition:Condition;
	public var bool_condition:Condition;

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
		string_condition = new Condition("test_string", Operator.EQ, "fact");
	}

	@Test
	public function canInstantiate() {
		Assert.isNotNull(rule);
	}

	@Test
	public function match_int() {
		rule.addCondition(int_condition);

		var matches = rule.matches(blackboard);
		Assert.isTrue(matches);
	}

	@Test
	public function match_int_fail() {
		rule.addCondition(new Condition("test_int", Operator.EQ, 2));

		var matches = rule.matches(blackboard);
		Assert.isFalse(matches);
	}

	@Test
	public function match_2_conditions() {
		rule.addCondition(int_condition);
		rule.addCondition(bool_condition);

		var matches = rule.matches(blackboard);
		Assert.isTrue(matches);
	}

	@Test
	public function match_2_conditions_first_fails() {
		rule.addCondition(new Condition("test_int", Operator.EQ, 2));
		rule.addCondition(bool_condition);

		var matches = rule.matches(blackboard);
		Assert.isFalse(matches);
	}

	@Test
	public function match_2_conditions_second_fails() {
		rule.addCondition(int_condition);
		rule.addCondition(new Condition("test_bool", Operator.EQ, false));

		var matches = rule.matches(blackboard);
		Assert.isFalse(matches);
	}
}
