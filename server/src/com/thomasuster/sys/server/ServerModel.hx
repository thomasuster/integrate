package com.thomasuster.sys.server;
import sys.io.Process;
import sys.io.FileOutput;
import sys.io.File;
import neko.vm.Mutex;
class ServerModel {

    public var pids:Array<Int> = [];
    public var close:Bool;
    public var root:String;

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
        var write:FileOutput = File.append('$root/logs.txt');
        write.writeString(s+'\n');
        write.close();
        mutex.release();
    }

    public function runProc(command:String, all:Array<String>):Void {
        var process:Process = new Process(command, all);
        pids.push(process.getPid());
        if(command == 'pwd') {
            print('pwd:' + process.stdout.readLine());
        }
    }
}
   