package engine;

import massive.munit.Assert;
import dropecho.rulesEngine.*;

class ConditionResultTest {
	public var int_condition:Condition;
	public var string_condition:Condition;
	public var bool_condition:Condition;
	public var blackboard:Blackboard;

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
	}

	@Test
	public function canInstantiate() {
		Assert.isNotNull(new ConditionResult(int_condition, false));
	}

	@Test
	public function match_int_eq() {
		var result = int_condition.result(blackboard);
		Assert.isTrue(result.matches);
	}

	@Test
	public function match_int_eq_fail() {
		int_condition = new Condition("test_int", Operator.EQ, 2);
		var result = int_condition.result(blackboard);

		Assert.isFalse(result.matches);
		Assert.areEqual("test_int should be EQ 2", result.reason);
	}
}
