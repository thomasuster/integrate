package com.thomasuster.sys.server;
import ServerMain;
import hxnet.interfaces.Server;
import String;
import neko.Lib;
import sys.io.FileOutput;
import sys.io.File;
import haxe.io.Eof;
import sys.io.Process;
import hxnet.protocols.WebSocket;
class SysServerWebSocket extends WebSocket {

    override private function recvText(raw:String):Void {
        try {
            print(raw);
            var all:Array<String> = raw.split(',');
            var command:String = all.shift();
            trace(command);
            if(command == 'runFrom') {
                print("OMGOMGOMGOMGOMG");
                print("OMGOMGOMGOMGOMG");
                print("OMGOMGOMGOMGOMG");
                print("OMGOMGOMGOMGOMG");
                print("OMGOMGOMGOMGOMG");
                print("OMGOMGOMGOMGOMG1");
                print(all[0]);
                var last:String = Sys.getCwd();
                print('here0');
                runProc('pwd',[]);
                Sys.setCwd(all[0]);
                print('here1');
                command = all.shift();
                print('here2');
                runProc(command, all);
                Sys.setCwd(last);
            }
            else if(command == 'killAll') {
                
            }
            else
                runProc(command, all);
        }
        catch(e:Dynamic) {
            print(e);
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
//        if(process.exitCode(true) == 0)
//            print(process.stdout.readLine());
//        else {
//            while(true) {
//                try {
//                    print(process.stderr.readLine());
//                }
//                catch(e:Eof) {
//                    break;
//                }
//            }
//        }
        print('run 2');
        ServerMain.pids.push(process.getPid());
        print('run 3');
    }

    function print(s:String):Void {
        ServerMain.print(s);
    }
}
   