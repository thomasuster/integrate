package ;
import neko.vm.Thread;
import com.thomasuster.sys.server.SysShutdownServer;
import neko.vm.Thread;
import neko.vm.Mutex;
import sys.io.FileOutput;
import sys.io.File;
import com.thomasuster.sys.server.SysServerWebSocket;
import hxnet.tcp.Server;
class ServerMain {

    static public var close:Bool;

    static var mutex:Mutex;
    public static var pids:Array<Int> = [];

    var threads:Array<Thread>;
    
    static public function main() {
        new ServerMain();
        pids = [];
    }

    public function new():Void {
        threads = [];
        mutex = new Mutex();
        print('start main');
        var server:Server = new hxnet.tcp.Server(new hxnet.base.Factory(SysServerWebSocket), 4000, 'localhost');
        server.listen();

        var shutDownSerber:SysShutdownServer = new SysShutdownServer();
        shutDownSerber.start();
        threads.push(Thread.create(shutDownSerber.update));

        while (!close) {
//            print('update ' + Math.random());
            server.update();
        }
        for (i in 0...pids.length) {
            var pid = pids[i];
            Sys.command('kill',['$pid']);
        }
        print('closed!');
    }

    public static function print(s:String):Void {
        mutex.acquire();
        var write:FileOutput = File.append('logs.txt');
        write.writeString(s+'\n');
        write.close();
        mutex.release();
    }
}
   