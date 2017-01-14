package com.thomasuster.sys.server;
import sys.io.FileOutput;
import sys.io.File;
import hxnet.protocols.RPC;
class SysServerRPC extends RPC {

    public function close():Void {
        print('CLOSE!');
        ServerMain.close = true;
    }

    override private function dispatch(func:String, arguments:Array<Dynamic>) {
        ServerMain.print('SysServerRPC! ' + func);
        super.dispatch(func, arguments);
    }


    function print(s:String):Void {
        ServerMain.print('SysServerRPC! ' + s);
    }
}
   