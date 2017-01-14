package;

import js.html.Event;
import js.html.MouseEvent;
import haxe.Timer;
import com.thomasuster.sys.js.WebSocketClient;
import js.Browser;
import js.html.Document;
import massive.munit.Assert;
import massive.munit.async.AsyncFactory;
import org.hamcrest.MatcherAssert;
import org.hamcrest.core.IsEqual;

class ExampleTest {
    
    var client:ExampleClient;
    var sys:WebSocketClient;
    
    @AsyncTest
    public function testExample(factory:AsyncFactory):Void {
        var handler:Dynamic = factory.createHandler(this, onTestAsyncExampleComplete, 300);
        var timer = Timer.delay(handler, 200);
        
        sys = new WebSocketClient();
        sys.connect();
        sys.send('cd',['../example/server']);
        sys.send('pwd',[]);
        sys.send('neko',['Build.n']);
        
        client = new ExampleClient();
    }
    private function onTestAsyncExampleComplete():Void
    {
//        sys.send('killAll',[]);
        MatcherAssert.assertThat(client.fromServer, IsEqual.equalTo('pong'));
    }
}