package com.thomasuster.sys.server;
import sys.net.Host;
import sys.net.Socket;
class ShutdownServer {

    public var model:ServerModel;

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
        s = socket.accept();
        s.close();
        model.close = true;
    }
}