package com.thomasuster.sys;
import sys.net.Host;
import sys.net.Socket;
class RPCClient {

    var socket:Socket;

    public function new():Void {
        socket = new Socket();
        socket.setBlocking(true);
        socket.setTimeout(6);
        socket.connect(new Host('localhost'),4002);
    }
        
    public function close():Void {
        trace('close');
        socket.output.writeString('close');
        socket.output.writeInt16(0);
    }
}
   