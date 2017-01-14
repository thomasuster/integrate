package com.thomasuster.sys.tool;
import haxe.io.Eof;
import sys.io.Process;
class ProcessPrinter {
    
    public function new():Void {
    }

    public function printAll(process:Process):Void {
        while(true) {
            try {
                Sys.println(process.stdout.readLine());
            }
            catch(e:Eof) {
                break;
            }
        }
        while(true) {
            try {
                Sys.println(process.stderr.readLine());
            }
            catch(e:Eof) {
                break;
            }
        }
    }
}