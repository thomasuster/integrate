package ;
import com.thomasuster.sys.js.SysClient;
import haxe.Timer;
import massive.munit.async.AsyncFactory;
import org.hamcrest.MatcherAssert;
import org.hamcrest.core.IsEqual;

class ExampleTest {
    
    var client:ExampleClient;
    var sys:SysClient;
    
    @AsyncTest
    public function testExample(factory:AsyncFactory):Void {
        var handler:Dynamic = factory.createHandler(this, onTestAsyncExampleComplete, 300);
        var timer:Timer = Timer.delay(handler, 200);
        
        sys = new SysClient();
        sys.connect();
        sys.send('neko', ['../example/server/Build.n']);
        
        client = new ExampleClient();
    }
    
    private function onTestAsyncExampleComplete():Void  {
        MatcherAssert.assertThat(client.fromServer, IsEqual.equalTo('pong'));
    }
}