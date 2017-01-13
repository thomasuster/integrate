package com.thomasuster.sys.server;
import sys.io.Process;
import hxnet.protocols.RPC;
class SysServerRPC extends RPC {
    
    private function make(raw:String):Void {
        var all:Array<String> = raw.split(',');
        var process:Process = new Process(all.shift(), all);
        process.close();
    }
}
   