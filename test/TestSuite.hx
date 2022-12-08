import massive.munit.TestSuite;

import engine.RuleTest;
import engine.ConditionResultTest;
import engine.EngineTest;
import engine.RuleResultTest;
import engine.ConditionTest;
import ExampleTest;

/**
 * Auto generated Test Suite for MassiveUnit.
 * Refer to munit command line tool for more information (haxelib run munit)
 */
class TestSuite extends massive.munit.TestSuite
{
	public function new()
	{
		super();

		add(engine.RuleTest);
		add(engine.ConditionResultTest);
		add(engine.EngineTest);
		add(engine.RuleResultTest);
		add(engine.ConditionTest);
		add(ExampleTest);
	}
}
