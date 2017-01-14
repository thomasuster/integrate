package com.thomasuster.sys.server;
import sys.io.FileOutput;
import sys.io.File;
import neko.vm.Mutex;
class ServerModel {

    public var pids:Array<Int> = [];
    public var close:Bool;

    var mutex:Mutex;

    public function new():Void {
        pids = [];
        mutex = new Mutex();
    }

    public function killAll():Void {
        for (i in 0...pids.length) {
            var pid = pids[i];
            Sys.command('kill',['$pid']);
        }
    }

    public function clearLogs():Void {
        mutex.acquire();
        var write:FileOutput = File.write('logs.txt');
        write.writeString('');
        write.close();
        mutex.release();
    }

    public function print(s:String):Void {
        mutex.acquire();
        var write:FileOutput = File.append('logs.txt');
        write.writeString(s+'\n');
        write.close();
        mutex.release();
    }
}
   