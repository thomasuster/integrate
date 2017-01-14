package ;
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

    static public function main() {
        mutex = new Mutex();
        print('start main');
        var server:Server = new hxnet.tcp.Server(new hxnet.base.Factory(SysServerWebSocket), 4000, 'localhost');
        server.listen();
        
        var shutDownSerber:SysShutdownServer = new SysShutdownServer();
        shutDownSerber.start();
        Thread.create(shutDownSerber.update);
        
        while (!close) {
            print('update ' + Math.random());
            server.update();
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
   