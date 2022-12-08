package engine;

import massive.munit.Assert;
import dropecho.rulesEngine.*;

class EngineTest {
	@Test
	public function testExample() {
		var engine = new Engine();
		Assert.isNotNull(engine);
	}

	@Test
	public function testtest() {
		var engine = new Engine();
//     var foo = engine.test(3);
		Assert.areEqual(foo, 7);
	}
}
