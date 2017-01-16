import com.thomasuster.sys.tool.PIDFinder;
import com.thomasuster.sys.tool.ProcessPrinter;
import com.thomasuster.sys.tool.ServerTerminator;
import sys.io.Process;
class RunMain {
    
    var commands:Map<String, Void->Void>;
    var server:Process;
    var finder:PIDFinder;
    var printer:ProcessPrinter;
    var serverTerminator:ServerTerminator;

    public static function main() {
        new RunMain();
    }

    public function new():Void {
        finder = new PIDFinder();
        printer = new ProcessPrinter();
        serverTerminator = new ServerTerminator();
        commands = new Map<String, Void->Void>();
        commands.set('test', test);
        commands.set('find', find);
        commands.set('kill', kill);
        commands.set('killAll', killAll);
        var command:String = Sys.args()[0];
        if(commands.exists(command))
            commands.get(command)();
        else
            Sys.println('Command not found \'$command\'');
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

        var path:String = Sys.args()[Sys.args().length-1];
        
        Sys.setCwd('$last/server');
        server = new Process('neko',['Build.n', path]);

        Sys.setCwd(path);

        var process:Process = new Process('haxelib',['run','munit','test']);
        var code:Int = process.exitCode(true);

        serverTerminator.terminate();
        server.exitCode(true);

        printer.printAll(process);
        Sys.exit(code);
    }

    function find():Void {
        var port:Int = Std.parseInt(Sys.args()[1]);
        Sys.println(finder.findPID(port));
    }

    function killPort(port:Int):Void {
        var pid:Int = finder.findPID(port);
        if(pid != 0)
            Sys.command('kill',['$pid']);
    }

    function kill():Void {
        var port:Int = Std.parseInt(Sys.args()[1]);
        killPort(port);
    }
}