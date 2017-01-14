import com.thomasuster.sys.RPCClient;
import haxe.io.Eof;
import sys.io.Process;
class RunMain {
    
    var commands:Map<String, Void->Void>;
    var server:Process;

    public static function main() {
        new RunMain();
    }

    public function new():Void {
        commands = new Map<String, Void->Void>();
        commands.set('test', test);
        commands.set('find', find);
        commands.set('kill', kill);
        commands.set('killAll', killAll);
        commands.get(Sys.args()[0])();
    }

    function killAll():Void {
        killPort(2000);
        killPort(4000);
        killPort(4001);
        killPort(4002);
    }

    function test():Void {
        killAll();
        
        var last:String = Sys.getCwd();
        
        Sys.setCwd('$last/server');
        server = new Process('neko',['Build.n']);

//        var path:String = Sys.args()[Sys.args().length-1];
//        Sys.setCwd(path);

//        var process:Process = new Process('haxelib',['run','munit','test']);
//        var code:Int = process.exitCode(true);
        
        
        server.exitCode(true);
//        trace('her2');

//        client.update();


//        while(true) {}
//        Sys.setCwd(last);
//        Sys.exit(code);
    }

    function printAll(process:Process):Void {
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

    function find():Void {
        var port:Int = Std.parseInt(Sys.args()[1]);
        Sys.println(findPID(port));
    }

    function findPID(port:Int):Int {
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

    function killPort(port:Int):Void {
        var pid:Int = findPID(port);
        if(pid != 0)
            Sys.command('kill',['$pid']);
    }

    function kill():Void {
        var port:Int = Std.parseInt(Sys.args()[1]);
        killPort(port);
    }
}