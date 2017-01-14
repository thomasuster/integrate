package com.thomasuster.sys.tool;
import sys.io.Process;
import haxe.io.Eof;
class PIDFinder {
    
    public function new():Void {
    }

    public function findPID(port:Int):Int {
        var lsof:Process = new Process('lsof',['-n','-i4TCP:$port']);
        var lines:Array<String> = [];
        try {
            lines.push(lsof.stdout.readLine());
            lines.push(lsof.stdout.readLine());
            var ereg:EReg = ~/.+\s+([0-9]+)\s/g;
            if(!ereg.match(lines[1]))
                return 0;
            var pidS:String = ereg.matched(1);
            var pid:Int = Std.parseInt(pidS);
            return pid;
        }
        catch(e:Eof) {
            return 0;
        }
    }
}