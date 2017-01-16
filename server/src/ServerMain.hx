package ;
import com.thomasuster.integrate.server.ServerModel;
import com.thomasuster.integrate.server.ShutdownServer;
import com.thomasuster.integrate.server.WSHandlerFactory;
import hxnet.tcp.Server;
import neko.vm.Thread;
class ServerMain {

    var model:ServerModel;
    var wsServer:Server;
    
    static public function main() {
        new ServerMain();
    }

    public function new():Void {
        model = new ServerModel();
        model.root = Sys.getCwd();
        model.clearLogs();
        
        startWSHandler();
        startShutdownServer();

        while (!model.close)
            wsServer.update();
        
        model.killAll();
    }

    function startWSHandler():Void {
        var factory:WSHandlerFactory = new WSHandlerFactory();
        factory.model = model;
        wsServer = new hxnet.tcp.Server(factory, 4000, 'localhost');
        wsServer.listen();
    }

    function startShutdownServer():Void {
        var socketServer:ShutdownServer = new ShutdownServer();
        socketServer.model = model;
        socketServer.start();
        Thread.create(socketServer.update);
    }
}
   