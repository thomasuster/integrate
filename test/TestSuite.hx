import massive.munit.TestSuite;

import com.thomasuster.sys.server.EchoTest;
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

		add(com.thomasuster.sys.server.EchoTest);
		add(ExampleTest);
	}
}
