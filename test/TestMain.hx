import massive.munit.client.RichPrintClient;
import massive.munit.TestRunner;
import mcover.coverage.munit.client.MCoverPrintClient;

/**
 * Auto generated Test Application.
 * Refer to munit command line tool for more information (haxelib run munit)
 */
class TestMain {
	static function main() {
		new TestMain();
	}

	public function new() {
		var suites = new Array<Class<massive.munit.TestSuite>>();
		suites.push(TestSuite);

		#if MCOVER
		var client = new MCoverPrintClient();
		#else
		var client = new RichPrintClient();
		#end

		var runner:TestRunner = new TestRunner(client);

		runner.completionHandler = completionHandler;

		#if (js && !nodejs)
		var seconds = 0; // edit here to add some startup delay
		function delayStartup() {
			if (seconds > 0) {
				seconds--;
				js.Browser.document.getElementById("munit").innerHTML = "Tests will start in " + seconds + "s...";
				haxe.Timer.delay(delayStartup, 1000);
			} else {
				js.Browser.document.getElementById("munit").innerHTML = "";
				runner.run(suites);
			}
		}
		delayStartup();
		#else
		runner.run(suites);
		#end
	}

	/**
	 * updates the background color and closes the current browser
	 * for flash and html targets (useful for continous integration servers)
	 */
	function completionHandler(successful:Bool) {
		trace("doing it");
		try {
			#if flash
			flash.external.ExternalInterface.call("testResult", successful);
			#elseif js
			js.Lib.eval("testResult(" + successful + ");");
			#elseif (neko || cpp || java || cs || python || php || hl || eval)
			Sys.exit(0);
			#end
		}
		// if run from outside browser can get error which we can ignore
		catch (e:Dynamic) {}
	}
}
