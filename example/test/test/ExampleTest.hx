package ;
import com.example.ExampleClient;
import com.thomasuster.sys.js.AsyncAssert;
import com.thomasuster.sys.js.SysClient;
import massive.munit.async.AsyncFactory;
import org.hamcrest.MatcherAssert;
import org.hamcrest.core.IsEqual;

class ExampleTest {
    
    var client:ExampleClient;
    var sys:SysClient;
    
    @BeforeClass
    public function beforeClass():Void {
        sys = new SysClient();
        sys.connect();
    }
    
    @AsyncTest
    public function testExample(asyncFactory:AsyncFactory):Void {
        AsyncAssert.register(this, asyncFactory, testExampleDone, 100);
        
        sys.send('neko', ['../example/server/Build.n']);

        client = new ExampleClient();
        client.start();
    }
    
    private function testExampleDone():Void  {
        MatcherAssert.assertThat(client.fromServer, IsEqual.equalTo('pong'));
    }
}