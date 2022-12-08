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
		blackboard.facts.set("test_int", 1);
		blackboard.facts.set("test_bool", true);
		blackboard.facts.set("test_string", "fact");
	}

	@Before
	public function setup() {
		rule = new Rule();

		int_condition = new Condition();
		int_condition.fact = "test_int";
		int_condition.op = Operator.EQ;
		int_condition.value = 1;

		bool_condition = new Condition();
		bool_condition.fact = "test_bool";
		bool_condition.op = Operator.EQ;
		bool_condition.value = true;

		string_condition = new Condition();
		string_condition.fact = "test_string";
		string_condition.op = Operator.EQ;
		string_condition.value = "fact";
	}

	@Test
	public function canInstantiate() {
		Assert.isNotNull(rule);
	}

	@Test
	public function match_int() {
		rule.conditions.push(int_condition);

		var matches = rule.matches(blackboard);
		Assert.isTrue(matches);
	}

	@Test
	public function match_int_fail() {
		int_condition.value = 2;

		rule.conditions.push(int_condition);

		var matches = rule.matches(blackboard);
		Assert.isFalse(matches);
	}

	@Test
	public function match_2_conditions() {
		rule.conditions.push(int_condition);
		rule.conditions.push(bool_condition);

		var matches = rule.matches(blackboard);
		Assert.isTrue(matches);
	}

	@Test
	public function match_2_conditions_first_fails() {
		int_condition.value = 2;
		rule.conditions.push(int_condition);
		rule.conditions.push(bool_condition);

		var matches = rule.matches(blackboard);
		Assert.isFalse(matches);
	}

	@Test
	public function match_2_conditions_second_fails() {
		rule.conditions.push(int_condition);
		bool_condition.value = false;
		rule.conditions.push(bool_condition);

		var matches = rule.matches(blackboard);
		Assert.isFalse(matches);
	}
}
