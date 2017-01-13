package;

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

    @Test
    public function testExample():Void {
        sys = new WebSocketClient();
        sys.connect();
        sys.send('echo',['hello world']);
        
        client = new ExampleClient();

        var document:Document = Browser.document;
        document.getElementById('ping').click();
        
//        while(client.fromServer == null) {}
        
        MatcherAssert.assertThat(client.fromServer, IsEqual.equalTo('pong'));
    }
}