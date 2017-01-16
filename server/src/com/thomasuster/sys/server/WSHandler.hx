package com.thomasuster.sys.server;
import ServerMain;
import String;
import hxnet.protocols.WebSocket;
import sys.io.Process;
class WSHandler extends WebSocket {

    public var model:ServerModel;

    override private function recvText(raw:String):Void {
        try {
            var all:Array<String> = raw.split(',');
            var command:String = all.shift();
            if(command == 'runFrom') //
                runFrom(command, all);
            else if(command == 'killAll')
                model.killAll();
            else
                runProc(command, all);
        }
        catch(e:Dynamic) {
            print(e);
        }
    }

    function runFrom(command:String, all:Array<String>):Void {
        var start:String = Sys.args()[Sys.args().length-1];
        var last:String = Sys.getCwd();
        var absolute:String = start + all.shift();
        print(absolute);
        runProc('pwd',[]);
        Sys.setCwd(absolute);
        runProc('pwd',[]);
        command = all.shift();
        runProc(command, all);
        Sys.setCwd(last);
    }

    public function runProc(command:String, all:Array<String>):Void {
        print(command + ' ' + all.join(' ') );
        var process:Process = new Process(command, all);
        model.pids.push(process.getPid());
        if(command == 'pwd') {
            print('pwd:' + process.stdout.readLine());
        }
    }

    function print(s:String):Void {
        model.print(s);
    }
}
   