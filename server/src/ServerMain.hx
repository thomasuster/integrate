package ;
import sys.io.FileOutput;
import sys.io.File;
import com.thomasuster.sys.server.SysServerWebSocket;
import hxnet.tcp.Server;
import neko.vm.Thread;
class ServerMain {

    static public function main() {
//        haxe.Log.trace = handleTrace;
        
        var server:Server = new hxnet.tcp.Server(new hxnet.base.Factory(SysServerWebSocket), 4000, 'localhost');
        server.start();
//        Thread.create(server.start);

//        var server:Server = new hxnet.tcp.Server(new hxnet.base.Factory(SysServerRPC), 4001, 'localhost');
//        Thread.create(server.start);
        
//        while(true) {}
    }

    static function handleTrace(v, ?infos) {
        var write:FileOutput = File.append('logs.txt');
        write.writeString(v+'\n');
        write.close();
        // handle trace
    }
}
   