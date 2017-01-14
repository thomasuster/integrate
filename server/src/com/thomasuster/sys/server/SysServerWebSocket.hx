package com.thomasuster.sys.server;
import String;
import neko.Lib;
import sys.io.FileOutput;
import sys.io.File;
import haxe.io.Eof;
import sys.io.Process;
import hxnet.protocols.WebSocket;
class SysServerWebSocket extends WebSocket {
    
    public var pids:Array<Int> = [];

    override private function recvText(raw:String):Void {
        try {
            var all:Array<String> = raw.split(',');
            var command:String = all.shift();
            if(command == 'cd')
                Sys.setCwd(all[0]);
            runProc(command, all);
        }
        catch(e:Dynamic) {
            trace(e);
        }
    }

    function runProc(command:String, all:Array<String>):Void {
        print('full:' + command + ' ' + all.join(' '));
        print('length:'+all.length);
        if(all.length == 1)
            print('all[0]=\'' + all[0] + "'");
        print('run');
        var process:Process = new Process(command, all);
        print('run 1');
        if(process.exitCode(true) == 0)
            print(process.stdout.readLine());
        else {
            while(true) {
                try {
                    print(process.stderr.readLine());
                }
                catch(e:Eof) {
                    break;
                }
            }
        }
        print('run 2');
        pids.push(process.getPid());
        print('run 3');
    }

    function print(s:String):Void {
        ServerMain.print(s);
    }
}
   