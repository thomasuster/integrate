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
        sys.setCwd('../server');
    }
    
    @AsyncTest
    public function testExample(asyncFactory:AsyncFactory):Void {
        AsyncAssert.register(this, asyncFactory, testExampleDone, 200);

        sys.send('neko',['Build.n']);

        client = new ExampleClient();
        client.start();
    }
    function testExampleDone():Void  {
        client.kill();
        sys.kill();
        MatcherAssert.assertThat(client.fromServer, IsEqual.equalTo('pong'));
    }

    @AsyncTest
    public function testClientArg(asyncFactory:AsyncFactory):Void {
        AsyncAssert.register(this, asyncFactory, testClientArgDone, 200);

        sys.send('neko',['Build.n']);

        client = new ExampleClient();
        client.args = '-marco';
        client.start();
    }
    function testClientArgDone():Void  {
        client.kill();
        sys.kill();
        MatcherAssert.assertThat(client.fromServer, IsEqual.equalTo('polo'));
    }

    @AsyncTest
    public function testServerArg(asyncFactory:AsyncFactory):Void {
        AsyncAssert.register(this, asyncFactory, testServerArgDone, 300);

        sys.send('neko',['Build.n', '-fortyTwo']);

        client = new ExampleClient();
        client.start();
    }
    function testServerArgDone():Void  {
        client.kill();
        sys.kill();
        MatcherAssert.assertThat(client.fromServer, IsEqual.equalTo('fortyTwo'));
    }
}