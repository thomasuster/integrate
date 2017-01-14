package com.example;
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
        AsyncAssert.register(this, asyncFactory, testExampleDone, 200);
        
        sys.send('neko', ['../example/server/Build.n']);

        client = new ExampleClient();
        client.start();
    }
    function testExampleDone():Void  {
        sys.kill();
        MatcherAssert.assertThat(client.fromServer, IsEqual.equalTo('pong'));
    }

    @AsyncTest
    public function testClientArg(asyncFactory:AsyncFactory):Void {
        AsyncAssert.register(this, asyncFactory, testClientArgDone, 200);

        sys.send('neko', ['../example/server/Build.n']);

        client = new ExampleClient();
        client.args = '-marco';
        client.start();
    }
    function testClientArgDone():Void  {
        sys.kill();
        MatcherAssert.assertThat(client.fromServer, IsEqual.equalTo('polo'));
    }
}