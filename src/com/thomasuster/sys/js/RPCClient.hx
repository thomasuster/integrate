package com.thomasuster.sys.js;
import hxnet.protocols.RPC;
import haxe.io.Bytes;
import sys.net.Host;
import sys.net.Socket;
class RPCClient {

    var socket:Socket;

    public function new():Void {
        socket = new Socket();
        socket.connect(new Host('localhost'),4001);
        socket.setBlocking(true);
        socket.setTimeout(6);
    }
        
    public function send(command:String, args:Array<String>):Void {
        socket.output.writeString('make');
        socket.output.writeInt16(1);
        socket.output.writeInt8(RPC.TYPE_STRING);
        var s:String = '$command,${args.join(',')}';
        var bytes:Bytes = Bytes.ofString();
        socket.output.writeInt32(bytes.length)
        socket.output.writeBytes(bytes,0,bytes.length);
    }
}
   