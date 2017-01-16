package com.thomasuster.integrate.server;
import String;
import hxnet.protocols.WebSocket;
import sys.io.Process;
class WSHandler extends WebSocket {

    public var model:ServerModel;

    var all:Array<String>;
    var command:String;

    override private function recvText(raw:String):Void {
        try {
            all = raw.split(',');
            command = all.shift();
            if(command == 'setCwd')
                setCwd();
            else if(command == 'killAll')
                model.killAll();
            else
                runProc(command, all);
        }
        catch(e:Dynamic) {
            print(e);
        }
    }

    function setCwd():Void {
        var start:String = Sys.args()[Sys.args().length-1];
        var path:String = start + all[0];
        Sys.setCwd(path);
        print('cd ${Sys.getCwd()}');
    }

    public function runProc(command:String, all:Array<String>):Void {
        print(command + ' ' + all.join(' ') );
        var process:Process = new Process(command, all);
        model.pids.push(process.getPid());
    }

    function print(s:String):Void {
        model.print(s);
    }
}
   