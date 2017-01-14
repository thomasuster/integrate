package com.thomasuster.sys.server;
import sys.net.Host;
import sys.net.Socket;
class SysShutdownServer {

    var socket:Socket;
    var s:Socket;

    public function new():Void {
        
    }

    public function start():Void {
        socket = new Socket();
        socket.setBlocking(true);
        socket.setTimeout(5);
        socket.bind(new Host('localhost'),4002);
        socket.listen(1);
    }

    public function update():Void {
        ServerMain.print('Waiting for terminate');
        s = socket.accept();
        ServerMain.print('b');
        s.close();
        ServerMain.close = true;
    }
}