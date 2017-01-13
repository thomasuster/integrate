package com.thomasuster.sys.server;
import haxe.io.Eof;
import sys.io.Process;
import hxnet.protocols.WebSocket;
class SysServerWebSocket extends WebSocket {
    
    override private function recvText(raw:String):Void {
        var all:Array<String> = raw.split(',');
        var process:Process = new Process(all.shift(), all);
        process.close();
        try {
            trace(process.stdout.readLine());
        }
        catch(e:Eof) {
            
        }
    }
}
   