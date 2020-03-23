package engine;

import massive.munit.Assert;
import Condition;

class ConditionTest {
	public var int_condition:Condition;
	public var string_condition:Condition;
	public var bool_condition:Condition;
	public var blackboard:Blackboard;

	@BeforeClass
	public function suiteSetup() {
		blackboard = new Blackboard();
		blackboard.facts.set("test_int", 1);
		blackboard.facts.set("test_bool", true);
		blackboard.facts.set("test_string", "fact");
	}

	@Before
	public function setup() {
		int_condition = new Condition();
		int_condition.fact = "test_int";
		int_condition.op = OPERATOR.EQ;
		int_condition.value = 1;

		bool_condition = new Condition();
		bool_condition.fact = "test_bool";
		bool_condition.op = OPERATOR.EQ;
		bool_condition.value = true;

		string_condition = new Condition();
		string_condition.fact = "test_string";
		string_condition.op = OPERATOR.EQ;
		string_condition.value = "fact";
	}

	@Test
	public function canInstantiate() {
		Assert.isNotNull(int_condition);
		Assert.isNotNull(bool_condition);
		Assert.isNotNull(string_condition);
	}

	@Test
	public function match_int_eq() {
		var matches = int_condition.matches(blackboard);
		Assert.isTrue(matches);
	}

	@Test
	public function match_int_neq() {
		int_condition.op = OPERATOR.NEQ;
		int_condition.value = 2;
		var matches = int_condition.matches(blackboard);
		Assert.isTrue(matches);
	}

	@Test
	public function match_int_gt() {
		int_condition.op = OPERATOR.GT;
		int_condition.value = 0;
		var matches = int_condition.matches(blackboard);
		Assert.isTrue(matches);
	}

	@Test
	public function match_int_gte() {
		int_condition.op = OPERATOR.GTE;
		var matches = int_condition.matches(blackboard);
		Assert.isTrue(matches);
	}

	@Test
	public function match_int_lt() {
		int_condition.op = OPERATOR.LT;
		int_condition.value = 2;
		var matches = int_condition.matches(blackboard);
		Assert.isTrue(matches);
	}

	@Test
	public function match_int_lte() {
		int_condition.op = OPERATOR.LTE;
		int_condition.value = 1;
		var matches = int_condition.matches(blackboard);
		Assert.isTrue(matches);
	}

	@Test
	public function match_int_fail() {
		int_condition.value = 2;

		var matches = int_condition.matches(blackboard);
		Assert.isFalse(matches);
	}

	@Test
	public function match_int_against_string_condition_value() {
		int_condition.value = "1";

		var matches = int_condition.matches(blackboard);
		Assert.isFalse(matches);
	}

	@Test
	public function match_bool() {
		var matches = bool_condition.matches(blackboard);
		Assert.isTrue(matches);
	}

	@Test
	public function match_bool_gte() {
		bool_condition.op = OPERATOR.GTE;
		var matches = bool_condition.matches(blackboard);
		Assert.isTrue(matches);
	}

	@Test
	public function match_bool_gt() {
		bool_condition.op = OPERATOR.GT;
		var matches = bool_condition.matches(blackboard);
		Assert.isFalse(matches);
	}

	@Test
	public function match_string() {
		var matches = string_condition.matches(blackboard);
		Assert.isTrue(matches);
	}

	@Test
	public function match_string_gt() {
		string_condition.op = OPERATOR.GT;
		string_condition.value = "f";
		var matches = string_condition.matches(blackboard);
		Assert.isTrue(matches);
	}

	@Test
	public function match_string_gte() {
		string_condition.op = OPERATOR.GTE;
		var matches = string_condition.matches(blackboard);
		Assert.isTrue(matches);
	}
}
