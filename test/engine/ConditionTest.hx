package engine;

import massive.munit.Assert;
import dropecho.rulesEngine.*;

class ConditionTest {
	var int_condition:Condition;
	var string_condition:Condition;
	var bool_condition:Condition;
	var blackboard:Blackboard;

	@BeforeClass
	public function suiteSetup() {
		blackboard = new Blackboard();
		blackboard.set("test_int", 1);
		blackboard.set("test_bool", true);
		blackboard.set("test_string", "fact");
	}

	@Before
	public function setup() {
		int_condition = new Condition("test_int", Operator.EQ, 1);
		bool_condition = new Condition("test_bool", Operator.EQ, true);
		string_condition = new Condition("test_string", Operator.EQ, "fact");
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
		int_condition = new Condition("test_int", Operator.NEQ, 2);
		var matches = int_condition.matches(blackboard);
		Assert.isTrue(matches);
	}

	@Test
	public function match_int_gt() {
		int_condition = new Condition("test_int", Operator.GT, 0);
		var matches = int_condition.matches(blackboard);
		Assert.isTrue(matches);
	}

	@Test
	public function match_int_gte() {
		int_condition = new Condition("test_int", Operator.GTE, 1);
		var matches = int_condition.matches(blackboard);
		Assert.isTrue(matches);
	}

	@Test
	public function match_int_lt() {
		int_condition = new Condition("test_int", Operator.LT, 2);
		var matches = int_condition.matches(blackboard);
		Assert.isTrue(matches);
	}

	@Test
	public function match_int_lte() {
		int_condition = new Condition("test_int", Operator.LTE, 1);
		var matches = int_condition.matches(blackboard);
		Assert.isTrue(matches);
	}

	@Test
	public function match_int_fail() {
		int_condition = new Condition("test_int", Operator.EQ, 2);
		var matches = int_condition.matches(blackboard);
		Assert.isFalse(matches);
	}

	@Test
	public function match_int_against_string_condition_value() {
		int_condition = new Condition("test_int", Operator.EQ, "1");
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
		bool_condition = new Condition("test_bool", Operator.GTE, true);
		var matches = bool_condition.matches(blackboard);
		Assert.isTrue(matches);
	}

	@Test
	public function match_bool_gt() {
		bool_condition = new Condition("test_bool", Operator.GT, true);
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
		string_condition = new Condition("test_string", Operator.GT, "f");
		var matches = string_condition.matches(blackboard);
		Assert.isTrue(matches);
	}

	@Test
	public function match_string_gte() {
		string_condition = new Condition("test_string", Operator.GTE, "fact");
		var matches = string_condition.matches(blackboard);
		Assert.isTrue(matches);
	}
}
